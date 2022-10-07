__global__ __launch_bounds__(1024) void sgemm_5(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[1024];
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j1 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4;
    int j2 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 1;
    int j3 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 2;
    int j4 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 3;
    int tidx = threadIdx.x, tidy = threadIdx.y * 4;
    float4 temp, A4;
    float bb = 0;
    temp.x = 0, temp.y = 0, temp.z = 0, temp.w = 0;
    for(int k = 0; k < gridDim.x; ++k){
        int ii = threadIdx.x + k * blockDim.x;
        int jj1 = tidy + k * blockDim.y * 4 + 0;
        int jj2 = tidy + k * blockDim.y * 4 + 1;
        int jj3 = tidy + k * blockDim.y * 4 + 2;
        int jj4 = tidy + k * blockDim.y * 4 + 3;
        shared_A[tidy + tidx * blockDim.y * 4] = A[ii + j1 * N];
        shared_A[tidy + 1 + tidx * blockDim.y * 4] = A[ii + j2 * N];
        shared_A[tidy + 2 + tidx * blockDim.y * 4] = A[ii + j3 * N];
        shared_A[tidy + 3 + tidx * blockDim.y* 4] = A[ii + j4 * N];
        shared_B[tidx + tidy * blockDim.y * 4] = B[i + jj1 * N];
        shared_B[tidx + (1 + tidy) * blockDim.y * 4] = B[i + jj2 * N];
        shared_B[tidx + (2 + tidy) * blockDim.y* 4] = B[i + jj3 * N];
        shared_B[tidx + (3 + tidy) * blockDim.y* 4] = B[i + jj4 * N];
        // shared_B[tidy + tidx * blockDim.y * 4] = B[i + jj1 * N];
        // shared_B[tidy + 1 + tidx * blockDim.y * 4] = B[i + jj2 * N];
        // shared_B[tidy + 2 + tidx * blockDim.y* 4] = B[i + jj3 * N];
        // shared_B[tidy + 3 + tidx * blockDim.y* 4] = B[i + jj4 * N];
        // shared_B[tidy + tidx * blockDim.y * 4] = B[tidy + blockIdx.x * blockDim.x + (tidx + k * blockDim.x) * N];
        // shared_B[tidy + 1 + tidx * blockDim.y * 4] = B[tidy + blockIdx.x * blockDim.x + 1 + (tidx + k * blockDim.x) * N];
        // shared_B[tidy + 2 + tidx * blockDim.y* 4] = B[tidy + blockIdx.x * blockDim.x  + 2+ (tidx + k * blockDim.x) * N];
        // shared_B[tidy + 3 + tidx * blockDim.y* 4] = B[tidy + blockIdx.x * blockDim.x + 3 + (tidx + k * blockDim.x) * N];
        __syncthreads();
        for(int kk = 0; kk < blockDim.x; ++kk){
            bb = shared_B[tidx + kk * blockDim.x];
            A4 = *(float4*)(shared_A + tidy + kk * blockDim.y* 4);
            temp.x += bb * A4.x;
            temp.y += bb * A4.y;
            temp.z += bb * A4.z;
            temp.w += bb * A4.w;
            // temp1 += shared_B[kk + tidx * blockDim.x] * shared_A[tidy + kk * blockDim.y* 4];
            // temp2 += shared_B[kk + tidx * blockDim.x] * shared_A[(tidy + 1) + kk * blockDim.y* 4];
            // temp3 += shared_B[kk + tidx * blockDim.x] * shared_A[(tidy + 2) + kk * blockDim.y* 4];
            // temp4 += shared_B[kk + tidx * blockDim.x] * shared_A[(tidy + 3) + kk * blockDim.y* 4];
        }
            //temp += shared_B[kk + tidx * blockDim.x]  * shared_A[tidy + kk * blockDim.y];
        __syncthreads();
    }
    C[i + j1 * N] =  alpha * temp.x + beta * C[i + j1 * N];
    C[i + j2 * N] =  alpha * temp.y + beta * C[i + j2 * N];
    C[i + j3 * N] =  alpha * temp.z + beta * C[i + j3 * N];
    C[i + j4 * N] =  alpha * temp.w + beta * C[i + j4 * N];
}