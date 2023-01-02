#include <stdio.h> 
#include <cublas_v2.h>     
#include "utils/utils.cuh"          
#define PPP 1
#include <cuda_runtime.h>
#include <helper_functions.h>
#include <helper_cuda.h>
#include "kernels.cuh"     
#define multi 20   
int main(int argc, char **argv)    
 {                                 
    int kernel_number = atoi(argv[1]);
    int num_tests = 10; 
    int start_size = atoi(argv[2]);       
    int end_size =  atoi(argv[3]);       
    int start_kernel = atoi(argv[4]);
    int end_kernel = atoi(argv[5]); 
    int gap_size = 256;                    
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        printf("%8.2d|", max_size);
    }          
    printf("\n");  
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        printf("%8.2f|", min(8.1, double(max_size) * 31.25 / 1e3));
    }

    printf("\n"); 
    float alpha = 1.0;   
    float negative_1 = -1.0;   
	float beta = -1.5; 
    int max_size = end_size;
    float *A = NULL, *B = NULL, *C_ref = NULL, *C = NULL, *E = NULL, *E_ = NULL, *Res=NULL;
    float *check_A_col = NULL, *check_B_row = NULL, *check_C_col = NULL, *check_C_row = NULL, *check_A_row_mul_C=NULL, *check_B_row_mul_C=NULL;
    float *dA = NULL,*dB = NULL, *dC_ref = NULL, *dC = NULL, *dE=NULL, *dE_ = NULL, *dRes =NULL;
    float *dcheck_A_col = NULL, *dcheck_B_row = NULL, *dcheck_C_col = NULL, *dcheck_C_row = NULL, *dcheck_A_col_mul_B=NULL, *dcheck_B_row_mul_A=NULL;
    int size = max_size * sizeof (int);             
    int deviceId;     
    cudaGetDevice(&deviceId); 
    cudaDeviceProp props = getDetails(deviceId);           
    A = (float *)malloc(sizeof(float) * max_size * max_size);
    B = (float *)malloc(sizeof(float) * max_size * max_size);   
    C = (float *)malloc(sizeof(float) * max_size * max_size);                     
    E = (float *)malloc(sizeof(float) * max_size);
    E_ = (float *)malloc(sizeof(float) * max_size);
    Res = (float *)malloc(sizeof(float) * 1);
    check_A_col = (float *)malloc(sizeof(float) * max_size);
    check_B_row = (float *)malloc(sizeof(float) * max_size);
    check_C_col = (float *)malloc(sizeof(float) * max_size);
    check_C_row = (float *)malloc(sizeof(float) * max_size);
    check_A_row_mul_C = (float *)malloc(sizeof(float) * max_size);
    check_B_row_mul_C = (float  *)malloc(sizeof(float) * max_size);
    
    C_ref = (float *)malloc(sizeof(float) * max_size * max_size); 
    generate_random_matrix(A, max_size);
    generate_random_matrix(B, max_size);        
    generate_random_matrix(C, max_size); 
    fill_vector(Res, 0.0, 1);       
    fill_vector(C, 0.0, max_size * max_size);
    fill_vector(E, 1.0, max_size);
    fill_vector(check_A_col, 0.0, max_size);  
    fill_vector(check_B_row, 0.0, max_size);
    fill_vector(check_C_col, 0.0, max_size);                                                 
    fill_vector(check_C_row, 0.0, max_size);
    fill_vector(check_A_row_mul_C, 0.0, max_size);
    fill_vector(check_B_row_mul_C, 0.0, max_size); 
    copy_matrix(C, C_ref, max_size);
    for(int i = 1; i <= max_size; ++i)E_[i] = (float)i;
    
    
    CUDA_CALLER(cudaMalloc((void**) &dA, sizeof(float) * max_size * max_size));
    CUDA_CALLER(cudaMalloc((void**) &dB, sizeof(float) * max_size * max_size));  
    CUDA_CALLER(cudaMalloc((void**) &dC, sizeof(float) * max_size * max_size));
    CUDA_CALLER(cudaMalloc((void**) &dC_ref, sizeof(float) * max_size * max_size));
    if(kernel_number == 1){
        CUDA_CALLER(cudaMalloc((void**) &dE, sizeof(float) * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dE_, sizeof(float) * max_size)); 
        CUDA_CALLER(cudaMalloc((void**) &dcheck_A_col, sizeof(float) * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_B_row, sizeof(float) * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_C_col, sizeof(float) * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_C_row, sizeof(float) * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_A_col_mul_B, sizeof(float) * max_size));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_B_row_mul_A, sizeof(float) * max_size));  
        CUDA_CALLER(cudaMalloc((void**) &dRes, sizeof(float)));
        CUDA_CALLER(cudaMemcpy(dE, E, sizeof(float) * max_size, cudaMemcpyHostToDevice));  
        CUDA_CALLER(cudaMemcpy(dE_, E_, sizeof(float) * max_size, cudaMemcpyHostToDevice)); 
        CUDA_CALLER(cudaMemcpy(dcheck_A_col, dcheck_A_col, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_B_row, check_B_row, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_C_col, check_C_col, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_C_row, check_C_row, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_A_col_mul_B, check_A_row_mul_C, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_B_row_mul_A, check_B_row_mul_C, sizeof(float) * max_size, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dRes, Res, sizeof(float), cudaMemcpyHostToDevice));    
    } 
    CUDA_CALLER(cudaMemcpy(dA, A, sizeof(float) * max_size * max_size, cudaMemcpyHostToDevice));
    CUDA_CALLER(cudaMemcpy(dB, B, sizeof(float) * max_size * max_size, cudaMemcpyHostToDevice));
    CUDA_CALLER(cudaMemcpy(dC, C, sizeof(float) * max_size * max_size, cudaMemcpyHostToDevice));      
    CUDA_CALLER(cudaMemcpy(dC_ref, C, sizeof(float) * max_size * max_size, cudaMemcpyHostToDevice));
    if (!verify_matrix(C_ref, C, max_size)) {  
        printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
        exit(-3); 
    } 
    printf("start!\n"); 
    cublasHandle_t handle;       
    cublasCreate(&handle);    
    cudaDeviceSynchronize(); 
    cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_T,max_size, max_size,  max_size, &alpha, dB, max_size, dA, max_size, &beta, dC_ref, max_size);
    // test_kernel(kernel_number, max_size, dA, dB, dC, alpha, beta);
    if(true){       
        dim3 blockDim(128);
        dim3 gridDim(CEIL_DIV(max_size, 32 ), CEIL_DIV(max_size, 128));
        cudaDeviceSynchronize(); 
        sgemm_wide <<<gridDim, blockDim>>>(max_size, max_size, dB, dA, dC, alpha, beta);  
    }   
    // printf("finish verified!\n");                   
    cudaDeviceSynchronize(); 
    cudaMemcpy(C, dC, sizeof(float) * max_size * max_size, cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();
    cudaMemcpy(C_ref, dC_ref, sizeof(float) * max_size * max_size, cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();                                                 

    if (!verify_matrix(C_ref, C, max_size)) { 
        printf("Failed to pass the correctness verification against NVIDIA cuBLAS. Exited.\n");
        exit(-3); 
    }   
    printf("finish verified!\n");     
    cudaDeviceSynchronize(); 
    for(int k_num = start_kernel; k_num <= end_kernel; k_num++){ 
        if (k_num >= 3 && k_num <= 11)continue;
        int K_min = end_size, K_max = end_size;
        if (k_num == 2 || k_num == 12 || k_num == 1 || k_num == 0 || k_num >= 25 ){
            K_min = 256;
            K_max = 1024; 
        }
        kernel_number = k_num;
        printf("##########################################################\n");
        printf("##################### kernel %d #########################\n", kernel_number);
        printf("abft_kernel_%d = th.as_tensor([", kernel_number);
        CUDA_CALLER(cudaMemcpy(dC, C, sizeof(float) * end_size * end_size, cudaMemcpyHostToDevice));      

    for(int K = K_min; K <= K_max; K *= 2){
        // printf("%d\n", K); 
        
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        cudaEvent_t beg, end;
        cudaEventCreate(&beg);
        cudaEventCreate(&end); 
        float elapsed = 0;       
        if (kernel_number == 0){     
            cudaEventRecord(beg);
            //printf("I am here!\n");
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();    
                cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_N,max_size, max_size,  K, &alpha, dB, max_size, dA, K, &beta, dC, max_size);
                cudaDeviceSynchronize();  
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);
        }   
        else if (kernel_number == 1){
             cudaEventRecord(beg);
             ft_sgemm_1(num_tests, max_size, K, handle, dA, dB, dC, dE, dRes, dcheck_C_row, dcheck_C_col, dcheck_A_col_mul_B, dcheck_B_row_mul_A, dcheck_A_col, dcheck_B_row,  alpha, beta, negative_1);
             cudaEventRecord(end);
             cudaEventSynchronize(beg);  
             cudaEventSynchronize(end); 
        }
        else if (kernel_number == 22){
              cudaEventRecord(beg);
              ft_sgemm_1(num_tests, max_size, max_size, handle, dA, dB, dC, dE, dRes, dcheck_C_row, dcheck_C_col, dcheck_A_col_mul_B, dcheck_B_row_mul_A, dcheck_A_col, dcheck_B_row,  alpha,   beta, negative_1);
              cudaEventRecord(end);
              cudaEventSynchronize(beg);
              cudaEventSynchronize(end);
         }
        else if (kernel_number == 2){
             cudaEventRecord(beg);
             dim3 blockDim(256);
             dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 128));
             for(int ii = 0; ii < num_tests; ++ii){
                 cudaDeviceSynchronize();
                 sgemm_13<<<gridDim, blockDim>>>(max_size, K, dA, dB, dC, alpha, beta);
                 cudaDeviceSynchronize();
             }
             cudaEventRecord(end);     
             cudaEventSynchronize(beg);
             cudaEventSynchronize(end); 
         }  
        else if (kernel_number == 25){
            cudaEventRecord(beg);
            dim3 blockDim(64);
            dim3 gridDim(CEIL_DIV(max_size, 16), CEIL_DIV(max_size, 16));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_small<<<gridDim, blockDim>>>(max_size, K, dB, dA, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 26){
            cudaEventRecord(beg);
            dim3 blockDim(64);
            dim3 gridDim(CEIL_DIV(max_size, 32), CEIL_DIV(max_size, 32));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_medium<<<gridDim, blockDim>>>(max_size, K, dB, dA, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 27){
            cudaEventRecord(beg);
            dim3 blockDim(64);
            dim3 gridDim(CEIL_DIV(max_size, 64), CEIL_DIV(max_size, 64));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_large<<<gridDim, blockDim>>>(max_size, K, dB, dA, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 28){
            cudaEventRecord(beg);
            dim3 blockDim(128);
            dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 32));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_tall<<<gridDim, blockDim>>>(max_size, K, dB, dA, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 29){
            cudaEventRecord(beg);
            dim3 blockDim(128);
            dim3 gridDim(CEIL_DIV(max_size, 32), CEIL_DIV(max_size, 128));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_wide<<<gridDim, blockDim>>>(max_size, K, dB, dA, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 30){
            cudaEventRecord(beg);
            dim3 blockDim(64);
            dim3 gridDim(CEIL_DIV(max_size, 16), CEIL_DIV(max_size, 16));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                ft_sgemm_small<<<gridDim, blockDim>>>(max_size, K, dB, dA, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 20){        
            cudaEventRecord(beg); 
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 128));
            for(int ii = 0; ii < num_tests; ++ii){      
                cudaDeviceSynchronize();       
                sgemm_13<<<gridDim, blockDim>>>(max_size, max_size, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end); 
            cudaEventSynchronize(beg);        
            cudaEventSynchronize(end);     
        }   
        else if (kernel_number == 21){  
             cudaEventRecord(beg);
             dim3 blockDim(256); 
             dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 128));
             for(int ii = 0; ii < num_tests; ++ii){
                 cudaDeviceSynchronize(); 
                 ft_sgemm_20<<<gridDim, blockDim>>>(max_size, max_size, dA, dB, dC, alpha, beta);
                 cudaDeviceSynchronize();
             } 
             cudaEventRecord(end);
             cudaEventSynchronize(beg);
             cudaEventSynchronize(end);
         }
        else if (kernel_number == 23){
              cudaEventRecord(beg);
              dim3 blockDim(256);
              dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 128));
              for(int ii = 0; ii < num_tests; ++ii){
                  cudaDeviceSynchronize();
                  ft_sgemm_12<<<gridDim, blockDim>>>(max_size, max_size, dA, dB, dC, alpha, beta);
                  cudaDeviceSynchronize();
              }
              cudaEventRecord(end);
              cudaEventSynchronize(beg);
              cudaEventSynchronize(end);
          }
        else if (kernel_number == 24){
              cudaEventRecord(beg);
              dim3 blockDim(256);
              dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 128));
              for(int ii = 0; ii < num_tests; ++ii){
                  cudaDeviceSynchronize();
                  ft_sgemm_6<<<gridDim, blockDim>>>(max_size, max_size, dA, dB, dC, alpha, beta);
                  cudaDeviceSynchronize();
              }
              cudaEventRecord(end);
              cudaEventSynchronize(beg);
              cudaEventSynchronize(end);
          }
        else if (kernel_number == 12){  
            cudaEventRecord(beg); 
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(max_size, 128), CEIL_DIV(max_size, 128));
            for(int ii = 0; ii < num_tests; ++ii){      
                cudaDeviceSynchronize();       
                ft_sgemm_12<<<gridDim, blockDim>>>(max_size, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);   
        }
        cudaEventElapsedTime(&elapsed, beg, end);                     
            
            // double gflops = double(2 * num_tests * double(max_size) * double(max_size) * double(max_size) + num_tests * 4 * double(max_size) * double(max_size) * (1.0 + 1.0 / 256.0)) / (1e9);
            double gflops  = 0.;
            if(kernel_number <= 12 || kernel_number >= 25)gflops = double(2 * num_tests * double(max_size) * double(max_size) * double(K)) / (1e9);
            else gflops = double(2 * num_tests * double(max_size) * double(max_size) * double(max_size)) / (1e9);
            double perf = gflops / (elapsed / 1e3);
            printf("%8.2f,", perf);
        
        fflush(stdout);
    } 
    }
    printf("])\n");
    }
}