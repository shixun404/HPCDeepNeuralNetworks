#define m 4
__global__  __launch_bounds__(256) void sgemm_7(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[4096]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[4096];
    int i1 = threadIdx.x * m + blockIdx.x * blockDim.x * m;
    int j1 = threadIdx.y * m + blockIdx.y * blockDim.y * m;
    int tidx = threadIdx.x * m, tidy = threadIdx.y * m;
    float4 temp[4], aa, bb, A1, C1[4];
    memset(temp, 0, sizeof(temp));
    for(int k = 0; k < gridDim.x; ++k){
        int ii1 = tidx + k * blockDim.x * m;
        int jj1 = tidy + k * blockDim.y * m;

        A1 = *(float4*)(A + ii1 + j1 * N);
        shared_A[tidy + tidx * blockDim.y * m] = A1.x;
        shared_A[tidy + (tidx + 1) * blockDim.y * m] = A1.y;
        shared_A[tidy + (tidx + 2) * blockDim.y * m] = A1.z;
        shared_A[tidy + (tidx + 3) * blockDim.y * m] = A1.w;

        A1 = *(float4*)(A + ii1 + (j1 + 1) * N);
        shared_A[tidy + 1 + tidx * blockDim.y * m] = A1.x;
        shared_A[tidy + 1 + (tidx + 1) * blockDim.y * m] = A1.y;
        shared_A[tidy + 1 + (tidx + 2) * blockDim.y * m] = A1.z;
        shared_A[tidy + 1 + (tidx + 3) * blockDim.y * m] = A1.w;

        A1 = *(float4*)(A + ii1 + (j1 + 2) * N);
        shared_A[tidy + 2 + tidx * blockDim.y * m] = A1.x;
        shared_A[tidy + 2 + (tidx + 1) * blockDim.y * m] = A1.y;
        shared_A[tidy + 2 + (tidx + 2) * blockDim.y * m] = A1.z;
        shared_A[tidy + 2 + (tidx + 3) * blockDim.y * m] = A1.w;

        A1 = *(float4*)(A + ii1 + (j1 + 3) * N);
        shared_A[tidy + 3 + tidx * blockDim.y* m] = A1.x;
        shared_A[tidy + 3 + (tidx + 1) * blockDim.y* m] = A1.y;
        shared_A[tidy + 3 + (tidx + 2) * blockDim.y* m] = A1.z;
        shared_A[tidy + 3 + (tidx + 3) * blockDim.y* m] = A1.w;

        *(float4*)(shared_B + tidx + tidy * blockDim.y * m) = *(float4*)(B + i1 + jj1 * N);
        *(float4*)(shared_B + tidx + (1 + tidy) * blockDim.y * m) = *(float4*)(B + i1 + (jj1 + 1) * N);
        *(float4*)(shared_B + tidx + (2 + tidy) * blockDim.y* m) = *(float4*)(B + i1 + (jj1 + 2) * N);
        *(float4*)(shared_B + tidx + (3 + tidy) * blockDim.y* m) = *(float4*)(B + i1 + (jj1 + 3) * N);
        __syncthreads();
        for(int kk = 0; kk < blockDim.x * m; ++kk){
            bb = *(float4*)(shared_B + tidx + kk * blockDim.x * m);
            aa = *(float4*)(shared_A + tidy + kk * blockDim.y * m);
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
    C1[1] = *(float4*)(C + i1 + (j1 + 1) * N);
    C1[2] = *(float4*)(C + i1 + (j1 + 2) * N);
    C1[3] = *(float4*)(C + i1 + (j1 + 3) * N);
    
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
    *(float4*)(C + i1 + (j1 + 1) * N) = C1[1];
    *(float4*)(C + i1 + (j1 + 2) * N) = C1[2];
    *(float4*)(C + i1 + (j1 + 3) * N) = C1[3];
}