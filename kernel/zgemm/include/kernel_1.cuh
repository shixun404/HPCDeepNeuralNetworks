#include <stdio.h>
__global__ void zgemm_1(int N, double *A, double *B, double *C, double2 alpha, double2 beta){
    
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j = threadIdx.y + blockIdx.y * blockDim.y;
    double2 *gA = (double2*)A;
    double2 *gB = (double2*)B;
    double2 *gC = (double2*)C;
    double2 temp, res;
    temp.x = 0, temp.y = 0;
    res.x = 0, res.y = 0;
    for(int k = 0; k < N; ++k){
        Z_MUL(gA[i + k * N], gB[k + j * N], temp); // Why line 24 much faster than line 25?
        // temp += B[j + k * N] * A[k + i * N];
    }
    Z_MUL(beta, gC[i + j * N], res)
    Z_MUL(alpha, temp, res)
    gC[i + j * N] = res;
    // gC[i + j * N].x = alpha.x * temp.x + beta.x * gC[i + j * N].x;
    // gC[i + j * N].y = alpha.x * temp.y + beta.x * gC[i + j * N].y;
}