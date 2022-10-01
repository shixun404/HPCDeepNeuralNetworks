#include <stdio.h>
#include <cublas_v2.h>
 #include "utils.cuh"
#define PPP 1
//#define N 2048 * 2048 * 2 // Number of elements in each vector
//#define threads_per_block 1024
__global__ void sdot(int N_, int threads_per_block_, float *a, float *b, float *c, int N)
{	
	__shared__ float cache[1024];
	int tid = threadIdx.x + blockIdx.x * blockDim.x;
	int cacheIndex = threadIdx.x;
	
	float temp = 0;
	while (tid < N_){
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


#define multi 20
int main(int argc, char **argv)
{
    if (argc != 2) {
        printf("Please select a kernel (range 0 - 1, here 0 is for NVIDIA cuBLAS).\n");
         exit(-1);
      }
    int kernel_number = atoi(argv[1]);
     for(int N = 1024 * 2048; N <= 2048 * 2048 * 4; N += 2048 * 1024){
        
        int M = 100;
        
        float *x[100], *y[100], *result[100];
        
        int size = N * sizeof (int); // The total number of bytes per vector
        
        int deviceId;
        
        cudaGetDevice(&deviceId);
        
        cudaDeviceProp props = getDetails(deviceId);
        
        int threads_per_block = 1024;
        
        int number_of_blocks =2048;

    for(int ii = 0; ii < M; ++ii){
        
        cudaMallocManaged(&result[ii], sizeof(int));
        cudaMallocManaged(&x[ii], size);
        cudaMallocManaged(&y[ii], size);
    
        cudaMemPrefetchAsync(result[ii], 1, deviceId);
        cudaMemPrefetchAsync(x[ii], size, deviceId);
        cudaMemPrefetchAsync(y[ii], size, deviceId);

    //printf("number of sms :%d \n", props.multiProcessorCount);
    //int number_of_blocks = 1024;//props.multiProcessorCount * multi;
	
	cudaStream_t stream_result; cudaStreamCreate(&stream_result);
	cudaStream_t stream_x; cudaStreamCreate(&stream_x);
	cudaStream_t stream_y; cudaStreamCreate(&stream_y);

    fill<<<threads_per_block, number_of_blocks, 0, stream_result>>>(result[ii], 0.0, 1); //result
    fill<<<threads_per_block, number_of_blocks, 0, stream_x>>>(x[ii], 1.0, N); // array x 
    fill<<<threads_per_block, number_of_blocks, 0, stream_y>>>(y[ii], 2.0, N); // array y
	
    cudaStreamDestroy(stream_result); cudaStreamDestroy(stream_x); cudaStreamDestroy(stream_y);	
    }
    cublasHandle_t handle;
    cublasCreate(&handle);
    //error variables
    //cudaError_t addVectorsErr;
    //cudaError_t asyncErr;
    if (kernel_number == 1){
    saxpy_timer t;
    //float alpha=1.6;
    //int M = 10000;
    for(int ii = 0; ii < M; ++ii){
	    sdot <<< number_of_blocks, threads_per_block >>> (N, threads_per_block, x[ii], y[ii] , result[ii], N);
	    //cublasSdot(handle, N, x[ii], 1, y[ii], 1, result[ii]);
    }
    cudaMemPrefetchAsync(result, size, cudaCpuDeviceId);
    cudaDeviceSynchronize();
    double elapsed = t.elapsed_msec();
    double gflops = double(2 * M * double(N)) / (1e9);
    double perf = gflops / (elapsed / 1e3);
    printf("%8.2f|", perf);
    }
    else if (kernel_number == 0){
        saxpy_timer t;
    //float alpha=1.6;
    //int M = 10000;
    for(int ii = 0; ii < M; ++ii){
        //sdot <<< number_of_blocks, threads_per_block >>> (N, threads_per_block, x[ii], y[ii] , result[ii], N);
        cublasSdot(handle, N, x[ii], 1, y[ii], 1, result[ii]);
    }
    cudaMemPrefetchAsync(result, size, cudaCpuDeviceId);
    cudaDeviceSynchronize();
    double elapsed = t.elapsed_msec();
    double gflops = double(2 * M * double(N)) / (1e9);
    double perf = gflops / (elapsed / 1e3);
    printf("%8.2f|", perf);

    }
    for(int ii = 0; ii < M; ++ii){
        cudaFree( result[ii] ); cudaFree( x[ii] ); cudaFree( y[ii] );
    }
}
printf("\n");
}
