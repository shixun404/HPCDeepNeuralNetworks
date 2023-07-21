
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
    t_cufft = (float*)malloc(sizeof(float) * 65536 / 128);
    t_vkfft = (float*)malloc(sizeof(float) * 65536 / 128);
    t_fft = (float*)malloc(sizeof(float) * 65536 / 128);
    
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
    __log_N__ = 9;
    long long N = pow((double)RADIX, (double)__log_N__); 
    int random_seed = 10;  
    #if P_FFT == 1
    int num_tests = 10;
    #else
    int num_tests = 1;
    #endif
    srandom(random_seed); 
    float *input = (float*)calloc(N * 2 * 10240, sizeof(float)); 
    float *output_ref, *output;
    
    output_ref = (float*)calloc(N * 2 * 10240, sizeof(float));
    output = (float*)calloc(N * 2 * 10240, sizeof(float));
    
    float r[6];
    
    r[0] = 1.0f;
    r[1] = 0.0f;
    r[2] = -0.5f;
    r[3] = -0.8660253882408142f;
    r[4] = -0.5f;
    r[5] = 0.8660253882408142f;
    for(int i = 0; i < 3; ++i){
        r[i * 2] = cosf(-2 * M_PI * (i % 3) / 3);
        r[i * 2 + 1] = sinf(-2 * M_PI * (i % 3) / 3);
    }
    
    float *input_d, *output_d, *output_d_vkfft, *output_d_cufft, *output_d_1, *output_d_ref_1, *checksum_r, *checksum_r_d, *dftmtx;
    checksum_r = (float*)calloc(1024*2, sizeof(float));
    dftmtx = (float*)calloc(1024*1024*2, sizeof(float));
    CUDA_CALLER(cudaMalloc((void**)&input_d, sizeof(float) * N * 2 * 10240));
    CUDA_CALLER(cudaMalloc((void**)&output_d, sizeof(float) * N * 2 * 10240));
    
    for(int i = 0; i < N * 2 * 10240; ++i){ 
            input[i] = (float)(random() % 100) / (float)100;
    }
    
        float* checksum_r_3, *checksum_r_d_3;
        checksum_r_3 = (float*)calloc(8*2, sizeof(float));
        CUDA_CALLER(cudaMalloc((void**)&checksum_r_d_3, sizeof(float) * 8 * 2));
        // printf("################################### 8 ###################################\n");
        for(int i = 0; i < 8; ++i)
        
        {
        
        for(int j = 0; j < 8; ++j )
        
        {
        
            dftmtx[i + (j * 2) * 8] = cosf((float)(-2 * M_PI * i * j) / 8.f);
            dftmtx[i + (j * 2 + 1) * 8] = sinf((float)(-2 * M_PI * i * j) / 8.f);
        
        }
    }
    
    for(int i = 0; i < 8; ++i)
    
    {
    
        checksum_r_3[i * 2] = 0;
        checksum_r_3[i * 2 + 1] = 0;
        for(int j = 0; j < 8; ++j)
    
    {
    
            float real = dftmtx[j + i * 2 * 8];
            float imag = dftmtx[j + (i * 2 + 1) * 8];
            checksum_r_3[i * 2] += real * r[(j % 3) * 2] - imag * r[(j % 3) * 2 + 1];
            checksum_r_3[i * 2 + 1] += imag * r[(j % 3) * 2] + real * r[(j % 3) * 2 + 1];
        
    }
    }
    
    cudaMemcpy((void*)checksum_r_d_3, (void*)checksum_r_3, 2 * 8 * sizeof(float), cudaMemcpyHostToDevice);
    
        float* checksum_r_4, *checksum_r_d_4;
        checksum_r_4 = (float*)calloc(16*2, sizeof(float));
        CUDA_CALLER(cudaMalloc((void**)&checksum_r_d_4, sizeof(float) * 16 * 2));
        // printf("################################### 16 ###################################\n");
        for(int i = 0; i < 16; ++i)
        
        {
        
        for(int j = 0; j < 16; ++j )
        
        {
        
            dftmtx[i + (j * 2) * 16] = cosf((float)(-2 * M_PI * i * j) / 16.f);
            dftmtx[i + (j * 2 + 1) * 16] = sinf((float)(-2 * M_PI * i * j) / 16.f);
        
        }
    }
    
    for(int i = 0; i < 16; ++i)
    
    {
    
        checksum_r_4[i * 2] = 0;
        checksum_r_4[i * 2 + 1] = 0;
        for(int j = 0; j < 16; ++j)
    
    {
    
            float real = dftmtx[j + i * 2 * 16];
            float imag = dftmtx[j + (i * 2 + 1) * 16];
            checksum_r_4[i * 2] += real * r[(j % 3) * 2] - imag * r[(j % 3) * 2 + 1];
            checksum_r_4[i * 2 + 1] += imag * r[(j % 3) * 2] + real * r[(j % 3) * 2 + 1];
        
    }
    }
    
    cudaMemcpy((void*)checksum_r_d_4, (void*)checksum_r_4, 2 * 16 * sizeof(float), cudaMemcpyHostToDevice);
    
        float* checksum_r_5, *checksum_r_d_5;
        checksum_r_5 = (float*)calloc(32*2, sizeof(float));
        CUDA_CALLER(cudaMalloc((void**)&checksum_r_d_5, sizeof(float) * 32 * 2));
        // printf("################################### 32 ###################################\n");
        for(int i = 0; i < 32; ++i)
        
        {
        
        for(int j = 0; j < 32; ++j )
        
        {
        
            dftmtx[i + (j * 2) * 32] = cosf((float)(-2 * M_PI * i * j) / 32.f);
            dftmtx[i + (j * 2 + 1) * 32] = sinf((float)(-2 * M_PI * i * j) / 32.f);
        
        }
    }
    
    for(int i = 0; i < 32; ++i)
    
    {
    
        checksum_r_5[i * 2] = 0;
        checksum_r_5[i * 2 + 1] = 0;
        for(int j = 0; j < 32; ++j)
    
    {
    
            float real = dftmtx[j + i * 2 * 32];
            float imag = dftmtx[j + (i * 2 + 1) * 32];
            checksum_r_5[i * 2] += real * r[(j % 3) * 2] - imag * r[(j % 3) * 2 + 1];
            checksum_r_5[i * 2 + 1] += imag * r[(j % 3) * 2] + real * r[(j % 3) * 2 + 1];
        
    }
    }
    
    cudaMemcpy((void*)checksum_r_d_5, (void*)checksum_r_5, 2 * 32 * sizeof(float), cudaMemcpyHostToDevice);
    
        float* checksum_r_6, *checksum_r_d_6;
        checksum_r_6 = (float*)calloc(64*2, sizeof(float));
        CUDA_CALLER(cudaMalloc((void**)&checksum_r_d_6, sizeof(float) * 64 * 2));
        // printf("################################### 64 ###################################\n");
        for(int i = 0; i < 64; ++i)
        
        {
        
        for(int j = 0; j < 64; ++j )
        
        {
        
            dftmtx[i + (j * 2) * 64] = cosf((float)(-2 * M_PI * i * j) / 64.f);
            dftmtx[i + (j * 2 + 1) * 64] = sinf((float)(-2 * M_PI * i * j) / 64.f);
        
        }
    }
    
    for(int i = 0; i < 64; ++i)
    
    {
    
        checksum_r_6[i * 2] = 0;
        checksum_r_6[i * 2 + 1] = 0;
        for(int j = 0; j < 64; ++j)
    
    {
    
            float real = dftmtx[j + i * 2 * 64];
            float imag = dftmtx[j + (i * 2 + 1) * 64];
            checksum_r_6[i * 2] += real * r[(j % 3) * 2] - imag * r[(j % 3) * 2 + 1];
            checksum_r_6[i * 2 + 1] += imag * r[(j % 3) * 2] + real * r[(j % 3) * 2 + 1];
        
    }
    }
    
    cudaMemcpy((void*)checksum_r_d_6, (void*)checksum_r_6, 2 * 64 * sizeof(float), cudaMemcpyHostToDevice);
    
        float* checksum_r_7, *checksum_r_d_7;
        checksum_r_7 = (float*)calloc(128*2, sizeof(float));
        CUDA_CALLER(cudaMalloc((void**)&checksum_r_d_7, sizeof(float) * 128 * 2));
        // printf("################################### 128 ###################################\n");
        for(int i = 0; i < 128; ++i)
        
        {
        
        for(int j = 0; j < 128; ++j )
        
        {
        
            dftmtx[i + (j * 2) * 128] = cosf((float)(-2 * M_PI * i * j) / 128.f);
            dftmtx[i + (j * 2 + 1) * 128] = sinf((float)(-2 * M_PI * i * j) / 128.f);
        
        }
    }
    
    for(int i = 0; i < 128; ++i)
    
    {
    
        checksum_r_7[i * 2] = 0;
        checksum_r_7[i * 2 + 1] = 0;
        for(int j = 0; j < 128; ++j)
    
    {
    
            float real = dftmtx[j + i * 2 * 128];
            float imag = dftmtx[j + (i * 2 + 1) * 128];
            checksum_r_7[i * 2] += real * r[(j % 3) * 2] - imag * r[(j % 3) * 2 + 1];
            checksum_r_7[i * 2 + 1] += imag * r[(j % 3) * 2] + real * r[(j % 3) * 2 + 1];
        
    }
    }
    
    cudaMemcpy((void*)checksum_r_d_7, (void*)checksum_r_7, 2 * 128 * sizeof(float), cudaMemcpyHostToDevice);
    
        float* checksum_r_8, *checksum_r_d_8;
        checksum_r_8 = (float*)calloc(256*2, sizeof(float));
        CUDA_CALLER(cudaMalloc((void**)&checksum_r_d_8, sizeof(float) * 256 * 2));
        // printf("################################### 256 ###################################\n");
        for(int i = 0; i < 256; ++i)
        
        {
        
        for(int j = 0; j < 256; ++j )
        
        {
        
            dftmtx[i + (j * 2) * 256] = cosf((float)(-2 * M_PI * i * j) / 256.f);
            dftmtx[i + (j * 2 + 1) * 256] = sinf((float)(-2 * M_PI * i * j) / 256.f);
        
        }
    }
    
    for(int i = 0; i < 256; ++i)
    
    {
    
        checksum_r_8[i * 2] = 0;
        checksum_r_8[i * 2 + 1] = 0;
        for(int j = 0; j < 256; ++j)
    
    {
    
            float real = dftmtx[j + i * 2 * 256];
            float imag = dftmtx[j + (i * 2 + 1) * 256];
            checksum_r_8[i * 2] += real * r[(j % 3) * 2] - imag * r[(j % 3) * 2 + 1];
            checksum_r_8[i * 2 + 1] += imag * r[(j % 3) * 2] + real * r[(j % 3) * 2 + 1];
        
    }
    }
    
    cudaMemcpy((void*)checksum_r_d_8, (void*)checksum_r_8, 2 * 256 * sizeof(float), cudaMemcpyHostToDevice);
    
        float* checksum_r_9, *checksum_r_d_9;
        checksum_r_9 = (float*)calloc(512*2, sizeof(float));
        CUDA_CALLER(cudaMalloc((void**)&checksum_r_d_9, sizeof(float) * 512 * 2));
        // printf("################################### 512 ###################################\n");
        for(int i = 0; i < 512; ++i)
        
        {
        
        for(int j = 0; j < 512; ++j )
        
        {
        
            dftmtx[i + (j * 2) * 512] = cosf((float)(-2 * M_PI * i * j) / 512.f);
            dftmtx[i + (j * 2 + 1) * 512] = sinf((float)(-2 * M_PI * i * j) / 512.f);
        
        }
    }
    
    for(int i = 0; i < 512; ++i)
    
    {
    
        checksum_r_9[i * 2] = 0;
        checksum_r_9[i * 2 + 1] = 0;
        for(int j = 0; j < 512; ++j)
    
    {
    
            float real = dftmtx[j + i * 2 * 512];
            float imag = dftmtx[j + (i * 2 + 1) * 512];
            checksum_r_9[i * 2] += real * r[(j % 3) * 2] - imag * r[(j % 3) * 2 + 1];
            checksum_r_9[i * 2 + 1] += imag * r[(j % 3) * 2] + real * r[(j % 3) * 2 + 1];
        
    }
    }
    
    cudaMemcpy((void*)checksum_r_d_9, (void*)checksum_r_9, 2 * 512 * sizeof(float), cudaMemcpyHostToDevice);
    
        float* checksum_r_10, *checksum_r_d_10;
        checksum_r_10 = (float*)calloc(1024*2, sizeof(float));
        CUDA_CALLER(cudaMalloc((void**)&checksum_r_d_10, sizeof(float) * 1024 * 2));
        // printf("################################### 1024 ###################################\n");
        for(int i = 0; i < 1024; ++i)
        
        {
        
        for(int j = 0; j < 1024; ++j )
        
        {
        
            dftmtx[i + (j * 2) * 1024] = cosf((float)(-2 * M_PI * i * j) / 1024.f);
            dftmtx[i + (j * 2 + 1) * 1024] = sinf((float)(-2 * M_PI * i * j) / 1024.f);
        
        }
    }
    
    for(int i = 0; i < 1024; ++i)
    
    {
    
        checksum_r_10[i * 2] = 0;
        checksum_r_10[i * 2 + 1] = 0;
        for(int j = 0; j < 1024; ++j)
    
    {
    
            float real = dftmtx[j + i * 2 * 1024];
            float imag = dftmtx[j + (i * 2 + 1) * 1024];
            checksum_r_10[i * 2] += real * r[(j % 3) * 2] - imag * r[(j % 3) * 2 + 1];
            checksum_r_10[i * 2 + 1] += imag * r[(j % 3) * 2] + real * r[(j % 3) * 2 + 1];
        
    }
    }
    
    cudaMemcpy((void*)checksum_r_d_10, (void*)checksum_r_10, 2 * 1024 * sizeof(float), cudaMemcpyHostToDevice);
    
    
    cudaMemcpy((void*)input_d, (void*)input, 2 * N * sizeof(float) * 10240, cudaMemcpyHostToDevice);
    

    cufftHandle plan;  


    cudaEvent_t fft_begin, fft_end;
    float elapsed_time_vkfft, elapsed_time, elapsed_time_cufft; 
    std::chrono::steady_clock::time_point timeSt; // = std::chrono::steady_clock::now();
    std::chrono::steady_clock::time_point timeEnd; // = std::chrono::steady_clock::now();
	float totTime, totTime_vkfft, totTime_cufft;
    cudaEventCreate(&fft_begin);
    cudaEventCreate(&fft_end);
    
    #if P_FFT == 1
    for(int batch_size = 128; batch_size <= 10240; batch_size += 128){
    #else
    int log_N = __log_N__;
    #endif
    int log_N = 9;
    N = pow(double(RADIX), double(log_N));
    
        cudaFuncSetAttribute(fft_radix2_logN18_1, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
        // cudaFuncSetAttribute(VkFFT_main_logN18_1, cudaFuncAttributeMaxDynamicSharedMemorySize, 65536);
        
        cudaEventCreate(&fft_begin);
        cudaEventCreate(&fft_end);
        {
            cufftCreate(&plan);
            cufftPlan1d(&plan, N, CUFFT_C2C, batch_size); 
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
            cudaMemcpy((void*)output_ref, (void*)output_d, 2 * N * batch_size * sizeof(float), cudaMemcpyDeviceToHost);
            cufftDestroy(plan);
        }
    
        
        {
        
            cudaEventRecord(fft_begin);
            timeSt = std::chrono::steady_clock::now();
            
            for(int i = 0; i < num_tests; ++i){
        {
                dim3 gridDim(batch_size / 4, 1, 1);
                dim3 blockDim(64, 1, 1);
                fft_radix2_logN18_2 <<<gridDim, blockDim, 16384>>> ((float2*)input_d, (float2*)output_d);
                cudaDeviceSynchronize();
            }
        
            }
            timeEnd = std::chrono::steady_clock::now();
            totTime = std::chrono::duration_cast<std::chrono::microseconds>(timeEnd - timeSt).count();
            cudaEventRecord(fft_end);  
            cudaEventSynchronize(fft_begin);
            cudaEventSynchronize(fft_end);
            cudaEventElapsedTime(&elapsed_time, fft_begin, fft_end);
            cudaMemcpy((void*)output, (void*)output_d, 2 * N * batch_size * sizeof(float), cudaMemcpyDeviceToHost);
            CUDA_CALLER(cudaFree(output_d_1));
        }
        
    #if V_FFT == 1
    // cudaMemcpy((void*)output_ref, (void*)output_d_vkfft, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
    // cudaMemcpy((void*)output, (void*)output_d, sizeof(float) * 2 * N, cudaMemcpyDeviceToHost);
    // cudaMemcpy((void*)output, (void*)output_d_cufft, sizeof(float) * 2 * N, cudaMemcpyDeviceToHost);
    // cudaMemcpy((void*)output, (void*)output_d_ref_1, 2 * N * sizeof(float), cudaMemcpyDeviceToHost);
    // cudaMemcpy((void*)output_ref, (void*)output_d_1, sizeof(float) * 2 * N, cudaMemcpyDeviceToHost);
    cudaDeviceSynchronize();
    bool pass = true;
    for(int i = 0; i < 2 * N * batch_size; i +=2){
        float2 res = *(float2*)(output + i); 
        float2 res_ref = *(float2*)(output_ref + i);
        float norm, norm_ref; 
        FLOAT2_NORM(res, norm);
        FLOAT2_NORM(res_ref, norm_ref);
        
        float err = fabs(norm - norm_ref);
        if(i % 1000000 ==0){
        printf("error %f detected at %d\n", err / fabs(norm), i / 2);
        printf("ref[%d]: %.3f + %.3f i\n",  i / 2, res_ref.x, res_ref.y);
        printf("res[%d]: %.3f + %.3f i\n\n",  i / 2, res.x, res.y);
        }
        if(err / fabs(norm) > 0.05){
            printf("error %f detected at %d\n", err / fabs(norm), i / 2);
            printf("ref[%d]: %.3f + %.3f i\n",  i / 2, res_ref.x, res_ref.y);
            printf("res[%d]: %.3f + %.3f i\n\n",  i / 2, res.x, res.y);
            pass = false;
            return -1;
            break;
            
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
    if(batch_size == 128)printf("| SIZE |  Execution Time (us)             |   Shared   | #threads |\n");
    if(batch_size == 128)printf("|log(N)|   Ours   |   cuFFT   | Memory (KB)|          |\n");
    // if(log_N == __log_N_st__)printf("|batch |   Ours   |   VkFFT   |   cuFFT   | Memory (KB)|          |\n");
    // printf("|%6d| %8.3f | %8.3f  |%8.3f   |%8.3f    |%10d|\n", batch_size, elapsed_time * 1000, elapsed_time_vkfft * 1000, elapsed_time_cufft * 1000, (float)sizeof(float) * (float)N * 2.f / 1024.f, N / 8);
    printf("|%6d| %8.3f | %8.3f  |%8.3f   |%8.3f    |%10d|\n", batch_size, elapsed_time * 1000, elapsed_time_cufft * 1000, (float)sizeof(float) * (float)N * 2.f / 1024.f, N / 8);
    t_fft[batch_size / 128] = elapsed_time;
    t_cufft[batch_size / 128] = elapsed_time_cufft;
    t_vkfft[batch_size / 128] = elapsed_time_vkfft;
    }
    printf("Execution Time\n");
    printf("t_fft = th.as_tensor([");
    for(int i = 128; i <= 10240; i += 128 ){
        printf("%8f,", t_fft[i / 128]);
    }
    printf("])\n");

    printf("t_cufft = th.as_tensor([");
    for(int i = 128; i <= 10240; i += 128 ){
        printf("%8f,", t_cufft[i / 128]);
    }
    printf("])\n");
    
    // printf("t_vkfft = th.as_tensor([");
    // for(int i = 128; i <= 10240; i += 128 ){
    //     printf("%8f,", t_vkfft[i]);
    // }
    // printf("])\n");

    printf("\n Flops\n");
    printf("gflops_fft = th.as_tensor([");
    for(int i = 128; i <= 10240; i += 128 ){
        long long N = pow((double)RADIX, (double)9);
        printf("%8.1f,", 5 * N * 9 * i / t_fft[i / 128] * 1000.f / 1000000000.f);
    }
    printf("])\n");

    printf("gflops_cufft = th.as_tensor([");
    for(int i = 128; i <= 10240; i += 128 ){
        long long N = pow((double)RADIX, (double)9);
        printf("%8.1f,", 5 * N * 9 * i / t_cufft[i / 128] * 1000.f / 1000000000.f);
    }
    printf("])\n");
    
    // printf("gflops_vkfft = th.as_tensor([");
    // for(int i = 128; i <= 10240; i += 128 ){
    //     long long N = pow((double)RADIX, (double)9);
    //     printf("%8.1f,", 5 * N * 9 * i / t_vkfft[i] * 1000.f / 1000000000.f);
    // }
    // printf("])\n");
    #endif
    return 0;
}

    