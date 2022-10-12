// __global__ __launch_bounds__(1024) void sgemm_4(int N, float *A, float *B, float *C, float alpha, float beta){
//     __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
//     __shared__ float shared_B[1024];
//     int i = threadIdx.y + blockIdx.y * blockDim.y;
//     int j1 = threadIdx.x * 4 + blockIdx.x * blockDim.x * 4;
//     int j2 = threadIdx.x * 4 + blockIdx.x * blockDim.x * 4 + 1;
//     int j3 = threadIdx.x * 4 + blockIdx.x * blockDim.x * 4 + 2;
//     int j4 = threadIdx.x * 4 + blockIdx.x * blockDim.x * 4 + 3;
//     int tidy = threadIdx.y, tidx = threadIdx.x * 4;
//     float4 temp, bb;
//     temp.x = 0., temp.y = 0., temp.z = 0., temp.w = 0. ;
//     for(int k = 0; k < gridDim.y; ++k){
//         int ii = threadIdx.y + k * blockDim.y;
//         int jj1 = tidx + k * blockDim.x * 4 + 0;
//         // int jj2 = tidx + k * blockDim.x * 4 + 1;
//         // int jj3 = tidx + k * blockDim.x * 4 + 2;
//         // int jj4 = tidx + k * blockDim.x * 4 + 3;
//         *(float4*)(shared_A+tidx + tidy * blockDim.y) = *(float4*)(A+jj1 + i * N);
//         // shared_A[(tidx + 1) + tidy * blockDim.y ] = A[jj2 + i * N];
//         // shared_A[(tidx + 2) +  tidy * blockDim.y] = A[jj3 + i * N];
//         // shared_A[(tidx + 3) +  tidy * blockDim.y] = A[jj4 + i * N];
//         *(float4*)(shared_B+tidx + tidy * blockDim.y) = *(float4*)(B + j1 + ii * N);
//         // shared_B[tidx + 1 + tidy * blockDim.y] = B[j2 + ii * N];
//         // shared_B[tidx + 2 + tidy * blockDim.y] = B[j3 + ii * N];
//         // shared_B[tidx + 3 + tidy * blockDim.y] = B[j4 + ii * N];
//         __syncthreads();
//         for(int kk = 0; kk < blockDim.y; ++kk){
//             // temp1 += shared_B[tidx + kk * blockDim.y] * shared_A[kk + tidy * blockDim.y];
//             // temp2 += shared_B[tidx + 1 + kk * blockDim.y] * shared_A[kk + tidy * blockDim.y];
//             // temp3 += shared_B[tidx + 2 + kk * blockDim.y] * shared_A[kk + tidy * blockDim.y];
//             // temp4 += shared_B[tidx + 3 + kk * blockDim.y] * shared_A[kk + tidy * blockDim.y];
//             bb = *(float4*)(shared_B + tidx + kk * blockDim.y);
//             temp.x += bb.x * shared_A[kk + tidy * blockDim.y];
//             temp.y += bb.y * shared_A[kk + tidy * blockDim.y];
//             temp.z += bb.z * shared_A[kk + tidy * blockDim.y];
//             temp.w += bb.w * shared_A[kk + tidy * blockDim.y];
//         }
//             //temp += shared_B[kk + tidx * blockDim.x]  * shared_A[tidy + kk * blockDim.y];
//         __syncthreads();
//     }
//     C[j1 + i * N] =  alpha * temp.x + beta * C[j1 + i * N];
//     C[j2 + i * N] =  alpha * temp.y + beta * C[j2 + i * N];
//     C[j3 + i * N] =  alpha * temp.z + beta * C[j3 + i * N];
//     C[j4 + i * N] =  alpha * temp.w + beta * C[j4 + i * N];
// }


__global__ void sgemm_4(int N, float *A, float *B, float *C, float alpha, float beta){
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
            temp1 += shared_B[tidx + kk * blockDim.x] * shared_A[tidy + kk * blockDim.y* 4];
            temp2 += shared_B[tidx + kk * blockDim.x] * shared_A[(tidy + 1) + kk * blockDim.y* 4];
            temp3 += shared_B[tidx + kk * blockDim.x] * shared_A[(tidy + 2) + kk * blockDim.y* 4];
            temp4 += shared_B[tidx + kk * blockDim.x] * shared_A[(tidy + 3) + kk * blockDim.y* 4];
            // temp1 += shared_B[kk + tidx * blockDim.x] * shared_A[tidy + kk * blockDim.y* 4];
            // temp2 += shared_B[kk + tidx * blockDim.x] * shared_A[(tidy + 1) + kk * blockDim.y* 4];
            // temp3 += shared_B[kk + tidx * blockDim.x] * shared_A[(tidy + 2) + kk * blockDim.y* 4];
            // temp4 += shared_B[kk + tidx * blockDim.x] * shared_A[(tidy + 3) + kk * blockDim.y* 4];
        }
            //temp += shared_B[kk + tidx * blockDim.x]  * shared_A[tidy + kk * blockDim.y];
        __syncthreads();
    }
    C[i + j1 * N] =  alpha * temp1 + beta * C[i + j1 * N];
    C[i + j2 * N] =  alpha * temp2 + beta * C[i + j2 * N];
    C[i + j3 * N] =  alpha * temp3 + beta * C[i + j3 * N];
    C[i + j4 * N] =  alpha * temp4 + beta * C[i + j4 * N];
}