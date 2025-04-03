#include <stdlib.h>
#include <complex>
#include "kernels.cuh"
#include <cuda_runtime.h> 
#include <cufftXt.h>
#include "utils/utils.cuh"   
#define FLOAT2_NORM(a, res) res = a.x * a.x + a.y * a.y;
int main(int argc, char** argv){  
    int N = 8192; 
    int random_seed = 10;  
    int num_tests = 10;
    srandom(random_seed); 
    float *input = (float*)calloc(N * 2, sizeof(float)); 
    float *output_ref, *output;
    
    output_ref = (float*)calloc(N * 2, sizeof(float));
    output = (float*)calloc(N * 2, sizeof(float));
    
    float* input_d, *output_d, *output_d_ref;
 
    cudaMalloc((void**)&input_d, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d_ref, sizeof(float) * N * 2);

    for(int i = 0; i < N * 2; ++i){ 
            input[i] = (float)(random() % 100) / (float)100;   
    }
    cudaMemcpy((void*)input_d, (void*)input, 2 * N * sizeof(float), cudaMemcpyHostToDevice);

    cufftHandle plan;  
    cufftCreate(&plan);
    cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
    
    for(int i = 0; i < num_tests; ++i){
        cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d_ref, CUFFT_FORWARD);
        cudaDeviceSynchronize(); 
    }
    cudaFuncSetAttribute(fft_radix2_logN13, cudaFuncAttributeMaxDynamicSharedMemorySize,sizeof(float) * 2 * N );
    dim3 gridDim(1, 1, 1);
    dim3 blockDim(int(N / 8), 1, 1);
    for(int i = 0; i < num_tests; ++i){ 
        fft_radix2_logN13 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
        cudaDeviceSynchronize(); 
    }

    for(N = 8; N <= 8192; N *= 2){
        dim3 gridDim(1, 1, 1);
        dim3 blockDim(int(N / 8), 1, 1);
        cudaEvent_t fft_begin, fft_end;
        float elapsed_time_ref, elapsed_time; 
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        
        cudaEventRecord(fft_begin);
        
        if(N == 8){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN3 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 16){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN4 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 32){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN5 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 64){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN6 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 128){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN7 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 256){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN8 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 512){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN9 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 1024){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN10 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 2048){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN11 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 4096){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN12 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        else if(N == 8192){
            for(int i = 0; i < num_tests; ++i){
                fft_radix2_logN13 <<<gridDim, blockDim, sizeof(float) * 2 * N >>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize(); 
            }    
        }
        cudaEventRecord(fft_end);  
        cudaEventSynchronize(fft_begin);
        cudaEventSynchronize(fft_end);
        cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
        
        
        cufftPlan1d(&plan, N, CUFFT_C2C, 1); 
        cudaEventRecord(fft_begin);
        for(int i = 0; i < num_tests; ++i){
            cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d_ref, CUFFT_FORWARD);
            cudaDeviceSynchronize();  
        }
        
        cudaEventRecord(fft_end);
        cudaEventSynchronize(fft_begin);  
        cudaEventSynchronize(fft_end);
        cudaEventElapsedTime(&elapsed_time_ref, fft_begin, fft_end);

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
            if(err > 0.01){
                pass = false;
                printf("error %f detected at %d\n", err, i / 2);
                printf("ref[%d]: %.3f + %.3f i\n",  i / 2, res_ref.x, res_ref.y);
                printf("res[%d]: %.3f + %.3f i\n\n",  i / 2, res.x, res.y);
                break;
            }
            
        }
        if(pass) printf("Pass!\n");
        else printf("Fail!\n");
        #endif
        elapsed_time /= num_tests;
        elapsed_time_ref /= num_tests;
        if(N == 8)printf("| SIZE |Execution Time(us)|   Shared   | #threads |\n");
        if(N == 8)printf("|log(N)|  Ours  |  cuFFT  | Memory (KB)|          |\n");
        printf("|%6d| %2.3f | %2.3f  |%8.3f    |%10d|\n", int(log2f((float)N)), elapsed_time * 1000, elapsed_time_ref  * 1000, (float)sizeof(float) * (float)N * 2.f / 1024.f, N / 8);
    }
    return 0;
}
