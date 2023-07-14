#include <stdlib.h>
#include <complex>
#include <cuda_runtime.h> 
#include <cufftXt.h>
#include "utils/utils.cuh" 
// extern __shared__ float shared[];
__global__ void global_memory_colescing(float *A, float*B, int N){
    
    int tx = threadIdx.x;
    
    float tmp = 0;
    
    #pragma unroll
    for(int i = 0; i < N / blockDim.x; ++i){
        tmp += A[tx + i * blockDim.x];
    }
    
    // float2 tmp2;
    
    // #pragma unroll
    // for(int i = 0; i < N / (blockDim.x * 2); ++i){
    //     tmp2 = *(((float2*)A) + tx + i * blockDim.x);
    //     tmp += tmp2.x + tmp2.y;
    // }
    float4 tmp4;
    
    // #pragma unroll
    // for(int i = 0; i < N / (blockDim.x * 4); ++i){
    //     tmp4 = *(((float4*)A) + tx + i * blockDim.x);
    //     tmp += tmp4.x + tmp4.y + tmp4.z + tmp4.w;
    // }
    // #pragma unroll
    // for(int i = 0; i < N / (blockDim.x * 8); ++i){
    //     tmp4 = *(((float4*)A) + tx + (i * blockDim.x) * 2);
    //     tmp += tmp4.x + tmp4.y + tmp4.z + tmp4.w;
        
    //     tmp4 = *(((float4*)A) + tx + 1 + (i * blockDim.x) * 2);
    //     tmp += tmp4.x + tmp4.y + tmp4.z + tmp4.w;
    // }
    B[tx] = tmp;
}
__global__ void test_shfl(float * A){
    float x = threadIdx.x ;
    float sum = 0;
    // computation
    for(int i = 0; i < 10; ++i){
    x = __cosf(x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    x = __cosf(1 - x);
    }

    // Reduction with warp shuffling
    sum =  __shfl_xor_sync(0xffffffff, x, 16, 32);
    sum += __shfl_xor_sync(0xffffffff, sum, 8, 32);
    sum += __shfl_xor_sync(0xffffffff, sum, 4, 32);
    sum += __shfl_xor_sync(0xffffffff, sum, 2, 32);
    sum += __shfl_xor_sync(0xffffffff, sum, 1, 32);

    // sum +=  __shfl_xor_sync(0xffffffff, x, 16, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 8, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 4, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 2, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 1, 32);

    // sum +=  __shfl_xor_sync(0xffffffff, x, 16, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 8, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 4, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 2, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 1, 32);

    // sum +=  __shfl_xor_sync(0xffffffff, x, 16, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 8, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 4, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 2, 32);
    // sum += __shfl_xor_sync(0xffffffff, sum, 1, 32);

    // sum =  0.001f * __shfl_xor_sync(0xffffffff, x, 16, 32);
    // sum += 0.001f * __shfl_xor_sync(0xffffffff, sum, 8, 32);
    // sum += 0.001f * __shfl_xor_sync(0xffffffff, sum, 4, 32);
    // sum += 0.001f * __shfl_xor_sync(0xffffffff, sum, 2, 32);
    // sum += 0.001f * __shfl_xor_sync(0xffffffff, sum, 1, 32);
    
    // Memory
    atomicAdd(A, sum);
}

int main(int argc, char** argv){
    cudaEvent_t fft_begin, fft_end;
    float elapsed_time;
    float *dA, *A, *B, *dB;
    int N = 256;
    int n = 32;
    A = (float*)malloc(sizeof(float) * N * n);
    B = (float*)malloc(sizeof(float) * N);
    memset(A, 0, sizeof(float) * N * n);
    memset(B, 0, sizeof(float) * N);
    for(int i = 0; i < N * n; ++i){
        A[i] = 1.0f;
    }
    cudaEventCreate(&fft_begin);
    cudaEventCreate(&fft_end); 
    cudaMalloc((void**) &dA, sizeof(float) * N * n);
    cudaMalloc((void**) &dB, sizeof(float) * N);
    cudaMemcpy((void*)dA, (void*)A, sizeof(float) * N * n, cudaMemcpyHostToDevice);
    cudaMemcpy((void*)dB, (void*)B, sizeof(float) * N, cudaMemcpyHostToDevice);
    // cudaFuncSetAttribute(test_shfl, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
    cudaEventRecord(fft_begin);
    
    for(int i = 0; i < 10; ++i){
        // test_shfl <<<1, 1024>>>(dA);
        global_memory_colescing <<<1, N>>>(dA, dB, N * n);
    }
    cudaEventRecord(fft_end);
    cudaEventSynchronize(fft_begin);
    cudaEventSynchronize(fft_end);
    cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);

    cudaMemcpy((void*)B, (void*)dB, sizeof(float) * N, cudaMemcpyDeviceToHost);
    for(int i  = 0; i < N; ++i)printf("%d: %f\n", i, B[i]);
    // printf("%d, %f\n", elapsed_time, *A);
    printf("%f\n", elapsed_time);

    return 0;
}