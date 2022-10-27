__global__ __launch_bounds__(1024) void sgemm_2(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[1024];
    int threads_per_block = blockDim.x;
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j = threadIdx.y + blockIdx.y * blockDim.y;
    int tidx = threadIdx.x, tidy = threadIdx.y;
    C[i + j * N] *= beta;
    float temp = 0;
    for(int k = 0; k < gridDim.x; ++k){
        int ii = threadIdx.x + k * blockDim.x;
        int jj = threadIdx.y + k * blockDim.y;
        shared_A[tidx + tidy * blockDim.y] = A[ii + j * N];
        shared_B[tidx + tidy * blockDim.y] = B[i + jj * N];
        __syncthreads();
        for(int kk = 0; kk < blockDim.x; ++kk)
            temp += shared_B[tidx + kk * blockDim.x] * shared_A[kk + tidy * blockDim.y];
            //temp += shared_B[kk + tidx * blockDim.x]  * shared_A[tidy + kk * blockDim.y];
        __syncthreads();
    }
    C[i + j * N] +=  alpha * temp;
}