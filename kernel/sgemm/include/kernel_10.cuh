#include <stdio.h>
#define rab(r,a,b) r.x += a.x * b; r.y += a.y * b; r.z += a.z * b; r.w += a.w * b;
#define rcab(r, c,a, b)\
    c.x = a * r.x + b * c.x;\
    c.y = a * r.y + b * c.y;\
    c.z = a * r.z + b * c.z;\
    c.w = a * r.w + b * c.w;


__global__ __launch_bounds__(256) void sgemm_10(int N, float *A, float *B, float *C, float alpha, float beta){
    int tx = threadIdx.x;
    int bx = blockIdx.x, by = blockIdx.y;
    bx = bx << 8;
    by = by << 8;
    B += bx + (tx&63) * 4 + (tx>>6) * N;
    A += by * N + tx * N;
    C += bx + by * N;
    int tx_mod_16_mul_16 = ((tx & 15) << 4);
    int tx_div_16_mul_16 = ((tx >> 4) << 4);
    int tx_div_16_mul_16_mul_N = ((tx >> 4) << 4) * N;
    // printf("bx: %d, by: %d\n", bx, by);
    __shared__ float sa[1024];
    __shared__ float sb[1024];
    float4 AA0, AA1, AA2, AA3, BB0, BB1, BB2, BB3, res[64], CC[64];
    memset(res, 0, sizeof(res));
    //printf("tid: %d\n", tx);
    for(int k = 0; k < N; k+=4){
        
        BB0 = *(float4*)B;
        AA0 = *(float4*)A;
        *((float4*)(sb) + tx) = BB0;
        sa[tx] = AA0.x;
        sa[tx + 256] = AA0.y;
        sa[tx + 512] = AA0.z;
        sa[tx + 768] = AA0.w;
        B += (N << 2);
        A += 4;
        __syncthreads();
        #pragma unroll
        for(int kk = 0; kk < 4; ++kk){
            BB0 = *(float4*)(sb + tx_mod_16_mul_16 + 0 + (kk << 8));
            BB1 = *(float4*)(sb + tx_mod_16_mul_16 + 4 + (kk << 8));
            BB2 = *(float4*)(sb + tx_mod_16_mul_16 + 8 + (kk << 8));
            BB3 = *(float4*)(sb + tx_mod_16_mul_16 + 12 + (kk << 8));

            AA0 = *(float4*)(sa + tx_div_16_mul_16 + 0 + (kk << 8));
            AA1 = *(float4*)(sa + tx_div_16_mul_16 + 4 + (kk << 8));
            AA2 = *(float4*)(sa + tx_div_16_mul_16 + 8 + (kk << 8));
            AA3 = *(float4*)(sa + tx_div_16_mul_16 + 12 + (kk << 8));

            rab(res[0], BB0, AA0.x);
            rab(res[1], BB1, AA0.x);
            rab(res[2], BB2, AA0.x);
            rab(res[3], BB3, AA0.x);
            rab(res[4], BB0, AA0.y);
            rab(res[5], BB1, AA0.y);
            rab(res[6], BB2, AA0.y);
            rab(res[7], BB3, AA0.y);
            rab(res[8], BB0, AA0.z);
            rab(res[9], BB1, AA0.z);
            rab(res[10], BB2, AA0.z);
            rab(res[11], BB3, AA0.z);
            rab(res[12], BB0, AA0.w);
            rab(res[13], BB1, AA0.w);
            rab(res[14], BB2, AA0.w);
            rab(res[15], BB3, AA0.w);

            rab(res[16], BB0, AA1.x);
            rab(res[17], BB1, AA1.x);
            rab(res[18], BB2, AA1.x);
            rab(res[19], BB3, AA1.x);
            rab(res[20], BB0, AA1.y);
            rab(res[21], BB1, AA1.y);
            rab(res[22], BB2, AA1.y);
            rab(res[23], BB3, AA1.y);
            rab(res[24], BB0, AA1.z);
            rab(res[25], BB1, AA1.z);
            rab(res[26], BB2, AA1.z);
            rab(res[27], BB3, AA1.z);
            rab(res[28], BB0, AA1.w);
            rab(res[29], BB1, AA1.w);
            rab(res[30], BB2, AA1.w);
            rab(res[31], BB3, AA1.w);

            rab(res[32], BB0, AA2.x);
            rab(res[33], BB1, AA2.x);
            rab(res[34], BB2, AA2.x);
            rab(res[35], BB3, AA2.x);
            rab(res[36], BB0, AA2.y);
            rab(res[37], BB1, AA2.y);
            rab(res[38], BB2, AA2.y);
            rab(res[39], BB3, AA2.y);
            rab(res[40], BB0, AA2.z);
            rab(res[41], BB1, AA2.z);
            rab(res[42], BB2, AA2.z);
            rab(res[43], BB3, AA2.z);
            rab(res[44], BB0, AA2.w);
            rab(res[45], BB1, AA2.w);
            rab(res[46], BB2, AA2.w);
            rab(res[47], BB3, AA2.w);

            rab(res[48], BB0, AA3.x);
            rab(res[49], BB1, AA3.x);
            rab(res[50], BB2, AA3.x);
            rab(res[51], BB3, AA3.x);
            rab(res[52], BB0, AA3.y);
            rab(res[53], BB1, AA3.y);
            rab(res[54], BB2, AA3.y);
            rab(res[55], BB3, AA3.y);
            rab(res[56], BB0, AA3.z);
            rab(res[57], BB1, AA3.z);
            rab(res[58], BB2, AA3.z);
            rab(res[59], BB3, AA3.z);
            rab(res[60], BB0, AA3.w);
            rab(res[61], BB1, AA3.w);
            rab(res[62], BB2, AA3.w);
            rab(res[63], BB3, AA3.w);
        }
        __syncthreads();
    }
        CC[0] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N);
        CC[1] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N);
        CC[2] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N);
        CC[3] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N);

        CC[4] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N + N);
        CC[5] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N + N);
        CC[6] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N + N);
        CC[7] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N);

        CC[8] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N + N * 2);
        CC[9] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N + N * 2);
        CC[10] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N + N * 2);
        CC[11] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 2);

        CC[12] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 3);
        CC[13] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 3);
        CC[14] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 3);
        CC[15] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 3);

        CC[16] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 4);
        CC[17] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 4);
        CC[18] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 4);
        CC[19] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 4);

        CC[20] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 5);
        CC[21] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 5);
        CC[22] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 5);
        CC[23] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 5);

        CC[24] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 6);
        CC[25] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 6);
        CC[26] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 6);
        CC[27] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 6);

        CC[28] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 7);
        CC[29] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 7);
        CC[30] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 7);
        CC[31] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 7);

        CC[32] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 8);
        CC[33] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 8);
        CC[34] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 8);
        CC[35] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 8);

        CC[36] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 9);
        CC[37] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 9);
        CC[38] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 9);
        CC[39] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 9);

        CC[40] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 10);
        CC[41] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 10);
        CC[42] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 10);
        CC[43] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 10);

        CC[44] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 11);
        CC[45] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 11);
        CC[46] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 11);
        CC[47] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 11);

        CC[48] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 12);
        CC[49] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 12);
        CC[50] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 12);
        CC[51] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 12);

        CC[52] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 13);
        CC[53] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 13);
        CC[54] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 13);
        CC[55] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 13);

        CC[56] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 14);
        CC[57] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 14);
        CC[58] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 14);
        CC[59] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 14);

        CC[60] = *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 15);
        CC[61] = *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 15);
        CC[62] = *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 15);
        CC[63] = *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 15);

        rcab(res[0], CC[0], alpha, beta);
        rcab(res[1], CC[1], alpha, beta);
        rcab(res[2], CC[2], alpha, beta);
        rcab(res[3], CC[3], alpha, beta);
        rcab(res[4], CC[4], alpha, beta);
        rcab(res[5], CC[5], alpha, beta);
        rcab(res[6], CC[6], alpha, beta);
        rcab(res[7], CC[7], alpha, beta);
        rcab(res[8], CC[8], alpha, beta);
        rcab(res[9], CC[9], alpha, beta);
        rcab(res[10], CC[10], alpha, beta);
        rcab(res[11], CC[11], alpha, beta);
        rcab(res[12], CC[12], alpha, beta);
        rcab(res[13], CC[13], alpha, beta);
        rcab(res[14], CC[14], alpha, beta);
        rcab(res[15], CC[15], alpha, beta);
        rcab(res[16], CC[16], alpha, beta);
        rcab(res[17], CC[17], alpha, beta);
        rcab(res[18], CC[18], alpha, beta);
        rcab(res[19], CC[19], alpha, beta);
        rcab(res[20], CC[20], alpha, beta);
        rcab(res[21], CC[21], alpha, beta);
        rcab(res[22], CC[22], alpha, beta);
        rcab(res[23], CC[23], alpha, beta);
        rcab(res[24], CC[24], alpha, beta);
        rcab(res[25], CC[25], alpha, beta);
        rcab(res[26], CC[26], alpha, beta);
        rcab(res[27], CC[27], alpha, beta);
        rcab(res[28], CC[28], alpha, beta);
        rcab(res[29], CC[29], alpha, beta);
        rcab(res[30], CC[30], alpha, beta);
        rcab(res[31], CC[31], alpha, beta);
        rcab(res[32], CC[32], alpha, beta);
        rcab(res[33], CC[33], alpha, beta);
        rcab(res[34], CC[34], alpha, beta);
        rcab(res[35], CC[35], alpha, beta);
        rcab(res[36], CC[36], alpha, beta);
        rcab(res[37], CC[37], alpha, beta);
        rcab(res[38], CC[38], alpha, beta);
        rcab(res[39], CC[39], alpha, beta);
        rcab(res[40], CC[40], alpha, beta);
        rcab(res[41], CC[41], alpha, beta);
        rcab(res[42], CC[42], alpha, beta);
        rcab(res[43], CC[43], alpha, beta);
        rcab(res[44], CC[44], alpha, beta);
        rcab(res[45], CC[45], alpha, beta);
        rcab(res[46], CC[46], alpha, beta);
        rcab(res[47], CC[47], alpha, beta);
        rcab(res[48], CC[48], alpha, beta);
        rcab(res[49], CC[49], alpha, beta);
        rcab(res[50], CC[50], alpha, beta);
        rcab(res[51], CC[51], alpha, beta);
        rcab(res[52], CC[52], alpha, beta);
        rcab(res[53], CC[53], alpha, beta);
        rcab(res[54], CC[54], alpha, beta);
        rcab(res[55], CC[55], alpha, beta);
        rcab(res[56], CC[56], alpha, beta);
        rcab(res[57], CC[57], alpha, beta);
        rcab(res[58], CC[58], alpha, beta);
        rcab(res[59], CC[59], alpha, beta);
        rcab(res[60], CC[60], alpha, beta);
        rcab(res[61], CC[61], alpha, beta);
        rcab(res[62], CC[62], alpha, beta);
        rcab(res[63], CC[63], alpha, beta);


        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N) = CC[0];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N) = CC[1];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N) = CC[2] ;
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N) = CC[3] ;

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N + N) = CC[4] ;
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N + N) = CC[5];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N + N) = CC[6];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N) = CC[7];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N + N * 2) = CC[8];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N + N * 2) = CC[9];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N + N * 2) = CC[10];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 2) = CC[11];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 3)  = CC[12];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 3)  = CC[13];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 3)  = CC[14];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 3) = CC[15];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 4) = CC[16];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 4) = CC[17];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 4) = CC[18];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 4) = CC[19];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 5) = CC[20];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 5) = CC[21];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 5) = CC[22];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 5) = CC[23];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 6) = CC[24];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 6) = CC[25];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 6) = CC[26];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 6) = CC[27];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 7) = CC[28];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 7) = CC[29];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 7) = CC[30];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 7) = CC[31];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 8) = CC[32];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 8) = CC[33];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 8) = CC[34];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 8) = CC[35];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 9) = CC[36];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 9) = CC[37];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 9) = CC[38];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 9) = CC[39];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 10) = CC[40];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 10) = CC[41];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 10) = CC[42];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 10) = CC[43];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 11) = CC[44];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 11) = CC[45];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 11) = CC[46];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 11) = CC[47];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 12) = CC[48];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 12) = CC[49];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 12) = CC[50];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 12) = CC[51];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 13) = CC[52];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 13) = CC[53];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 13) = CC[54];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 13) = CC[55];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 14) = CC[56];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 14) = CC[57];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 14) = CC[58];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 14) = CC[59];

        *(float4 *)(C + tx_mod_16_mul_16 + tx_div_16_mul_16_mul_N +      N * 15) = CC[60];
        *(float4 *)(C + tx_mod_16_mul_16 + 4 + tx_div_16_mul_16_mul_N +  N * 15) = CC[61];
        *(float4 *)(C + tx_mod_16_mul_16 + 8 + tx_div_16_mul_16_mul_N +  N * 15) = CC[62];
        *(float4 *)(C + tx_mod_16_mul_16 + 12 + tx_div_16_mul_16_mul_N + N * 15) = CC[63];
}