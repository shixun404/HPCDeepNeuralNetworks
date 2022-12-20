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
    // initial column
    int k = 0;
    // block row range: blockIdx.x * ms ~ blockIdx.x * ms + ms - 1
    // warp row id:  

    // global memory read
    // tile A size = ms x ks = 16 * 16, col major
    // tile B size = ns x ks = 16 * 16, row major
    // init double buffer with size ms * ks * 2 + ns * ks * 2 = 1024 in shared memory
    // [buffer_A_1, buffer_A_2, buffer_B_1, buffer_B_2]
    __shared__ float sAB[1024]; 
    int buffer_A_offset = 0;
    int buffer_B_offset = 2 * ms * ks;
    // tile A global offset
    // block bx read tile A with rows in [bx * ms, bx * ms + ms - 1]
    A += bx * ms;

    // tile B global offset
    // block bx read tile A with rows in [bx * ms, bx * ms + ms - 1]
    B += by * ns;

    // tile A inner offset.
    // Each thread load (16 * 16) / 64 = 4 floats from A.
    int load_tile_A_num_floats_one_thread = (int)((ms * ks) / blockDim.x);
    // number of threads to load a column of tile A: 16 floats / 4 floats = 4 threads,
    int load_tile_A_num_threads_one_col = (int)(ms / load_tile_A_num_floats_one_thread);
    // thread tx load 4 floats with rows = [(tx % 4 threads) * 4, (tx % 4  threads) * 4 + 3],
    //                              col  = (tx / 4 threads) of tile A
    A += (tx % load_tile_A_num_threads_one_col) * (load_tile_A_num_floats_one_thread) + (int)(tx / load_tile_A_num_threads_one_col) * N;

    // tile B inner offset.
    // each thread load (16 * 16) / 64 = 4 floats from B.
    int load_tile_B_num_floats_one_thread = (int)((ns * ks) / blockDim.x);
    // number of threads to load a column of tile B: 16 floats / 4 floats = 4 threads,
    int load_tile_B_num_threads_one_col = (int)(ns / load_tile_B_num_floats_one_thread);
    // thread tx load 4 floats with rows = [(tx % 4 threads) * 4, (tx % 4  threads) * 4 + 3],
    //                              col  = (tx / 4 threads) of tile A
    B += (tx % load_tile_B_num_threads_one_col) * (load_tile_B_num_floats_one_thread) + (int)(tx / load_tile_B_num_threads_one_col) * N;

    // prefetch the vector from A and B in global memory 
    float4 prefetch_vector_tile_A = *((float4*)A);
    float4 prefetch_vector_tile_B = *((float4*)B);

    // offset to store the prefetch vector
    int offset_store_prefetch = ((k / ks) & 1);
    
    // get the pointer to prefetched buffer A and prefetched buffer B
    float* buffer_A = (float*)(sAB) + buffer_A_offset + offset_store_prefetch * ms * ks;
    float* buffer_B = (float*)(sAB) + buffer_B_offset + offset_store_prefetch * ns * ks;

    // store the vectors in the prefetched buffer A and prefetched buffer B
    *(((float4*)buffer_A) + tx) = prefetch_vector_tile_A;
    *(((float4*)buffer_B) + tx) = prefetch_vector_tile_B;

    __syncthreads();

    // K loop
    for(k = 0; k < K; k += ks){
        // tile A abd tile B global offsets move forward ks columns
        A += ks * N; 
        B += ks * N; 
        // prefetch the vector from A and B in global memory 
        prefetch_vector_tile_A = *((float4*)A);
        prefetch_vector_tile_B = *((float4*)B);
        
        // inner k loop, 16
        for(int kk = 0; kk < ks; ++kk){
            
        }

        
    }
    

}