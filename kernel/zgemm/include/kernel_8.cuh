#include <stdio.h>
#include <mma.h>
using namespace nvcuda;
#define warp_col_tiles 2
#define warp_row_tiles 4
#define SKEW_KERNEL_2 4
#define BM 64
#define BN 64
#define BK 8
extern __shared__ double shared_mem[];
__global__ void zgemm_8(int M, int N, int K, double *A, double *B, double *C, double2 alpha, double2 beta){
    int tid = threadIdx.x;
    int bid_x = blockIdx.x, bid_y = blockIdx.y;
    int wid = tid / 32;
    
    // __shared__ double shared_mem[((BM + SKEW_KERNEL_2) * BK * 4) * 2];

    double2 * gA = (double2*)A;
    double2 * gB = (double2*)B;
    double2 * gC = (((double2*)C));

    double* sA_real = (shared_mem + (BM + SKEW_KERNEL_2) * BK * 0);
    double* sA_imag = (shared_mem + (BM + SKEW_KERNEL_2) * BK * 1);
    double* sB_real = (shared_mem + (BM + SKEW_KERNEL_2) * BK * 2);
    double* sB_imag = (shared_mem + (BM + SKEW_KERNEL_2) * BK * 3);
    
    double2 mem_temp[BM * BK / 256 * 2];
    
    wmma::fragment<wmma::accumulator, 8, 8, 4, double> c_real[warp_col_tiles][warp_row_tiles];
    wmma::fragment<wmma::accumulator, 8, 8, 4, double> c_imag[warp_col_tiles][warp_row_tiles];
    wmma::fragment<wmma::matrix_a, 8, 8, 4, double, wmma::col_major> a_real_frag[warp_row_tiles];
    wmma::fragment<wmma::matrix_a, 8, 8, 4, double, wmma::col_major> a_imag_frag[warp_row_tiles];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> b_real_frag[warp_col_tiles];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> b_imag_frag[warp_col_tiles];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> neg_b_imag_frag[warp_col_tiles];
    
    #pragma unroll
    for(int i = 0; i < warp_col_tiles; i++){
        #pragma unroll
        for(int j = 0; j < warp_row_tiles; j++){
            wmma::fill_fragment(c_real[i][j], (double)0.0f);        
            wmma::fill_fragment(c_imag[i][j], (double)0.0f);        
        }
    }
    int offset = 0;
    int k = 0;
    #pragma unroll
    for(int kk = 0; kk < BK; kk += (256 / BM)){
        mem_temp[kk / (256 / BM)] = *(gA + (bid_x * BM + tid % BM) + (k + kk + tid / BM) * M);
        mem_temp[kk / (256 / BM) + BM * BK / 256] = *(gB + (k + kk + tid / BM) + (bid_y * BM + tid % BM) * K);
    }

    #pragma unroll
    for(int kk = 0; kk < BK; kk += (256 / BM)){
    *(sA_real + (tid / BM + kk) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[kk / (256 / BM)].x;
    *(sA_imag + (tid / BM + kk) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[kk / (256 / BM)].y;
    *(sB_real + (tid / BM + kk) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[kk / (256 / BM) + BM * BK / 256].x;
    *(sB_imag + (tid / BM + kk) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[kk / (256 / BM) + BM * BK / 256].y;
    }
    __syncthreads();
    
    #pragma unroll
    for(; k < K; k += BK){
        #pragma unroll
        for(int kk = 0; kk < BK; kk += (256 / BM)){
            mem_temp[kk / (256 / BM)] = *(gA + (bid_x * BM + tid % BM) + (k + BK + kk + tid / BM) * M);
            mem_temp[kk / (256 / BM) + BM * BK / 256] = *(gB + (k + BK + kk + tid / BM) + (bid_y * BM + tid % BM) * K);
        }
        #pragma unroll
        for(int kk = 0; kk < BK; kk += 4){
            #pragma unroll
            for(int i = 0; i < warp_row_tiles; ++i){
                wmma::load_matrix_sync(a_real_frag[i], sA_real + offset + (wid % 2) * BM / 2 + i * 8 + kk * (BM + SKEW_KERNEL_2), (BM + SKEW_KERNEL_2));
                wmma::load_matrix_sync(a_imag_frag[i], sA_imag + offset + (wid % 2) * BM / 2 + i * 8 + kk * (BM + SKEW_KERNEL_2), (BM + SKEW_KERNEL_2));
            }

            #pragma unroll
            for(int i = 0; i < warp_col_tiles; ++i){
                wmma::load_matrix_sync(b_real_frag[i], sB_real + offset + (wid / 2) * BN / 4 + i * 8 + kk * (BN + SKEW_KERNEL_2), (BN + SKEW_KERNEL_2));
                wmma::load_matrix_sync(b_imag_frag[i], sB_imag + offset + (wid / 2) * BN / 4 + i * 8 + kk * (BN + SKEW_KERNEL_2), (BN + SKEW_KERNEL_2));
            }

            #pragma unroll
            for(int i = 0; i < warp_col_tiles; ++i){
                neg_b_imag_frag[i].x[0] = -1.0f * b_imag_frag[i].x[0];
            }
            
            #pragma unroll
            for(int i = 0; i < warp_col_tiles; ++i){
                #pragma unroll
                for(int j = 0; j < warp_row_tiles; ++j){
                    wmma::mma_sync(c_imag[i][j], a_real_frag[j], b_imag_frag[i], c_imag[i][j]);
                    wmma::mma_sync(c_imag[i][j], a_imag_frag[j], b_real_frag[i], c_imag[i][j]);        
                    wmma::mma_sync(c_real[i][j], a_real_frag[j], b_real_frag[i], c_real[i][j]);
                    wmma::mma_sync(c_real[i][j], a_imag_frag[j], neg_b_imag_frag[i], c_real[i][j]);
                }
            }
        }
        
        offset = offset > 0 ? 0 : ((BM + SKEW_KERNEL_2) * BK * 4);
        
        #pragma unroll
        for(int kk = 0; kk < BK; kk += (256 / BM)){
            *(sA_real + (tid / BM + kk) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[kk / (256 / BM)].x;
            *(sA_imag + (tid / BM + kk) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[kk / (256 / BM)].y;
            *(sB_real + (tid / BM + kk) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[kk / (256 / BM) + BM * BK / 256].x;
            *(sB_imag + (tid / BM + kk) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[kk / (256 / BM) + BM * BK / 256].y;
        }
        __syncthreads();
    }
    

    #pragma unroll
    for(int i = 0; i < warp_col_tiles; ++i){
        #pragma unroll
        for(int j = 0; j < warp_row_tiles; ++j){
            mem_temp[0] =   *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
            mem_temp[1] =   *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
            for(int ii = 0; ii < c_real[i][j].num_elements; ii++) {
                mem_temp[ii + 2].x = alpha.x * c_real[i][j].x[ii] + beta.x * mem_temp[ii].x - 
                                    alpha.y * c_imag[i][j].x[ii] - beta.y * mem_temp[ii].y;
                mem_temp[ii + 2].y = alpha.x * c_imag[i][j].x[ii] + beta.x * mem_temp[ii].y +
                                    alpha.y * c_real[i][j].x[ii] + beta.y * mem_temp[ii].x;
            }
            *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M) = mem_temp[0 + 2];
            *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M) = mem_temp[1 + 2];
        }
    }


    // #pragma unroll
    // for(int i = 0; i < warp_col_tiles; ++i){
    //     #pragma unroll
    //     for(int j = 0; j < warp_row_tiles; ++j){
    //         mem_temp[0] =   *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
    //         mem_temp[1] =   *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
    //         for(int ii = 0; ii < c_real[i][j].num_elements; ii++) {
    //             mem_temp[ii + 2].x = alpha.x * c_real[i][j].x[ii] + beta.x * mem_temp[ii].x - 
    //                                 alpha.y * c_imag[i][j].x[ii] - beta.y * mem_temp[ii].y;
    //             mem_temp[ii + 2].y = alpha.x * c_imag[i][j].x[ii] + beta.x * mem_temp[ii].y +
    //                                 alpha.y * c_real[i][j].x[ii] + beta.y * mem_temp[ii].x;
    //         }
    //         *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M) = mem_temp[0 + 2];
    //         *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M) = mem_temp[1 + 2];
    //     }
    // }

    //     #pragma unroll
    // for(int i = 0; i < warp_col_tiles; ++i){
    //     #pragma unroll
    //     for(int j = 0; j < warp_row_tiles; ++j){
    //         mem_temp[0] =   *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
    //         mem_temp[1] =   *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
    //         for(int ii = 0; ii < c_real[i][j].num_elements; ii++) {
    //             mem_temp[ii + 2].x = alpha.x * c_real[i][j].x[ii] + beta.x * mem_temp[ii].x - 
    //                                 alpha.y * c_imag[i][j].x[ii] - beta.y * mem_temp[ii].y;
    //             mem_temp[ii + 2].y = alpha.x * c_imag[i][j].x[ii] + beta.x * mem_temp[ii].y +
    //                                 alpha.y * c_real[i][j].x[ii] + beta.y * mem_temp[ii].x;
    //         }
    //         *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M) = mem_temp[0 + 2];
    //         *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M) = mem_temp[1 + 2];
    //     }
    // }
}