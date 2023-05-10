#include <complex>
#include <iostream> 
#include <random>
#include <vector>
#include <cuda_runtime.h>
#include <cufftXt.h>
#include <math.h> 
#include "utils/utils.cuh"          
#include "kernels.cuh"  
 
int main(int argc, char *argv[]) {
    int kernel_number = atoi(argv[1]);
    long long start_size = atoi(argv[2] );
    long long end_size = atoi(argv[3]);
    start_size = (long long)pow(2, start_size); 
    end_size = (long long)pow(2, end_size);
    printf("%lld %lld \n", start_size, end_size);
    int num_tests = 10;
    printf("%12s|%12s|%16s|%32s|\n", "Size","log(Size)", "Elapsed (s)", "Performance (GFLOPS)");
    
    
     
    
    for(int n = start_size; n <= end_size; n *= 2){
        cufftHandle plan;
        cudaStream_t stream = NULL;
        int batch_size = 1;
        int fft_size = batch_size * n;
        using scalar_type = float;
        using data_type = std::complex<scalar_type>;
        std::vector<data_type> data(fft_size * 2), data1(fft_size * 2);
        for (int i = 0; i < fft_size * 2; i++) {
            data[i] = data_type(i+1, i+1);
            data1[i] = data_type(i+1, i+1);
        }
        cufftComplex *d_data = nullptr;
        cufftComplex *d_data_1 = nullptr;   
        CUFFT_CALL(cufftCreate(&plan)); 
        CUFFT_CALL(cufftPlan1d(&plan, data.size() / 2, CUFFT_C2C, batch_size));
        CUDA_RT_CALL(cudaStreamCreateWithFlags(&stream, cudaStreamNonBlocking));
        CUFFT_CALL(cufftSetStream(plan, stream)); 
        CUDA_RT_CALL(cudaMalloc(reinterpret_cast<void **>(&d_data), sizeof(data_type) * data.size()));
        CUDA_RT_CALL(cudaMemcpyAsync(d_data, data.data(), sizeof(data_type) * data.size(),cudaMemcpyHostToDevice, stream));
        CUDA_RT_CALL(cudaMalloc(reinterpret_cast<void **>(&d_data_1), sizeof(data_type) * data.size()));
        CUDA_RT_CALL(cudaMemcpyAsync(d_data_1, data1.data(), sizeof(data_type) * data.size(), cudaMemcpyHostToDevice, stream));
        cudaEvent_t beg, end, beg1, end1; 
        cudaEventCreate(&beg);                              
        cudaEventCreate(&end);   
        cudaEventCreate(&beg1);                        
        cudaEventCreate(&end1);  
        float elapsed = 0, elapsed_cuFFT = 0;
        dim3 blockDim(256);      
        dim3 gridDim(CEIL_DIV(fft_size / 2, 256));
        if(kernel_number == 1)for(int i = 0; i < num_tests; ++i){ 
                int k = 0;
                for(int ns = 1; ns < fft_size; ns *= 2){
                    ft_fft<<<gridDim, blockDim>>>(fft_size, d_data_1, ns, k);
                    k++;  
                    cudaDeviceSynchronize(); 
                }          
                cudaDeviceSynchronize(); 
        }
        if(kernel_number == 3){
            dim3 blockDim(1);  
            dim3 gridDim(1);
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp2<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
        }
        if(kernel_number == 4){ 
            dim3 blockDim(1); 
            dim3 gridDim(1);
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp3<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
        }
        if(kernel_number == 5){
            dim3 blockDim(1); 
            dim3 gridDim(1); 
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp4<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
        }
        if(kernel_number == 6){
            dim3 blockDim(1); 
            dim3 gridDim(1);
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp5<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
        }
        if(kernel_number == 7){
            dim3 blockDim(1); 
            dim3 gridDim(1);
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp5_for<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
        }
        if(kernel_number == 8){
            dim3 blockDim(1); 
            dim3 gridDim(1);
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp5_for_<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
        }
        if(kernel_number == 9){
            dim3 blockDim(1); 
            dim3 gridDim(1);
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp6<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
        }
        cudaEventRecord(beg);
        for(int i = 0; i < num_tests; ++i){ 
            cufftExecC2C(plan, d_data, d_data, CUFFT_FORWARD);
            // CUFFT_CALL(cufftExecC2C(plan, d_data, d_data, CUFFT_INVERSE));
            cudaDeviceSynchronize();  
        } 
        cudaEventRecord(end);     
        cudaEventSynchronize(beg);
        cudaEventSynchronize(end); 
        cudaEventElapsedTime(&elapsed_cuFFT, beg, end);  

        int k = 0;
        k = 0;
        bool if_verified = true; 
        if(kernel_number != 0 && num_tests == 1){
        CUDA_RT_CALL(cudaMemcpy(data.data(), d_data, sizeof(data_type) * data.size(), cudaMemcpyDeviceToHost));
        CUDA_RT_CALL(cudaMemcpy(data1.data(), d_data_1, sizeof(data_type) * data1.size(), cudaMemcpyDeviceToHost));
        CUDA_RT_CALL(cudaStreamSynchronize(stream));
        for (auto &i : data1) {    
             
            double error_bound = 0.1;  
            if(kernel_number == 3 && k < fft_size){
                if(fabs(i.real()- data[k % fft_size].real()) / (fabs(data[k % fft_size].real()) + 0.0001) > error_bound 
                || fabs(i.imag()-data[k % fft_size].imag()) / (fabs(data[k % fft_size].imag()) + 0.0001) > error_bound){
                    if_verified=false; 
                    printf("error k=%d, k-fft_size=%d\n", k, k-fft_size);
                    printf("%f %f j | %f %f j \n", i.real(), i.imag(), data[k % fft_size].real(),data[k % fft_size].imag());
                }
            }
            if(kernel_number >= 4 && k < fft_size){
                if(fabs(i.real()- data[k % fft_size].real()) / (fabs(data[k % fft_size].real()) + 0.0001) > error_bound 
                || fabs(i.imag()-data[k % fft_size].imag()) / (fabs(data[k % fft_size].imag()) + 0.0001) > error_bound){
                    if_verified=false; 
                    printf("error k=%d, k-fft_size=%d\n", k, k-fft_size);
                    printf("%f %f j | %f %f j \n", i.real(), i.imag(), data[k % fft_size].real(),data[k % fft_size].imag());
                }
            }
            if(kernel_number == 2 && k < fft_size){
                if(fabs(i.real()- data[k < fft_size?k:k-fft_size].real()) / (fabs(data[k < fft_size?k:k-fft_size].real()) + 0.0001) > error_bound 
                || fabs(i.imag()-data[k < fft_size?k:k-fft_size].imag()) / (fabs(data[k < fft_size?k:k-fft_size].imag()) + 0.0001) > error_bound){
                    if_verified=false; 
                    printf("error k=%d, k-fft_size=%d\n", k, k-fft_size);
                    printf("%f %f j | %f %f j \n", i.real(), i.imag(), data[k < fft_size?k:k-fft_size].real(),data[k < fft_size?k:k-fft_size].imag());
                }
            }
            if(kernel_number == 1){
                if((int(log2f(n)) % 2) * n <= k &&  k < (1 + (int(log2f(n)) % 2)) * n ){
                    if(fabs(i.real()- data[k < fft_size?k:k-fft_size].real()) / (fabs(data[k < fft_size?k:k-fft_size].real()) + 0.0001) > error_bound 
                    || fabs(i.imag()-data[k < fft_size?k:k-fft_size].imag()) / (fabs(data[k < fft_size?k:k-fft_size].imag()) + 0.0001) > error_bound){
                        if_verified=false;
                        printf("error k=%d, k-fft_size=%d\n", k, k-fft_size);
                        printf("%f %f j | %f %f j \n", i.real(), i.imag(), data[k < fft_size?k:k-fft_size].real(),data[k < fft_size?k:k-fft_size].imag());
                    }
                }
            }
            k++;
        
        }
        if(if_verified)printf("Pass\n");
        }
        if(kernel_number == 1){
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                int k = 0;
                for(int ns = 1; ns < fft_size; ns *= 2){
                    ft_fft<<<gridDim, blockDim>>>(fft_size, d_data_1, ns, k);
                    k++;  
                    cudaDeviceSynchronize(); 
                }          
                cudaDeviceSynchronize(); 
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);                     
        }
        else if(kernel_number == 2){     
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                int k = 0;
                // for(int ns = 1; ns < fft_size; ns *= 2){
                fft_small<<<gridDim, blockDim, 256 * 2 * 2 * sizeof(float)>>>(fft_size, d_data_1, 1, k);
                k++; 
                cudaDeviceSynchronize(); 
                // }
                // cudaDeviceSynchronize(); 
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);
        }
        else if(kernel_number == 3){
            dim3 blockDim(1); 
            dim3 gridDim(1);
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp2<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);
        }
        else if(kernel_number == 4){
            dim3 blockDim(1); 
            dim3 gridDim(1);
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp3<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);
        }
        else if(kernel_number == 5){
            dim3 blockDim(1); 
            dim3 gridDim(1);
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp4<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize(); 
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);
        }
        else if(kernel_number == 6){
            dim3 blockDim(1); 
            dim3 gridDim(1); 
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp5<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize();  
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);
        }
        else if(kernel_number == 7){
            dim3 blockDim(1); 
            dim3 gridDim(1); 
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp5_for<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize();  
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);
        }
        else if(kernel_number == 8){
            dim3 blockDim(1); 
            dim3 gridDim(1); 
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp5_for_<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize();  
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);
        }
        else if(kernel_number == 9){
            dim3 blockDim(1); 
            dim3 gridDim(1); 
            cudaEventRecord(beg1);  
            for(int i = 0; i < num_tests; ++i){ 
                radix2_exp6<<<gridDim, blockDim>>>(fft_size, d_data_1, 1);
                cudaDeviceSynchronize();  
            }
            cudaEventRecord(end1);     
            cudaEventSynchronize(beg1);
            cudaEventSynchronize(end1); 
            cudaEventElapsedTime(&elapsed, beg1, end1);
        }
        double gflops = 0.;
        gflops = double(num_tests * 5.0 * double(n) * double(log2f(n)) ) / (1000000000.0);
        double perf =  (elapsed / num_tests) * 1000;
        double perf_cuFFT =  (elapsed_cuFFT / num_tests) * 1000;
        // CUFFT_CALL(cufftExecC2C(plan, d_data, d_data, CUFFT_FORWARD));
        cudaDeviceSynchronize();   
        // printf("%12d|%12.2f|%16.2f|%32.2f|\n", n, log2(n), elapsed, perf);
        printf("2^%d, %.3f, %.3f\n", int(log2f(n)), perf, perf_cuFFT);
        // printf("%f, ", int(log2f(n)), perf * 1000);
        fflush(stdout);
        
        CUDA_RT_CALL(cudaFree(d_data))
        CUFFT_CALL(cufftDestroy(plan));
        CUDA_RT_CALL(cudaStreamDestroy(stream));
        CUDA_RT_CALL(cudaDeviceReset());
    }
    return EXIT_SUCCESS;
}