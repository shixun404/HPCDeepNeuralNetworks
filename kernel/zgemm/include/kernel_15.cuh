#include <stdio.h>
#include <mma.h>
using namespace nvcuda;

#define SKEW_KERNEL_2 4
#define BM 64
#define BN 64
#define BK 8
#define warp_col_tiles BN / (8 * 4)
#define warp_row_tiles BM / (8 * 2)
extern __shared__ double shared_mem[];
__global__ void zgemm_15(int M, int N, int K, double *A, double *B, double *C, double2 alpha, double2 beta){
    int tid = threadIdx.x;
    int bid_x = blockIdx.x, bid_y = blockIdx.y;
    int wid = tid / 32;
    
    
    // __shared__ double shared_mem[((BM + SKEW_KERNEL_2) * BK * 2 + (BN + SKEW_KERNEL_2) * BK * 2 ) * 2];

    double2 * gA = (double2*)A;
    double2 * gB = (double2*)B;
    double2 * gC = (((double2*)C));

    double* sA_real = (shared_mem + (BM + SKEW_KERNEL_2) * BK * 0);
    double* sA_imag = (shared_mem + (BM + SKEW_KERNEL_2) * BK * 1);
    double* sB_real = (shared_mem + (BN + SKEW_KERNEL_2) * BK * 0 + (BM + SKEW_KERNEL_2) * BK * 2);
    double* sB_imag = (shared_mem + (BN + SKEW_KERNEL_2) * BK * 1 + (BM + SKEW_KERNEL_2) * BK * 2);
    
    double2 mem_temp[32];
    
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
    
    for(int i = 0; i < (BM * BK + 256 - 1) / 256; ++i){
        mem_temp[i] = *(gA + (bid_x * BM + tid % BM) + (0 + tid / BM + 256 / BM * i) * M);
    }
    
    
    for(int i = 0; i < (BN * BK + 256 - 1)  / 256; ++i){
        mem_temp[(BM * BK + 256 - 1)  / 256 + i] = *(gB + (0 + tid / BN + 256 / BN * i) + (bid_y * BN + tid % BN) * K);
    }
    
    // mem_temp[1] = *(gA + (bid_x * 64 + tid % 64) + (0 + tid / 64 + 4) * M);
    // mem_temp[1] = *(gB + (0 + tid / 128) + (bid_y * 128 + tid % 128) * K);
    // mem_temp[2] = *(gB + (0 + tid / 128 + 2) + (bid_y * 128 + tid % 128) * K);
    // mem_temp[3] = *(gB + (0 + tid / 128 + 4) + (bid_y * 128 + tid % 128) * K);
    // mem_temp[4] = *(gB + (0 + tid / 128 + 6) + (bid_y * 128 + tid % 128) * K);

    
    for(int i = 0; i < (BM * BK + 256 - 1) / 256; ++i){
        *(sA_real + (tid / BM + 256 / BM * i) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[i].x;
        *(sA_imag + (tid / BM + 256 / BM * i) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[i].y;
    }

    for(int i = 0; i < (BN * BK + 256 - 1)  / 256; ++i){
        *(sB_real + (tid / BN + 256 / BN * i) * (BN + SKEW_KERNEL_2) + (tid % BN) + offset) = mem_temp[i +  (BM * BK + 256 - 1)  / 256].x;
        *(sB_imag + (tid / BN + 256 / BN * i) * (BN + SKEW_KERNEL_2) + (tid % BN) + offset) = mem_temp[i +  (BM * BK + 256 - 1)  / 256].y;
    }
    
    // *(sA_real + (tid / 32) * (32 + SKEW_KERNEL_2) + (tid % 32) + offset) = mem_temp[0].x;
    // *(sA_imag + (tid / 32) * (32 + SKEW_KERNEL_2) + (tid % 32) + offset) = mem_temp[0].y;
    // // *(sA_real + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[1].x;
    // // *(sA_imag + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[1].y;
    
    // *(sB_real + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].x;
    // *(sB_imag + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].y;
    // *(sB_real + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].x;
    // *(sB_imag + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].y;
    // *(sB_real + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].x;
    // *(sB_imag + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].y;
    // *(sB_real + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[4].x;
    // *(sB_imag + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[4].y;
    __syncthreads();
    
    #pragma unroll
    for(int k = 0; k < K; k += BK){
        // mem_temp[0] = *(gA + (bid_x * 32 + tid % 32) + (k + 8 + tid / 32) * M);
        // // mem_temp[1] = *(gA + (bid_x * 64 + tid % 64) + (k + 8 + tid / 64 + 4) * M);
        // mem_temp[1] = *(gB + (k + 8 + tid / 128) + (bid_y * 128 + tid % 128) * K);
        // mem_temp[2] = *(gB + (k + 8 + tid / 128 + 2) + (bid_y * 128 + tid % 128) * K);
        // mem_temp[3] = *(gB + (k + 8 + tid / 128 + 4) + (bid_y * 128 + tid % 128) * K);
        // mem_temp[4] = *(gB + (k + 8 + tid / 128 + 6) + (bid_y * 128 + tid % 128) * K);
        #pragma unroll
        for(int i = 0; i < (BM * BK + 256 - 1) / 256; ++i){
            mem_temp[i] = *(gA + (bid_x * BM + tid % BM) + (k + BK + tid / BM + 256 / BM * i) * M);
        }
        
        #pragma unroll
        for(int i = 0; i < (BN * BK + 256 - 1) / 256; ++i){
            mem_temp[(BM * BK + 256 - 1)  / 256 + i] = *(gB + (k + BK + tid / BN + 256 / BN * i) + (bid_y * BN + tid % BN) * K);
        }
        #pragma unroll
        for(int kk = 0; kk < BK / 4; ++kk){
            #pragma unroll
            for(int i = 0; i < warp_col_tiles; ++i){
                wmma::load_matrix_sync(b_real_frag[i], sB_real + offset + (wid / 2) * BN / 4 + i * 8 + kk * 4 * (BN + SKEW_KERNEL_2), (BN + SKEW_KERNEL_2));
                wmma::load_matrix_sync(b_imag_frag[i], sB_imag + offset + (wid / 2) * BN / 4 + i * 8 + kk * 4 * (BN + SKEW_KERNEL_2), (BN + SKEW_KERNEL_2));
            }
            // wmma::load_matrix_sync(b_real_frag[0], sB_real + offset + (wid / 2) * 32 + 0 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(b_imag_frag[0], sB_imag + offset + (wid / 2) * 32 + 0 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(b_real_frag[1], sB_real + offset + (wid / 2) * 32 + 1 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(b_imag_frag[1], sB_imag + offset + (wid / 2) * 32 + 1 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(b_real_frag[2], sB_real + offset + (wid / 2) * 32 + 2 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(b_imag_frag[2], sB_imag + offset + (wid / 2) * 32 + 2 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(b_real_frag[3], sB_real + offset + (wid / 2) * 32 + 3 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(b_imag_frag[3], sB_imag + offset + (wid / 2) * 32 + 3 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));

            
            #pragma unroll
            for(int i = 0; i < warp_row_tiles; ++i){
                wmma::load_matrix_sync(a_real_frag[i], sA_real + offset + (wid % 2) * BM / 2 + i * 8 + kk * 4 * (BM + SKEW_KERNEL_2), (BM + SKEW_KERNEL_2));
                wmma::load_matrix_sync(a_imag_frag[i], sA_imag + offset + (wid % 2) * BM / 2 + i * 8 + kk * 4 * (BM + SKEW_KERNEL_2), (BM + SKEW_KERNEL_2));
            }
            #pragma unroll
            for(int i = 0; i < warp_col_tiles; ++i){
                neg_b_imag_frag[i].x[0] = (double)-1.0f * b_imag_frag[i].x[0];
            }
            // neg_b_imag_frag[0].x[0] = (double)-1.0f * b_imag_frag[0].x[0];
            // neg_b_imag_frag[1].x[0] = (double)-1.0f * b_imag_frag[1].x[0];
            // neg_b_imag_frag[2].x[0] = (double)-1.0f * b_imag_frag[2].x[0];
            // neg_b_imag_frag[3].x[0] = (double)-1.0f * b_imag_frag[3].x[0];
            // wmma::load_matrix_sync(a_real_frag[0], sA_real + offset + (wid % 2) * 16 + 0 * 8 + kk * 4 * (32 + SKEW_KERNEL_2), (32 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(a_imag_frag[0], sA_imag + offset + (wid % 2) * 16 + 0 * 8 + kk * 4 * (32 + SKEW_KERNEL_2), (32 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(a_real_frag[1], sA_real + offset + (wid % 2) * 16 + 1 * 8 + kk * 4 * (32 + SKEW_KERNEL_2), (32 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(a_imag_frag[1], sA_imag + offset + (wid % 2) * 16 + 1 * 8 + kk * 4 * (32 + SKEW_KERNEL_2), (32 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(a_real_frag[2], sA_real + offset + (wid % 2) * 32 + 2 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(a_imag_frag[2], sA_imag + offset + (wid % 2) * 32 + 2 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(a_real_frag[3], sA_real + offset + (wid % 2) * 32 + 3 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            // wmma::load_matrix_sync(a_imag_frag[3], sA_imag + offset + (wid % 2) * 32 + 3 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
        
            // wmma::mma_sync(c_imag[0][0], a_real_frag[0], b_imag_frag[0], c_imag[0][0]);
            // wmma::mma_sync(c_imag[0][0], a_imag_frag[0], b_real_frag[0], c_imag[0][0]);        
            // wmma::mma_sync(c_imag[0][1], a_real_frag[1], b_imag_frag[0], c_imag[0][1]);
            // wmma::mma_sync(c_imag[0][1], a_imag_frag[1], b_real_frag[0], c_imag[0][1]);        
            // wmma::mma_sync(c_imag[0][2], a_real_frag[2], b_imag_frag[0], c_imag[0][2]);
            // wmma::mma_sync(c_imag[0][2], a_imag_frag[2], b_real_frag[0], c_imag[0][2]);        
            // wmma::mma_sync(c_imag[0][3], a_real_frag[3], b_imag_frag[0], c_imag[0][3]);
            // wmma::mma_sync(c_imag[0][3], a_imag_frag[3], b_real_frag[0], c_imag[0][3]);        
            // wmma::mma_sync(c_imag[1][3], a_real_frag[3], b_imag_frag[1], c_imag[1][3]);
            // wmma::mma_sync(c_imag[1][3], a_imag_frag[3], b_real_frag[1], c_imag[1][3]);        
            // wmma::mma_sync(c_imag[1][2], a_real_frag[2], b_imag_frag[1], c_imag[1][2]);
            // wmma::mma_sync(c_imag[1][2], a_imag_frag[2], b_real_frag[1], c_imag[1][2]);        
            // wmma::mma_sync(c_imag[1][1], a_real_frag[1], b_imag_frag[1], c_imag[1][1]);
            // wmma::mma_sync(c_imag[1][1], a_imag_frag[1], b_real_frag[1], c_imag[1][1]);        
            // wmma::mma_sync(c_imag[1][0], a_real_frag[0], b_imag_frag[1], c_imag[1][0]);
            // wmma::mma_sync(c_imag[1][0], a_imag_frag[0], b_real_frag[1], c_imag[1][0]);        
            // wmma::mma_sync(c_real[0][0], a_real_frag[0], b_real_frag[0], c_real[0][0]);
            // wmma::mma_sync(c_real[0][0], a_imag_frag[0], neg_b_imag_frag[0], c_real[0][0]);
            // wmma::mma_sync(c_real[0][1], a_real_frag[1], b_real_frag[0], c_real[0][1]);
            // wmma::mma_sync(c_real[0][1], a_imag_frag[1], neg_b_imag_frag[0], c_real[0][1]);
            // wmma::mma_sync(c_real[0][2], a_real_frag[2], b_real_frag[0], c_real[0][2]);
            // wmma::mma_sync(c_real[0][2], a_imag_frag[2], neg_b_imag_frag[0], c_real[0][2]);
            // wmma::mma_sync(c_real[0][3], a_real_frag[3], b_real_frag[0], c_real[0][3]);
            // wmma::mma_sync(c_real[0][3], a_imag_frag[3], neg_b_imag_frag[0], c_real[0][3]);
            // wmma::mma_sync(c_real[1][3], a_real_frag[3], b_real_frag[1], c_real[1][3]);
            // wmma::mma_sync(c_real[1][3], a_imag_frag[3], neg_b_imag_frag[1], c_real[1][3]);
            // wmma::mma_sync(c_real[1][2], a_real_frag[2], b_real_frag[1], c_real[1][2]);
            // wmma::mma_sync(c_real[1][2], a_imag_frag[2], neg_b_imag_frag[1], c_real[1][2]);            
            // wmma::mma_sync(c_real[1][1], a_real_frag[1], b_real_frag[1], c_real[1][1]);
            // wmma::mma_sync(c_real[1][1], a_imag_frag[1], neg_b_imag_frag[1], c_real[1][1]);
            // wmma::mma_sync(c_real[1][0], a_real_frag[0], b_real_frag[1], c_real[1][0]);
            // wmma::mma_sync(c_real[1][0], a_imag_frag[0], neg_b_imag_frag[1], c_real[1][0]);
            

            
            
            
            // for(int ii = 0; ii < neg_b_imag_frag[0].num_elements; ii++) {
            

            // }
            
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

            

            
            // for(int i = 0; i < warp_col_tiles; ++i){
            //     for(int j = 0; j < warp_row_tiles; ++j){
            //         wmma::mma_sync(c_imag[i][j], a_real_frag[j], b_imag_frag[i], c_imag[i][j]);
            //         wmma::mma_sync(c_imag[i][j], a_imag_frag[j], b_real_frag[i], c_imag[i][j]);        
            //     }
            // }


            
            // for(int i = 0; i < warp_col_tiles; ++i){
            //     for(int j = 0; j < warp_row_tiles; ++j){
            //         wmma::mma_sync(c_real[i][j], a_real_frag[j], b_real_frag[i], c_real[i][j]);
            //         wmma::mma_sync(c_real[i][j], a_imag_frag[j], neg_b_imag_frag[i], c_real[i][j]);
            //     }
            // }
            // for(int j = 0; j < warp_row_tiles; j+=2){
            // // for(int i = 0; i < warp_col_tiles; ++i){
            //     // wmma::load_matrix_sync(b_real_frag[i], sB_real + offset + (wid / 2) * 16 + i * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            //     // wmma::load_matrix_sync(b_imag_frag[i], sB_imag + offset + (wid / 2) * 16 + i * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            //     // neg_b_imag_frag[i].x[0] = (double)-1.0f * b_imag_frag[i].x[0];
            //     // #pragma unroll
                
            //         // if(i == 0){
            //         //     wmma::load_matrix_sync(a_real_frag[j], sA_real + offset + (wid % 2) * 32 + j * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            //         //     wmma::load_matrix_sync(a_imag_frag[j], sA_imag + offset + (wid % 2) * 32 + j * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            //         // }
            //         wmma::mma_sync(c_imag[0][j], a_real_frag[j], b_imag_frag[0], c_imag[0][j]);
            //         wmma::mma_sync(c_imag[0][j], a_imag_frag[j], b_real_frag[0], c_imag[0][j]);        
            //         wmma::mma_sync(c_real[0][j], a_real_frag[j], b_real_frag[0], c_real[0][j]);
            //         wmma::mma_sync(c_real[0][j], a_imag_frag[j], neg_b_imag_frag[0], c_real[0][j]);
                    
            //         wmma::mma_sync(c_imag[1][j], a_real_frag[j], b_imag_frag[1], c_imag[1][j]);
            //         wmma::mma_sync(c_imag[1][j], a_imag_frag[j], b_real_frag[1], c_imag[1][j]);        
            //         wmma::mma_sync(c_real[1][j], a_real_frag[j], b_real_frag[1], c_real[1][j]);
            //         wmma::mma_sync(c_real[1][j], a_imag_frag[j], neg_b_imag_frag[1], c_real[1][j]);
                    
                    
            //         wmma::mma_sync(c_imag[1][j + 1], a_real_frag[j + 1], b_imag_frag[1], c_imag[1][j + 1]);
            //         wmma::mma_sync(c_imag[1][j + 1], a_imag_frag[j + 1], b_real_frag[1], c_imag[1][j + 1]);        
            //         wmma::mma_sync(c_real[1][j + 1], a_real_frag[j + 1], b_real_frag[1], c_real[1][j + 1]);
            //         wmma::mma_sync(c_real[1][j + 1], a_imag_frag[j + 1], neg_b_imag_frag[1], c_real[1][j + 1]);

            //         wmma::mma_sync(c_imag[0][j + 1], a_real_frag[j + 1], b_imag_frag[0], c_imag[0][j + 1]);
            //         wmma::mma_sync(c_imag[0][j + 1], a_imag_frag[j + 1], b_real_frag[0], c_imag[0][j + 1]);        
            //         wmma::mma_sync(c_real[0][j + 1], a_real_frag[j + 1], b_real_frag[0], c_real[0][j + 1]);
            //         wmma::mma_sync(c_real[0][j + 1], a_imag_frag[j + 1], neg_b_imag_frag[0], c_real[0][j + 1]);
                    
            //     // }
            // }
        }
        
        offset = offset > 0 ? 0 : ((BM + SKEW_KERNEL_2 + BN + SKEW_KERNEL_2) * BK * 2);
        
    // *(sA_real + (tid / 32) * (32 + SKEW_KERNEL_2) + (tid % 32) + offset) = mem_temp[0].x;
    // *(sA_imag + (tid / 32) * (32 + SKEW_KERNEL_2) + (tid % 32) + offset) = mem_temp[0].y;
    
    // *(sB_real + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].x;
    // *(sB_imag + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].y;
    // *(sB_real + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].x;
    // *(sB_imag + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].y;
    // *(sB_real + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].x;
    // *(sB_imag + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].y;
    // *(sB_real + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[4].x;
    // *(sB_imag + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[4].y;
    #pragma unroll
    for(int i = 0; i < (BM * BK + 256 - 1)  / 256; ++i){
        *(sA_real + (tid / BM + 256 / BM * i) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[i].x;
        *(sA_imag + (tid / BM + 256 / BM * i) * (BM + SKEW_KERNEL_2) + (tid % BM) + offset) = mem_temp[i].y;
    }

    #pragma unroll
    for(int i = 0; i < (BN * BK + 256 - 1)  / 256; ++i){
        *(sB_real + (tid / BN + 256 / BN * i) * (BN + SKEW_KERNEL_2) + (tid % BN) + offset) = mem_temp[i +  (BM * BK + 256 - 1)  / 256].x;
        *(sB_imag + (tid / BN + 256 / BN * i) * (BN + SKEW_KERNEL_2) + (tid % BN) + offset) = mem_temp[i +  (BM * BK + 256 - 1)  / 256].y;
    }
        __syncthreads();
    }
    
    
    
    
    #pragma unroll
    for(int i = 0; i < warp_col_tiles; ++i){
        #pragma unroll
        for(int j = 0; j < warp_row_tiles; ++j){
            mem_temp[0] = *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
            mem_temp[1] = *(gC + (bid_x * BM + (wid % 2) * BM / 2 + j * 8 + ((tid % 32) / 4)) + (bid_y * BN + (wid / 2) * BN / 4 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
            #pragma unroll
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
    
    
    
    
    
    
    
    
    
    
    
//     #pragma unroll
//     for(int i = 0; i < warp_col_tiles; ++i){
//         #pragma unroll
//         for(int j = 0; j < warp_row_tiles; ++j){
//             mem_temp[0 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j] =   *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
//             mem_temp[1 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j] =   *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
            
//         }
//     }

//     #pragma unroll
//     for(int i = 0; i < warp_col_tiles; ++i){
//         #pragma unroll
//         for(int j = 0; j < warp_row_tiles; ++j){
//             for(int ii = 0; ii < c_real[i][j].num_elements; ii++) {
//                 mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j + 16].x = alpha.x * c_real[i][j].x[ii] + beta.x * mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j].x - 
//                                     alpha.y * c_imag[i][j].x[ii] - beta.y * mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j].y;
//                 mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j + 16].y = alpha.x * c_imag[i][j].x[ii] + beta.x * mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j].y +
//                                     alpha.y * c_real[i][j].x[ii] + beta.y * mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j].x;
//             }
//         }
//     }

//     #pragma unroll
//     for(int i = 0; i < warp_col_tiles; ++i){
//         #pragma unroll
//         for(int j = 0; j < warp_row_tiles; ++j){
//             *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M) = mem_temp[0 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j + 16];
//             *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M) = mem_temp[1 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j + 16];
//         }
//     }
}