#include <complex>
#include <iostream> 
#include <random>
#include <vector>
#include <cuda_runtime.h>
#include <cufftXt.h>
#include <math.h> 
#include "utils/utils.cuh"          
#include "kernels.cuh"  

#define M_PI 3.14159265358979312f 
// #define VERIFY 0
#define hadmard 1
struct M_complex{
    float x, y;
};
#define M_complex_MUL(a, b, c) c.x = a.x * b.x - a.y * b.y; c.y = a.y * b.x + a.x * b.y;
void generate_W(float* W, int N){  
    for(int c = 0; c < N; ++c)
    for(int r = 0; r < N; ++r){d
        float angle = (-2.f * M_PI * r * c) / N;
        W[2 * (r + c * N)] = cosf(angle);
        W[2 * (r + c * N) + 1] = sinf(angle);
        // printf("%f + %f i\n", cosf(angle), sinf(angle));
    }
}
int main(int argc, char *argv[]) {
    if(argc != 2){
        printf("Missing exponent of FFT size as input. Default base is 2.\n");
        return -1;
    }
    // printf("%f\n", -2 * M_PI * ((1 * 2) / 2) * ((1 * 2) % 4) / (100));
    int size = atoi(argv[1]);
    int batch_size = 1;
    int num_tests = 3;
    double error_bound = 0.1;  
    int M = pow((double)2, (double)(size / 2));
    float *X, *W, *Y, *Y_ref;
    float *d_X0, *d_X1, *d_W, *d_Y, *d_Y_ref;
    float elapsed = 0, elapsed_cuFFT = 0;
    M_complex alpha, beta;
    alpha.x = 1;
    alpha.y = 0;
    beta.x = 0;
    beta.y = 0;
    X = (float*)malloc(sizeof(float) * M * M * 2);
    Y = (float*)malloc(sizeof(float) * M * M * 2);
    Y_ref = (float*)malloc(sizeof(float) * M * M * 2);
    W = (float*)malloc(sizeof(float) * M * M * 2);
    cudaMalloc((void**)(&d_X1), sizeof(float) * M * M * 2);
    cudaMalloc((void**)(&d_X0), sizeof(float) * M * M * 2);
    cudaMalloc((void**)(&d_Y), sizeof(float) * M * M * 2);
    cudaMalloc((void**)(&d_Y_ref), sizeof(float) * M * M * 2);
    cudaMalloc((void**)(&d_W), sizeof(float) * M * M * 2);

    // Random init X
    generate_random_matrix(X, M);
    generate_random_matrix(X + M * M, M);
    generate_W(W, M);
    

    cudaMemcpy(d_X0, X, sizeof(float) * M * M * 2, cudaMemcpyHostToDevice);
    cudaMemcpy(d_W, W, sizeof(float) * M * M * 2, cudaMemcpyHostToDevice);


    cublasHandle_t handle;
    cufftHandle fft_handle, fft_handle_test, fft_handle_test2;
    cublasCreate(&handle); 
    cufftCreate(&fft_handle);
    cufftCreate(&fft_handle_test);
    cufftCreate(&fft_handle_test2);
    dim3 blockDim(256);
    dim3 gridDim(CEIL_DIV(M * M, 512));
    
    
    cudaEvent_t beg, end, beg1, end1; 
    cudaEventCreate(&beg);                              
    cudaEventCreate(&end);   
    cudaEventCreate(&beg1);                        
    cudaEventCreate(&end1);  

    /////////////////////////////////////////////////////////////////////////////////////
    // X_j x W = X_s
    // cublasCgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, 
    //             M, M, M, 
    //             (cuComplex*)&alpha, (cuComplex*)d_X0, M, (cuComplex*)d_W, M, 
    //             (cuComplex*)&beta, (cuComplex*)d_X1, M);
    
    // cufftPlan1d(&fft_handle_test, M * M, CUFFT_C2C, M);
    // cufftExecC2C(fft_handle_test, (cuComplex*)d_X0, (cuComplex*)d_X1, CUFFT_FORWARD);
    // // Hadamard(X_s, W_v) --> X_s
    // #ifdef hadmard
    // my_hadamard_kernel<<<gridDim, blockDim>>>(d_X1, M);
    // #endif
    // // W x X_s = Y
    // cublasCgemm(handle, CUBLAS_OP_T, CUBLAS_OP_T, 
    //             M, M, M, 
    //             (cuComplex*)&alpha, (cuComplex*)d_X1, M, (cuComplex*)d_W, M, 
    //             (cuComplex*)&beta, (cuComplex*)d_Y, M);
    /////////////////////////////////////////////////////////////////////////////////////
    // cufftPlan1d(&fft_handle_test, M * M, CUFFT_C2C, M);
    int s = M * M;
    cufftPlanMany(&fft_handle_test, 1, &M, &M, M, 1, &M, M, 1,CUFFT_C2C,M);
    cufftPlanMany(&fft_handle_test2, 1, &M, &M, 1, M, &M, M, 1,CUFFT_C2C,M);



    cufftExecC2C(fft_handle_test, (cuComplex*)d_X0, (cuComplex*)d_X1, CUFFT_FORWARD);
    // Hadamard(X_s, W_v) --> X_s
    #ifdef hadmard
    my_hadamard_kernel<<<gridDim, blockDim>>>(d_X1, M);
    #endif
    // W x X_s = Y
    // cublasCgemm(handle, CUBLAS_OP_T, CUBLAS_OP_T, 
    //             M, M, M, 
    //             (cuComplex*)&alpha, (cuComplex*)d_X1, M, (cuComplex*)d_W, M, 
    //             (cuComplex*)&beta, (cuComplex*)d_Y, M);
    cufftExecC2C(fft_handle_test2, (cuComplex*)d_X1, (cuComplex*)d_Y, CUFFT_FORWARD);
    /////////////////////////////////////////////////////////////////////////////////////
    
    #ifdef VERIFY
    cudaMemcpy(Y, d_Y, sizeof(float) * M * M * 2, cudaMemcpyDeviceToHost);
    #endif
    
    
    // compare with cuFFT.
    cufftPlan1d(&fft_handle, M * M, CUFFT_C2C, batch_size);
    
    cufftExecC2C(fft_handle, (cuComplex*)d_X0, (cuComplex*)d_Y_ref, CUFFT_FORWARD);

    // #ifdef VERIFY
    // cudaMemcpy(Y_ref, d_Y_ref, sizeof(float) * M * M * 2, cudaMemcpyDeviceToHost);
    
    // compare
    // bool if_verified = true; 
    // for(int i = 0; i < M * M * 2; ++i){
    //     if(fabs(Y[i]- Y_ref[i]) / sqrt(Y_ref[(i / 2) * 2] * Y_ref[(i / 2) * 2] + Y_ref[(i / 2) * 2 + 1] * Y_ref[(i / 2) * 2 + 1] + 0.0001) > error_bound ){
    //         if_verified=false; 
    //         printf("Detect error at %d, cuFFT result: %.3f + %.3f i, our result: %.3f + %.3f i \n", 
    //         i / 2, Y_ref[(i / 2) * 2], Y_ref[(i / 2) * 2 + 1], Y[(i / 2) * 2], Y[(i / 2) * 2 + 1]);
    //     }
    // }
    // if(if_verified)printf("No error detected!\n");
    // #endif
    cudaEventRecord(beg1);  
    // cufftPlanMany(&fft_handle_test, 1, &M, &M, M, 1, &M, M, 1,CUFFT_C2C,M);
    for(int i = 0; i < num_tests; ++i){
        
        // cublasCgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, 
        //         M, M, M, 
        //         (cuComplex*)&alpha, (cuComplex*)d_X0, M, (cuComplex*)d_W, M, 
        //         (cuComplex*)&beta, (cuComplex*)d_X1, M);

        
        cufftExecC2C(fft_handle_test, (cuComplex*)d_X0, (cuComplex*)d_X1, CUFFT_FORWARD);

        // Hadamard(X_s, W_v) --> X_s
        // #ifdef hadmard
        // my_hadamard_kernel<<<gridDim, blockDim>>>(d_X1, M);
        // #endif
        // W x X_s = Y
        // cublasCgemm(handle, CUBLAS_OP_T, CUBLAS_OP_T, 
        //             M, M, M, 
        //             (cuComplex*)&alpha, (cuComplex*)d_X1, M, (cuComplex*)d_W, M, 
        //             (cuComplex*)&beta, (cuComplex*)d_Y, M);
        cufftExecC2C(fft_handle_test2, (cuComplex*)d_X1, (cuComplex*)d_Y, CUFFT_FORWARD);
        cudaDeviceSynchronize(); 
    }
    cudaEventRecord(end1);     
    cudaEventSynchronize(beg1);
    cudaEventSynchronize(end1); 
    cudaEventElapsedTime(&elapsed, beg1, end1);     


    cudaEventRecord(beg);  
    for(int i = 0; i < num_tests; ++i){
        cufftExecC2C(fft_handle, (cuComplex*)d_X0, (cuComplex*)d_Y_ref, CUFFT_FORWARD);
        cudaDeviceSynchronize(); 
    }
    cudaEventRecord(end);     
    cudaEventSynchronize(beg);
    cudaEventSynchronize(end); 
    cudaEventElapsedTime(&elapsed_cuFFT, beg, end);     

    double gflops = 0.;
    gflops = double(num_tests * 5.0 * double(M * M) * double(log2f(M * M)) ) / (1000000000.0);
    double perf =  (elapsed / num_tests) * 1000;
    double perf_cuFFT =  (elapsed_cuFFT / num_tests) * 1000;

    printf("2^%d, %.3f, %.3f\n", size, perf, perf_cuFFT);


    cudaFree(d_X0);
    cudaFree(d_X1);
    cudaFree(d_Y);
    cudaFree(d_W);
    cudaFree(d_Y_ref);

    free(X);
    free(Y);
    free(W);
    free(Y_ref);


}
