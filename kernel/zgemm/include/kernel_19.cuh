#include <stdio.h>
#include <mma.h>
using namespace nvcuda;
#define warp_col_tiles 2
#define warp_row_tiles 4
#define SKEW_KERNEL_2 4

extern __shared__ double shared_mem[];
__global__ void zgemm_19(int M, int N, int K, double *A, double *B, double *C, double2 alpha, double2 beta){
    int threadblock_tile_M = 64, threadblock_tile_N = 64;
    int tid = threadIdx.x;
    int bid_x = blockIdx.x, bid_y = blockIdx.y;
    int wid = tid / 32;
    double2 ABe[4], eTAB[2];
    double2 Be, eTA;
    float tmp_r, tmp_c, tmp_a, tmp_b;
    ABe[0].x = 0; ABe[1].x = 0; ABe[2].x = 0; ABe[3].x = 0;
    ABe[0].y = 0; ABe[1].y = 0; ABe[2].y = 0; ABe[3].y = 0;
    eTAB[0].x = 0; eTAB[1].x = 0;
    eTAB[0].y = 0; eTAB[1].y = 0;
    double2 *shared_mem_double2 = (double2*)shared_mem;
    double2 * gA = (double2*)A;
    double2 * gB = (double2*)B;
    double2 * gC = (((double2*)C));
    double zero = 0;
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
    int k = 0;
    asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
            : "l"(__cvta_generic_to_shared(sA) + (0 + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
                "l"(&A[((bid_x * 64 + tid % 64) + ((k + 0) % K + tid / 64) * M) * 2 + 0]));
    asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
        : "l"(__cvta_generic_to_shared(sA) + (0 + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
            "l"(&A[((bid_x * 64 + tid % 64) + ((k + 0) % K + tid / 64 + 4) * M) * 2 + 0]));
    asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
        : "l"(__cvta_generic_to_shared(sB) + (0 + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
            "l"(&B[(((k + 0) % K + tid / 64) + (bid_y * 64 + tid % 64) * K) * 2 + 0]));
    asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
        : "l"(__cvta_generic_to_shared(sB) + (0 + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
            "l"(&B[(((k + 0) % K + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K) * 2 + 0]));
    offset_k = (offset_k + 1) % 3;
    offset = (offset_k *  ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8));
    asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
            : "l"(__cvta_generic_to_shared(sA) + (offset + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
                "l"(&A[((bid_x * 64 + tid % 64) + ((k + 8) % K + tid / 64) * M) * 2 + 0]));
    asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
        : "l"(__cvta_generic_to_shared(sA) + (offset + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
            "l"(&A[((bid_x * 64 + tid % 64) + ((k + 8) % K + tid / 64 + 4) * M) * 2 + 0]));
    asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
        : "l"(__cvta_generic_to_shared(sB) + (offset + (tid / 64) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
            "l"(&B[(((k + 8) % K + tid / 64) + (bid_y * 64 + tid % 64) * K) * 2 + 0]));
    asm ("cp.async.ca.shared.global [%0], [%1], 16;\n" :
        : "l"(__cvta_generic_to_shared(sB) + (offset + (tid / 64 + 4) * (64 + SKEW_KERNEL_2) + (tid % 64)) * sizeof(double) * 2), 
            "l"(&B[(((k + 8) % K + tid / 64 + 4) + (bid_y * 64 + tid % 64) * K) * 2 + 0]));
    int offset_cur = ((offset_k + 2) % 3) * ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8);
    asm ("cp.async.commit_group;\n" ::);
    asm ("cp.async.wait_group 0;\n" ::);
    __syncthreads();
    b[0][0] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 0 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    b[0][1] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 1 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    

    a[0][0] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 0 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    a[0][1] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 1 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    a[0][2] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 2 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
    a[0][3] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 3 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));


 

    #pragma unroll
    for(k = 0; k < K - 16; k += 8){
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
        b[1][0] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 0 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        b[1][1] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 1 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        

        a[1][0] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 0 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[1][1] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 1 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[1][2] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 2 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[1][3] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 3 * 8) + (1 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));


        tmp_r = a[1][0].x, tmp_c = a[1][0].y;
        
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(a[1][1].x), "d"(a[1][1].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(a[1][2].x), "d"(a[1][2].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(a[1][3].x), "d"(a[1][3].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(tmp_c), "d"(tmp_r));

        // tmp_a = tmp_r;
        // tmp_r = b[1][0].x, tmp_c = b[1][0].y;
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(b[1][1].x), "d"(b[1][1].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(tmp_c), "d"(tmp_r));
        tmp_c = (float)b[1][0].y +  (float)b[1][1].y;
        tmp_r =  (float)a[1][0].y +  (float)a[1][1].y +  (float)a[1][2].y +  (float)a[1][3].y;
        
        tmp_a =  (float)a[1][0].x +  (float)a[1][1].x +  (float)a[1][2].x +  (float)a[1][3].x + tmp_r;

        tmp_b =  (float)b[1][0].x +  (float)b[1][1].x + tmp_c;
        tmp_c += tmp_c;
        // tmp_c = b[1][0].y;
        // // tmp_c += tmp_c;
        // tmp_r = a[1][0].y;
        
        // tmp_a = a[1][0].x;

        // tmp_b = b[1][0].x;
        
        asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        : "d"((double)tmp_a), "d"((double)tmp_b), "d"(c[0][0][0].y), "d"(c[0][0][1].y));
        asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        : "d"((double)tmp_r), "d"(-(double)tmp_c), "d"(c[0][0][0].y), "d"(c[0][0][1].y));
        
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        // : "d"(tmp_a), "d"(tmp_b), "d"(c[0][0][0].y), "d"(c[0][0][1].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        // : "d"(tmp_a), "d"(tmp_b), "d"(c[0][0][0].y), "d"(c[0][0][1].y));
        // Be.y = b[1][0].x + b[1][1].x;
        // Be.y += b[1][0].y + b[1][1].y;
        // eTA.y = a[1][0].x + a[1][1].x + a[1][2].x + a[1][3].x;
        // eTA.y += a[1][0].y + a[1][1].y + a[1][2].y + a[1][3].y;


        
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 16, 32);
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 8, 32);
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 4, 32);
       
        // // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 16, 32);
        // // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 8, 32);
        // // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 4, 32);

        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 16, 32);
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 8, 32);
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 4, 32);
        // ABe[0].y += eTA.y + Be.y;
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 16, 32);
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 8, 32);
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 4, 32);

        // ABe[0].x += a[1][0].x * Be.x - a[1][0].y * Be.y;
        // ABe[1].x += a[1][1].x * Be.x - a[1][1].y * Be.y;
        // ABe[2].x += a[1][2].x * Be.x - a[1][2].y * Be.y;
        // ABe[3].x += a[1][3].x * Be.x - a[1][3].y * Be.y;

        // ABe[0].y += a[1][0].x * Be.y + a[1][0].y * Be.x;
        // ABe[1].y += a[1][1].x * Be.y + a[1][1].y * Be.x;
        // ABe[2].y += a[1][2].x * Be.y + a[1][2].y * Be.x;
        // ABe[3].y += a[1][3].x * Be.y + a[1][3].y * Be.x;

        // eTAB[0].x += eTA.x * b[1][0].x - eTA.y * b[1][0].y;
        // eTAB[1].x += eTA.x * b[1][1].x - eTA.y * b[1][1].y;
        
        // eTAB[0].y += eTA.x * b[1][0].y - eTA.x * b[1][0].y;
        // eTAB[1].y += eTA.x * b[1][1].y - eTA.x * b[1][1].y;
        
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

        // Be.x = b[0][0].x + b[0][1].x;
        // Be.x += b[0][0].y + b[0][1].y;
        // eTA.x = a[0][0].x + a[0][1].x + a[0][2].x + a[0][3].x;
        // eTA.x += a[0][0].y + a[0][1].y + a[0][2].y + a[0][3].y;

        // Be.x += __shfl_xor_sync(0xffffffff, Be.x, 16, 32);
        // Be.x += __shfl_xor_sync(0xffffffff, Be.x, 8, 32);
        // Be.x += __shfl_xor_sync(0xffffffff, Be.x, 4, 32);
        
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 16, 32);
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 8, 32);
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 4, 32);

        // eTA.x += __shfl_xor_sync(0xffffffff, eTA.x, 16, 32);
        // eTA.x += __shfl_xor_sync(0xffffffff, eTA.x, 8, 32);
        // eTA.x += __shfl_xor_sync(0xffffffff, eTA.x, 4, 32);
        

        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        //         : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        //         : "d"(eTA.x), "d"(Be.x), "d"(c[0][0][0].y), "d"(c[0][0][1].y));

        // ABe[0].x += eTA.x + Be.x;

        // Be.y = b[1][0].x + b[1][1].x;
        // Be.y += b[1][0].y + b[1][1].y;
        // eTA.y = a[1][0].x + a[1][1].x + a[1][2].x + a[1][3].x;
        // eTA.y += a[1][0].y + a[1][1].y + a[1][2].y + a[1][3].y;


        
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 16, 32);
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 8, 32);
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 4, 32);
       
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 16, 32);
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 8, 32);
        // Be.y += __shfl_xor_sync(0xffffffff, Be.y, 4, 32);

        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 16, 32);
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 8, 32);
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 4, 32);
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        //         : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        //         : "d"(eTA.y), "d"(Be.y), "d"(c[0][0][0].y), "d"(c[0][0][1].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        //         : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        //         : "d"(b[1][0].y), "d"(b[1][0].y), "d"(c[0][0][0].y), "d"(c[0][0][1].y));

        
        // ABe[0].y += eTA.y + Be.y;

        offset_k = (offset_k + 1) % 3;
        offset = (offset_k * ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8));
        offset_cur = ((offset_k + 2) % 3) * ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8);
        
        asm ("cp.async.commit_group;\n" ::);
        asm ("cp.async.wait_group 1;\n" ::);
        __syncthreads();
        b[0][0] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 0 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        b[0][1] = *(sB + offset_cur + ((wid / 2) * 16 + (tid % 32) / 4 + 1 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        

        a[0][0] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 0 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[0][1] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 1 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[0][2] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 2 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        a[0][3] = *(sA + offset_cur + ((wid % 2) * 32 + (tid % 32) / 4 + 3 * 8) + (0 * 4 + (tid % 32) % 4) * (64 + SKEW_KERNEL_2));
        
        

        // tmp_r = a[0][0].x, tmp_c = a[0][0].y;
        // tmp_r = a[0][0].x + a[0][1].x + a[0][2].x + a[0][3].x;
        // tmp_c = a[0][0].y + a[0][1].y + a[0][2].y + a[0][3].y;

        // tmp_r += tmp_c;
        // tmp_r += tmp_c;
        
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(a[0][1].x), "d"(a[0][1].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(a[0][2].x), "d"(a[0][2].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(a[0][3].x), "d"(a[0][3].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(tmp_c), "d"(tmp_r));

        // tmp_a = tmp_r;
        // tmp_r = b[0][0].x, tmp_c = b[0][0].y;
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(b[0][1].x), "d"(b[0][1].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(tmp_r), "=d"(tmp_c)
        // : "d"(zero), "d"(zero), "d"(tmp_c), "d"(tmp_r));
        
        tmp_c = (float)b[0][0].y +  (float)b[0][1].y;
        tmp_r =  (float)a[0][0].y +  (float)a[0][1].y +  (float)a[0][2].y +  (float)a[0][3].y;
        
        tmp_a =  (float)a[0][0].x +  (float)a[0][1].x +  (float)a[0][2].x +  (float)a[0][3].x + tmp_r;

        tmp_b =  (float)b[0][0].x +  (float)b[0][1].x + tmp_c;
        tmp_c += tmp_c;
        // tmp_c = b[1][0].y;
        // // tmp_c += tmp_c;
        // tmp_r = a[1][0].y;
        
        // tmp_a = a[1][0].x;

        // tmp_b = b[1][0].x;
        
        asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        : "d"((double)tmp_a), "d"((double)tmp_b), "d"(c[0][0][0].y), "d"(c[0][0][1].y));
        asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        : "d"((double)tmp_r), "d"(-(double)tmp_c), "d"(c[0][0][0].y), "d"(c[0][0][1].y));
        // asm volatile("mma.sync.aligned.m8n8k4.row.col.f64.f64.f64.f64 {%0,%1}, {%2}, {%3}, {%4,%5};\n"
        // : "=d"(c[0][0][0].y), "=d"(c[0][0][1].y)
        // : "d"(tmp_r), "d"(-tmp_c), "d"(c[0][0][0].y), "d"(c[0][0][1].y));
        


        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 16, 32);
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 8, 32);
        // eTA.y += __shfl_xor_sync(0xffffffff, eTA.y, 4, 32);

        // ABe[0].x += a[0][0].x * Be.x - a[0][0].y * Be.y;
        // ABe[1].x += a[0][1].x * Be.x - a[0][1].y * Be.y;
        // ABe[2].x += a[0][2].x * Be.x - a[0][2].y * Be.y;
        // ABe[3].x += a[0][3].x * Be.x - a[0][3].y * Be.y;

        // ABe[0].y += a[0][0].x * Be.y + a[0][0].y * Be.x;
        // ABe[1].y += a[0][1].x * Be.y + a[0][1].y * Be.x;
        // ABe[2].y += a[0][2].x * Be.y + a[0][2].y * Be.x;
        // ABe[3].y += a[0][3].x * Be.y + a[0][3].y * Be.x;

        // eTAB[0].x += eTA.x * b[0][0].x - eTA.y * b[0][0].y;
        // eTAB[1].x += eTA.x * b[0][1].x - eTA.y * b[0][1].y;
        
        // eTAB[0].y += eTA.x * b[0][0].y - eTA.x * b[0][0].y;
        // eTAB[1].y += eTA.x * b[0][1].y - eTA.x * b[0][1].y;
        
    }


    #pragma unroll
    for(; k < K; k += 8){
        int offset_cur = ((offset_k + 2) % 3) * ((64 + SKEW_KERNEL_2 + 64 + SKEW_KERNEL_2) * 8);    
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
            mem_temp[0].x += eTAB[0].x + eTAB[1].x + eTAB[0].y + eTAB[1].y;
            mem_temp[0].x += ABe[0].x + ABe[1].x + ABe[2].x + ABe[3].x + ABe[0].y + ABe[1].y + ABe[2].y + ABe[3].y;
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
    
}