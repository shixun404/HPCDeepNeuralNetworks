/*
 * Copyright 2020 NVIDIA Corporation.  All rights reserved.
 *
 * NOTICE TO LICENSEE:
 *
 * This source code and/or documentation ("Licensed Deliverables") are
 * subject to NVIDIA intellectual property rights under U.S. and
 * international Copyright laws.
 *
 * These Licensed Deliverables contained herein is PROPRIETARY and
 * CONFIDENTIAL to NVIDIA and is being provided under the terms and
 * conditions of a form of NVIDIA software license agreement by and
 * between NVIDIA and Licensee ("License Agreement") or electronically
 * accepted by Licensee.  Notwithstanding any terms or conditions to
 * the contrary in the License Agreement, reproduction or disclosure
 * of the Licensed Deliverables to any third party without the express
 * written consent of NVIDIA is prohibited.
 *
 * NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
 * LICENSE AGREEMENT, NVIDIA MAKES NO REPRESENTATION ABOUT THE
 * SUITABILITY OF THESE LICENSED DELIVERABLES FOR ANY PURPOSE.  IT IS
 * PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY OF ANY KIND.
 * NVIDIA DISCLAIMS ALL WARRANTIES WITH REGARD TO THESE LICENSED
 * DELIVERABLES, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY,
 * NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE.
 * NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
 * LICENSE AGREEMENT, IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY
 * SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, OR ANY
 * DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
 * WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
 * ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
 * OF THESE LICENSED DELIVERABLES.
 *
 * U.S. Government End Users.  These Licensed Deliverables are a
 * "commercial item" as that term is defined at 48 C.F.R. 2.101 (OCT
 * 1995), consisting of "commercial computer software" and "commercial
 * computer software documentation" as such terms are used in 48
 * C.F.R. 12.212 (SEPT 1995) and is provided to the U.S. Government
 * only as a commercial end item.  Consistent with 48 C.F.R.12.212 and
 * 48 C.F.R. 227.7202-1 through 227.7202-4 (JUNE 1995), all
 * U.S. Government End Users acquire the Licensed Deliverables with
 * only those rights set forth herein.
 *
 * Any use of the Licensed Deliverables in individual and commercial
 * software must include, in the user documentation and internal
 * comments to the code, the above Disclaimer and U.S. Government End
 * Users Notice.
 */

#include <complex>
#include <iostream>
#include <random>
#include <vector>

#include <cuda_runtime.h>
#include <cufftXt.h>
#include <math.h> 
// #include "cufft_utils.h"
// #include <stdio.h>     
// #include <cublas_v2.h>     
#include "utils/utils.cuh"          
// #define PPP 1
// #include <cuda_runtime.h> 
// #include <helper_functions.h>
// #include <helper_cuda.h>
#include "kernels.cuh"  

int main(int argc, char *argv[]) {
    int start_size = 1024 * 1024 * 128 ;
    int end_size = 1024 * 1024 * 128;
    // int gap_size = 10240;
    int num_tests = 10;
    
    // for(int max_size = start_size; max_size <= end_size; max_size += gap_size){
    // printf("%8d|", max_size);
    // } 
    printf("%12s|%12s|%16s|%32s|\n", "Size","log(Size)", "Elapsed (s)", "Performance (GFLOPS)");
    for(int n = start_size; n <= end_size; n *= 2){
        cufftHandle plan;
        cudaStream_t stream = NULL;

        // int n = 80;
        int batch_size = 1;
        int fft_size = batch_size * n;

        using scalar_type = float;
        using data_type = std::complex<scalar_type>;

        std::vector<data_type> data(fft_size * 2), data1(fft_size * 2);

        for (int i = 0; i < fft_size * 2; i++) {
            data[i] = data_type(i, -i);
            data1[i] = data_type(i, -i);
        }

        // std::printf("Input array:\n");
        // for (auto &i : data) {
        //     std::printf("%f + %fj\n", i.real(), i.imag());
        // }
        // std::printf("=====\n");

        cufftComplex *d_data = nullptr;
        cufftComplex *d_data_1 = nullptr;

        CUFFT_CALL(cufftCreate(&plan));
        CUFFT_CALL(cufftPlan1d(&plan, data.size() / 2, CUFFT_C2C, batch_size));

        CUDA_RT_CALL(cudaStreamCreateWithFlags(&stream, cudaStreamNonBlocking));
        CUFFT_CALL(cufftSetStream(plan, stream));

        // Create device data arrays
        CUDA_RT_CALL(cudaMalloc(reinterpret_cast<void **>(&d_data), sizeof(data_type) * data.size()));
        CUDA_RT_CALL(cudaMemcpyAsync(d_data, data.data(), sizeof(data_type) * data.size(),
                                    cudaMemcpyHostToDevice, stream));
        CUDA_RT_CALL(cudaMalloc(reinterpret_cast<void **>(&d_data_1), sizeof(data_type) * data.size()));
        CUDA_RT_CALL(cudaMemcpyAsync(d_data_1, data1.data(), sizeof(data_type) * data.size(),
                                    cudaMemcpyHostToDevice, stream));

        /*
        * Note: 
        *  Identical pointers to data and output arrays implies in-place transformation
        */
        cudaEvent_t beg, end; 
        cudaEventCreate(&beg);                        
        cudaEventCreate(&end); 
        float elapsed = 0;   
         dim3 blockDim(256);      
            dim3 gridDim(CEIL_DIV(fft_size, 256));
        cudaEventRecord(beg); 
        for(int i = 0; i < num_tests; ++i){ 
            cudaDeviceSynchronize(); 
            // CUFFT_CALL(cufftExecC2C(plan, d_data, d_data, CUFFT_FORWARD));
            // CUFFT_CALL(cufftExecC2C(plan, d_data, d_data, CUFFT_INVERSE));
            // cudaDeviceSynchronize();  
            // // sgemm_tall<<<gridDim, blockDim>>>
            // // printf("abc\n");
            ft_fft<<<gridDim, blockDim>>>(fft_size, d_data_1);
            ft_fft<<<gridDim, blockDim>>>(fft_size, d_data_1);
            // CUFFT_CALL(cufftExecC2C(plan, d_data, d_data, CUFFT_INVERSE));
            cudaDeviceSynchronize(); 
        }
        cudaEventRecord(end);     
        cudaEventSynchronize(beg);
        cudaEventSynchronize(end); 
        cudaEventElapsedTime(&elapsed, beg, end);                     
        double gflops  = 0.;
        gflops = double(num_tests * 5.0 * double(n) * double(log2f(n)) ) / (1000000000.0);
        // double perf = gflops / (elapsed / 1e3);
        double perf =  (elapsed / num_tests);
        // printf("%12d|%12.2f|%16.2f|%32.2f|\n", n, log2(n), elapsed, perf);
        printf("%f, ", perf);
        fflush(stdout);
        
        // CUDA_RT_CALL(cudaMemcpy(data.data(), d_data, sizeof(data_type) * data.size(),
        //                             cudaMemcpyDeviceToHost));
        // CUDA_RT_CALL(cudaMemcpy(data1.data(), d_data_1, sizeof(data_type) * data1.size(),
        //                             cudaMemcpyDeviceToHost));

        // CUDA_RT_CALL(cudaStreamSynchronize(stream));

        // std::printf("Output array: cuFFT\n");
        // int k = 0;
        // for (auto &i : data) {
        //     if(k >= fft_size)break;
        //     std::printf("%f + %fj\n", i.real(), i.imag());
        //     k++;
        // }
        // std::printf("=====\n");

        // k = 0;
        // std::printf("Output array: Ours\n");
        // for (auto &i : data1) {
        //     if((int(log2f(n)) % 2) * n <= k &&  k < (1 + (int(log2f(n)) % 2)) * n )
        //     std::printf("%f + %fj\n", i.real(), i.imag());
        //     k++;
        // }
        // std::printf("=====\n");

        /* free resources */
        CUDA_RT_CALL(cudaFree(d_data))

        CUFFT_CALL(cufftDestroy(plan));

        CUDA_RT_CALL(cudaStreamDestroy(stream));

        CUDA_RT_CALL(cudaDeviceReset());
        
    }

    return EXIT_SUCCESS;
}