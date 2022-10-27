__global__ void sgemm_1(int N, float *A, float *B, float *C, float alpha, float beta){
    // int idx = threadIdx.x + blockIdx.x * blockDim.x;
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j = threadIdx.y + blockIdx.y  * blockDim.y;
    float temp = 0.;
    for(int k = 0; k < N; ++k){
        temp += B[i + k * N] * A[k + j * N]; // Why line 24 much faster than line 25?
        // temp += B[j + k * N] * A[k + i * N];
    }
    C[i + j * N] = alpha * temp + beta * C[i + j * N];
    // C[j + i * N] = alpha * temp + beta * C[j + i * N];
}