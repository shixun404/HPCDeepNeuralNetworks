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
        // float4 *a = (float4 *)(shared_A + idx * 4 + idy * 128);
        // Here ------------
        //      |___________|
        // shared memory index we need to change
        float4 *a = (float4*)A;
        shared_A[(tx&127) + ((((tx >> 7)<<2) + 0)<<7) ]= (*a).x;
        shared_A[(tx&127) + ((((tx >> 7)<<2) + 1)<<7) ]= (*a).y;
        shared_A[(tx&127) + ((((tx >> 7)<<2) + 2)<<7) ]= (*a).z; 
        shared_A[(tx&127) + ((((tx >> 7)<<2) + 3)<<7) ]= (*a).w;
        // shared_A[idx * 4 + idy * 128] = A[id / 32 + k * 8 + (id % 32 * 4 + 128 * blockIdx.y + 0) * N];
        // shared_A[idx * 4 + 1 + idy * 128] = A[id / 32 + k * 8 + (id % 32 * 4 + 128 * blockIdx.y + 1) * N];
        // shared_A[idx * 4 + 2 + idy * 128] = A[id / 32 + k * 8 + (id % 32 * 4 + 128 * blockIdx.y + 2) * N];
        // shared_A[idx * 4 + 3 + idy * 128] = A[id / 32 + k * 8 + (id % 32 * 4 + 128 * blockIdx.y + 3) * N];
        // *(float4*)(shared_B + (id % 32) * 4 + (int)(id / 32) * 128) = *(float4*)(B + (id % 32) * 4 + 128 * blockIdx.x + (id / 32 + k * 8) * N);
        *(float4*)(shared_B + idx_4 + idy_128) = *(float4*)(B);
        B += (N<<3);
        A += 8; 
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
        #pragma unroll
        for(int kk = 0; kk < 8; kk+=1){
            bb0 = *(float4*)(shared_B + tidx_3 + (kk<<7));
            bb1 = *(float4*)(shared_B + tidx_3 + 4 + (kk<<7));
            aa0 = *(float4*)(shared_A + tidy_3 + (kk<<7));
            aa1 = *(float4*)(shared_A + tidy_3 + 4 + (kk<<7));
            
            // tab(t[0], aa0, bb0.x);
            // tab(t[1], aa1, bb0.x);
            // tab(t[2], aa0, bb0.y);
            // tab(t[3], aa1, bb0.y);
            // tab(t[4], aa0, bb0.z);
            // tab(t[5], aa1, bb0.z);
            // tab(t[6], aa0, bb0.w);
            // tab(t[7], aa1, bb0.w);

            // tab(t[8], aa0, bb1.x);
            // tab(t[9], aa1, bb1.x);
            // tab(t[10], aa0, bb1.y);
            // tab(t[11], aa1, bb1.y);
            // tab(t[12], aa0, bb1.z);
            // tab(t[13], aa1, bb1.z);
            // tab(t[14], aa0, bb1.w);
            // tab(t[15], aa1, bb1.w);

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
    
    
    // // first row
    // C1[0].x =  alpha * t[0].x + beta * C1[0].x;
    // C1[2].x =  alpha * t[0].y + beta * C1[2].x;
    // C1[4].x =  alpha * t[0].z + beta * C1[4].x;
    // C1[6].x =  alpha * t[0].w + beta * C1[6].x;

    // C1[8].x =  alpha * t[1].x + beta * C1[8].x;
    // C1[10].x =  alpha * t[1].y + beta * C1[10].x;
    // C1[12].x =  alpha * t[1].z + beta * C1[12].x;
    // C1[14].x =  alpha * t[1].w + beta * C1[14].x;

    // //second row 
    // C1[0].y =  alpha * t[2].x + beta * C1[0].y;
    // C1[2].y =  alpha * t[2].y + beta * C1[2].y;
    // C1[4].y =  alpha * t[2].z + beta * C1[4].y;
    // C1[6].y =  alpha * t[2].w + beta * C1[6].y;

    // C1[8].y =  alpha * t[3].x + beta * C1[8].y;
    // C1[10].y =  alpha * t[3].y + beta * C1[10].y;
    // C1[12].y =  alpha * t[3].z + beta * C1[12].y;
    // C1[14].y =  alpha * t[3].w + beta * C1[14].y;

    // // third row
    // C1[0].z =  alpha * t[4].x + beta * C1[0].z;
    // C1[2].z =  alpha * t[4].y + beta * C1[2].z;
    // C1[4].z =  alpha * t[4].z + beta * C1[4].z;
    // C1[6].z =  alpha * t[4].w + beta * C1[6].z;

    // C1[8].z =  alpha * t[5].x + beta * C1[8].z;
    // C1[10].z =  alpha * t[5].y + beta * C1[10].z;
    // C1[12].z =  alpha * t[5].z + beta * C1[12].z;
    // C1[14].z =  alpha * t[5].w + beta * C1[14].z;

    // // fourth row
    // C1[0].w =  alpha * t[6].x + beta * C1[0].w;
    // C1[2].w =  alpha * t[6].y + beta * C1[2].w;
    // C1[4].w =  alpha * t[6].z + beta * C1[4].w;
    // C1[6].w =  alpha * t[6].w + beta * C1[6].w;

    // C1[8].w =  alpha * t[7].x + beta * C1[8].w;
    // C1[10].w =  alpha * t[7].y + beta * C1[10].w;
    // C1[12].w =  alpha * t[7].z + beta * C1[12].w;
    // C1[14].w =  alpha * t[7].w + beta * C1[14].w;

    // // 5-th row
    // C1[1].x =  alpha * t[8].x + beta * C1[1].x;
    // C1[3].x =  alpha * t[8].y + beta * C1[3].x;
    // C1[5].x =  alpha * t[8].z + beta * C1[5].x;
    // C1[7].x =  alpha * t[8].w + beta * C1[7].x;

    // C1[9].x =  alpha * t[9].x + beta * C1[9].x;
    // C1[11].x =  alpha * t[9].y + beta * C1[11].x;
    // C1[13].x =  alpha * t[9].z + beta * C1[13].x;
    // C1[15].x =  alpha * t[9].w + beta * C1[15].x;
    
    // // 6-th row
    // C1[1].y =  alpha * t[10].x + beta * C1[1].y;
    // C1[3].y =  alpha * t[10].y + beta * C1[3].y;
    // C1[5].y =  alpha * t[10].z + beta * C1[5].y;
    // C1[7].y =  alpha * t[10].w + beta * C1[7].y;

    // C1[9].y =  alpha * t[11].x + beta * C1[9].y;
    // C1[11].y =  alpha * t[11].y + beta * C1[11].y;
    // C1[13].y =  alpha * t[11].z + beta * C1[13].y;
    // C1[15].y =  alpha * t[11].w + beta * C1[15].y;

    // // 7-th row
    // C1[1].z =  alpha * t[12].x + beta * C1[1].z;
    // C1[3].z =  alpha * t[12].y + beta * C1[3].z;
    // C1[5].z =  alpha * t[12].z + beta * C1[5].z;
    // C1[7].z =  alpha * t[12].w + beta * C1[7].z;

    // C1[9].z =  alpha * t[13].x + beta * C1[9].z;
    // C1[11].z =  alpha * t[13].y + beta * C1[11].z;
    // C1[13].z =  alpha * t[13].z + beta * C1[13].z;
    // C1[15].z =  alpha * t[13].w + beta * C1[15].z;

    // // 8-th row
    // C1[1].w =  alpha * t[14].x + beta * C1[1].w;
    // C1[3].w =  alpha * t[14].y + beta * C1[3].w;
    // C1[5].w =  alpha * t[14].z + beta * C1[5].w;
    // C1[7].w =  alpha * t[14].w + beta * C1[7].w;

    // C1[9].w =  alpha * t[15].x + beta * C1[9].w;
    // C1[11].w =  alpha * t[15].y + beta * C1[11].w;
    // C1[13].w =  alpha * t[15].z + beta * C1[13].w;
    // C1[15].w =  alpha * t[15].w + beta * C1[15].w;

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