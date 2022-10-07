__global__  __launch_bounds__(1024) void sgemm_6(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[1024];
    int i1 = threadIdx.x * 4 + blockIdx.x * blockDim.x * 4;
    int i2 = threadIdx.x * 4 + blockIdx.x * blockDim.x * 4 + 1;
    int i3 = threadIdx.x * 4 + blockIdx.x * blockDim.x * 4 + 2;
    int i4 = threadIdx.x * 4 + blockIdx.x * blockDim.x * 4 + 3;
    int j1 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4;
    int j2 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 1;
    int j3 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 2;
    int j4 = threadIdx.y * 4 + blockIdx.y * blockDim.y * 4 + 3;
    int tidx = threadIdx.x * 4, tidy = threadIdx.y * 4;
    float4 temp[4], aa, bb, A1, C1[4];
    memset(temp, 0, sizeof(temp));
    for(int k = 0; k < gridDim.x; ++k){
        int ii1 = tidx + k * blockDim.x * 4;
        int ii2 = tidx + k * blockDim.x * 4 + 1;
        int ii3 = tidx + k * blockDim.x * 4 + 2;
        int ii4 = tidx + k * blockDim.x * 4 + 3;
        int jj1 = tidy + k * blockDim.y * 4 + 0;
        int jj2 = tidy + k * blockDim.y * 4 + 1;
        int jj3 = tidy + k * blockDim.y * 4 + 2;
        int jj4 = tidy + k * blockDim.y * 4 + 3;

        A1 = *(float4*)(A + ii1 + j1 * N);
        shared_A[tidy + tidx * blockDim.y * 4] = A1.x;
        shared_A[tidy + (tidx + 1) * blockDim.y * 4] = A1.y;
        shared_A[tidy + (tidx + 2) * blockDim.y * 4] = A1.z;
        shared_A[tidy + (tidx + 3) * blockDim.y * 4] = A1.w;

        A1 = *(float4*)(A + ii1 + j2 * N);
        shared_A[tidy + 1 + tidx * blockDim.y * 4] = A1.x;
        shared_A[tidy + 1 + (tidx + 1) * blockDim.y * 4] = A1.y;
        shared_A[tidy + 1 + (tidx + 2) * blockDim.y * 4] = A1.z;
        shared_A[tidy + 1 + (tidx + 3) * blockDim.y * 4] = A1.w;

        A1 = *(float4*)(A + ii1 + j3 * N);
        shared_A[tidy + 2 + tidx * blockDim.y * 4] = A1.x;
        shared_A[tidy + 2 + (tidx + 1) * blockDim.y * 4] = A1.y;
        shared_A[tidy + 2 + (tidx + 2) * blockDim.y * 4] = A1.z;
        shared_A[tidy + 2 + (tidx + 3) * blockDim.y * 4] = A1.w;

        A1 = *(float4*)(A + ii1 + j4 * N);
        shared_A[tidy + 3 + tidx * blockDim.y* 4] = A1.x;
        shared_A[tidy + 3 + (tidx + 1) * blockDim.y* 4] = A1.y;
        shared_A[tidy + 3 + (tidx + 2) * blockDim.y* 4] = A1.z;
        shared_A[tidy + 3 + (tidx + 3) * blockDim.y* 4] = A1.w;

        *(float4*)(shared_B + tidx + tidy * blockDim.y * 4) = *(float4*)(B + i1 + jj1 * N);
        *(float4*)(shared_B + tidx + (1 + tidy) * blockDim.y * 4) = *(float4*)(B + i1 + jj2 * N);
        *(float4*)(shared_B + tidx + (2 + tidy) * blockDim.y* 4) = *(float4*)(B + i1 + jj3 * N);
        *(float4*)(shared_B + tidx + (3 + tidy) * blockDim.y* 4) = *(float4*)(B + i1 + jj4 * N);
        __syncthreads();
        for(int kk = 0; kk < blockDim.x * 4; ++kk){
            bb = *(float4*)(shared_B + tidx + kk * blockDim.x * 4);
            aa = *(float4*)(shared_A + tidy + kk * blockDim.y * 4);
            temp[0].x += bb.x * aa.x;
            temp[0].y += bb.x * aa.y;
            temp[0].z += bb.x * aa.z;
            temp[0].w += bb.x * aa.w;
            
            temp[1].x += bb.y * aa.x;
            temp[1].y += bb.y * aa.y;
            temp[1].z += bb.y * aa.z;
            temp[1].w += bb.y * aa.w;

            temp[2].x += bb.z * aa.x;
            temp[2].y += bb.z * aa.y;
            temp[2].z += bb.z * aa.z;
            temp[2].w += bb.z * aa.w;

            temp[3].x += bb.w * aa.x;
            temp[3].y += bb.w * aa.y;
            temp[3].z += bb.w * aa.z;
            temp[3].w += bb.w * aa.w;
        }
            //temp += shared_B[kk + tidx * blockDim.x]  * shared_A[tidy + kk * blockDim.y];
        __syncthreads();
    }
    C1[0] = *(float4*)(C + i1 + j1 * N);
    C1[1] = *(float4*)(C + i1 + j2 * N);
    C1[2] = *(float4*)(C + i1 + j3 * N);
    C1[3] = *(float4*)(C + i1 + j4 * N);
    C1[0].x =  alpha * temp[0].x + beta * C1[0].x;
    C1[1].x =  alpha * temp[0].y + beta * C1[1].x;
    C1[2].x =  alpha * temp[0].z + beta * C1[2].x;
    C1[3].x =  alpha * temp[0].w + beta * C1[3].x;

    C1[0].y =  alpha * temp[1].x + beta * C1[0].y;
    C1[1].y =  alpha * temp[1].y + beta * C1[1].y;
    C1[2].y =  alpha * temp[1].z + beta * C1[2].y;
    C1[3].y =  alpha * temp[1].w + beta * C1[3].y;

    C1[0].z =  alpha * temp[2].x + beta * C1[0].z;
    C1[1].z =  alpha * temp[2].y + beta * C1[1].z;
    C1[2].z =  alpha * temp[2].z + beta * C1[2].z;
    C1[3].z =  alpha * temp[2].w + beta * C1[3].z;

    C1[0].w =  alpha * temp[3].x + beta * C1[0].w;
    C1[1].w =  alpha * temp[3].y + beta * C1[1].w;
    C1[2].w =  alpha * temp[3].z + beta * C1[2].w;
    C1[3].w =  alpha * temp[3].w + beta * C1[3].w;

    *(float4*)(C + i1 + j1 * N) = C1[0]; 
    *(float4*)(C + i1 + j2 * N) = C1[1];
    *(float4*)(C + i1 + j3 * N) = C1[2];
    *(float4*)(C + i1 + j4 * N) = C1[3];
}