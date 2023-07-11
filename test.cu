#include <stdlib.h>
#include <complex>
#include <cuda_runtime.h> 
#include <cufftXt.h>
#include "utils/utils.cuh" 
// extern __shared__ float shared[];
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
    float *dA, *A;
    A = (float*)malloc(sizeof(float));
    cudaEventCreate(&fft_begin);
    cudaEventCreate(&fft_end); 
    cudaMalloc((void**) &dA, sizeof(float) * 1);
    cudaFuncSetAttribute(test_shfl, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
    cudaEventRecord(fft_begin);
    
    for(int i = 0; i < 10; ++i){
    test_shfl <<<1, 1024, 65536>>>(dA);
    }
    cudaEventRecord(fft_end);
    cudaEventSynchronize(fft_begin);
    cudaEventSynchronize(fft_end);
    cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);

    cudaMemcpy((void*)A, (void*)dA, sizeof(float), cudaMemcpyDeviceToHost);

    printf("%d, %f\n", elapsed_time, *A);

    return 0;
}