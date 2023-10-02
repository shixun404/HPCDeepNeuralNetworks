#include <stdio.h>
#include <mma.h>
using namespace nvcuda;
#define warp_col_tiles 4
#define warp_row_tiles 4
#define SKEW_KERNEL_2 4
extern __shared__ double shared_mem[];
__global__ void zgemm_16(int M, int N, int K, double *A, double *B, double *C, double2 alpha, double2 beta){
    int threadblock_tile_M = 128, threadblock_tile_N = 64;
    int tid = threadIdx.x;
    int bid_x = blockIdx.x, bid_y = blockIdx.y;
    int wid = tid / 32;
    
    
    // __shared__ double shared_mem[((128 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8 * 2) * 2];

    double2 * gA = (double2*)A;
    double2 * gB = (double2*)B;
    double2 * gC = (((double2*)C));

    double* sA_real = (shared_mem + (128 + SKEW_KERNEL_2) * 8 * 0);
    double* sA_imag = (shared_mem + (128 + SKEW_KERNEL_2) * 8 * 1);
    double* sB_real = (shared_mem + (64 + SKEW_KERNEL_2) * 8 * 0 + (128 + SKEW_KERNEL_2) * 8 * 2);
    double* sB_imag = (shared_mem + (64 + SKEW_KERNEL_2) * 8 * 1 + (128 + SKEW_KERNEL_2) * 8 * 2);
    
    double2 mem_temp[32];
    
    wmma::fragment<wmma::accumulator, 8, 8, 4, double> c_real[warp_col_tiles][warp_row_tiles];
    wmma::fragment<wmma::accumulator, 8, 8, 4, double> c_imag[warp_col_tiles][warp_row_tiles];
    wmma::fragment<wmma::accumulator, 8, 8, 4, double> t1;
    wmma::fragment<wmma::accumulator, 8, 8, 4, double> t2;
    wmma::fragment<wmma::matrix_a, 8, 8, 4, double, wmma::col_major> a_real_frag[4];
    wmma::fragment<wmma::matrix_a, 8, 8, 4, double, wmma::col_major> a_imag_frag[4];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> b_real_frag[4];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> b_imag_frag[4];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> neg_b_imag_frag[4];
    wmma::fragment<wmma::matrix_a, 8, 8, 4, double, wmma::col_major> neg_a_imag_frag[4];
    
    #pragma unroll
    for(int i = 0; i < warp_col_tiles; i++){
        #pragma unroll
        for(int j = 0; j < warp_row_tiles; j++){
            wmma::fill_fragment(c_real[i][j], (double)0.0f);        
            wmma::fill_fragment(c_imag[i][j], (double)0.0f);        
        }
    }
    int offset = 0, offset_k = 0;
    
    mem_temp[0] = *(gA + (bid_x * 128 + tid % 128) + (0 + tid / 128) * M);
    mem_temp[1] = *(gA + (bid_x * 128 + tid % 128) + (0 + tid / 128 + 2) * M);
    mem_temp[2] = *(gA + (bid_x * 128 + tid % 128) + (0 + tid / 128 + 4) * M);
    mem_temp[3] = *(gA + (bid_x * 128 + tid % 128) + (0 + tid / 128 + 6) * M);
    
    mem_temp[4] = *(gB + (0 + tid / 64) + (bid_y * 64 + tid % 64) * K);
    mem_temp[5] = *(gB + (0 + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K);

    *(sA_real + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[0].x;
    *(sA_imag + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[0].y;
    *(sA_real + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].x;
    *(sA_imag + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].y;
    *(sA_real + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].x;
    *(sA_imag + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].y;
    *(sA_real + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].x;
    *(sA_imag + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].y;
    
    *(sB_real + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[4].x;
    *(sB_imag + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[4].y;
    *(sB_real + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[5].x;
    *(sB_imag + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[5].y;
    __syncthreads();
    offset_k = (offset_k + 1) % 3;
    offset = (offset_k *  ((64 + SKEW_KERNEL_2 + 128 + SKEW_KERNEL_2) * 8 * 2));

    mem_temp[0] = *(gA + (bid_x * 128 + tid % 128) + (8 + tid / 128) * M);
    mem_temp[1] = *(gA + (bid_x * 128 + tid % 128) + (8 + tid / 128 + 2) * M);
    mem_temp[2] = *(gA + (bid_x * 128 + tid % 128) + (8 + tid / 128 + 4) * M);
    mem_temp[3] = *(gA + (bid_x * 128 + tid % 128) + (8 + tid / 128 + 6) * M);
    
    mem_temp[4] = *(gB + (8 + tid / 64) + (bid_y * 64 + tid % 64) * K);
    mem_temp[5] = *(gB + (8 + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K);

    *(sA_real + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[0].x;
    *(sA_imag + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[0].y;
    *(sA_real + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].x;
    *(sA_imag + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].y;
    *(sA_real + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].x;
    *(sA_imag + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].y;
    *(sA_real + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].x;
    *(sA_imag + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].y;
    
    *(sB_real + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[4].x;
    *(sB_imag + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[4].y;
    *(sB_real + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[5].x;
    *(sB_imag + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[5].y;
    __syncthreads();
    // offset_k = (offset_k + 1) % 3;
    // offset = (offset_k *  ((64 + SKEW_KERNEL_2 + 128 + SKEW_KERNEL_2) * 8 * 2));
    
    #pragma unroll
    for(int k = 0; k < K; k += 8){
        // mem_temp[0] = *(gA + (bid_x * 64 + tid % 64) + (k + 8 + tid / 64) * M);
        // mem_temp[1] = *(gA + (bid_x * 64 + tid % 64) + (k + 8 + tid / 64 + 4) * M);
        // mem_temp[2] = *(gB + (k + 8 + tid / 64) + (bid_y * 64 + tid % 64) * K);
        // mem_temp[3] = *(gB + (k + 8 + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K);


        mem_temp[0] = *(gA + (bid_x * 128 + tid % 128) + ((k + 16) % K + tid / 128) * M);
        mem_temp[1] = *(gA + (bid_x * 128 + tid % 128) + ((k + 16) % K + tid / 128 + 2) * M);
        mem_temp[2] = *(gA + (bid_x * 128 + tid % 128) + ((k + 16) % K + tid / 128 + 4) * M);
        mem_temp[3] = *(gA + (bid_x * 128 + tid % 128) + ((k + 16) % K + tid / 128 + 6) * M);
        
        mem_temp[4] = *(gB + ((k + 16) % K + tid / 64) + (bid_y * 64 + tid % 64) * K);
        mem_temp[5] = *(gB + ((k + 16) % K + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K);
        // #pragma unroll
        int offset_cur = ((offset_k + 2) % 3) * ((64 + SKEW_KERNEL_2 + 128 + SKEW_KERNEL_2) * 8 * 2);
        for(int kk = 0; kk < 2; ++kk){

            // for(int i = 0; i < warp_col_tiles; ++i){
            //     wmma::load_matrix_sync(b_real_frag[i], sB_real + offset + (wid / 2) * 16 + i * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            //     wmma::load_matrix_sync(b_imag_frag[i], sB_imag + offset + (wid / 2) * 16 + i * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            // }
            
            wmma::load_matrix_sync(b_real_frag[0], sB_real + offset_cur + (wid / 4) * 32 + 0 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_imag_frag[0], sB_imag + offset_cur + (wid / 4) * 32 + 0 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_real_frag[1], sB_real + offset_cur + (wid / 4) * 32 + 1 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_imag_frag[1], sB_imag + offset_cur + (wid / 4) * 32 + 1 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_real_frag[2], sB_real + offset_cur + (wid / 4) * 32 + 2 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_imag_frag[2], sB_imag + offset_cur + (wid / 4) * 32 + 2 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_real_frag[3], sB_real + offset_cur + (wid / 4) * 32 + 3 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_imag_frag[3], sB_imag + offset_cur + (wid / 4) * 32 + 3 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));

            
            // for(int i = 0; i < warp_row_tiles; ++i){
            //     wmma::load_matrix_sync(a_real_frag[i], sA_real + offset + (wid % 2) * 32 + i * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            //     wmma::load_matrix_sync(a_imag_frag[i], sA_imag + offset + (wid % 2) * 32 + i * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            // }
            neg_b_imag_frag[0].x[0] = (double)-1.0f * b_imag_frag[0].x[0];
            neg_b_imag_frag[1].x[0] = (double)-1.0f * b_imag_frag[1].x[0];
            neg_b_imag_frag[2].x[0] = (double)-1.0f * b_imag_frag[2].x[0];
            neg_b_imag_frag[3].x[0] = (double)-1.0f * b_imag_frag[3].x[0];

            wmma::load_matrix_sync(a_real_frag[0], sA_real + offset_cur + (wid % 4) * 32 + 0 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_imag_frag[0], sA_imag + offset_cur + (wid % 4) * 32 + 0 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_real_frag[1], sA_real + offset_cur + (wid % 4) * 32 + 1 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_imag_frag[1], sA_imag + offset_cur + (wid % 4) * 32 + 1 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_real_frag[2], sA_real + offset_cur + (wid % 4) * 32 + 2 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_imag_frag[2], sA_imag + offset_cur + (wid % 4) * 32 + 2 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_real_frag[3], sA_real + offset_cur + (wid % 4) * 32 + 3 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_imag_frag[3], sA_imag + offset_cur + (wid % 4) * 32 + 3 * 8 + kk * 4 * (128 + SKEW_KERNEL_2), (128 + SKEW_KERNEL_2));
            
            #pragma unroll
            
            for(int i = 0; i < warp_col_tiles; ++i){
                for(int j = 0; j < warp_row_tiles; ++j){
                    wmma::mma_sync(c_imag[i][j], a_real_frag[j], b_imag_frag[i], c_imag[i][j]);
                    wmma::mma_sync(c_imag[i][j], a_imag_frag[j], b_real_frag[i], c_imag[i][j]);        
                    wmma::mma_sync(c_real[i][j], a_real_frag[j], b_real_frag[i], c_real[i][j]);
                    wmma::mma_sync(c_real[i][j], a_imag_frag[j], neg_b_imag_frag[i], c_real[i][j]);
                    
                }
            }
        }
        
        offset_k = (offset_k + 1) % 3;
        offset = (offset_k *  ((64 + SKEW_KERNEL_2 + 128 + SKEW_KERNEL_2) * 8 * 2));

        *(sA_real + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[0].x;
        *(sA_imag + (tid / 128) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[0].y;
        *(sA_real + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].x;
        *(sA_imag + (tid / 128 + 2) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[1].y;
        *(sA_real + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].x;
        *(sA_imag + (tid / 128 + 4) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[2].y;
        *(sA_real + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].x;
        *(sA_imag + (tid / 128 + 6) * (128 + SKEW_KERNEL_2) + (tid % 128) + offset) = mem_temp[3].y;
        *(sB_real + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[4].x;
        *(sB_imag + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[4].y;
        *(sB_real + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[5].x;
        *(sB_imag + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[5].y;
        __syncthreads();
    }
    
    
    
    
    #pragma unroll
    for(int i = 0; i < warp_col_tiles; ++i){
        #pragma unroll
        for(int j = 0; j < warp_row_tiles; ++j){
            mem_temp[0] = *(gC + (bid_x * 128 + (wid % 4) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 4) * 32 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
            mem_temp[1] = *(gC + (bid_x * 128 + (wid % 4) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 4) * 32 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
            #pragma unroll
            for(int ii = 0; ii < c_real[i][j].num_elements; ii++) {
                mem_temp[ii + 2].x = alpha.x * c_real[i][j].x[ii] + beta.x * mem_temp[ii].x - 
                                        alpha.y * c_imag[i][j].x[ii] - beta.y * mem_temp[ii].y;
                mem_temp[ii + 2].y = alpha.x * c_imag[i][j].x[ii] + beta.x * mem_temp[ii].y +
                                        alpha.y * c_real[i][j].x[ii] + beta.y * mem_temp[ii].x;       
            }
            *(gC + (bid_x * 128 + (wid % 4) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 4) * 32 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M) = mem_temp[0 + 2];
            *(gC + (bid_x * 128 + (wid % 4) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 4) * 32 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M) = mem_temp[1 + 2];

        }
    }
    
    
    
    
    
    
    
    
    
    
    
    // #pragma unroll
    // for(int i = 0; i < warp_col_tiles; ++i){
    //     #pragma unroll
    //     for(int j = 0; j < warp_row_tiles; ++j){
    //         mem_temp[0 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j] =   *(gC + (bid_x * 128 + (wid % 4) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 4) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
    //         mem_temp[1 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j] =   *(gC + (bid_x * 128 + (wid % 4) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 4) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
            
    //     }
    // }

    // #pragma unroll
    // for(int i = 0; i < warp_col_tiles; ++i){
    //     #pragma unroll
    //     for(int j = 0; j < warp_row_tiles; ++j){
    //         for(int ii = 0; ii < c_real[i][j].num_elements; ii++) {
    //             mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j + 16].x = alpha.x * c_real[i][j].x[ii] + beta.x * mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j].x - 
    //                                 alpha.y * c_imag[i][j].x[ii] - beta.y * mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j].y;
    //             mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j + 16].y = alpha.x * c_imag[i][j].x[ii] + beta.x * mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j].y +
    //                                 alpha.y * c_real[i][j].x[ii] + beta.y * mem_temp[ii * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j].x;
    //         }
    //     }
    // }

    // #pragma unroll
    // for(int i = 0; i < warp_col_tiles; ++i){
    //     #pragma unroll
    //     for(int j = 0; j < warp_row_tiles; ++j){
    //         *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M) = mem_temp[0 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j + 16];
    //         *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M) = mem_temp[1 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j + 16];
    //     }
    // }
}