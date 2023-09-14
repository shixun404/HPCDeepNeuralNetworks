#include <stdio.h>
#include <cublas_v2.h>
#include "utils/utils.cuh"
#include "kernels.cuh"
#define PPP 1
#include <cuda_runtime.h>
#include <helper_functions.h>
#include <helper_cuda.h>
int main(int argc, char **argv)
{       
    if (argc < 2) {
        printf("Please select a kernel (range 0 - 1, here 0 is for NVIDIA cuBLAS).\n");
         exit(-1);
    }
    int kernel_number = atoi(argv[1]);
    int num_tests = 10;
    int start_size = atoi(argv[2]);
    int end_size = atoi(argv[3]);
    int gap_size = 256;
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        printf("%8.2d|", max_size);
    }
    printf("\n");
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        printf("%8.2f|", min(8.1, double(max_size) * 31.25 / 1e3));
    }

    printf("\n");
    int threads_x = atoi(argv[4]); 
    double2 alpha, beta;
    alpha.x = 1.5, alpha.y = 0.0;
	beta.x = -1.0, beta.y = 0.0; 
    int max_size = end_size;
    double *A = NULL, *B = NULL, *C_ref = NULL, *C = NULL;
    double *dA = NULL,*dB = NULL, *dC_ref = NULL, *dC = NULL;
    int size = max_size * sizeof (int);
    int deviceId;
    cudaGetDevice(&deviceId);
    cudaDeviceProp props = getDetails(deviceId);
    
    A = (double *)malloc(sizeof(double) * max_size * max_size * 2);
    B = (double *)malloc(sizeof(double) * max_size * max_size * 2);
    C = (double *)malloc(sizeof(double) * max_size * max_size * 2);
    C_ref = (double *)malloc(sizeof(double) * max_size * max_size * 2);
    
    generate_random_matrix_double(A, max_size);
    generate_random_matrix_double(A + max_size * max_size, max_size);
    
    generate_random_matrix_double(B, max_size);
    generate_random_matrix_double(B + max_size * max_size, max_size);
    
    generate_random_matrix_double(C, max_size);
    generate_random_matrix_double(C + max_size * max_size, max_size);

    copy_matrix_double(C, C_ref, max_size);
    copy_matrix_double(C + max_size * max_size, C_ref + max_size * max_size , max_size);

    CUDA_CALLER(cudaMalloc((void**) &dA, sizeof(double) * max_size * max_size * 2));
    CUDA_CALLER(cudaMalloc((void**) &dB, sizeof(double) * max_size * max_size * 2));
    CUDA_CALLER(cudaMalloc((void**) &dC, sizeof(double) * max_size * max_size * 2));
    CUDA_CALLER(cudaMalloc((void**) &dC_ref, sizeof(double) * max_size * max_size * 2));
    
    CUDA_CALLER(cudaMemcpy(dA, A, sizeof(double) * max_size * max_size * 2, cudaMemcpyHostToDevice));
    CUDA_CALLER(cudaMemcpy(dB, B, sizeof(double) * max_size * max_size * 2, cudaMemcpyHostToDevice));
    CUDA_CALLER(cudaMemcpy(dC, C, sizeof(double) * max_size * max_size * 2, cudaMemcpyHostToDevice));
    CUDA_CALLER(cudaMemcpy(dC_ref, C_ref, sizeof(double) * max_size * max_size * 2, cudaMemcpyHostToDevice));

    cublasHandle_t handle;
    cublasCreate(&handle);      
   
    if (!verify_matrix_double(C_ref, C, max_size) || 
        !verify_matrix_double(C_ref + max_size * max_size, C + max_size * max_size, max_size)) {
        printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
        exit(-3); 
    } 
    printf("asdasda\n");
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        
        cublasZgemm(handle, CUBLAS_OP_N,CUBLAS_OP_N,max_size, max_size,  max_size, &alpha, (cuDoubleComplex*)dA, max_size, (cuDoubleComplex*)dB, max_size, &beta, (cuDoubleComplex*)dC_ref, max_size);
    
        if(kernel_number == 0)
        {
            cublasZgemm(handle, CUBLAS_OP_N,CUBLAS_OP_N,max_size, max_size,  max_size, &alpha, (cuDoubleComplex*)dA, max_size, (cuDoubleComplex*)dB, max_size, &beta, (cuDoubleComplex*)dC, max_size);
        }
        else if(kernel_number == 1){
            dim3 blockDim(threads_x, threads_x);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            zgemm_1 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta); 
        }
     
        cudaDeviceSynchronize();
        cudaMemcpy(C, dC, sizeof(double) * max_size * max_size * 2, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();
        cudaMemcpy(C_ref, dC_ref, sizeof(double) * max_size * max_size * 2, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();

        if (!verify_matrix_double(C_ref, C, max_size) || 
        !verify_matrix_double(C_ref + max_size * max_size, C + max_size * max_size, max_size)) {
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
        exit(-3);
        }
        cudaEvent_t beg, end;
        cudaEventCreate(&beg);
        cudaEventCreate(&end);
        float elapsed = 0;
        if (kernel_number == 0){
            cudaEventRecord(beg);
            for(int ii = 0; ii < num_tests; ++ii){
                    cudaDeviceSynchronize();
                    cublasZgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, max_size, max_size, max_size, &alpha, (cuDoubleComplex*)dA, max_size, (cuDoubleComplex*)dB, max_size, &beta, (cuDoubleComplex*)dC, max_size);
                    cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if(kernel_number == 1){
            cudaEventRecord(beg);
            dim3 blockDim(threads_x, threads_x);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                zgemm_1<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        cudaEventElapsedTime(&elapsed, beg, end);
        
        double gflops = double(2 * num_tests * double(max_size) * double(max_size) * double(max_size)) / (1e9);
        double perf = gflops / (elapsed / 1e3);
        printf("%8.2f,", perf);        
        fflush(stdout);
    }
    printf("\n");
}
