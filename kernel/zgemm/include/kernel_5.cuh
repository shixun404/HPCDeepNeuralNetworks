#include <stdio.h>
#include <mma.h>
using namespace nvcuda;
#define warp_col_tiles 2
#define warp_row_tiles 4
#define SKEW_KERNEL_2 4
__global__ void zgemm_5(int M, int N, int K, double *A, double *B, double *C, double2 alpha, double2 beta){
    int threadblock_tile_M = 64, threadblock_tile_N = 64;
    int tid = threadIdx.x;
    int bid_x = blockIdx.x, bid_y = blockIdx.y;
    int wid = tid / 32;
    
    // __shared__ double shared_mem[64 * 16];
    __shared__ double shared_mem[(64 + SKEW_KERNEL_2) * 16 * 2];

    double2 * gA = (double2*)A;
    double2 * gB = (double2*)B;
    double2 * gC = (((double2*)C));
    
    // double* sA_real = (shared_mem + 256 * 0);
    // double* sA_imag = (shared_mem + 256 * 1);
    // double* sB_real = (shared_mem + 256 * 2);
    // double* sB_imag = (shared_mem + 256 * 3);
    double* sA_real = (shared_mem + (64 + SKEW_KERNEL_2) * 8 * 0);
    double* sA_imag = (shared_mem + (64 + SKEW_KERNEL_2) * 8 * 1);
    double* sB_real = (shared_mem + (64 + SKEW_KERNEL_2) * 8 * 2);
    double* sB_imag = (shared_mem + (64 + SKEW_KERNEL_2) * 8 * 3);
    
    double2 mem_temp[4];
    // beta /= alpha;

    // // global C to shared c
    // #pragma unroll
    // for(int i = 0; i < 16; ++i){
    //     mem_temp = *(gC + (i * blockDim.x + tid) % 64 + (i * blockDim.x + tid) / 64 * M);
    //     *(sC_real + i * blockDim.x) = mem_temp.x;
    //     *(sC_imag + i * blockDim.x) = mem_temp.y;
    // }

    // __syncthreads();
    // //// frag_c real and frag_c imag initialization
    wmma::fragment<wmma::accumulator, 8, 8, 4, double> c_real[warp_col_tiles][warp_row_tiles];
    wmma::fragment<wmma::accumulator, 8, 8, 4, double> c_imag[warp_col_tiles][warp_row_tiles];
    wmma::fragment<wmma::matrix_a, 8, 8, 4, double, wmma::col_major> a_real_frag[4];
    wmma::fragment<wmma::matrix_a, 8, 8, 4, double, wmma::col_major> a_imag_frag[4];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> b_real_frag[2];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> b_imag_frag[2];
    wmma::fragment<wmma::matrix_b, 8, 8, 4, double, wmma::row_major> neg_b_imag_frag[2];
    
    #pragma unroll
    for(int i = 0; i < warp_col_tiles; i++){
        #pragma unroll
        for(int j = 0; j < warp_row_tiles; j++){
            wmma::fill_fragment(c_real[i][j], (double)0.0f);        
            wmma::fill_fragment(c_imag[i][j], (double)0.0f);        
        }
    }
    
    
    
    // Load A, B into shared memory, do MMA
    //// global A to shared a
    //// global B to shared b
    #pragma unroll
    for(int k = 0; k < K; k += 8){
        mem_temp[0] = *(gA + (bid_x * 64 + tid % 64) + (k + tid / 64) * M);
        mem_temp[1] = *(gA + (bid_x * 64 + tid % 64) + (k + tid / 64 + 4) * M);
        mem_temp[2] = *(gB + (k + tid / 64) + (bid_y * 64 + tid % 64) * K);
        mem_temp[3] = *(gB + (k + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K);

        *(sA_real + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) = mem_temp[0].x;
        *(sA_imag + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) = mem_temp[0].y;
        
        *(sA_real + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) = mem_temp[1].x;
        *(sA_imag + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) = mem_temp[1].y;
        
        
        
        
        *(sB_real + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) = mem_temp[2].x;
        *(sB_imag + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) = mem_temp[2].y;
        *(sB_real + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) = mem_temp[3].x;
        *(sB_imag + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) = mem_temp[3].y;
        
        __syncthreads();
        // wmma::load_matrix_sync(a_real_frag[0], sA_real + (wid % 2) * 32 + 0 * 8, 64);
        // wmma::load_matrix_sync(a_imag_frag[0], sA_imag + (wid % 2) * 32 + 0 * 8, 64);
        // wmma::load_matrix_sync(a_real_frag[1], sA_real + (wid % 2) * 32 + 1 * 8, 64);
        // wmma::load_matrix_sync(a_imag_frag[1], sA_imag + (wid % 2) * 32 + 1 * 8, 64);
        // wmma::load_matrix_sync(a_real_frag[2], sA_real + (wid % 2) * 32 + 2 * 8, 64);
        // wmma::load_matrix_sync(a_imag_frag[2], sA_imag + (wid % 2) * 32 + 2 * 8, 64);
        // wmma::load_matrix_sync(a_real_frag[3], sA_real + (wid % 2) * 32 + 3 * 8, 64);
        // wmma::load_matrix_sync(a_imag_frag[3], sA_imag + (wid % 2) * 32 + 3 * 8, 64);
        
        // wmma::load_matrix_sync(b_real_frag[0], sB_real + (wid / 2) * 16 + 0 * 8, 64);
        // wmma::load_matrix_sync(b_imag_frag[0], sB_imag + (wid / 2) * 16 + 0 * 8, 64);
        // wmma::load_matrix_sync(b_real_frag[1], sB_real + (wid / 2) * 16 + 1 * 8, 64);
        // wmma::load_matrix_sync(b_imag_frag[1], sB_imag + (wid / 2) * 16 + 1 * 8, 64);
        for(int kk = 0; kk < 2; ++kk){
            wmma::load_matrix_sync(a_real_frag[0], sA_real + (wid % 2) * 32 + 0 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_imag_frag[0], sA_imag + (wid % 2) * 32 + 0 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_real_frag[1], sA_real + (wid % 2) * 32 + 1 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_imag_frag[1], sA_imag + (wid % 2) * 32 + 1 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_real_frag[2], sA_real + (wid % 2) * 32 + 2 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_imag_frag[2], sA_imag + (wid % 2) * 32 + 2 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_real_frag[3], sA_real + (wid % 2) * 32 + 3 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(a_imag_frag[3], sA_imag + (wid % 2) * 32 + 3 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            
            wmma::load_matrix_sync(b_real_frag[0], sB_real + (wid / 2) * 16 + 0 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_imag_frag[0], sB_imag + (wid / 2) * 16 + 0 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_real_frag[1], sB_real + (wid / 2) * 16 + 1 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            wmma::load_matrix_sync(b_imag_frag[1], sB_imag + (wid / 2) * 16 + 1 * 8 + kk * 4 * (64 + SKEW_KERNEL_2), (64 + SKEW_KERNEL_2));
            
            for(int ii = 0; ii < neg_b_imag_frag[0].num_elements; ii++) {
                neg_b_imag_frag[0].x[ii] = (double)-1.0f * b_imag_frag[0].x[ii];
                neg_b_imag_frag[1].x[ii] = (double)-1.0f * b_imag_frag[1].x[ii];
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
        // __syncthreads();
    }
    
    for(int i = 0; i < warp_col_tiles; ++i){
        for(int j = 0; j < warp_row_tiles; ++j){
            mem_temp[0] =   *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
            mem_temp[1] =   *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
            for(int ii = 0; ii < c_real[i][j].num_elements; ii++) {
                mem_temp[ii + 2].x = alpha.x * c_real[i][j].x[ii] + beta.x * mem_temp[ii].x - 
                                    alpha.y * c_imag[i][j].x[ii] - beta.y * mem_temp[ii].y;
                mem_temp[ii + 2].y = alpha.x * c_imag[i][j].x[ii] + beta.x * mem_temp[ii].y +
                                    alpha.y * c_real[i][j].x[ii] + beta.y * mem_temp[ii].x;
            }
            // __syncthreads();
            // wmma::store_matrix_sync(gC + ((wid % 2) * 32 + j * 8) + ((wid / 2) * 16 + i * 8) * M
            //                         , c_real[i][j], M, wmma::col_major);
            // if(tid % 32 == 0)printf("bx: %d, by: %d, tx: %d, c[0].real: %f, c[0].imag: %f, c[1].real: %f, c[1].imag: %f, r_real %d c_real %d  r_imag %d  c_imag %d\n", bid_x, bid_y, tid,  mem_temp[0].x,  mem_temp[0].y,  mem_temp[1].x, mem_temp[1].y
            // , bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) % 4) * 2 + 0,
            // (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) / 4)),
            // bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) % 4) * 2 + 1,
            // (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) / 4))
            // );
            // mem_temp[0].x = 0;
            // mem_temp[0].y = 0;
            *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M) = mem_temp[0 + 2];
            *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M) = mem_temp[1 + 2];

        }
    }
}