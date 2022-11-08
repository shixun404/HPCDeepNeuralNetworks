#include <stdio.h>
//#include "../kernels.cuh"
#define m 8
#define kk_max 1024
#define tab(t, a, b)t.x += a.x * b;t.y += a.y * b;  t.z += a.z * b;t.w += a.w * b;  
#define checksum_8(t, a, b) t += a.x; t += a.y; t += a.z; t += a.w; t += b.x; t += b.y; t += b.z; t += b.w;
#define saxpy(t1,t2, a, b1,b2) t1.x += a * b1.x; t1.y += a * b1.y; t1.z += a * b1.z; t1.w += a * b1.w; \
                               t2.x += a * b2.x; t2.y += a * b2.y; t2.z += a * b2.z; t2.w += a * b2.w;
// #define tcab(t, c, alpha, beta) c = alpha * t + beta * c;
#define tcab(t, c, alpha, beta) \
    c.x = alpha * t.x + beta * c.x;\
    c.y = alpha * t.y + beta * c.y;\
    c.z = alpha * t.z + beta * c.z;\
    c.w = alpha * t.w + beta * c.w;
// #define shared_vec_write(s, offset, vec) \
//         (*(float4*)((float*)s + offset)).x += vec[0].x; \
//         (*(float4*)((float*)s + offset)).y += vec[0].y; \
//         (*(float4*)((float*)s + offset)).z += vec[0].z; \
//         (*(float4*)((float*)s + offset)).w += vec[0].w; \
//         (*(float4*)((float*)s + offset + 4)).x += vec[1].x; \
//         (*(float4*)((float*)s + offset + 4)).y += vec[1].y; \
//         (*(float4*)((float*)s + offset + 4)).z += vec[1].z; \
//         (*(float4*)((float*)s + offset + 4)).w += vec[1].w;

#define shared_vec_write(s, offset, vec, tmp) \
        tmp = (*(float4*)((float*)s + offset));\
        tmp.x += vec[0].x; \
        tmp.y += vec[0].y; \
        tmp.z += vec[0].z; \
        tmp.w += vec[0].w; \
        (*(float4*)((float*)s + offset)) = tmp;\
        tmp = (*(float4*)((float*)s + offset + 4));\
        tmp.x += vec[1].x; \
        tmp.y += vec[1].y; \
        tmp.z += vec[1].z; \
        tmp.w += vec[1].w; \
        (*(float4*)((float*)s + offset + 4)) = tmp;
// #define shared_vec_write_2float4(s, offset, vec, tmp) \
//         tmp = (*(float4*)((float*)s + offset));\
//         tmp.x = vec[0].x; \
//         tmp.y = vec[0].y; \
//         tmp.z = vec[0].z; \
//         tmp.w = vec[0].w; \
//         (*(float4*)((float*)s + offset)) = tmp;\
//         tmp = (*(float4*)((float*)s + offset + 4));\
//         tmp.x = vec[1].x; \
//         tmp.y = vec[1].y; \
//         tmp.z = vec[1].z; \
//         tmp.w = vec[1].w; \
//         (*(float4*)((float*)s + offset + 4)) = tmp;

#define shared_vec_write_2float4(s, offset, vec, tmp) \
        (*(float4*)((float*)s + offset)).x = vec[0].x; \
        (*(float4*)((float*)s + offset)).y = vec[0].y; \
        (*(float4*)((float*)s + offset)).z = vec[0].z; \
        (*(float4*)((float*)s + offset)).w = vec[0].w; \
        (*(float4*)((float*)s + offset + 4)).x = vec[1].x; \
        (*(float4*)((float*)s + offset + 4)).y = vec[1].y; \
        (*(float4*)((float*)s + offset + 4)).z = vec[1].z; \
        (*(float4*)((float*)s + offset + 4)).w = vec[1].w; 

        // (*(float4*)((float*)s + offset + 4)) = tmp;

#define warp_shfl_down(a, i) \
    a.x += __shfl_down_sync(0xffffffff, a.x, i, 32); \
    a.y += __shfl_down_sync(0xffffffff, a.y, i, 32); \
    a.z += __shfl_down_sync(0xffffffff, a.z, i, 32); \
    a.w += __shfl_down_sync(0xffffffff, a.w, i, 32);
    

__global__  __launch_bounds__(256) void ft_sgemm_7(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[1024];
    __shared__ float shared_C_r[512], shared_C_c[256], shared_C_r_ref[512], shared_C_c_ref[256];
    // __shared__ float shared_C_r[128], shared_C_c[128], shared_C_r_ref[128], shared_C_c_ref[128];
    int tx = threadIdx.x;
    int bx = blockIdx.x, by = blockIdx.y;
    int wid = (tx >> 5);
    int wid_b = (wid >> 2), wid_a = (wid & 3);
    int inter_warp_id_b = ((tx&31) >> 2);
    int inter_warp_id_a = ((tx&31) & 3);
    int i1 = (wid_b << 6) + (inter_warp_id_b << 3) + (bx<<7);
    int j1 = (wid_a << 5) + (inter_warp_id_a << 3) + (by<<7);
    float4 t[16], bb0,aa0,bb1, aa1, C1[16], C_c[2], C_r[2], C_c_ref[2], C_r_ref[2], tmp;
    float A_c, B_r = 0.; 
    int idx = tx & 31, idy = tx >> 5;
    memset(t, 0, sizeof(t));
    memset(C_c_ref, 0, sizeof(C_c_ref));
    memset(C_r_ref, 0, sizeof(C_r_ref));
    memset(C_c, 0, sizeof(C_c));
    memset(C_r, 0, sizeof(C_r));
    int idx_4 = (idx<<2), idy_128 = (idy << 7), by_128 = (by << 7);
    A = A + ((tx>>1) + by_128) * N + ((tx & 1) << 2);
    B = B + idx_4 + (bx << 7) + idy * N;

    for(int k = 0; k < N; k += 8){
        bb0 = *(float4*)B;
        aa0 = *(float4*)A;
        
        *((float4*)(shared_B) + tx) = bb0;
        shared_A[(tx>>1) + ((((tx&1)<<2) + 0)<<7)]= aa0.x;
        shared_A[(tx>>1) + ((((tx&1)<<2)+1)<<7) ]= aa0.y;
        shared_A[(tx>>1) + ((((tx&1)<<2) + 2)<<7)]= aa0.z; 
        shared_A[(tx>>1) + ((((tx&1)<<2) + 3)<<7)]= aa0.w;
        B += (N<<3);
        A += 8; 
        A_c = 0;
        B_r = 0;
        __syncthreads(); 
        #pragma unroll
        for(int kk = 0; kk < 8; kk+=1){
            bb0 = *(float4*)(shared_B + (wid_b << 6) + (inter_warp_id_b << 3) + (kk<<7));
            bb1 = *(float4*)(shared_B + (wid_b << 6) + (inter_warp_id_b << 3) + 4 + (kk<<7));
            aa0 = *(float4*)(shared_A + (wid_a << 5) + (inter_warp_id_a << 3) + (kk<<7));
            aa1 = *(float4*)(shared_A + (wid_a << 5) + (inter_warp_id_a << 3) + 4 + (kk<<7));
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

            checksum_8(A_c, aa0, aa1);
            checksum_8(B_r, bb0, bb1);
            saxpy(C_c[0], C_c[1], A_c, bb0, bb1);
            saxpy(C_r[0], C_r[1], B_r, aa0, aa1);

        }
        __syncthreads();
    }
    checksum_8(C_c_ref[0].x, t[0], t[1])
    checksum_8(C_c_ref[0].y, t[2], t[3])
    checksum_8(C_c_ref[0].z, t[4], t[5])
    checksum_8(C_c_ref[0].w, t[6], t[7])
    checksum_8(C_c_ref[1].x, t[8], t[9])
    checksum_8(C_c_ref[1].y, t[10], t[11])
    checksum_8(C_c_ref[1].z, t[12], t[13])
    checksum_8(C_c_ref[1].w, t[14], t[15])
    
    // C_r_ref[0] = t[0] + t[2] + t[4] + t[6] + t[8] + t[10] + t[12] + t[14];
    tcab(t[0], C_r_ref[0], 1.0, 1.0)
    tcab(t[2], C_r_ref[0], 1.0, 1.0)
    tcab(t[4], C_r_ref[0], 1.0, 1.0)
    tcab(t[6], C_r_ref[0], 1.0, 1.0)
    tcab(t[8], C_r_ref[0], 1.0, 1.0)
    tcab(t[10], C_r_ref[0], 1.0, 1.0)
    tcab(t[12], C_r_ref[0], 1.0, 1.0)
    tcab(t[14], C_r_ref[0], 1.0, 1.0)
    
    // C_r_ref[1] = t[1] + t[3] + t[5] + t[7] + t[9] + t[11] + t[13] + t[15];
    tcab(t[1], C_r_ref[1], 1.0, 1.0)
    tcab(t[3], C_r_ref[1], 1.0, 1.0)
    tcab(t[5], C_r_ref[1], 1.0, 1.0)
    tcab(t[7], C_r_ref[1], 1.0, 1.0)
    tcab(t[9], C_r_ref[1], 1.0, 1.0)
    tcab(t[11], C_r_ref[1], 1.0, 1.0)
    tcab(t[13], C_r_ref[1], 1.0, 1.0)
    tcab(t[15], C_r_ref[1], 1.0, 1.0)

    // put to shared memory for reduction
    int shared_col_idx = (((wid_a << 2) + inter_warp_id_a) << 7) + (((wid_b << 3) + inter_warp_id_b) << 3);
    int shared_row_idx = (((wid_b << 3) + inter_warp_id_b) << 7) + (((wid_a << 2) + inter_warp_id_a) << 3);
    
    // reduction
    __syncthreads();
    warp_shfl_down(C_c[0], 1);
    warp_shfl_down(C_c[1], 1);
    warp_shfl_down(C_c_ref[0], 1);
    warp_shfl_down(C_c_ref[1], 1);
    __syncthreads();
    int i = 8;
    while(i <= 16){
        // printf("%d, %d\n",(tx&31),  (__shfl_down_sync(0xffffffff, tx, 8,32)&31));
        warp_shfl_down(C_r[0], i);
        warp_shfl_down(C_r[1], i);
        warp_shfl_down(C_r_ref[0], i);
        warp_shfl_down(C_r_ref[1], i);

        warp_shfl_down(C_c[0], i / 4);
        warp_shfl_down(C_c[1], i / 4);
        warp_shfl_down(C_c_ref[0], i / 4);
        warp_shfl_down(C_c_ref[1], i / 4);
        __syncthreads();
        i *= 2;
    }
    
    
    int wx = ((wid_b << 3) + inter_warp_id_b), wy = ((wid_a << 2) + inter_warp_id_a);
    // shared_vec_write_2float4(shared_C_r, wx * 8 + wid_a * 128, C_r, tmp);
    // shared_vec_write_2float4(shared_C_r_ref, wx * 8 + wid_a * 128, C_r_ref, tmp);
    // shared_vec_write_2float4(shared_C_c, wy * 8 + wid_b * 128, C_c, tmp);
    // shared_vec_write_2float4(shared_C_c_ref, wy * 8 + wid_b * 128, C_c_ref, tmp);
    // __syncthreads();
    // i = 256;
    // shared_C_r[tx] += shared_C_r[tx + i];
    // shared_C_r_ref[tx] += shared_C_r_ref[tx + i];
    // __syncthreads();
    // i = i / 2;
    // if(tx < 128){
    // shared_C_r[tx] += shared_C_r[tx + i];
    // shared_C_r_ref[tx] += shared_C_r_ref[tx + i];
    // }
    // else{
    //     shared_C_c[tx - 128] += shared_C_c[tx + i - 128];
    //     shared_C_c_ref[tx - 128] += shared_C_c_ref[tx + i - 128];
    // }
    
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