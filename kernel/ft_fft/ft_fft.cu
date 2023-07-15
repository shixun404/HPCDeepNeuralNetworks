
#include <stdlib.h>
#include <complex>
#include "kernels.cuh"
#include <cuda_runtime.h> 
#include <cufftXt.h>
#include "utils/utils.cuh"   
# define RADIX 2
#define FLOAT2_NORM(a, res) res = a.x * a.x + a.y * a.y;
int main(int argc, char** argv){  
    // #if (V == 1)
    int __log_N__, __log_N_st__ = 3;
    float * t_cufft, *t_vkfft, *t_fft;
    t_cufft = (float*)malloc(sizeof(float) * 34);
    t_vkfft = (float*)malloc(sizeof(float) * 34);
    t_fft = (float*)malloc(sizeof(float) * 34);
    
    if (argc < 2){
        printf("Please input log(N)\n");
        return -1;
    }
    else if(argc == 2) __log_N__ = atoi(argv[1]);
    else if(argc == 3){
        __log_N__ = atoi(argv[2]);
        __log_N_st__ = atoi(argv[1]);
    }
    // #endif
    int N = pow((double)RADIX, (double)__log_N__); 
    int random_seed = 10;  
    #if P_FFT == 1
    int num_tests = 100;
    #else
    int num_tests = 1;
    #endif
    srandom(random_seed); 
    float *input = (float*)calloc(N * 2, sizeof(float)); 
    float *output_ref, *output;
    
    output_ref = (float*)calloc(N * 2, sizeof(float));
    output = (float*)calloc(N * 2, sizeof(float));
    
    float *input_d, *output_d, *output_d_vkfft, *output_d_cufft, *output_d_1, *output_d_ref_1;
 
    CUDA_CALLER(cudaMalloc((void**)&input_d, sizeof(float) * N * 2));
    CUDA_CALLER(cudaMalloc((void**)&output_d, sizeof(float) * N * 2));
    // CUDA_CALLER(cudaMalloc((void**)&output_d_vkfft, sizeof(float) * N * 2));
    // CUDA_CALLER(cudaMalloc((void**)&output_d_cufft, sizeof(float) * N * 2));
    CUDA_CALLER(cudaMalloc((void**)&output_d_1, sizeof(float) * N * 2));
    // CUDA_CALLER(cudaMalloc((void**)&output_d_ref_1, sizeof(float) * N * 2));

    for(int i = 0; i < N * 2; ++i){ 
            input[i] = (float)(random() % 100) / (float)100;   
    }
    cudaMemcpy((void*)input_d, (void*)input, 2 * N * sizeof(float), cudaMemcpyHostToDevice);

    cufftHandle plan;  
    cufftCreate(&plan);


    cudaEvent_t fft_begin, fft_end;
    float elapsed_time_vkfft, elapsed_time, elapsed_time_cufft; 
    std::chrono::steady_clock::time_point timeSt; // = std::chrono::steady_clock::now();
    std::chrono::steady_clock::time_point timeEnd; // = std::chrono::steady_clock::now();
	float totTime, totTime_vkfft, totTime_cufft;
    cudaEventCreate(&fft_begin);
    cudaEventCreate(&fft_end);
    
    #if P_FFT == 1
    for(int log_N = __log_N_st__; log_N <= __log_N__; ++log_N){
    #else
    int log_N = __log_N__;
    #endif
    N = pow(double(RADIX), double(log_N));
    
    if(log_N == 3){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(1, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN3 <<<gridDim, blockDim, 192>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(1, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN3 <<<gridDim, blockDim, 192>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 4){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(4, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN4 <<<gridDim, blockDim, 256>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(4, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN4 <<<gridDim, blockDim, 256>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 5){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(4, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN5 <<<gridDim, blockDim, 384>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(4, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN5 <<<gridDim, blockDim, 384>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 6){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(8, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN6 <<<gridDim, blockDim, 640>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(8, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN6 <<<gridDim, blockDim, 640>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 7){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(16, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN7 <<<gridDim, blockDim, 1152>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(16, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN7 <<<gridDim, blockDim, 1152>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 8){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(32, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN8 <<<gridDim, blockDim, 2176>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(32, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN8 <<<gridDim, blockDim, 2176>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 9){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(64, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN9 <<<gridDim, blockDim, 4352>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(64, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN9 <<<gridDim, blockDim, 4352>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 10){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(128, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN10 <<<gridDim, blockDim, 8704>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(128, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN10 <<<gridDim, blockDim, 8704>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 11){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(128, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN11 <<<gridDim, blockDim, 17408>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(128, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN11 <<<gridDim, blockDim, 17408>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 12){
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(256, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN12 <<<gridDim, blockDim, 34816>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(256, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN12 <<<gridDim, blockDim, 34816>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
    if(log_N == 13){
        
        cudaFuncSetAttribute(fft_radix2_logN13, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
        cudaFuncSetAttribute(VkFFT_main_logN13, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(1024, 1, 1);
            cudaEventRecord(fft_begin);
            // timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        
                fft_radix2_logN13 <<<gridDim, blockDim, 65536>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
            }
            // timeEnd = std::chrono::steady_clock::now();
            // totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
        }
        
        {
        
            dim3 gridDim(1, 1, 1);
            dim3 blockDim(1024, 1, 1);
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
        
            for(int i = 0; i < num_tests; ++i){
        
                VkFFT_main_logN13 <<<gridDim, blockDim, 65536>>>((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();  
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime_vkfft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);
            cudaEventSynchronize(fft_begin);  
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_vkfft, fft_begin, fft_end);
        }
        
        {
            cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            for(int i = 0; i < num_tests; ++i){
                cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d, CUFFT_FORWARD);
                cudaDeviceSynchronize(); 
            } 
            timeEnd = std::chrono::steady_clock::now();
            totTime_cufft = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time_cufft, fft_begin, fft_end);  
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * sizeof(float), cudaMemcpyDeviceToHost); 
        }
    }    
    
     #if V_FFT == 1
    // cudaMemcpy((void*)output_ref, (void*)output_d_vkfft, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
    // cudaMemcpy((void*)output, (void*)output_d, sizeof(float) * 2 * N, cudaMemcpyDeviceToHost);
    // cudaMemcpy((void*)output, (void*)output_d_cufft, sizeof(float) * 2 * N, cudaMemcpyDeviceToHost);
    // cudaMemcpy((void*)output, (void*)output_d_ref_1, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
    // cudaMemcpy((void*)output_ref, (void*)output_d_1, sizeof(float) * 2 * N, cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();
    bool pass = true;
    for(int i = 0; i < 2 * N; i +=2){
        float2 res = *(float2*)(output + i); 
        float2 res_ref = *(float2*)(output_ref + i);
        float norm, norm_ref; 
        FLOAT2_NORM(res, norm);
        FLOAT2_NORM(res_ref, norm_ref);
        
        float err = fabs(norm - norm_ref);
        // if(i % 10 ==0){
        printf("error %f detected at %d\n", err / fabs(norm), i / 2);
        printf("ref[%d]: %.3f + %.3f i\n",  i / 2, res_ref.x, res_ref.y);
        printf("res[%d]: %.3f + %.3f i\n\n",  i / 2, res.x, res.y);
        //}
        if(err / fabs(norm) > 0.05){
            //printf("error %f detected at %d\n", err / fabs(norm), i / 2);
            //printf("ref[%d]: %.3f + %.3f i\n",  i / 2, res_ref.x, res_ref.y);
            //printf("res[%d]: %.3f + %.3f i\n\n",  i / 2, res.x, res.y);
            pass = false;
            // break;
        }   
    }
    if(pass) printf("Pass!\n");
    else printf("Fail!\n");
    #endif

    #if P_FFT == 1
    elapsed_time /= num_tests;
    elapsed_time_vkfft /= num_tests;
    elapsed_time_cufft /= num_tests;
    totTime /= num_tests;
    totTime_vkfft /= num_tests;
    totTime_cufft /= num_tests;
    if(log_N == __log_N_st__)printf("| SIZE |  Execution Time (us)             |   Shared   | #threads |\n");
    if(log_N == __log_N_st__)printf("|log(N)|   Ours   |   VkFFT   |   cuFFT   | Memory (KB)|          |\n");
    printf("|%6d| %8.3f | %8.3f  |%8.3f   |%8.3f    |%10d|\n", int(log2f((float)N)), elapsed_time * 1000, elapsed_time_vkfft * 1000, elapsed_time_cufft * 1000, (float)sizeof(float) * (float)N * 2.f / 1024.f, N / 8);
    t_fft[log_N] = elapsed_time;
    t_cufft[log_N] = elapsed_time_cufft;
    t_vkfft[log_N] = elapsed_time_vkfft;
    }
    printf("Execution Time\n");
    printf("t_fft = th.as_tensor([");
    for(int i = __log_N_st__; i <= __log_N__; ++i ){
        printf("%8f,", t_fft[i]);
    }
    printf("])\n");

    printf("t_cufft = th.as_tensor([");
    for(int i = __log_N_st__; i <= __log_N__; ++i ){
        printf("%8f,", t_cufft[i]);
    }
    printf("])\n");
    
    printf("t_vkfft = th.as_tensor([");
    for(int i = __log_N_st__; i <= __log_N__; ++i ){
        printf("%8f,", t_vkfft[i]);
    }
    printf("])\n");

    printf("\n Flops\n");
    printf("gflops_fft = th.as_tensor([");
    for(int i = __log_N_st__; i <= __log_N__; ++i ){
        long long N = pow((double)RADIX, (double)i);
        printf("%8f,", 5 * N * i / t_fft[i] * 1000.f / 1000000000.f);
    }
    printf("])\n");

    printf("gflops_cufft = th.as_tensor([");
    for(int i = __log_N_st__; i <= __log_N__; ++i ){
        long long N = pow((double)RADIX, (double)i);
        printf("%8f,", 5 * N * i / t_cufft[i] * 1000.f / 1000000000.f);
    }
    printf("])\n");
    
    printf("gflops_vkfft = th.as_tensor([");
    for(int i = __log_N_st__; i <= __log_N__; ++i ){
        long long N = pow((double)RADIX, (double)i);
        printf("%8f,", 5 * N * i / t_vkfft[i] * 1000.f / 1000000000.f);
    }
    printf("])\n");
    #endif
    return 0;
}

    