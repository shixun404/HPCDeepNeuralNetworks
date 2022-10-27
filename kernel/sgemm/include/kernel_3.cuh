__global__ void sgemm_3(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[1024];
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j1 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4;
    int j2 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 1;
    int j3 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 2;
    int j4 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 3;
    int tidx = threadIdx.x, tidy = threadIdx.y * 4;
    float temp1 = 0, temp2 = 0, temp3 = 0, temp4 = 0;
    for(int k = 0; k < gridDim.x; ++k){
        int ii = threadIdx.x + k * blockDim.x;
        int jj1 = tidy + k * blockDim.y * 4 + 0;
        int jj2 = tidy + k * blockDim.y * 4 + 1;
        int jj3 = tidy + k * blockDim.y * 4 + 2;
        int jj4 = tidy + k * blockDim.y * 4 + 3;
        shared_A[tidx + tidy * blockDim.y * 4] = A[ii + j1 * N];
        shared_A[tidx + (tidy + 1) * blockDim.y * 4] = A[ii + j2 * N];
        shared_A[tidx + (tidy + 2)  * blockDim.y * 4] = A[ii + j3 * N];
        shared_A[tidx + (tidy + 3)  * blockDim.y* 4] = A[ii + j4 * N];
        shared_B[tidx + tidy * blockDim.y * 4] = B[i + jj1 * N];
        shared_B[tidx + (tidy + 1) * blockDim.y * 4] = B[i + jj2 * N];
        shared_B[tidx + (tidy + 2) * blockDim.y* 4] = B[i + jj3 * N];
        shared_B[tidx + (tidy + 3) * blockDim.y* 4] = B[i + jj4 * N];
        __syncthreads();
        for(int kk = 0; kk < blockDim.x; ++kk){
            temp1 += shared_B[tidx + kk * blockDim.x] * shared_A[kk + tidy * blockDim.y* 4];
            temp2 += shared_B[tidx + kk * blockDim.x] * shared_A[kk + (tidy + 1) * blockDim.y* 4];
            temp3 += shared_B[tidx + kk * blockDim.x] * shared_A[kk + (tidy + 2) * blockDim.y* 4];
            temp4 += shared_B[tidx + kk * blockDim.x] * shared_A[kk + (tidy + 3) * blockDim.y* 4];
        }
            //temp += shared_B[kk + tidx * blockDim.x]  * shared_A[tidy + kk * blockDim.y];
        __syncthreads();
    }
    C[i + j1 * N] =  alpha * temp1 + beta * C[i + j1 * N];
    C[i + j2 * N] =  alpha * temp2 + beta * C[i + j2 * N];
    C[i + j3 * N] =  alpha * temp3 + beta * C[i + j3 * N];
    C[i + j4 * N] =  alpha * temp4 + beta * C[i + j4 * N];
}