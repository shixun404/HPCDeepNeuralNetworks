#include <stdlib.h>
#include <complex>
#include "kernels.cuh"
#include <cuda_runtime.h> 
#include <cufftXt.h>
#include "utils/utils.cuh"   
#define FLOAT2_NORM(a, res) res = a.x * a.x + a.y * a.y;
int main(int argc, char** argv){  
    int log_N = 16;
    int N = pow((double)2, (double)log_N); 
    int random_seed = 10;  
    int num_tests = 1;
    srandom(random_seed); 
    float *input = (float*)calloc(N * 2, sizeof(float)); 
    float *output_ref, *output;
    
    output_ref = (float*)calloc(N * 2, sizeof(float));
    output = (float*)calloc(N * 2, sizeof(float));
    
    float *input_d, *output_d, *output_d_ref, *output_d_1, *output_d_ref_1;
 
    cudaMalloc((void**)&input_d, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d_ref, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d_1, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d_ref_1, sizeof(float) * N * 2);

    for(int i = 0; i < N * 2; ++i){ 
            input[i] = (float)(random() % 100) / (float)100;   
    }
    cudaMemcpy((void*)input_d, (void*)input, 2 * N * sizeof(float), cudaMemcpyHostToDevice);

    // dim3 gridDim(16, 1, 1);
    // dim3 blockDim(16, 8, 1);


    cudaEvent_t fft_begin, fft_end;
    float elapsed_time_ref, elapsed_time; 
    cudaEventCreate(&fft_begin);
    cudaEventCreate(&fft_end);
    if(log_N == 14){
        cudaEventRecord(fft_begin);
        for(int i = 0; i < num_tests; ++i){
            
            dim3 gridDim(16, 1, 1);
            dim3 blockDim(16, 8, 1);
            fft_logN14_1 <<<gridDim, blockDim, 8192>>> ((float2*)input_d, (float2*)output_d_1);
            
            cudaDeviceSynchronize();
            {
            dim3 gridDim(4, 1, 1);
            dim3 blockDim(16, 32, 1); 
            fft_logN14_2 <<<gridDim, blockDim, 32768>>> ((float2*)output_d_1, (float2*)output_d);
            }
            cudaDeviceSynchronize(); 
        }    
        cudaEventRecord(fft_end);  
        cudaEventSynchronize(fft_begin);
        cudaEventSynchronize(fft_end);
        cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
        
        for(int i = 0; i < num_tests; ++i){
            
            dim3 gridDim(16, 1, 1);
            dim3 blockDim(16, 8, 1);
            VkFFT_main_logN14_1 <<<gridDim, blockDim, 8192 >>>((float2*)input_d, (float2*)output_d_ref_1);
            
            cudaDeviceSynchronize();  
            {
            dim3 gridDim(4, 1, 1);
            dim3 blockDim(16, 32, 1); 
            VkFFT_main_logN14_2 <<<gridDim, blockDim, 34816 >>>((float2*)output_d_ref_1, (float2*)output_d_ref);
            }
            cudaDeviceSynchronize();  
        }
        
        cudaEventRecord(fft_end);
        cudaEventSynchronize(fft_begin);  
        cudaEventSynchronize(fft_end);
        cudaEventElapsedTime(&elapsed_time_ref, fft_begin, fft_end);
    }
    else if(log_N == 15){
        cudaFuncSetAttribute(fft_logN15_2, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
        cudaFuncSetAttribute(VkFFT_main_logN15_2, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
        cudaEventRecord(fft_begin);
        for(int i = 0; i < num_tests; ++i){
            
            dim3 gridDim(32, 1, 1);
            dim3 blockDim(16, 8, 1);
            fft_logN15_1 <<<gridDim, blockDim, 8192>>> ((float2*)input_d, (float2*)output_d_1);
            
            cudaDeviceSynchronize();
            {
            dim3 gridDim(4, 1, 1);
            dim3 blockDim(64, 16, 1); 
            fft_logN15_2 <<<gridDim, blockDim, 65536>>> ((float2*)output_d_1, (float2*)output_d);
            }
            cudaDeviceSynchronize(); 
        }    
        cudaEventRecord(fft_end);  
        cudaEventSynchronize(fft_begin);
        cudaEventSynchronize(fft_end);
        cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
        
        for(int i = 0; i < num_tests; ++i){
            
            dim3 gridDim(32, 1, 1);
            dim3 blockDim(16, 8, 1);
            VkFFT_main_logN15_1 <<<gridDim, blockDim, 8192 >>>((float2*)input_d, (float2*)output_d_ref_1);
            
            cudaDeviceSynchronize();  
            {
            dim3 gridDim(4, 1, 1);
            dim3 blockDim(64, 16, 1); 
            VkFFT_main_logN15_2 <<<gridDim, blockDim, 65536 >>>((float2*)output_d_ref_1, (float2*)output_d_ref);
            }
            cudaDeviceSynchronize();  
        }
        
        cudaEventRecord(fft_end);
        cudaEventSynchronize(fft_begin);  
        cudaEventSynchronize(fft_end);
        cudaEventElapsedTime(&elapsed_time_ref, fft_begin, fft_end);
    }
    else if(log_N == 16){
        cudaFuncSetAttribute(fft_logN16_2, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
        cudaFuncSetAttribute(VkFFT_main_logN16_2, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
        cudaEventRecord(fft_begin);
        for(int i = 0; i < num_tests; ++i){
            
            dim3 gridDim(32, 1, 1);
            dim3 blockDim(16, 16, 1);
            fft_logN16_1 <<<gridDim, blockDim, 16384>>> ((float2*)input_d, (float2*)output_d_1);
            
            cudaDeviceSynchronize();
            {
            dim3 gridDim(8, 1, 1);
            dim3 blockDim(64, 16, 1); 
            fft_logN16_2 <<<gridDim, blockDim, 65536>>> ((float2*)output_d_1, (float2*)output_d);
            }
            cudaDeviceSynchronize(); 
        }    
        cudaEventRecord(fft_end);  
        cudaEventSynchronize(fft_begin);
        cudaEventSynchronize(fft_end);
        cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
        
        for(int i = 0; i < num_tests; ++i){
            
            dim3 gridDim(32, 1, 1);
            dim3 blockDim(16, 16, 1);
            VkFFT_main_logN16_1 <<<gridDim, blockDim, 16384 >>>((float2*)input_d, (float2*)output_d_ref_1);
            
            cudaDeviceSynchronize();  
            {
            dim3 gridDim(8, 1, 1);
            dim3 blockDim(64, 16, 1); 
            VkFFT_main_logN16_2 <<<gridDim, blockDim, 65536 >>>((float2*)output_d_ref_1, (float2*)output_d_ref);
            }
            cudaDeviceSynchronize();  
        }
        
        cudaEventRecord(fft_end);
        cudaEventSynchronize(fft_begin);  
        cudaEventSynchronize(fft_end);
        cudaEventElapsedTime(&elapsed_time_ref, fft_begin, fft_end);
    }

    #if defined(VERIFY)
    cudaMemcpy((void*)output_ref, (void*)output_d_ref, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy((void*)output, (void*)output_d, sizeof(float) * 2 * N, cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();
    bool pass = true;
    for(int i = 0; i < 2 * N; i +=2){
        float2 res = *(float2*)(output + i); 
        float2 res_ref = *(float2*)(output_ref + i);
        float norm, norm_ref; 
        FLOAT2_NORM(res, norm);
        FLOAT2_NORM(res_ref, norm_ref);
        
        float err = fabs(norm - norm_ref);
        // if(err > 0.1){
        //     pass = false;
            printf("error %f detected at %d\n", err, i / 2);
            printf("ref[%d]: %.3f + %.3f i\n",  i / 2, res_ref.x, res_ref.y);
            printf("res[%d]: %.3f + %.3f i\n\n",  i / 2, res.x, res.y);
            // break;
        // }   
    }
    if(pass) printf("Pass!\n");
    else printf("Fail!\n");
    #endif
    // elapsed_time /= num_tests;
    // elapsed_time_ref /= num_tests;
    // if(N == 8)printf("| SIZE |Execution Time(us)|   Shared   | #threads |\n");
    // if(N == 8)printf("|log(N)|  Ours  |  cuFFT  | Memory (KB)|          |\n");
    // printf("|%6d| %2.3f | %2.3f  |%8.3f    |%10d|\n", int(log2f((float)N)), elapsed_time * 1000, elapsed_time_ref  * 1000, (float)sizeof(float) * (float)N * 2.f / 1024.f, N / 8);
    return 0;
}
