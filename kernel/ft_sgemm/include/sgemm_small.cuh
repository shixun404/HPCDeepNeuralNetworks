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
    int ms = 16, ns = 16, ks = 16, mw = 8, nw = 16, mr = 2, nr = 2;
    int bx = blockIdx.x, by = blockIdx.ytx = threadIdx.x; 
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
    
    // warp size mw x nw (8 x 16)
    //           -----------------
    //          |      vec B      |
    //           -----------------                 
    //  -----    -----------------    -             -
    // |     |  |     warp 0      |   | mw = 8      | ms = 16
    // | vec |  |                 |   |             | 
    // |     |   -----------------    -             |
    // |  A  |  |     warp 1      |                 | 
    // |     |  |                 |                 |
    //  -----    -----------------                  -
    //              ns = nw = 16

    // numbers of warp along A vector and B vector
    int num_warp_A = int(ms / mw);
    int num_warp_B = int(ns / nw);
    
    // 1D warp id =  tx % 32
    int id_warp = (tx & 31)
    
    // 2D warp arrangement, row major
    // 2D warp idB = 1D warp id % num_warp_B
    //         idA = 1D warp id / num_warp_B    
    int idB_warp = id_warp % num_warp_B;
    int idA_warp = int(id_warp / num_warp_B);
    
    // offset for the warp tile
    // offset vec A = 2D warp idA * mw
    // offset vec B = 2D warp idB * nw
    int offset_vec_A_warp = idA_warp * mw;
    int offset_vec_B_warp = idB_warp * nw;

    // inner warp thread arrangement 1, row major
    //                warp 0
    //      --------------------------             -
    //     |  0  1  2  3  4  5  6  7  |  mr = 2    |  mw = 8  
    //     |  8  9 10 11 12 13 14 15  |            |
    //     | 16 17 18 19 20 21 22 23  |            |
    //     | 24 25 26 27 28 29 30 31  |            |
    //      --------------------------             -
    //      nr = 2
    //      nw = nr * 8 = 16

    //2D thread idB = tx % (nw / nr)
    //          idA = tx / (nw / nr)
    int idB_thread = tx % (nw / nr);
    int idA_thread = int(tx / (nw / nr));

    // offset for the threads
    // offset vec A = 2D thread idA * mr
    // offset vec B = 2D thread idA * nr
    int offset_vec_A_thread = idA_thread * mr;
    int offset_vec_B_thread = idB_thread * nr;
    
    // inner warp thread arrangement 2, col major
    //                warp 0
    //      --------------------------             -
    //     |  0  4  8 12 16 20 24 28  |  mr = 2    |  mw = 8  
    //     |  1  5  9 13 17 21 25 29  |            |
    //     |  2  6 10 14 18 22 26 30  |            |
    //     |  3  7 11 15 19 23 27 31  |            |
    //      --------------------------             -
    //      nr = 2
    //      nw = nr * 8 = 16

    
    
    
    // load two vectors with size 2 from buffer A and buffer B into registers
    // mr = 2, nr = 2
    float2 vec_A  = {0.0, 0.0};
    float2 vec_B  = {0.0, 0.0};
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
        
        // update offset to store the prefetch vector
        offset_store_prefetch = (((int)(k / ks)) & 1);
        
        // update the pointer to prefetched buffer A and prefetched buffer B
        buffer_A = (float*)(sAB) + buffer_A_offset + offset_store_prefetch * ms * ks;
        buffer_B = (float*)(sAB) + buffer_B_offset + offset_store_prefetch * ns * ks;
        
        // store the vectors in the prefetched buffer A and prefetched buffer B
        *(((float4*)buffer_A) + tx) = prefetch_vector_tile_A;
        *(((float4*)buffer_B) + tx) = prefetch_vector_tile_B;
        __syncthreads();


    }
    

}