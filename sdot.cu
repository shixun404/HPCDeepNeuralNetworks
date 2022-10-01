#include <stdio.h>
#include <cublas_v2.h>
#include "utils.cuh"
#define PPP 1
#include <cuda_runtime.h>

//#define N 2048 * 2048 * 2 // Number of elements in each vector
//#define threads_per_block 1024
__global__ void _sdot(int N, float *a, float *b, float *c)
{	
	__shared__ float cache[1024];
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
	int cacheIndex = threadIdx.x;
	
	float temp = 0;
	while (tid < N){
		temp += a[tid] * b[tid];
		tid += blockDim.x * gridDim.x;
	}
	
	cache[cacheIndex] = temp;
	
	__syncthreads();
    int i = blockDim.x/2;
	while (i != 0){
		if (cacheIndex < i)
			cache[cacheIndex] += cache[cacheIndex + i];
		__syncthreads();
		i /= 2;
	}
	
	if (cacheIndex == 0)
	atomicAdd( c , cache[0] );
        //c[blockIdx.x] = cache[0];

}

__global__ void sdot(int N, float *a, float *b, float *c)
{
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int tid_0 = tid;

    float temp = 0;
    while (tid < N){
        temp += a[tid] * b[tid];
        tid += blockDim.x * gridDim.x;
    }
    if(tid_0 < N)
        c[tid_0] = temp;
}
__global__ void reduction(int N, float *a, float *c){
    __shared__ float cache[1024];
    int i = blockDim.x / 2;
    int id = threadIdx.x + blockIdx.x * blockDim.x;
    if(id < N)
    cache[threadIdx.x] = a[id];
    else cache[threadIdx.x] = 0.;
    __syncthreads();
    while(i != 0){
        if(threadIdx.x < i)
            cache[threadIdx.x] += cache[threadIdx.x + i];
        __syncthreads();
        i /= 2;
    }
    if(threadIdx.x == 0)
    c[blockIdx.x] = cache[0];
}

#define multi 20
int main(int argc, char **argv)
{
    if (argc != 2) {
        printf("Please select a kernel (range 0 - 1, here 0 is for NVIDIA cuBLAS).\n");
         exit(-1);
      }
    int kernel_number = atoi(argv[1]);
    int num_tests = 100;
    int start_size = 1024 * 1024 * 64;
    int end_size = 1024 * 1024 * 64 * 8;
    int gap_size = 1024;
    for(int max_size = start_size, exp_=10; max_size <= end_size; max_size *=2, exp_ += 1){
        printf("%8.2d|", exp_);
    }
    printf("\n");
    for(int max_size = start_size; max_size <= end_size; max_size *=2){
        
        float *A = NULL, *B = NULL, *C = NULL, *C_ref = NULL;
        float *dA = NULL,*dB = NULL,*dC = NULL,*dC_ref = NULL;//device matrices
        int size = max_size * sizeof (int); // The total number of bytes per vector
        
        int deviceId;
        
        cudaGetDevice(&deviceId);
        
        cudaDeviceProp props = getDetails(deviceId);
        
        int threads_per_block = 1024;
        
        int number_of_blocks = min(1024, (max_size + 1024 - 1) / threads_per_block);
        //printf("\n number of blocks: %d\n", number_of_blocks);
        A = (float *)malloc(sizeof(float) * max_size);
        B = (float *)malloc(sizeof(float) * max_size);
        C = (float *)malloc(sizeof(float) * max_size);
        C_ref = (float *)malloc(sizeof(float) * max_size);
        
        generate_random_vector(A, max_size);
        generate_random_vector(B, max_size);
        //generate_random_vector(C, max_size);
        float val = 2.0;
        //fill_vector(A, max_size, val);
        //fill_vector(B, max_size, val);
        fill_vector(C, max_size, 0.0);
        
        
        copy_vector(C, C_ref, max_size);
    
        CUDA_CALLER(cudaMalloc((void**) &dA, sizeof(float) * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dB, sizeof(float) * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dC, sizeof(float) * max_size * 4));
        CUDA_CALLER(cudaMalloc((void**) &dC_ref, sizeof(float) * max_size));
        //CUDA_CALLER(cudaMalloc((void**) &dC_1, sizeof(float) * max_size));
        //CUDA_CALLER(cudaMalloc((void**) &dC_2, sizeof(float) * max_size / 1024));
        //CUDA_CALLER(cudaMalloc((void**) &dC_3, sizeof(float) * max_size) / 1024);
        //CUDA_CALLER(cudaMalloc((void**) &dC_4, sizeof(float) * max_size) / 1024);
        
        
        CUDA_CALLER(cudaMemcpy(dA, A, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dB, B, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dC, C, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dC_ref, C_ref, sizeof(float) * max_size, cudaMemcpyHostToDevice));

        cublasHandle_t handle;
        cublasCreate(&handle);
        
        if (!verify_vector(C_ref, C, 1)) {
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
            exit(-3);
        }
        //printf("abc\n");
        // cublasSdot(err, CUBLAS_OP_N, CUBLAS_OP_N, m, n, k, &alpha, dA, m, dB, k, &beta, dC_ref, m);
        cublasSdot(handle, max_size, dA, 1, dB, 1, dC_ref);
        //sdot <<< number_of_blocks, threads_per_block >>> (max_size, dA, dB, dC);
        /*
        int j = 0;
        int reduction_size = number_of_blocks * 1024;//min(number_of_blocks * 1024, max_size);
        //printf("reduction_size %d\n", reduction_size);
        sdot <<< number_of_blocks, threads_per_block >>> (max_size, dA, dB, dC);
        while(reduction_size != 1){
            //reduction_size = (reduction_size + 1023) / 1024;
            reduction <<<(reduction_size + 1023) / 1024, threads_per_block >>> (reduction_size, dC + j * max_size, dC +
            (j + 1) * max_size);
            j++;
            reduction_size = (reduction_size + 1023) / 1024;
        }
        */
        _sdot <<< number_of_blocks, threads_per_block >>> (max_size, dA, dB, dC);
        //printf("j: %d\n", j);
        cudaDeviceSynchronize();
        //cudaMemcpy(C, dC + j * max_size, sizeof(float) * max_size, cudaMemcpyDeviceToHost);
        cudaMemcpy(C, dC, sizeof(float) * max_size, cudaMemcpyDeviceToHost);
        cudaMemcpy(C_ref, dC_ref, sizeof(float) * max_size, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();
        
        
        if (!verify_vector(C_ref, C, 1)) {
            
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
            //printf("j is %d\n", j);
            
            exit(-3);
        }
        if (kernel_number == 1){
        // test

            //int reduction_size = number_of_blocks * threads_per_block;
            saxpy_timer t;
            for(int ii = 0; ii < num_tests; ++ii){
	            int reduction_size = number_of_blocks * 1024;
                int j = 0;
                sdot <<< number_of_blocks, threads_per_block >>> (max_size, dA, dB, dC);       
                while(reduction_size != 1){
                    reduction <<<(reduction_size + 1023) / 1024, threads_per_block >>> (reduction_size, dC + j * max_size, dC +
                    (j + 1) * max_size);
                    j++;
                    reduction_size = (reduction_size +1023) / 1024;
                }
            }
            //double elapsed = t.elapsed_msec();
            cudaMemPrefetchAsync(dC, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%8.2f|", perf);
        }

        else if (kernel_number == 2){
                      saxpy_timer t;
            for(int ii = 0; ii < num_tests; ++ii){
                sdot <<< number_of_blocks, threads_per_block >>> (max_size, dA, dB, dC);
            }
            //double elapsed = t.elapsed_msec();
            cudaMemPrefetchAsync(dC, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%8.2f|", perf);
  
        }
        else if (kernel_number == 0){
            saxpy_timer t;
            for(int ii = 0; ii < num_tests; ++ii){
                cublasSdot(handle, max_size, dA, 1, dB, 1, dC);
            }
            cudaMemPrefetchAsync(dC, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%8.2f|", perf);
        }
        for(int ii = 0; ii < num_tests; ++ii){
            cudaFree( dC ); 
            cudaFree( dA ); 
            cudaFree( dB );
            cudaFree( dC_ref );
        }
        fflush(stdout);
    }
    printf("\n");
}
