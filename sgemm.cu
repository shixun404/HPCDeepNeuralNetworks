#include <stdio.h>
#include <cublas_v2.h>
#include "utils.cuh"
#define PPP 1
#include <cuda_runtime.h>

__global__ void sgemm_1(int N, float* A, float*B, float*C, float alpha, float beta){
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    int j = idx / N;
    int i = idx % N;
    float temp = 0;
    for(int k = 0; k < N; ++k){
        temp += A[i + k * N] * B[k + j * N];
    }
    C[i + j * N] = alpha * temp + beta * C[i + j * N];
}

__global__ void sgemm_1_row(int N, float *A, float *B, float *C, float alpha, float beta){
    // int idx = threadIdx.x + blockIdx.x * blockDim.x;
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j = threadIdx.y + blockIdx.y  * blockDim.y;
    float temp = 0.;
    for(int k = 0; k < N; ++k){
        temp += B[i + k * N] * A[k + j * N]; // Why line 24 much faster than line 25?
        // temp += B[j + k * N] * A[k + i * N];
    }
    C[i + j * N] = alpha * temp + beta * C[i + j * N];
    // C[j + i * N] = alpha * temp + beta * C[j + i * N];
}

__global__ __launch_bounds__(1024) void sgemm_2(int N, float *A, float *B, float *C, float alpha, float beta){
    __shared__ float shared_A[1024]; // blockDim * 2 for sublocks of A and B
    __shared__ float shared_B[1024];
    int threads_per_block = blockDim.x;
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j = threadIdx.y + blockIdx.y * blockDim.y;
    int tidx = threadIdx.x, tidy = threadIdx.y;
    C[i + j * N] *= beta;
    float temp = 0;
    for(int k = 0; k < gridDim.x; ++k){
        int ii = threadIdx.x + k * blockDim.x;
        int jj = threadIdx.y + k * blockDim.y;
        shared_A[tidx + tidy * blockDim.y] = A[ii + j * N];
        shared_B[tidx + tidy * blockDim.y] = B[i + jj * N];
        __syncthreads();
        for(int kk = 0; kk < blockDim.x; ++kk)
            temp += shared_B[tidx + kk * blockDim.x] * shared_A[kk + tidy * blockDim.y];
        __syncthreads();
    }
    C[i + j * N] +=  alpha * temp;
}

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
        // fill_vector(A, max_size * max_size, 0);
        // fill_vector(B, max_size * max_size, 0);
        // fill_vector(C, max_size * max_size, 0);
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
            sgemm_1_row <<<number_of_blocks, threads_per_block>>>(max_size, dA, dB, dC, alpha, beta);
        else if (kernel_number == 1){
            // sgemm_1_row <<<number_of_blocks, threads_per_block>>>(max_size, dA, dB, dC, alpha, beta);   
            sgemm_1_row<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 2){
            sgemm_2 <<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
        }
        else if(kernel_number == 3){
            sgemm_1_row<<<number_of_blocks, threads_per_block>>>(max_size, dA, dB, dC, alpha, beta);
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
                sgemm_1_row<<<gridDim, blockDim>>>(max_size, dA, dB, dC, alpha, beta);
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
        else if(kernel_number == 3){
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_1_row<<<number_of_blocks, threads_per_block>>>(max_size, dA, dB, dC, alpha, beta);
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
