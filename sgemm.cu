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
    int start_size = 256;
    int end_size = 6144;
    int gap_size = 256;
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        printf("%8.2d|", max_size);
    }
    printf("\n");
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        
        float *A = NULL, *B = NULL, *C_ref = NULL, *C = NULL;
        float *dA = NULL,*dB = NULL, *dC_ref = NULL, *dC = NULL;
        int size = max_size * sizeof (int);
        int deviceId;
        cudaGetDevice(&deviceId);
        cudaDeviceProp props = getDetails(deviceId);
        int threads_per_block = atoi(argv[2]);
        int number_of_blocks = 0;
	if(kernel_number == 2) number_of_blocks =  (max_size + threads_per_block - 1) / threads_per_block;
	else number_of_blocks = (max_size / 4 + threads_per_block - 1) / threads_per_block;
        
        A = (float *)malloc(sizeof(float) * max_size * max_size);
        B = (float *)malloc(sizeof(float) * max_size * max_size);
        C = (float *)malloc(sizeof(float) * max_size * max_size);
	C_ref = (float *)malloc(sizeof(float) * max_size * max_size);
        // alpha = (float *)malloc(sizeof(float) * 1);
        // float a = *alpha;
        generate_random_matrix(A, max_size);
        generate_random_matrix(B, max_size);
        generate_random_matrix(C, max_size);
        copy_matrix(C, C_ref, max_size);
        float alpha = 1.5;
	float beta = -1.0; //float(rand() % 5) + (rand() % 5) * 0.01;
        // a = (rand() % 2 == 0) ? a :( -1.0 * a);
        CUDA_CALLER(cudaMalloc((void**) &dA, sizeof(float) * max_size * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dB, sizeof(float) * max_size * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dC, sizeof(float) * max_size * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dC_ref, sizeof(float) * max_size * max_size));
        
        CUDA_CALLER(cudaMemcpy(dA, A, sizeof(float) * max_size * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dB, B, sizeof(float) * max_size * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dC, C, sizeof(float) * max_size * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dC_ref, C_ref, sizeof(float) * max_size * max_size, cudaMemcpyHostToDevice));

        cublasHandle_t handle;
        cublasCreate(&handle);
        
        if (!verify_matrix(C_ref, C, max_size)) {
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
            exit(-3);
        }

        cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_N,max_size, max_size,  max_size, &alpha, dA, max_size, dB, max_size, &beta, dC_ref, max_size);
	if(kernel_number == 0)
	cpu_gemm(alpha, beta, A, B, max_size, C);
	cudaDeviceSynchronize();
        cudaMemcpy(C, dC, sizeof(float) * max_size, cudaMemcpyDeviceToHost);
        cudaMemcpy(C_ref, dC_ref, sizeof(float) * max_size, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();
        if (!verify_vector(C_ref, C, 1)) {
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
            exit(-3);
        }
        if (kernel_number == 0){
            saxpy_timer t;
            for(int ii = 0; ii < num_tests; ++ii){
                cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, max_size, max_size, max_size, &alpha, dA, max_size, dB, max_size, &beta, dC, max_size);
            }
            cudaMemPrefetchAsync(dC, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%4.2f,", perf);
        }
       // cudaFree( dalpha ); 
        cudaFree( dA ); 
        cudaFree( dB );
	cudaFree(dC);
        cudaFree( dC_ref );
        
        fflush(stdout);
    }
    printf("\n");
}
