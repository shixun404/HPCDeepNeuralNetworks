#include <stdio.h>

#include <cublas_v2.h>
#include "utils.cuh"
 //#define N 2048 * 2048 * 2 // Number of elements in each vector

__global__ void saxpy_(float *x, float *y,float alpha, float *result, int N)
{
   int index = threadIdx.x + blockIdx.x * blockDim.x;
   int stride = blockDim.x * gridDim.x;
   
   for(int i = index; i < N; i += stride)
   {
       result[i] = alpha * x[i] + y[i];
   }
}

__global__ void saxpy(float *x, float *y, float alpha, int N)
{
   int index = threadIdx.x + blockIdx.x * blockDim.x;
   int stride = blockDim.x * gridDim.x;
   for(int i = index; i < N; i += stride)
   {
       y[i] =  alpha * x[i] + y[i];
   }
}




#define multi 20
int main()
{
    for(int N = 2048; N <= 2048 * 2048; N *= 2){
    //float *x[100], *y[100], *result[100];
    float *x, *y, *result;
    int M = 100;
    float  *x_[100], *y_[100], *result_[100];
    int size = N * sizeof (float); // The total number of bytes per vector

    int deviceId;
    cudaGetDevice(&deviceId);
    cudaDeviceProp props = getDetails(deviceId);
    int threads_per_block = 1024;
    int number_of_blocks = props.multiProcessorCount * 10;


for(int ii = 0; ii < M; ++ii){
    cudaMallocManaged(&result_[ii], size);
    cudaMallocManaged(&x_[ii], size);
    cudaMallocManaged(&y_[ii], size);
    
    cudaMemPrefetchAsync(result_[ii], size, deviceId);
    cudaMemPrefetchAsync(x_[ii], size, deviceId);
    cudaMemPrefetchAsync(y_[ii], size, deviceId);
	
	
    cudaStream_t stream_result; cudaStreamCreate(&stream_result);
    cudaStream_t stream_x; cudaStreamCreate(&stream_x);
    cudaStream_t stream_y; cudaStreamCreate(&stream_y);

    fill<<<threads_per_block,number_of_blocks, 0 , stream_result>>>(result_[ii], 0.0, N); //result
    fill<<<threads_per_block,number_of_blocks, 0 , stream_x>>>(x_[ii], 2.0, N); // array x 
    fill<<<threads_per_block,number_of_blocks, 0 , stream_y>>>(y_[ii], 2.0, N); // array y
	
	cudaStreamDestroy(stream_result); cudaStreamDestroy(stream_x); cudaStreamDestroy(stream_y);	
    //x_[0] = x;
    //y_[0] = y;
    //result_[0] = result;
  }
    cublasHandle_t handle;
    cublasCreate(&handle);

    //error variables
    cudaError_t addVectorsErr;
    cudaError_t asyncErr;
    saxpy_timer t;
    float alpha=2.0;
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start);
    for(int i = 0; i < M; ++i){
	saxpy <<< number_of_blocks, threads_per_block >>> ( x_[i], y_[i], alpha, N);
	//cublasSaxpy(handle, N, &alpha, x_[i], 1, y_[i], 1)	;
	//saxpy <<< number_of_blocks, threads_per_block >>> ( x, y , result)
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    //float milliseconds = 0;
    float elapsed = 0;//t.elapsed_msec();
    cudaEventElapsedTime(&elapsed, start, stop);
    cudaMemPrefetchAsync(result, size, cudaCpuDeviceId);
    cudaDeviceSynchronize();
    double gflops = 2 * M * double(N) / 1e9;
    double perf = gflops / (elapsed / 1e3);
    //printf("%fms\n performance: %f gflops\n", elapsed, perf);
    printf("%f, ", perf);
    
    //addVectorsErr = cudaGetLastError();

    //if(addVectorsErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(addVectorsErr));

    //asyncErr = cudaDeviceSynchronize();
    //if(asyncErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(asyncErr));

    
    //Print out the first and last 5 values of c for a quality check
    //for( int i = 0; i < 5; ++i )
    //    printf("y[%d] = %f, ", i, y_[0][i]);
    //printf ("\n");
    //for( int i = N-5; i < N; ++i )
    //    printf("y[%d] = %f, ", i, y_[99][i]);
    //printf ("\n");

    for(int ii = 0; ii < M; ++ii){
	cudaFree( result_[ii] ); cudaFree( x_[ii] ); cudaFree( y_[ii] );
	}
	}
}
