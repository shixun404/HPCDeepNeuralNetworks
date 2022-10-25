#include <stdio.h>
#define tab(t, a, b)t.x += a.x * b;t.y += a.y * b;  t.z += a.z * b;t.w += a.w * b;  
    
// #define tcab(t, c, alpha, beta) c = alpha * t + beta * c;
#define tcab(t, c, alpha, beta) \
    c.x = alpha * t.x + beta * c.x;\
    c.y = alpha * t.y + beta * c.y;\
    c.z = alpha * t.z + beta * c.z;\
    c.w = alpha * t.w + beta * c.w;
    

__global__  __launch_bounds__(256) void sgemm_14(int N, float *A, float *B, float *C, float alpha, float beta){
    extern __shared__ float shared_AB[];
    float *shared_A = (float*)shared_AB; // blockDim * 2 for sublocks of A and B
    float *shared_B = (float*)shared_AB + 2 * 4096;
    float* sa, *sb;
    sa = (float*)shared_A;
    sb = (float*)shared_B;
    int tx = threadIdx.x;
    int bx = blockIdx.x, by = blockIdx.y;
    int wid = (tx >> 5);
    int wid_b = (wid >> 2), wid_a = (wid & 3);
    int inter_warp_id_b = ((tx&31) >> 2);
    int inter_warp_id_a = ((tx&31) & 3);
    int i1 = (wid_b << 6) + (inter_warp_id_b << 3) + (bx<<7);
    int j1 = (wid_a << 5) + (inter_warp_id_a << 3) + (by<<7);
    float4 t[16], bb0[2],aa0[2],bb1[2], aa1[2], C1[16], pre_A[4], pre_B[4];
    memset(t, 0, sizeof(t));
    int by_128 = (by << 7);
    A = A + ((tx>>1) + by_128) * N + ((tx & 1) << 4);
    B = B + ((tx & 7) << 4) + (bx << 7) + (tx>>3) * N;
    pre_B[0] = ((float4*)B)[0];
    pre_B[1] = ((float4*)B)[1];
    pre_B[2] = ((float4*)B)[2];
    pre_B[3] = ((float4*)B)[3];
    pre_A[0] = ((float4*)A)[0];
    pre_A[1] = ((float4*)A)[1];
    pre_A[2] = ((float4*)A)[2];
    pre_A[3] = ((float4*)A)[3];
    //int shared_offset = 0;
    ((float4*)sb)[(tx << 2)] = pre_B[0];
    ((float4*)sb)[(tx << 2) + 1] = pre_B[1];
    ((float4*)sb)[(tx << 2) + 2] = pre_B[2];
    ((float4*)sb)[(tx << 2) + 3] = pre_B[3];
    sa[(tx>>1) + ((((tx&1)<<4) + 0)<<7)]= pre_A[0].x;
    sa[(tx>>1) + ((((tx&1)<<4) + 1)<<7) ]= pre_A[0].y;
    sa[(tx>>1) + ((((tx&1)<<4) + 2)<<7)]= pre_A[0].z; 
    sa[(tx>>1) + ((((tx&1)<<4) + 3)<<7)]= pre_A[0].w;
    sa[(tx>>1) + ((((tx&1)<<4) + 4)<<7)]= pre_A[1].x;
    sa[(tx>>1) + ((((tx&1)<<4) + 5)<<7) ]= pre_A[1].y;
    sa[(tx>>1) + ((((tx&1)<<4) + 6)<<7)]= pre_A[1].z; 
    sa[(tx>>1) + ((((tx&1)<<4) + 7)<<7)]= pre_A[1].w;
    sa[(tx>>1) + ((((tx&1)<<4) + 8)<<7)] = pre_A[2].x;
    sa[(tx>>1) + ((((tx&1)<<4) + 9)<<7) ]= pre_A[2].y;
    sa[(tx>>1) + ((((tx&1)<<4) + 10)<<7)]= pre_A[2].z; 
    sa[(tx>>1) + ((((tx&1)<<4) + 11)<<7)]= pre_A[2].w;
    sa[(tx>>1) + ((((tx&1)<<4) + 12)<<7)] = pre_A[3].x;
    sa[(tx>>1) + ((((tx&1)<<4) + 13)<<7) ]= pre_A[3].y;
    sa[(tx>>1) + ((((tx&1)<<4) + 14)<<7)]= pre_A[3].z; 
    sa[(tx>>1) + ((((tx&1)<<4) + 15)<<7)]= pre_A[3].w;
    
    
    __syncthreads();
    bb0[0] = *(float4*)(sb + (wid_b << 6) + (inter_warp_id_b << 3));
    bb1[0] = *(float4*)(sb + (wid_b << 6) + (inter_warp_id_b << 3) + 4);
    aa0[0] = *(float4*)(sa + (wid_a << 5) + (inter_warp_id_a << 3));
    aa1[0] = *(float4*)(sa + (wid_a << 5) + (inter_warp_id_a << 3) + 4);

    for(int k = 0; k < N; k += 32){
        B += (N<<5);
        A += 32; 
        int shared_offset = ((((k>>5) + 1)&1)<<12);
        pre_B[0] = ((float4*)B)[0];
        pre_B[1] = ((float4*)B)[1];
        pre_B[2] = ((float4*)B)[2];
        pre_B[3] = ((float4*)B)[3];
        pre_A[0] = ((float4*)A)[0];
        pre_A[1] = ((float4*)A)[1];
        pre_A[2] = ((float4*)A)[2];
        pre_A[3] = ((float4*)A)[3];
        #pragma unroll
        for(int kk = 0; kk < 32; kk+=1){
            int prefetch_next = ((kk + 1)&1);
            int prefetch = ((kk)&1);
            int kk_ = ((kk + 1)&31);
            bb0[prefetch_next] = *(float4*)(sb + (wid_b << 6) + (inter_warp_id_b << 3) + (kk_<<7));
            bb1[prefetch_next] = *(float4*)(sb + (wid_b << 6) + (inter_warp_id_b << 3) + 4 + (kk_<<7));
            aa0[prefetch_next] = *(float4*)(sa + (wid_a << 5) + (inter_warp_id_a << 3) + (kk_<<7));
            aa1[prefetch_next] = *(float4*)(sa + (wid_a << 5) + (inter_warp_id_a << 3) + 4 + (kk_<<7));
            tab(t[0], bb0[prefetch], aa0[prefetch].x);
            tab(t[1], bb1[prefetch], aa0[prefetch].x);
            tab(t[2], bb0[prefetch], aa0[prefetch].y);
            tab(t[3], bb1[prefetch], aa0[prefetch].y);
            tab(t[4], bb0[prefetch], aa0[prefetch].z);
            tab(t[5], bb1[prefetch], aa0[prefetch].z);
            tab(t[6], bb0[prefetch], aa0[prefetch].w);
            tab(t[7], bb1[prefetch], aa0[prefetch].w);

            tab(t[8], bb0[prefetch], aa1[prefetch].x);
            tab(t[9], bb1[prefetch], aa1[prefetch].x);
            tab(t[10], bb0[prefetch], aa1[prefetch].y);
            tab(t[11], bb1[prefetch], aa1[prefetch].y);
            tab(t[12], bb0[prefetch], aa1[prefetch].z);
            tab(t[13], bb1[prefetch], aa1[prefetch].z);
            tab(t[14], bb0[prefetch], aa1[prefetch].w);
            tab(t[15], bb1[prefetch], aa1[prefetch].w);

        }
    sb = (float*)shared_B + shared_offset;
    sa = (float*)shared_A + shared_offset;
    ((float4*)sb)[(tx << 2)] = pre_B[0];
    ((float4*)sb)[(tx << 2) + 1] = pre_B[1];
    ((float4*)sb)[(tx << 2) + 2] = pre_B[2];
    ((float4*)sb)[(tx << 2) + 3] = pre_B[3];
    sa[(tx>>1) + ((((tx&1)<<4) + 0)<<7)]= pre_A[0].x;
    sa[(tx>>1) + ((((tx&1)<<4) + 1)<<7) ]= pre_A[0].y;
    sa[(tx>>1) + ((((tx&1)<<4) + 2)<<7)]= pre_A[0].z; 
    sa[(tx>>1) + ((((tx&1)<<4) + 3)<<7)]= pre_A[0].w;
    sa[(tx>>1) + ((((tx&1)<<4) + 4)<<7)]= pre_A[1].x;
    sa[(tx>>1) + ((((tx&1)<<4) + 5)<<7) ]= pre_A[1].y;
    sa[(tx>>1) + ((((tx&1)<<4) + 6)<<7)]= pre_A[1].z; 
    sa[(tx>>1) + ((((tx&1)<<4) + 7)<<7)]= pre_A[1].w;
    sa[(tx>>1) + ((((tx&1)<<4) + 8)<<7)] = pre_A[2].x;
    sa[(tx>>1) + ((((tx&1)<<4) + 9)<<7) ]= pre_A[2].y;
    sa[(tx>>1) + ((((tx&1)<<4) + 10)<<7)]= pre_A[2].z; 
    sa[(tx>>1) + ((((tx&1)<<4) + 11)<<7)]= pre_A[2].w;
    sa[(tx>>1) + ((((tx&1)<<4) + 12)<<7)] = pre_A[3].x;
    sa[(tx>>1) + ((((tx&1)<<4) + 13)<<7) ]= pre_A[3].y;
    sa[(tx>>1) + ((((tx&1)<<4) + 14)<<7)]= pre_A[3].z; 
    sa[(tx>>1) + ((((tx&1)<<4) + 15)<<7)]= pre_A[3].w;
    __syncthreads();
    bb0[0] = *(float4*)(sb + (wid_b << 6) + (inter_warp_id_b << 3));
    bb1[0] = *(float4*)(sb + (wid_b << 6) + (inter_warp_id_b << 3) + 4);
    aa0[0] = *(float4*)(sa + (wid_a << 5) + (inter_warp_id_a << 3));
    aa1[0] = *(float4*)(sa + (wid_a << 5) + (inter_warp_id_a << 3) + 4);
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