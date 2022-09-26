#include <stdio.h>
#include <cublas_v2.h>
#define N 2048 * 2048 * 2 // Number of elements in each vector


#include <chrono>
class saxpy_timer
{
public:
    saxpy_timer() { reset(); }
    void reset() {
	t0_ = std::chrono::high_resolution_clock::now();
    }
    double elapsed(bool reset_timer=false) {
	std::chrono::high_resolution_clock::time_point t =
			std::chrono::high_resolution_clock::now();
	std::chrono::duration<double> time_span =
			std::chrono::duration_cast<std::chrono::duration<double>>(t - t0_);
	if (reset_timer)
	    reset();
	return time_span.count();
    }
    double elapsed_msec(bool reset_timer=false) {
	return elapsed(reset_timer) * 1000;
    }
private:
    std::chrono::high_resolution_clock::time_point t0_;
};
__global__ void fill(float *a , float x)
{
   int index =  blockIdx.x * blockDim.x + threadIdx.x;
   int stride = blockDim.x * gridDim.x;
   
   for(int i = index; i < N; i += stride)
   {
       a[i] = x;
   }
}

__global__ void saxpy_(float *x, float *y,float alpha, float *result)
{
   int index = threadIdx.x + blockIdx.x * blockDim.x;
   int stride = blockDim.x * gridDim.x;
   
   for(int i = index; i < N; i += stride)
   {
       result[i] = alpha * x[i] + y[i];
   }
}

__global__ void saxpy(float *x, float *y, float alpha)// float loop=8)
{
   int index = threadIdx.x + blockIdx.x * blockDim.x;
   //printf("%d")
	int stride = blockDim.x * gridDim.x;
 //printf("%d\n", loop);
   
   //int index = (threadIdx.x + blockIdx.x * blockDim.x) * loop;
   //int index_next = index + loop;
   for(int i = index; i < N; i += stride)
    //for(int i = index; i < index_next; i += 1)
   {
       y[i] =  alpha * x[i] + y[i];
	 //y[i] = __fadd_rn(__fmul_rd(alpha, x[i]), y[i]);
   }
}



cudaDeviceProp getDetails(int deviceId)
{
    cudaDeviceProp props;
    cudaGetDeviceProperties(&props, deviceId);
    return props;
}



#define multi 20
int main()
{
    float *x, *y, *result;
    int size = N * sizeof (int); // The total number of bytes per vector
    
    int deviceId;
    cudaGetDevice(&deviceId);
    cudaDeviceProp props = getDetails(deviceId);
    

    cudaMallocManaged(&result, size);
    cudaMallocManaged(&x, size);
    cudaMallocManaged(&y, size);
    
    cudaMemPrefetchAsync(result, size, deviceId);
    cudaMemPrefetchAsync(x, size, deviceId);
    cudaMemPrefetchAsync(y, size, deviceId);
	
    int threads_per_block = 1024;
    printf("number of sms :%d \n", props.multiProcessorCount);
    int number_of_blocks = props.multiProcessorCount * 10;
	
	cudaStream_t stream_result; cudaStreamCreate(&stream_result);
	cudaStream_t stream_x; cudaStreamCreate(&stream_x);
	cudaStream_t stream_y; cudaStreamCreate(&stream_y);

    fill<<<threads_per_block,number_of_blocks, 0 , stream_result>>>(result, 0.0); //result
    fill<<<threads_per_block,number_of_blocks, 0 , stream_x>>>(x, 1.0); // array x 
    fill<<<threads_per_block,number_of_blocks, 0 , stream_y>>>(y, 2.0); // array y
	
	cudaStreamDestroy(stream_result); cudaStreamDestroy(stream_x); cudaStreamDestroy(stream_y);	
    
    cublasHandle_t handle;
    cublasCreate(&handle);

    //error variables
    cudaError_t addVectorsErr;
    cudaError_t asyncErr;
    saxpy_timer t;
    float alpha=2.0;
    int M = 10000;
    for(int i = 0; i < M; ++i){
	saxpy <<< number_of_blocks, threads_per_block >>> ( x, y, alpha);
	//cublasSaxpy(handle, N, &alpha, x, 1, y, 1)	;
//saxpy <<< number_of_blocks, threads_per_block >>> ( x, y , result)
    }
    cudaMemPrefetchAsync(result, size, cudaCpuDeviceId);
    cudaDeviceSynchronize();
    double elapsed = t.elapsed_msec();
    double gflops = 2 * M * double(N) / 1e9;
    double perf = gflops / (elapsed / 1e3);
    printf("%fms\n performance: %f gflops\n", elapsed, perf);
    
	addVectorsErr = cudaGetLastError();

    if(addVectorsErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(addVectorsErr));

    asyncErr = cudaDeviceSynchronize();
    if(asyncErr != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(asyncErr));

    
    //Print out the first and last 5 values of c for a quality check
    for( int i = 0; i < 5; ++i )
        printf("y[%d] = %f, ", i, y[i]);
    printf ("\n");
    for( int i = N-5; i < N; ++i )
        printf("y[%d] = %f, ", i, y[i]);
    printf ("\n");

    cudaFree( result ); cudaFree( x ); cudaFree( y );
}
