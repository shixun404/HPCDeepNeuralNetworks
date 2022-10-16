#include <stdio.h>
//#include "../kernels.cuh"
#define m 8
#define kk_max 1<<10
#define tab(t, a, b)t.x += a.x * b;t.y += a.y * b;  t.z += a.z * b;t.w += a.w * b;  
    
// #define tcab(t, c, alpha, beta) c = alpha * t + beta * c;
#define tcab(t, c, alpha, beta) \
    c.x = alpha * t.x + beta * c.x;\
    c.y = alpha * t.y + beta * c.y;\
    c.z = alpha * t.z + beta * c.z;\
    c.w = alpha * t.w + beta * c.w;
    

__global__  __launch_bounds__(256) void sgemm_9(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[1024];
    int tx = threadIdx.x;
    int tidx = (tx & 15), tidy = (tx>>4);
    int bx = blockIdx.x, by = blockIdx.y;
    int tidx_3 = (tidx << 3), tidy_3 = (tidy << 3);
    int i1 = tidx_3 + (bx<<7);
    int j1 = tidy_3 + (by<<7);
    float4 t[16], bb0,aa0,bb1, aa1, C1[16];
    int idx = tx & 31, idy = tx >> 5;
    memset(t, 0, sizeof(t));
    int idx_4 = (idx<<2), idy_128 = (idy << 7), by_128 = (by << 7);
    // int A_gap = (idx_4 + by_128)*N;
    int A_gap = ((tx&127) + by_128) * N;
    // A = A + A_gap + idy;
    A = A + A_gap + ((tx >> 7) << 2);
    B = B + idx_4 + (bx << 7) + idy * N;
    for(int k = 0; k < N; k += 8){
        float4 *a = (float4*)A;
        shared_A[(tx&127) + ((((tx >> 7)<<2) + 0)<<7) ]= (*a).x;
        shared_A[(tx&127) + ((((tx >> 7)<<2) + 1)<<7) ]= (*a).y;
        shared_A[(tx&127) + ((((tx >> 7)<<2) + 2)<<7) ]= (*a).z; 
        shared_A[(tx&127) + ((((tx >> 7)<<2) + 3)<<7) ]= (*a).w;
        *(float4*)(shared_B + idx_4 + idy_128) = *(float4*)(B);
        B += (N<<3);
        A += 8; 
        __syncthreads(); 
        #pragma unroll
        for(int kk = 0; kk < 8; kk+=1){
            bb0 = *(float4*)(shared_B + tidx_3 + (kk<<7));
            bb1 = *(float4*)(shared_B + tidx_3 + 4 + (kk<<7));
            aa0 = *(float4*)(shared_A + tidy_3 + (kk<<7));
            aa1 = *(float4*)(shared_A + tidy_3 + 4 + (kk<<7));
            tab(t[0], bb0, aa0.x);
            tab(t[1], bb1, aa0.x);
            tab(t[2], bb0, aa0.y);
            tab(t[3], bb1, aa0.y);
            tab(t[4], bb0, aa0.z);
            tab(t[5], bb1, aa0.z);
            tab(t[6], bb0, aa0.w);
            tab(t[7], bb1, aa0.w);

            tab(t[8], bb0, aa1.x);
            tab(t[9], bb1, aa1.x);
            tab(t[10], bb0, aa1.y);
            tab(t[11], bb1, aa1.y);
            tab(t[12], bb0, aa1.z);
            tab(t[13], bb1, aa1.z);
            tab(t[14], bb0, aa1.w);
            tab(t[15], bb1, aa1.w);

        }
        __syncthreads();
    }
    C1[0] = *(float4*)(C + i1 + j1 * N);
    C1[1] = *(float4*)(C + i1 + 4 + j1 * N);
    
    C1[2] = *(float4*)(C + i1 + (j1 + 1) * N);
    C1[3] = *(float4*)(C + i1 + 4 + (j1 + 1) * N);

    C1[4] = *(float4*)(C + i1 + (j1 + 2) * N);
    C1[5] = *(float4*)(C + i1 + 4 + (j1 + 2) * N);

    C1[6] = *(float4*)(C + i1 + (j1 + 3) * N);
    C1[7] = *(float4*)(C + i1 + 4 + (j1 + 3) * N);

    C1[8] = *(float4*)(C + i1 + (j1 + 4) * N);
    C1[9] = *(float4*)(C + i1 + 4 + (j1 + 4) * N);
    
    C1[10] = *(float4*)(C + i1 + (j1 + 5) * N);
    C1[11] = *(float4*)(C + i1 + 4 + (j1 + 5) * N);

    C1[12] = *(float4*)(C + i1 + (j1 + 6) * N);
    C1[13] = *(float4*)(C + i1 + 4 + (j1 + 6) * N);

    C1[14] = *(float4*)(C + i1 + (j1 + 7) * N);
    C1[15] = *(float4*)(C + i1 + 4 + (j1 + 7) * N);
    
    tcab(t[0], C1[0], alpha, beta);
    tcab(t[1], C1[1], alpha, beta);
    tcab(t[2], C1[2], alpha, beta);
    tcab(t[3], C1[3], alpha, beta);
    tcab(t[4], C1[4], alpha, beta);
    tcab(t[5], C1[5], alpha, beta);
    tcab(t[6], C1[6], alpha, beta);
    tcab(t[7], C1[7], alpha, beta);
    tcab(t[8], C1[8], alpha, beta);
    tcab(t[9], C1[9], alpha, beta);
    tcab(t[10], C1[10], alpha, beta);
    tcab(t[11], C1[11], alpha, beta);
    tcab(t[12], C1[12], alpha, beta);
    tcab(t[13], C1[13], alpha, beta);
    tcab(t[14], C1[14], alpha, beta);
    tcab(t[15], C1[15], alpha, beta);
    *(float4*)(C + i1 + j1 * N) = C1[0]; 
    *(float4*)(C + i1 + 4 + j1 * N) = C1[1];


    *(float4*)(C + i1 + (j1 + 1) * N) = C1[2];
    *(float4*)(C + i1 + 4 + (j1 + 1) * N) = C1[3];
    
    *(float4*)(C + i1 + (j1 + 2) * N) = C1[4];
    *(float4*)(C + i1 + 4 + (j1 + 2) * N) = C1[5];
    
    *(float4*)(C + i1 + (j1 + 3) * N) = C1[6];
    *(float4*)(C + i1 + 4 + (j1 + 3) * N) = C1[7];
    
    *(float4*)(C + i1 + (j1 + 4) * N) = C1[8];
    *(float4*)(C + i1 + 4 + (j1 + 4) * N) = C1[9];

    *(float4*)(C + i1 + (j1 + 5) * N) = C1[10];
    *(float4*)(C + i1 + 4 + (j1 + 5) * N) = C1[11];

    *(float4*)(C + i1 + (j1 + 6) * N) = C1[12];
    *(float4*)(C + i1 + 4 + (j1 + 6) * N) = C1[13];

    *(float4*)(C + i1 + (j1 + 7) * N) = C1[14];
    *(float4*)(C + i1 + 4 + (j1 + 7) * N) = C1[15];
}