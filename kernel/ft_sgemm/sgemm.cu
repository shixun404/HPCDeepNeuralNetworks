#include <stdio.h>     
#include <cublas_v2.h>     
#include "utils/utils.cuh"          
#define PPP 1
#include <cuda_runtime.h> 
#include <helper_functions.h>
#include <helper_cuda.h>
#include "kernels.cuh"      
#define multi 20   
 int main(int argc, char **argv){                                 
     
    // Iinitialization
    srand(10);     
    int kernel_number = atoi(argv[1]); 
    int start_size = atoi(argv[2]);       
    int end_size =  atoi(argv[3]);       
    int gap_size =  atoi(argv[4]);       
    int MAX_SIZE = atoi(argv[3])  ;
    int st_kernel = atoi(argv[5]);
    int end_kernel = atoi(argv[6]);
    // int start_kernel = atoi(argv[5]);
    // int end_kernel = atoi(argv[6]);   
    int num_tests = 20;            
    for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        printf("%8.2d|", max_size);
    }          
    // printf("\n");  
    // for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
    //     printf("%8.2f|", min(8.1, double(max_size) * 31.25 / 1e3));
    // } 
    // printf("\n");  
    float alpha = 1.0;    
    float negative_1 = -1.0;   
	float beta = -1.5;  
    int max_size = end_size;  
    int M, N, K;
    M = max_size; N = max_size;  K = max_size;  //   K=512;
    float *A = NULL, *B = NULL, *C_ref = NULL, *C = NULL, *E = NULL, *E_ = NULL, *Res=NULL;
    float *check_A_col = NULL, *check_B_row = NULL, *check_C_col = NULL, *check_C_row = NULL, *check_A_row_mul_C=NULL, *check_B_row_mul_C=NULL;
    float *dA = NULL,*dB = NULL, *dC_ref = NULL, *dC = NULL, *dE=NULL, *dE_ = NULL, *dRes =NULL;
    float *dcheck_A_col = NULL, *dcheck_B_row = NULL, *dcheck_C_col = NULL, *dcheck_C_row = NULL, *dcheck_A_col_mul_B=NULL, *dcheck_B_row_mul_A=NULL;
    int size = max_size * sizeof (int);             
    int deviceId;       
    cudaGetDevice(&deviceId); 
    cudaDeviceProp props = getDetails(deviceId);           
    A = (float *)malloc(sizeof(float) * MAX_SIZE * MAX_SIZE);
    B = (float *)malloc(sizeof(float) * MAX_SIZE * MAX_SIZE);    
    C = (float *)malloc(sizeof(float) * MAX_SIZE * MAX_SIZE);                                   
    E = (float *)malloc(sizeof(float) * MAX_SIZE);  
    E_ = (float *)malloc(sizeof(float) * MAX_SIZE); 
    Res = (float *)malloc(sizeof(float) * 1);
    check_A_col = (float *)malloc(sizeof(float) * MAX_SIZE); 
    check_B_row = (float *)malloc(sizeof(float) * MAX_SIZE); 
    check_C_col = (float *)malloc(sizeof(float) * MAX_SIZE);     
    check_C_row = (float *)malloc(sizeof(float) * MAX_SIZE);
    check_A_row_mul_C = (float *)malloc(sizeof(float) * MAX_SIZE);
    check_B_row_mul_C = (float  *)malloc(sizeof(float) * MAX_SIZE);
            
    C_ref = (float *)malloc(sizeof(float) * MAX_SIZE * MAX_SIZE); 
    generate_random_matrix(A, MAX_SIZE);
    generate_random_matrix(B, MAX_SIZE);                                                       
    generate_random_matrix(C, MAX_SIZE); 
    fill_vector(Res, 0.0, 1);       
    fill_vector(C, 0.0, MAX_SIZE * MAX_SIZE); 
    fill_vector(E, 1.0, MAX_SIZE);
    fill_vector(check_A_col, 0.0, MAX_SIZE);  
    fill_vector(check_B_row, 0.0, MAX_SIZE);
    fill_vector(check_C_col, 0.0, MAX_SIZE);                                                 
    fill_vector(check_C_row, 0.0, MAX_SIZE);
    fill_vector(check_A_row_mul_C, 0.0, MAX_SIZE);
    fill_vector(check_B_row_mul_C, 0.0, MAX_SIZE); 
    copy_matrix(C, C_ref, MAX_SIZE);
    for(int i = 1; i <= MAX_SIZE; ++i)E_[i] = (float)i;
    
    
    CUDA_CALLER(cudaMalloc((void**) &dA, sizeof(float) * MAX_SIZE * MAX_SIZE));
    CUDA_CALLER(cudaMalloc((void**) &dB, sizeof(float) * MAX_SIZE * MAX_SIZE));  
    CUDA_CALLER(cudaMalloc((void**) &dC, sizeof(float) * MAX_SIZE * MAX_SIZE));
    CUDA_CALLER(cudaMalloc((void**) &dC_ref, sizeof(float) * MAX_SIZE * MAX_SIZE));
    if(kernel_number == 10){
        CUDA_CALLER(cudaMalloc((void**) &dE, sizeof(float) * MAX_SIZE));
        CUDA_CALLER(cudaMalloc((void**) &dE_, sizeof(float) * MAX_SIZE)); 
        CUDA_CALLER(cudaMalloc((void**) &dcheck_A_col, sizeof(float) * MAX_SIZE));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_B_row, sizeof(float) * MAX_SIZE));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_C_col, sizeof(float) * MAX_SIZE));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_C_row, sizeof(float) * MAX_SIZE));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_A_col_mul_B, sizeof(float) * MAX_SIZE));
        CUDA_CALLER(cudaMalloc((void**) &dcheck_B_row_mul_A, sizeof(float) * MAX_SIZE));  
        CUDA_CALLER(cudaMalloc((void**) &dRes, sizeof(float)));
        CUDA_CALLER(cudaMemcpy(dE, E, sizeof(float) * MAX_SIZE, cudaMemcpyHostToDevice));  
        CUDA_CALLER(cudaMemcpy(dE_, E_, sizeof(float) * MAX_SIZE, cudaMemcpyHostToDevice)); 
        CUDA_CALLER(cudaMemcpy(dcheck_A_col, dcheck_A_col, sizeof(float) * MAX_SIZE, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_B_row, check_B_row, sizeof(float) * MAX_SIZE, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_C_col, check_C_col, sizeof(float) * MAX_SIZE, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_C_row, check_C_row, sizeof(float) * MAX_SIZE, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_A_col_mul_B, check_A_row_mul_C, sizeof(float) * MAX_SIZE, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dcheck_B_row_mul_A, check_B_row_mul_C, sizeof(float) * MAX_SIZE, cudaMemcpyHostToDevice));
        CUDA_CALLER(cudaMemcpy(dRes, Res, sizeof(float), cudaMemcpyHostToDevice));    
    }  
    CUDA_CALLER(cudaMemcpy(dA, A, sizeof(float) * MAX_SIZE * MAX_SIZE, cudaMemcpyHostToDevice));     
    CUDA_CALLER(cudaMemcpy(dB, B, sizeof(float) * MAX_SIZE * MAX_SIZE, cudaMemcpyHostToDevice));
    CUDA_CALLER(cudaMemcpy(dC, C, sizeof(float) * MAX_SIZE * MAX_SIZE, cudaMemcpyHostToDevice));        
    CUDA_CALLER(cudaMemcpy(dC_ref, C, sizeof(float) * MAX_SIZE * MAX_SIZE, cudaMemcpyHostToDevice));
    
    
    // Verification    
    cublasHandle_t handle;         
    cublasCreate(&handle);     
    cudaDeviceSynchronize();     
    for (int iter = 0; iter < 1 ; iter++){
    cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_T, M, N, K, &alpha, dA, M, dB, N, &beta, dC_ref, M);
    }
    //for(int i = 0; i < 10; ++i)cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_T, M, N, K, &alpha, dA, M, dB, N, &beta, dC_ref, M);
    if(kernel_number == 1){       
        dim3 blockDim(64);  
        dim3 gridDim(CEIL_DIV(M, 16), CEIL_DIV(N, 16));
        cudaDeviceSynchronize(); 
        sgemm_small<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);  
    }  
    else if(kernel_number == 2){       
        dim3 blockDim(64);  
        dim3 gridDim(CEIL_DIV(M, 32), CEIL_DIV(N, 32));     
        cudaDeviceSynchronize(); 
        sgemm_medium<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);  
    }   
    else if(kernel_number == 3){       
        dim3 blockDim(64);  
        dim3 gridDim(CEIL_DIV(M, 64), CEIL_DIV(N, 64));
        cudaDeviceSynchronize(); 
        sgemm_large<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);  
    } 
    else if(kernel_number == 4){ 
        dim3 blockDim(128);      
        dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 32));
        cudaDeviceSynchronize();  
        sgemm_tall<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);  
    }    
    else if(kernel_number == 5){                                
        dim3 blockDim(128);  
        dim3 gridDim(CEIL_DIV(M, 32), CEIL_DIV(N, 128)); 
        cudaDeviceSynchronize(); 
        sgemm_wide<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);  
    } 
    else if(kernel_number == 6){
        for (int iter = 0; iter < 1; iter++){
        dim3 blockDim(256);    
        dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 128));
        cudaDeviceSynchronize(); 
        sgemm_huge<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);  
        }      
    } 
    else if(kernel_number == 7){
        dim3 blockDim(256);     
        dim3 gridDim(CEIL_DIV(M, 64), CEIL_DIV(N, 64));
        cudaDeviceSynchronize(); 
        sgemm_test<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);  
    } 
    else if(kernel_number == 16){
        for (int iter = 0; iter < 1; iter++){
        dim3 blockDim(256);  
        dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 128));
        cudaDeviceSynchronize(); 
        ft_sgemm_huge<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);  
        }
    } 
    else{
        cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_T, M, N, K, &alpha, dA, M, dB, N, &beta, dC, M);
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
    fflush(stdout);            
    printf("finish verified!\n");      
    cudaDeviceSynchronize(); 

    // Performance Profiling 
    // printf("##########################################################\n");
    // printf("##################### kernel %d #########################\n", kernel_number);
    int list[17] = {0, 1, 2, 3, 4, 5, 6,7, 10, 11, 12, 13, 14, 15, 16, 17, 18};
    char arr[17][20] = {"cublas", "kernel_sgemm_small", "kernel_sgemm_medium", "kernel_sgemm_large", "kernel_sgemm_tall", "kernel_sgemm_wide", "kernel_sgemm_huge", "kernel_sgemm_test",
                        "abft_baseline", "abft_kernel_small", "abft_kernel_medium", "abft_kernel_large", "abft_kernel_tall", "abft_kernel_wide", "abft_kernel_huge", "thread_abft_kernel", "warp_abft_kernel"};
    for(int jj = 0; jj < 17; ++jj){
        kernel_number = list[jj];
        if(kernel_number < st_kernel)continue;
        if(kernel_number > end_kernel) break;                                                
        printf("%s = th.as_tensor([", arr[jj]);
        CUDA_CALLER(cudaMemcpy(dC, C, sizeof(float) * MAX_SIZE * MAX_SIZE, cudaMemcpyHostToDevice));
        for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
        N = K = M = max_size; K = 1024;                                      
        cudaEvent_t beg, end; 
        cudaEventCreate(&beg); 
        cudaEventCreate(&end); 
        float elapsed = 0;       
        if (kernel_number == 0){     
            cudaEventRecord(beg);                      
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();    
                cublasSgemm(handle, CUBLAS_OP_N,CUBLAS_OP_N, M, N, K, &alpha, dA, M, dB, K, &beta, dC, M);
                cudaDeviceSynchronize();  
            }
            cudaEventRecord(end);
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        }
        else if (kernel_number == 1){
            cudaEventRecord(beg);
            dim3 blockDim(64);
            dim3 gridDim(CEIL_DIV(M, 16), CEIL_DIV(N, 16));
            
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_small<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        }  
        else if (kernel_number == 2){ 
            cudaEventRecord(beg);
            dim3 blockDim(64);
            dim3 gridDim(CEIL_DIV(M, 32), CEIL_DIV(N, 32));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_medium<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            } 
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);  
        }  
        else if (kernel_number == 3){     
            cudaEventRecord(beg);                
            dim3 blockDim(64);                           
            dim3 gridDim(CEIL_DIV(M, 64), CEIL_DIV(N, 64));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize(); 
                sgemm_large<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize(); 
            }
            cudaEventRecord(end);      
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 4){
            cudaEventRecord(beg);
            dim3 blockDim(128);
            dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 32));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_tall<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            } 
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 5){
            cudaEventRecord(beg);
            dim3 blockDim(128);
            dim3 gridDim(CEIL_DIV(M, 32), CEIL_DIV(N, 128));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_wide<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 6){
            cudaEventRecord(beg);
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 128));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_huge<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 7){
            cudaEventRecord(beg);
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(M, 64), CEIL_DIV(N, 64));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                sgemm_test<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 10){
            cudaEventRecord(beg);
            baseline_ft_sgemm(num_tests, M,N, K, handle, dA, dB, dC, dE, dRes, dcheck_C_row, dcheck_C_col, dcheck_A_col_mul_B, dcheck_B_row_mul_A, dcheck_A_col, dcheck_B_row,  alpha, beta, negative_1);
            cudaEventRecord(end);
            cudaEventSynchronize(beg);  
            cudaEventSynchronize(end); 
        }
        else if (kernel_number == 11){ 
            cudaEventRecord(beg);
            dim3 blockDim(64);
            dim3 gridDim(CEIL_DIV(M, 16), CEIL_DIV(N, 16));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                ft_sgemm_small<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize(); 
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        }  
        else if (kernel_number == 12){ 
            cudaEventRecord(beg);
            dim3 blockDim(64); 
            dim3 gridDim(CEIL_DIV(M, 32), CEIL_DIV(N, 32));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                ft_sgemm_medium<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end);  
        }  
        else if (kernel_number == 13){                                      
            cudaEventRecord(beg);                                  
            dim3 blockDim(64);                       
            dim3 gridDim(CEIL_DIV(M, 64), CEIL_DIV(N, 64));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                ft_sgemm_large<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 14){
            cudaEventRecord(beg);             
            dim3 blockDim(128);
            dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 32));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                ft_sgemm_tall<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);             
            cudaEventSynchronize(end); 
        }  
        else if (kernel_number == 15){
            cudaEventRecord(beg);
            dim3 blockDim(128);
            dim3 gridDim(CEIL_DIV(M, 32), CEIL_DIV(N, 128));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();        
                ft_sgemm_wide<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);      
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 16){
            cudaEventRecord(beg);
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 128));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();   
                 ft_sgemm_huge<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        else if (kernel_number == 17){
            cudaEventRecord(beg);
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 128));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                ft_sgemm_huge_thread<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            } 
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        }
        else if (kernel_number == 18){ 
            cudaEventRecord(beg);
            dim3 blockDim(256);
            dim3 gridDim(CEIL_DIV(M, 128), CEIL_DIV(N, 128));
            for(int ii = 0; ii < num_tests; ++ii){
                cudaDeviceSynchronize();
                ft_sgemm_huge_warp<<<gridDim, blockDim>>>(M, N, K, dA, dB, dC, alpha, beta);
                cudaDeviceSynchronize();
            }
            cudaEventRecord(end);     
            cudaEventSynchronize(beg);
            cudaEventSynchronize(end); 
        } 
        cudaEventElapsedTime(&elapsed, beg, end);                     
        double gflops  = 0.;
        gflops = double(2 * num_tests * double(M) * double(N) * double(K)) / (1e9);
        double perf = gflops / (elapsed / 1e3);
        printf("%8.2f,", perf);
        fflush(stdout);
    }
    printf("])\n");
    }
}
