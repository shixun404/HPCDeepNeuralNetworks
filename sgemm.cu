#include <stdio.h>
#include <cublas_v2.h>
#include "utils.cuh"
#include "kernels.cuh"
#define PPP 1
#include <cuda_runtime.h>

#define multi 20
int main(int argc, char **argv)
{
    if (argc < 2) {
        printf("Please select a kernel (range 0 - 1, here 0 is for NVIDIA cuBLAS).\n");
         exit(-1);
      }
    int kernel_number = atoi(argv[1]);
    int num_tests = 10;
    int start_size = 256;
    int end_size = 6144;
    int gap_size = 256;
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        printf("%8.2d|", max_size);
    }
    printf("\n");
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        printf("%8.2f|", min(8.1, double(max_size) * 31.25 / 1e3));
    }

    printf("\n");
    int threads_per_block = atoi(argv[2]);
    int threads_x = atoi(argv[3]);
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        dim3 blockDim(threads_x, threads_x);
        dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
        float *A = NULL, *B = NULL, *C_ref = NULL, *C = NULL;
        float *dA = NULL,*dB = NULL, *dC_ref = NULL, *dC = NULL;
        int size = max_size * sizeof (int);
        int deviceId;
        cudaGetDevice(&deviceId);
        cudaDeviceProp props = getDetails(deviceId);
        int number_of_blocks = 0;
	    number_of_blocks =  (max_size * max_size + threads_per_block - 1) / threads_per_block; 
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
        // cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_N,max_size, max_size,  max_size, &alpha, dA, max_size, dB, max_size, &beta, dC_ref, max_size);
	    cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_N,max_size, max_size,  max_size, &alpha, dB, max_size, dA, max_size, &beta, dC_ref, max_size);
        if(kernel_number == 0)
            sgemm_1 <<<number_of_blocks, threads_per_block>>>(max_size, dA, dB, dC, alpha, beta);
        else if (kernel_number == 1){
            // sgemm_1_row <<<number_of_blocks, threads_per_block>>>(max_size, dA, dB, dC, alpha, beta);   
            sgemm_1 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 2){
            sgemm_2 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }

        cudaDeviceSynchronize();
        cudaMemcpy(C, dC, sizeof(float) * max_size * max_size, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();
        cudaMemcpy(C_ref, dC_ref, sizeof(float) * max_size * max_size, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();
        
        //print_matrix(C_ref, max_size);
        //print_matrix(C, max_size);

        if (!verify_matrix(C_ref, C, max_size)) {
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
            exit(-3);
        }
        //assert(0);
        // printf("yes! correct!\n");
        // printf("hey!");
        saxpy_timer t;
        if (kernel_number == 0){
            for(int ii = 0; ii < num_tests; ++ii){
                 cudaDeviceSynchronize();
		         cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, max_size, max_size, max_size, &alpha, dB, max_size, dA, max_size, &beta, dC, max_size);
            	 cudaDeviceSynchronize();
	        }
        }
        else if(kernel_number == 1){
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_1<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
        }
        else if (kernel_number == 2){
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_2<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
        }

            cudaMemPrefetchAsync(dC, size, cudaCpuDeviceId);
            cudaDeviceSynchronize();
            double elapsed = t.elapsed_msec();
            double gflops = double(2 * num_tests * double(max_size) * double(max_size) * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%8.2f,", perf);
        
       // cudaFree( dalpha ); 
        cudaFree( dA ); 
        cudaFree( dB );
	    cudaFree(dC);
        cudaFree( dC_ref );
        
        fflush(stdout);
    }
    printf("\n");
}
