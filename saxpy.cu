#include <stdio.h>
#include <cublas_v2.h>
#include "utils.cuh"
#define PPP 1
#include <cuda_runtime.h>

struct f128{
    float a;
    float b;
    float c;
    float d;
};


__global__ void _saxpy(int N, float alpha, float *a, float *b)
{	
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
	
	while (tid < N){
		b[tid] += alpha * a[tid];
		tid += blockDim.x * gridDim.x;
	}
	
}
__global__ void saxpy3(int N, float alpha, f128 *a, f128 *b)
{
    int tid = threadIdx.x + blockIdx.x * blockDim.x;

        while (tid < N){
                b[tid].a += alpha * a[tid].a;
		b[tid].b += alpha * a[tid].b;
		b[tid].c += alpha * a[tid].c;
		b[tid].d += alpha * a[tid].d;
                tid += blockDim.x * gridDim.x;
        }

}
__global__ void saxpy(int N, float alpha, f128 *a, f128 *b)
{
    int tid = threadIdx.x + blockIdx.x * blockDim.x;

    if(tid >= N)
        return;
    b[tid].a = alpha * a[tid].a + b[tid].a;
    b[tid].b = alpha * a[tid].b + b[tid].b;
    b[tid].c = alpha * a[tid].c + b[tid].c;
    b[tid].d = alpha * a[tid].d + b[tid].d;
}

#define multi 20
int main(int argc, char **argv)
{
    if (argc < 2) {
        printf("Please select a kernel (range 0 - 1, here 0 is for NVIDIA cuBLAS).\n");
         exit(-1);
      }
    int kernel_number = atoi(argv[1]);
    int num_tests = 100;
    int start_size = 1024;
    int end_size = 1024 * 1024 * 4;
    int gap_size = 1024;
    for(int max_size = start_size, exp_=10; max_size <= end_size; max_size *=2, exp_ += 1){
        printf("%8.2d|", exp_);
    }
    printf("\n");
    for(int max_size = start_size; max_size <= end_size; max_size *=2){
        
        float *A = NULL, *B = NULL, *B_ref = NULL;// *alpha = NULL;
        float *dA = NULL,*dB = NULL, *dB_ref = NULL;// *dalpha = NULL;
        int size = max_size * sizeof (int);
        int deviceId;
        cudaGetDevice(&deviceId);
        cudaDeviceProp props = getDetails(deviceId);
        int threads_per_block = atoi(argv[2]);
        int number_of_blocks = 0;
	if(kernel_number == 2)number_of_blocks =  (max_size + threads_per_block - 1) / threads_per_block;
	else number_of_blocks = (max_size / 4 + threads_per_block - 1) / threads_per_block;
        
        A = (float *)malloc(sizeof(float) * max_size * num_tests);
        B = (float *)malloc(sizeof(float) * max_size * num_tests);
        B_ref = (float *)malloc(sizeof(float) * max_size);
        // alpha = (float *)malloc(sizeof(float) * 1);
        // float a = *alpha;
        generate_random_vector(A, max_size * num_tests);
        generate_random_vector(B, max_size * num_tests);
        //generate_random_vector(alpha, 1);
        copy_vector(B, B_ref, max_size);
        float a = float(rand() % 5) + (rand() % 5) * 0.01;
        a = (rand() % 2 == 0) ? a :( -1.0 * a);
        CUDA_CALLER(cudaMalloc((void**) &dA, sizeof(float) * max_size * num_tests));
        CUDA_CALLER(cudaMalloc((void**) &dB, sizeof(float) * max_size * num_tests));
        CUDA_CALLER(cudaMalloc((void**) &dB_ref, sizeof(float) * max_size));
        //CUDA_CALLER(cudaMalloc((void**) &dalpha, sizeof(float) * 1));
        
        CUDA_CALLER(cudaMemcpy(dA, A, sizeof(float) * max_size * num_tests, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dB, B, sizeof(float) * max_size * num_tests, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dB_ref, B, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        //CUDA_CALLER(cudaMemcpy(dalpha, alpha, sizeof(float) * 1, cudaMemcpyHostToDevice));

        cublasHandle_t handle;
        cublasCreate(&handle);
        
        if (!verify_vector(B_ref, B, 1)) {
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
            exit(-3);
        }

        cublasSaxpy(handle, max_size, &a, dA, 1, dB_ref, 1);
        if(kernel_number <= 1)
	saxpy <<< number_of_blocks, threads_per_block >>> (max_size / 4, a, (f128*)dA, (f128*)dB);
	else if(kernel_number == 2)
	_saxpy <<< number_of_blocks, threads_per_block >>> (max_size, a, dA,dB);
	else if(kernel_number == 3)
        saxpy3 <<< number_of_blocks, threads_per_block >>> (max_size / 4, a, (f128*)dA, (f128*)dB);
	cudaDeviceSynchronize();
        cudaMemcpy(B, dB, sizeof(float) * max_size, cudaMemcpyDeviceToHost);
        cudaMemcpy(B_ref, dB_ref, sizeof(float) * max_size, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();
        if (!verify_vector(B_ref, B, 1)) {
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
            exit(-3);
        }
        if (kernel_number == 1){
            saxpy_timer t;
            for(int ii = 0; ii < num_tests; ++ii){
                saxpy<<< number_of_blocks, threads_per_block >>>(max_size / 4, a, (f128*)(dA + ii * max_size), (f128*)(dB +
                ii * max_size));
            }
            cudaMemPrefetchAsync(dB, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%8.2f|", perf);
        }
        else if (kernel_number == 3){
            saxpy_timer t;
            for(int ii = 0; ii < num_tests; ++ii){
                saxpy3<<< number_of_blocks, threads_per_block >>>(max_size / 4, a, (f128*)(dA + ii * max_size), (f128*)(dB + ii * max_size));
            }
            cudaMemPrefetchAsync(dB, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%4.2f,", perf);
        }

	else if (kernel_number == 2){
            saxpy_timer t;
            for(int ii = 0; ii < num_tests; ++ii){
                _saxpy<<< number_of_blocks, threads_per_block >>>(max_size, a, dA + ii * max_size, dB +
                ii * max_size);
            }
            cudaMemPrefetchAsync(dB, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%4.2f,", perf);
        }

        else if (kernel_number == 0){
            saxpy_timer t;
            for(int ii = 0; ii < num_tests; ++ii){
                cublasSaxpy(handle, max_size, &a, dA + ii * max_size, 1, dB + ii * max_size, 1);
            }
            cudaMemPrefetchAsync(dB, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%4.2f,", perf);
        }
       // cudaFree( dalpha ); 
        cudaFree( dA ); 
        cudaFree( dB );
        cudaFree( dB_ref );
        
        fflush(stdout);
    }
    printf("\n");
}
