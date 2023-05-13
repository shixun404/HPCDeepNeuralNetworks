#include <stdlib.h>
#include <complex>
#include "kernels.cuh"
#include <cuda_runtime.h> 
#include <cufftXt.h>
#include "utils/utils.cuh"   
#define FLOAT2_NORM(a, res) res = a.x * a.x + a.y * a.y;
int main(int argc, char** argv){  
    int N = 16;
    int random_seed = 10;  
    int num_tests = 1 ;     
    srandom(random_seed);
    float *input = (float*)calloc(N * 2, sizeof(float)); 
    float *output_ref, *output;
    
    output_ref = (float*)calloc(N * 2, sizeof(float));
    output = (float*)calloc(N * 2, sizeof(float));
    
    float* input_d, *output_d, *output_d_ref;
 
    cudaMalloc((void**)&input_d, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d_ref, sizeof(float) * N * 2);

    // dim3 gridDim(1, 1, 1);
    // dim3 blockDim(4, 1, 1);
    
    // for(int i = 0; i < num_tests; ++i){
    //     vkfft_logN5 <<<gridDim, blockDim, sizeof(float) * 2 * 48 >>> ((float2*)input_d, (float2*)output_d);
    //     cudaDeviceSynchronize(); 
    // }


    // dim3 gridDim(1, 1, 1);
    // dim3 blockDim(1, 1, 1);
    // for(int i = 0; i < num_tests; ++i){
    //     vkfft_logN3 <<<gridDim, blockDim>>> ((float2*)input_d, (float2*)output_d);
    //     cudaDeviceSynchronize(); 
    // }

    dim3 gridDim(1, 1, 1);
    dim3 blockDim(2, 1, 1);
    // for(int i = 0; i < num_tests; ++i){
    //     vkfft_logN4 <<<gridDim, blockDim, sizeof(float) * 2 * 16>>> ((float2*)input_d, (float2*)output_d);
    //     cudaDeviceSynchronize(); 
    // }
 
    for(int i = 0; i < N * 2; ++i){ 
        input[i] = (float)(random() % 100) / (float)100;   
    }

    cufftHandle plan;  
    cufftCreate(&plan);
    cufftPlan1d(&plan, N, CUFFT_C2C, 1);
     
    for(int i = 0; i < num_tests; ++i){
        cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d_ref, CUFFT_FORWARD);
        cudaDeviceSynchronize(); 
    }
    
    cudaMemcpy((void*)input_d, (void*)input, 2 * N * sizeof(float), cudaMemcpyHostToDevice);

    
    cudaEvent_t fft_begin, fft_end;
    float elapsed_time_ref, elapsed_time;
    cudaEventCreate(&fft_begin);
    cudaEventCreate(&fft_end);
    cudaEventRecord(fft_begin);
    // for(int i = 0; i < num_tests; ++i){
    //     vkfft_logN5 <<<gridDim, blockDim, sizeof(float) * 2 * 48 >>> ((float2*)input_d, (float2*)output_d);
    //     cudaDeviceSynchronize(); 
    // }
    // for(int i = 0; i < num_tests; ++i){
    //     vkfft_logN3 <<<gridDim, blockDim>>> ((float2*)input_d, (float2*)output_d);
    //     cudaDeviceSynchronize(); 
    // }

    for(int i = 0; i < num_tests; ++i){
        vkfft_logN4 <<<gridDim, blockDim, sizeof(float) * 2 * 16>>> ((float2*)input_d, (float2*)output_d);
        cudaDeviceSynchronize(); 
    }

    cudaEventRecord(fft_end);  
    cudaEventSynchronize(fft_begin);
    cudaEventSynchronize(fft_end);
    cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
    
    
    
    cudaEventRecord(fft_begin);
    for(int i = 0; i < num_tests; ++i){
        cufftExecC2C(plan, (cufftComplex *)input_d, (cufftComplex *)output_d_ref, CUFFT_FORWARD);
        cudaDeviceSynchronize();  
    }
    
    cudaEventRecord(fft_end);
    cudaEventSynchronize(fft_begin);  
    cudaEventSynchronize(fft_end);
    cudaEventElapsedTime(&elapsed_time_ref, fft_begin, fft_end);

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
        }
        
    }
    if(pass) printf("Pass!\n");
    else printf("Fail!\n");
    elapsed_time /= num_tests;
    elapsed_time_ref /= num_tests;
    printf("Ours: %f us, cuFFT: %f us\n", elapsed_time * 1000, elapsed_time_ref  * 1000);
    return 0;
}
