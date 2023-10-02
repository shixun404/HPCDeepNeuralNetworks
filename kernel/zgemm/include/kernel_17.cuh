#include <stdio.h>
#include <mma.h>
using namespace nvcuda;
#define warp_col_tiles 2
#define warp_row_tiles 4
#define SKEW_KERNEL_2 0
extern __shared__ double shared_mem[];
__global__ void zgemm_17(int M, int N, int K, double *A, double *B, double *C, double2 alpha, double2 beta){
    int threadblock_tile_M = 64, threadblock_tile_N = 64;
    int tid = threadIdx.x;
    int bid_x = blockIdx.x, bid_y = blockIdx.y;
    int wid = tid / 32;
    
    
    // __shared__ double shared_mem[((64 + SKEW_KERNEL_2) * 16 * 2) * 2];
    double2 *shared_mem_double2 = (double2*)shared_mem;
    double2 * gA = (double2*)A;
    double2 * gB = (double2*)B;
    double2 * gC = (((double2*)C));

    double2* sA = (shared_mem_double2 + (64 + SKEW_KERNEL_2) * 8 * 0);
    double2* sB = (shared_mem_double2 + (64 + SKEW_KERNEL_2) * 8 * 1);
    
    double2 mem_temp[32];
    
    double2 c[warp_col_tiles][warp_row_tiles][2];
    double2 a[2][4];
    double2 b[2][2];
    
    #pragma unroll
    for(int i = 0; i < warp_col_tiles; i++){
        #pragma unroll
        for(int j = 0; j < warp_row_tiles; j++){
            c[i][j][0].x = 0;
            c[i][j][0].y = 0;
            c[i][j][1].x = 0;
            c[i][j][1].y = 0;
            
        }
    }
    int offset = 0, offset_k = 0;
    
    mem_temp[0] = *(gA + (bid_x * 64 + tid % 64) + (0 + tid / 64 + 0) * M);
    mem_temp[1] = *(gA + (bid_x * 64 + tid % 64) + (0 + tid / 64 + 4) * M);
    mem_temp[2] = *(gB + (0 + tid / 64 + 0) + (bid_y * 64 + tid % 64) * K);
    mem_temp[3] = *(gB + (0 + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K);

    *(sA + (tid / 64 + 0) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[0];
    *(sA + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[1];
    *(sB + (tid / 64 + 0) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[2];
    *(sB + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[3];

    __syncthreads();
    offset_k = (offset_k + 1) % 3;
    offset = (offset_k *  ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8));

    mem_temp[0] = *(gA + (bid_x * 64 + tid % 64) + (8 + tid / 64 + 0) * M);
    mem_temp[1] = *(gA + (bid_x * 64 + tid % 64) + (8 + tid / 64 + 4) * M);
    mem_temp[2] = *(gB + (8 + tid / 64 + 0) + (bid_y * 64 + tid % 64) * K);
    mem_temp[3] = *(gB + (8 + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K);

    *(sA + (tid / 64 + 0) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[0];
    *(sA + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[1];
    *(sB + (tid / 64 + 0) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[2];
    *(sB + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64) + offset) = mem_temp[3];
    int offset_cur = ((offset_k + 2) % 3) * ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8);
    
    __syncthreads();
    b[0][0] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 0 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    b[0][1] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 1 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    

    a[0][0] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 0 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    a[0][1] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 1 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    a[0][2] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 2 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    a[0][3] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 3 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));




    #pragma unroll
    for(int k = 0; k < K; k += 8){
        // mem_temp[0] = *(gA + (bid_x * 64 + tid % 64) + (k + 8 + tid / 64) * M);
        // mem_temp[1] = *(gA + (bid_x * 64 + tid % 64) + (k + 8 + tid / 64 + 4) * M);
        // mem_temp[2] = *(gB + (k + 8 + tid / 64) + (bid_y * 64 + tid % 64) * K);
        // mem_temp[3] = *(gB + (k + 8 + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K);

        int offset_next_k = (offset_k + 1) % 3;
        int offset_next = (offset_next_k *  ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8));
        asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
            : "l"(__cvta_generic_to_shared(sA) + (offset_next + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
                "l"(&A[((bid_x * 64 + tid % 64) + ((k + 16) % K + tid / 64) * M) * 2 + 0]));
        asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
            : "l"(__cvta_generic_to_shared(sA) + (offset_next + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
                "l"(&A[((bid_x * 64 + tid % 64) + ((k + 16) % K + tid / 64 + 4) * M) * 2 + 0]));

        asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
            : "l"(__cvta_generic_to_shared(sB) + (offset_next + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
                "l"(&B[(((k + 16) % K + tid / 64) + (bid_y * 64 + tid % 64) * K) * 2 + 0]));
        asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
            : "l"(__cvta_generic_to_shared(sB) + (offset_next + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
                "l"(&B[(((k + 16) % K + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K) * 2 + 0]));

        int offset_cur = ((offset_k + 2) % 3) * ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8);
        // #pragma unroll
        // for(int kk = 0; kk < 2; ++kk){   
            
            b[1][0] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 0 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
            b[1][1] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 1 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
            

            a[1][0] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 0 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
            a[1][1] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 1 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
            a[1][2] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 2 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
            a[1][3] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 3 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));

            #pragma unroll
            for(int i = 0; i < warp_col_tiles; ++i){
                #pragma unroll
                for(int j = 0; j < warp_row_tiles; ++j){
                    asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
                    : "=d"(c[i][j][0].x), "=d"(c[i][j][1].x)
                    : "d"(a[0][j].x), "d"(b[0][i].x), "d"(c[i][j][0].x), "d"(c[i][j][1].x));

                    asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
                    : "=d"(c[i][j][0].x), "=d"(c[i][j][1].x)
                    : "d"(a[0][j].y), "d"(-b[0][i].y), "d"(c[i][j][0].x), "d"(c[i][j][1].x));

                    asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
                    : "=d"(c[i][j][0].y), "=d"(c[i][j][1].y)
                    : "d"(a[0][j].x), "d"(b[0][i].y), "d"(c[i][j][0].y), "d"(c[i][j][1].y));

                    asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
                    : "=d"(c[i][j][0].y), "=d"(c[i][j][1].y)
                    : "d"(a[0][j].y), "d"(b[0][i].x), "d"(c[i][j][0].y), "d"(c[i][j][1].y));
                }
            }

            #pragma unroll
            for(int i = 0; i < warp_col_tiles; ++i){
                #pragma unroll
                for(int j = 0; j < warp_row_tiles; ++j){
                    asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
                    : "=d"(c[i][j][0].x), "=d"(c[i][j][1].x)
                    : "d"(a[1][j].x), "d"(b[1][i].x), "d"(c[i][j][0].x), "d"(c[i][j][1].x));

                    asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
                    : "=d"(c[i][j][0].x), "=d"(c[i][j][1].x)
                    : "d"(a[1][j].y), "d"(-b[1][i].y), "d"(c[i][j][0].x), "d"(c[i][j][1].x));

                    asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
                    : "=d"(c[i][j][0].y), "=d"(c[i][j][1].y)
                    : "d"(a[1][j].x), "d"(b[1][i].y), "d"(c[i][j][0].y), "d"(c[i][j][1].y));

                    asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
                    : "=d"(c[i][j][0].y), "=d"(c[i][j][1].y)
                    : "d"(a[1][j].y), "d"(b[1][i].x), "d"(c[i][j][0].y), "d"(c[i][j][1].y));
                }
            }
        // }
        offset_k = (offset_k + 1) % 3;
        offset = (offset_k * ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8));
        offset_cur = ((offset_k + 2) % 3) * ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8);
        
        asm ("cp.async.commit_group;\n" ::);
        asm ("cp.async.wait_group 0;\n" ::);
        __syncthreads();
        b[0][0] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 0 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        b[0][1] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 1 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        

        a[0][0] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 0 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[0][1] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 1 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[0][2] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 2 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[0][3] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 3 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));




    }

    
    
    #pragma unroll
    for(int i = 0; i < warp_col_tiles; ++i){
        #pragma unroll
        for(int j = 0; j < warp_row_tiles; ++j){
            mem_temp[0] = *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
            mem_temp[1] = *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
            #pragma unroll
            for(int ii = 0; ii < 2; ii++) {
                mem_temp[ii + 2].x = alpha.x * c[i][j][ii].x + beta.x * mem_temp[ii].x - 
                                        alpha.y * c[i][j][ii].y - beta.y * mem_temp[ii].y;
                mem_temp[ii + 2].y = alpha.x * c[i][j][ii].y + beta.x * mem_temp[ii].y +
                                        alpha.y * c[i][j][ii].x + beta.y * mem_temp[ii].x;       
            }
            *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M) = mem_temp[0 + 2];
            *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M) = mem_temp[1 + 2];

        }
    }
    
    // #pragma unroll
    // for(int i = 0; i < warp_col_tiles; ++i){
    //     #pragma unroll
    //     for(int j = 0; j < warp_row_tiles; ++j){
    //         mem_temp[0 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j] =   *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 0) * M);
    //         mem_temp[1 * warp_col_tiles * warp_row_tiles + i * warp_row_tiles + j] =   *(gC + (bid_x * 64 + (wid % 2) * 32 + j * 8 + ((tid % 32) / 4)) + (bid_y * 64 + (wid / 2) * 16 + i * 8 + ((tid % 32) % 4) * 2 + 1) * M);
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