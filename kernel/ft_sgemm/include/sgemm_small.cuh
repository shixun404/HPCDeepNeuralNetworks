#include <stdio.h>

#define m 8
#define kk_max 1024
#define tab(t, a, b)t.x += a.x * b;t.y += a.y * b;  t.z += a.z * b;t.w += a.w * b;  
    
// #define tcab(t, c, alpha, beta) c = alpha * t + beta * c;
#define tcab(t, c, alpha, beta) \
    c.x = alpha * t.x + beta * c.x;\
    c.y = alpha * t.y + beta * c.y;\
    c.z = alpha * t.z + beta * c.z;\
    c.w = alpha * t.w + beta * c.w;
    
__global__  __launch_bounds__(256) void sgemm_small(int N, int K, float *A, float *B, float *C, float alpha, float beta){
    // ms = ns = ks = 16
    // mw = 16, nw = 8
    // mr = 2, nr = 2
    // blockId, warpId, and threadIdx
    int ms = 16, ns = 16, ks = 16, mw = 16, nw = 8, mr = 2, nr = 2;
    int bx = blockIdx.x, by = blockIdx.y, wid = (threadIdx.x >> 5), wx = 0, wy = 0, tx = threadIdx.x; 
    // threadIdx in the warp
    int tx_w = ((tx & 31) & 7), ty_w = ((tx & 31) >> 3);
    // block row range: blockIdx.x * ms ~ blockIdx.x * ms + ms - 1
    // warp row id:  
    // global memory read
    // A tile: size = ms x ks = 16 * 16
    // Each thread load (16 * 16) / 64 = 4 floats from A.
    int load_tile_A_num_floats_one_thread = (int)((ms * ks) / blockDim.x);
    // Number of threads to load a column of tile A: 16 floats / 4 floats = 4 threads,
    int load_tile_A_num_threads_one_col = (int)(ms / load_tile_A_num_floats_one_thread);
    // Thread tx load 4 floats with rows [(tx % 4 threads) * 4, (tx % 4  threads) * 4 + 3],
    //                              col (tx / 4 threads) of tile A
    int load_offset_A = (tx % load_tile_A_num_threads_one_col) * (load_tile_A_num_floats_one_thread) + (int)(tx / load_tile_A_num_threads_one_col) * N;
    //   bx * 16
    A +=load_offset_A; 
    
    
    // shared memory size 
    // shared a tile & shared b tile ns * ks + ms * ks = 512
    // double buffer 2 * 512 = 1024
    extern __shared__ float shared_ab[];   
    
    
    B

    // prefetch 


    // K loop
    for(int k = 0; k < K; k += ks){
        // load global A, global B

        // inner k loop, 16
        for(int kk = 0; kk < ks; ++kk){
            
        }
    }
    

}