#include <stdio.h>
#include <cublas_v2.h>
#include "utils.cuh"
#include "kernels.cuh"
#define PPP 1
#include <cuda_runtime.h>
#include <helper_functions.h>
#include <helper_cuda.h>
//#include "kernel_9.cu"
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
        printf("%8.2f|", min(8.1, double(max_size) * 31.25 / 1e3));
    }

    printf("\n");
    int threads_per_block = atoi(argv[2]);
    int threads_x = atoi(argv[3]);
    float alpha = 1.5;
	float beta = -1.0; 
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
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
        generate_random_matrix(A, max_size);
        generate_random_matrix(B, max_size);
        generate_random_matrix(C, max_size);
        copy_matrix(C, C_ref, max_size);
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
	    cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_N,max_size, max_size,  max_size, &alpha, dB, max_size, dA, max_size, &beta, dC_ref, max_size);
        // test_kernel(kernel_number, max_size, dA, dB, dC, alpha, beta);
        if(kernel_number == 0 || kernel_number == 1){
            dim3 blockDim(threads_x, threads_x);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            sgemm_1 <<<number_of_blocks, threads_per_block>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 2){
            dim3 blockDim(threads_x, threads_x);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            sgemm_2 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 3){
            dim3 blockDim(threads_x, threads_x / 4);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            sgemm_3 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 4){
            dim3 blockDim(threads_x, threads_x / 4);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            sgemm_4 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 5){
            dim3 blockDim(threads_x, threads_x / 4);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            sgemm_5 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 6){
            dim3 blockDim(threads_x / 4, threads_x / 4);
            dim3 gridDim(CEIL_DIV(max_size, threads_x ), CEIL_DIV(max_size, threads_x ));
            sgemm_6 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 7){
            dim3 blockDim(threads_x / 2, threads_x / 2);
            dim3 gridDim(CEIL_DIV(max_size, threads_x * 2), CEIL_DIV(max_size, threads_x * 2));
            sgemm_7 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 8){
            dim3 blockDim(16, 16);
            dim3 gridDim(CEIL_DIV(max_size, 64), CEIL_DIV(max_size, 64));
            sgemm_8<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 9){
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 128));
            sgemm_9<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 10){
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(max_size, 256), CEIL_DIV(max_size, 256));
            sgemm_10<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }

        cudaDeviceSynchronize();
        cudaMemcpy(C, dC, sizeof(float) * max_size * max_size, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();
        cudaMemcpy(C_ref, dC_ref, sizeof(float) * max_size * max_size, cudaMemcpyDeviceToHost);
        cudaDeviceSynchronize();

        if (!verify_matrix(C_ref, C, max_size)) {
            printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
            exit(-3);
        }
        // saxpy_timer t;
        // print_matrix(C, max_size);
        // printf("CPU \n");
        // print_matrix(C_ref, max_size);
        cudaEvent_t beg, end;
    cudaEventCreate(&beg);
    cudaEventCreate(&end);
    float elapsed = 0;
        if (kernel_number == 0){
            cudaEventRecord(beg);
            for(int ii = 0; ii < num_tests; ++ii){
                 cudaDeviceSynchronize();
		         cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, max_size, max_size, max_size, &alpha, dB, max_size, dA, max_size, &beta, dC, max_size);
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
                sgemm_1<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 2){
            cudaEventRecord(beg);
            dim3 blockDim(threads_x, threads_x);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_2<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 3){
            cudaEventRecord(beg);
            dim3 blockDim(threads_x, threads_x / 4);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_3<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 4){
            cudaEventRecord(beg);
            dim3 blockDim(threads_x, threads_x / 4);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_4<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 5){
            cudaEventRecord(beg);
            dim3 blockDim(threads_x, threads_x / 4);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_5<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 6){
            cudaEventRecord(beg);
            dim3 blockDim(threads_x / 4, threads_x / 4);
            dim3 gridDim(CEIL_DIV(max_size, threads_x), CEIL_DIV(max_size, threads_x));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_6<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 7){
            cudaEventRecord(beg);
            dim3 blockDim(threads_x / 2, threads_x / 2);
            dim3 gridDim(CEIL_DIV(max_size, threads_x * 2), CEIL_DIV(max_size, threads_x * 2));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_7<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 8){
            cudaEventRecord(beg);
            dim3 blockDim(threads_x / 2, threads_x / 2);
            dim3 gridDim(CEIL_DIV(max_size, threads_x * 2), CEIL_DIV(max_size, threads_x * 2));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_8<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 9){
            cudaEventRecord(beg);
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 128));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_9<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }
        else if (kernel_number == 10){
            cudaEventRecord(beg);
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(max_size, 256), CEIL_DIV(max_size, 256));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_10<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }

            // cudaMemPrefetchAsync(dC, size, cudaCpuDeviceId);
            // cudaDeviceSynchronize();
            cudaEventElapsedTime(&elapsed, beg, end);
            
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
