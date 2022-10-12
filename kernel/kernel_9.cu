#include <stdio.h>
//#include "../kernels.cuh"
#define m 8
#define tab(t, a, b)t.x += a.x * b;t.y += a.y * b;  t.z += a.z * b;t.w += a.w * b;  
    
#define tcab(t, c, alpha, beta) c = alpha * t + beta * c;

__global__  __launch_bounds__(256) void sgemm_9(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[1024];
    int tidx = threadIdx.x, tidy = threadIdx.y;
    int i1 = threadIdx.x * m + blockIdx.x * blockDim.x * m;
    int j1 = threadIdx.y * m + blockIdx.y * blockDim.y * m;
    float4 t[16], bb0,aa0,bb1, aa1, C1[16];
    int id = threadIdx.y * blockDim.x + threadIdx.x;
    int idx = id % 32, idy = id / 32;
    memset(t, 0, sizeof(t));
    int max_k = N / m;
    for(int k = 0; k < max_k; k++){
        // float4 *a = (float4 *)(shared_A + idx * 4 + idy * 128);
        shared_A[idx * 4 + idy * 128] = A[idy + k * 8 + (idx * 4 + 128 * blockIdx.y + 0) * N];
        shared_A[idx * 4 + 1 + idy * 128] = A[idy + k * 8 + (idx * 4 + 128 * blockIdx.y + 1) * N];
        shared_A[idx * 4 + 2 + idy * 128] = A[idy + k * 8 + (idx * 4 + 128 * blockIdx.y + 2) * N];
        shared_A[idx * 4 + 3 + idy * 128] = A[idy + k * 8 + (idx * 4 + 128 * blockIdx.y + 3) * N];
        // shared_A[idx * 4 + idy * 128] = A[id / 32 + k * 8 + (id % 32 * 4 + 128 * blockIdx.y + 0) * N];
        // shared_A[idx * 4 + 1 + idy * 128] = A[id / 32 + k * 8 + (id % 32 * 4 + 128 * blockIdx.y + 1) * N];
        // shared_A[idx * 4 + 2 + idy * 128] = A[id / 32 + k * 8 + (id % 32 * 4 + 128 * blockIdx.y + 2) * N];
        // shared_A[idx * 4 + 3 + idy * 128] = A[id / 32 + k * 8 + (id % 32 * 4 + 128 * blockIdx.y + 3) * N];
        // *(float4*)(shared_B + (id % 32) * 4 + (int)(id / 32) * 128) = *(float4*)(B + (id % 32) * 4 + 128 * blockIdx.x + (id / 32 + k * 8) * N);
        *(float4*)(shared_B + idx * 4 + idy * 128) = *(float4*)(B + idx * 4 + 128 * blockIdx.x + (idy + k * 8) * N);
        
        // int ii1 = tidx + k * 8;
        // int jj1 = tidy + k * 8;      
        // if (tidy * m + tidx * 128 < 1024 ){     
        //     shared_A[tidy * m + tidx * 128] = A[ii1 + (j1 + 0) * N];
        //     shared_A[tidy * m + 1 + tidx * 128] = A[ii1 + (j1 + 1) * N];
        //     shared_A[tidy * m + 2 + tidx * 128] = A[ii1 + (j1 + 2) * N];
        //     shared_A[tidy * m + 3 + tidx * 128] = A[ii1 + (j1 + 3) * N];
        //     shared_A[tidy * m + 4 + tidx * 128] = A[ii1 + (j1 + 4) * N];
        //     shared_A[tidy * m + 5 + tidx * 128] = A[ii1 + (j1 + 5) * N];
        //     shared_A[tidy * m + 6 + tidx * 128] = A[ii1 + (j1 + 6) * N];
        //     shared_A[tidy * m + 7 + tidx * 128] = A[ii1 + (j1 + 7) * N];
        // } 
        // if(tidx * m + tidy * 128 < 1024){
        //     *(float4*)(shared_B + tidx * m + tidy * 128) = *(float4*)(B + i1 + jj1 * N);
        //     *(float4*)(shared_B + tidx * m + 4 + tidy * 128) = *(float4*)(B + i1 + 4 + jj1 * N);
        // }
        __syncthreads(); 
        // if(tidx == 0 && tidy == 0 ){
        //     for(int i = 0; i < 256; ++i){
        //         //float dif0 = (shared_A[(i % 32) * 4 + (int)(i / 32) * 128] - A[i / 32 + k * 8 + (i % 32 * 4 + 128 * blockIdx.y + 0) * N]);
        //         float dif1 = (*(float4*)(shared_B + (i % 32) * 4 + (int)(i / 32) * 128)).x - (*(float4*)(B + (i % 32) * 4 + 128 * blockIdx.x + (i / 32 + k * 8) * N)).x;
        //         if(dif1 != 0.)printf("shared memory B: %f, B: %f\n", shared_B[(i % 32) * 4 + (int)(i / 32) * 128], B[(i % 32) * 4 + 128 * blockIdx.x + (i / 32 + k * 8) * N]);
        //         dif1 = (*(float4*)(shared_B + (i % 32) * 4 + (int)(i / 32) * 128)).y - (*(float4*)(B + (i % 32) * 4 + 128 * blockIdx.x + (i / 32 + k * 8) * N)).y;
        //         if(dif1 != 0)printf("shared memory B: %f, B: %f\n", shared_B[(i % 32) * 4 + 1 + (int)(i / 32) * 128], B[(i % 32) * 4 +1+ 128 * blockIdx.x + (i / 32 + k * 8) * N]);
        //         dif1 = (*(float4*)(shared_B + (i % 32) * 4 + (int)(i / 32) * 128)).z - (*(float4*)(B + (i % 32) * 4 + 128 * blockIdx.x + (i / 32 + k * 8) * N)).z;
        //         if(dif1 != 0)printf("shared memory B: %f, B: %f\n", shared_B[(i % 32) * 4 + 2 +(int)(i / 32) * 128], B[(i % 32) * 4 + 2 + 128 * blockIdx.x + (i / 32 + k * 8) * N]);                
        //         dif1 = (*(float4*)(shared_B + (i % 32) * 4 + (int)(i / 32) * 128)).w - (*(float4*)(B + (i % 32) * 4 + 128 * blockIdx.x + (i / 32 + k * 8) * N)).w;
        //         if(dif1 != 0)printf("shared memory B: %f, B: %f\n", shared_B[(i % 32) * 4 + 3 + (int)(i / 32) * 128], B[(i % 32) * 4 + 128 * blockIdx.x +3+ (i / 32 + k * 8) * N]);
        //     }
            
        // }
        for(int kk = 0; kk < 8; ++kk){
            bb0 = *(float4*)(shared_B + tidx * m + kk * 128);
            bb1 = *(float4*)(shared_B + tidx * m + 4 + kk * 128);
            aa0 = *(float4*)(shared_A + tidy * m + kk * 128);
            aa1 = *(float4*)(shared_A + tidy * m + 4 + kk * 128);
            
            tab(t[0], aa0, bb0.x);
            tab(t[1], aa1, bb0.x);
            tab(t[2], aa0, bb0.y);
            tab(t[3], aa1, bb0.y);
            tab(t[4], aa0, bb0.z);
            tab(t[5], aa1, bb0.z);
            tab(t[6], aa0, bb0.w);
            tab(t[7], aa1, bb0.w);

            tab(t[8], aa0, bb1.x);
            tab(t[9], aa1, bb1.x);
            tab(t[10], aa0, bb1.y);
            tab(t[11], aa1, bb1.y);
            tab(t[12], aa0, bb1.z);
            tab(t[13], aa1, bb1.z);
            tab(t[14], aa0, bb1.w);
            tab(t[15], aa1, bb1.w);

        }
            //temp += shared_B[kk + tidx * blockDim.x]  * shared_A[tidy + kk * blockDim.y];
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
    
    // first row
    C1[0].x =  alpha * t[0].x + beta * C1[0].x;
    C1[2].x =  alpha * t[0].y + beta * C1[2].x;
    C1[4].x =  alpha * t[0].z + beta * C1[4].x;
    C1[6].x =  alpha * t[0].w + beta * C1[6].x;

    C1[8].x =  alpha * t[1].x + beta * C1[8].x;
    C1[10].x =  alpha * t[1].y + beta * C1[10].x;
    C1[12].x =  alpha * t[1].z + beta * C1[12].x;
    C1[14].x =  alpha * t[1].w + beta * C1[14].x;

    //second row 
    C1[0].y =  alpha * t[2].x + beta * C1[0].y;
    C1[2].y =  alpha * t[2].y + beta * C1[2].y;
    C1[4].y =  alpha * t[2].z + beta * C1[4].y;
    C1[6].y =  alpha * t[2].w + beta * C1[6].y;

    C1[8].y =  alpha * t[3].x + beta * C1[8].y;
    C1[10].y =  alpha * t[3].y + beta * C1[10].y;
    C1[12].y =  alpha * t[3].z + beta * C1[12].y;
    C1[14].y =  alpha * t[3].w + beta * C1[14].y;

    // third row
    C1[0].z =  alpha * t[4].x + beta * C1[0].z;
    C1[2].z =  alpha * t[4].y + beta * C1[2].z;
    C1[4].z =  alpha * t[4].z + beta * C1[4].z;
    C1[6].z =  alpha * t[4].w + beta * C1[6].z;

    C1[8].z =  alpha * t[5].x + beta * C1[8].z;
    C1[10].z =  alpha * t[5].y + beta * C1[10].z;
    C1[12].z =  alpha * t[5].z + beta * C1[12].z;
    C1[14].z =  alpha * t[5].w + beta * C1[14].z;

    // fourth row
    C1[0].w =  alpha * t[6].x + beta * C1[0].w;
    C1[2].w =  alpha * t[6].y + beta * C1[2].w;
    C1[4].w =  alpha * t[6].z + beta * C1[4].w;
    C1[6].w =  alpha * t[6].w + beta * C1[6].w;

    C1[8].w =  alpha * t[7].x + beta * C1[8].w;
    C1[10].w =  alpha * t[7].y + beta * C1[10].w;
    C1[12].w =  alpha * t[7].z + beta * C1[12].w;
    C1[14].w =  alpha * t[7].w + beta * C1[14].w;

    // 5-th row
    C1[1].x =  alpha * t[8].x + beta * C1[1].x;
    C1[3].x =  alpha * t[8].y + beta * C1[3].x;
    C1[5].x =  alpha * t[8].z + beta * C1[5].x;
    C1[7].x =  alpha * t[8].w + beta * C1[7].x;

    C1[9].x =  alpha * t[9].x + beta * C1[9].x;
    C1[11].x =  alpha * t[9].y + beta * C1[11].x;
    C1[13].x =  alpha * t[9].z + beta * C1[13].x;
    C1[15].x =  alpha * t[9].w + beta * C1[15].x;
    
    // 6-th row
    C1[1].y =  alpha * t[10].x + beta * C1[1].y;
    C1[3].y =  alpha * t[10].y + beta * C1[3].y;
    C1[5].y =  alpha * t[10].z + beta * C1[5].y;
    C1[7].y =  alpha * t[10].w + beta * C1[7].y;

    C1[9].y =  alpha * t[11].x + beta * C1[9].y;
    C1[11].y =  alpha * t[11].y + beta * C1[11].y;
    C1[13].y =  alpha * t[11].z + beta * C1[13].y;
    C1[15].y =  alpha * t[11].w + beta * C1[15].y;

    // 7-th row
    C1[1].z =  alpha * t[12].x + beta * C1[1].z;
    C1[3].z =  alpha * t[12].y + beta * C1[3].z;
    C1[5].z =  alpha * t[12].z + beta * C1[5].z;
    C1[7].z =  alpha * t[12].w + beta * C1[7].z;

    C1[9].z =  alpha * t[13].x + beta * C1[9].z;
    C1[11].z =  alpha * t[13].y + beta * C1[11].z;
    C1[13].z =  alpha * t[13].z + beta * C1[13].z;
    C1[15].z =  alpha * t[13].w + beta * C1[15].z;

    // 8-th row
    C1[1].w =  alpha * t[14].x + beta * C1[1].w;
    C1[3].w =  alpha * t[14].y + beta * C1[3].w;
    C1[5].w =  alpha * t[14].z + beta * C1[5].w;
    C1[7].w =  alpha * t[14].w + beta * C1[7].w;

    C1[9].w =  alpha * t[15].x + beta * C1[9].w;
    C1[11].w =  alpha * t[15].y + beta * C1[11].w;
    C1[13].w =  alpha * t[15].z + beta * C1[13].w;
    C1[15].w =  alpha * t[15].w + beta * C1[15].w;

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