#include <stdio.h>
#include <vector>
#include <cmath>
#include <cublas_v2.h>
#include <cuda_runtime.h>
#include "cublas_utils.h"
#define p(r,c,n) (c * n + r)
#define batch 2

#define block_size 4
#define get_r(p, n) ((batch * p) % n)
#define get_c(p, n) ((batch * p) / n)


using namespace std;
using data_type = float;



__global__ void sgemm1(data_type *a, data_type *b, data_type *c, int n){
    
    // Define variables.
    int index_x = (threadIdx.x%2) + blockIdx.x * blockDim.x;
    int index_y = (threadIdx.x/2) + blockIdx.y * blockDim.y;
    int tid = threadIdx.x;


    // Define shared memories.
    __shared__ data_type t_a[batch * 2][1];
    __shared__ data_type t_b[batch * 2][1];
    data_type cal_c[batch][batch];


    for (int i = 0; i < batch; i++)
    {
        for (int j = 0; j < batch; j++)
        {
           cal_c[i][j] = 0;
        }
    }


    // Start Calculation    
    for (int repeat = 0; repeat < n; repeat++)
    {
        t_a[tid][0] = a[p((blockIdx.x * 2 * batch + tid), repeat, n)];
        t_b[tid][0] = b[p(repeat, (blockIdx.y * 2 * batch + tid), n)];

        if(t_a[tid][0]!=0){
            printf("repeat:%d blockIdx:%d tid:%d ====a===%f\n",repeat,blockIdx.x,tid,t_a[tid][0]);
        }
        if(t_b[tid][0]!=0){
            printf("repeat:%d blockIdx:%d tid:%d ====b===%f\n",repeat,blockIdx.y,tid,t_b[tid][0]);
        }
        __syncthreads();
        

        for (int i = 0; i <  batch; i++)
        {
            for (int j = 0; j < batch; j++)
            {
                cal_c[i][j] += t_a[batch * get_r(tid/batch,2) + j][0] * t_b[batch * get_c(tid/batch,2) + i][0];
           
            }
        }
        __syncthreads();

        printf("tc :\n");
        for (int j = 0; j <  batch; j++)
        {
            for (int i = 0; i < batch; i++)
            {
                printf("tid:%d  = %f ", tid, cal_c[i][j]);
               
            }
            printf("\n");
            
        }
    }

    for (int i = 0; i < batch; i++)
    {
        for (int j = 0; j < batch; j++)
        {
            c[p(batch * index_x + j, batch * index_y + i , n)] = cal_c[i][j];
            printf("tid %d p:%d n: %d r: %d, c: %d val: %f \n", tid, p(batch * index_x + j, batch * index_y + i , n), n, batch * index_x + j, batch * index_y + i, cal_c[i][j]);
        }
        //  printf("\n");
    }
    
    __syncthreads();
    if(tid == 1){
        for(int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                printf("%f ", c[p(i,j,n)]);
            }
            printf("\n");
        }
    }

}





__global__ void sgemm(data_type *a, data_type *b, data_type *c, int n){
    
    // Define variables.
    int row = threadIdx.y + blockIdx.y * 4;
    int col = threadIdx.x + blockIdx.x * 4;
    int acc = 0;


    // Define shared memories.
    __shared__ data_type a_tile[4][4];
    __shared__ data_type b_tile[4][4];
    unsigned int tid = threadIdx.x;
    
    printf("tid = %d\n",tid);
 
    for (int t = 0; t < (n-1) / 4 + 1; t++){

        if ((row < 4) && (t * 4 + threadIdx.x < n))
        {
            a_tile[threadIdx.y][threadIdx.x] = a[row * n + t * 4 + threadIdx.x];
        }
        else{
            a_tile[threadIdx.y][threadIdx.x] = 0;
        }
        
        if ((col < 4) && (t * 4 + threadIdx.y < n))
        {
            b_tile[threadIdx.y][threadIdx.x] = b[col * n + (t * 4 + threadIdx.y)];
        }
        else{
            b_tile[threadIdx.y][threadIdx.x] = 0;
        }


        for (int i = 0; i < 4; i++)
        {
            acc += a_tile[threadIdx.y][i] * b_tile[i][threadIdx.x];
            __syncthreads();
        }
    }
    if (row < n && col < n)
    {
        c[row * n + col] = acc;

    }
}







 

    int N, nBytes;
    data_type  *A, *B, *C;
    int start_n = 0;
    int step_n = 2;
    int repeat_n = 10;
    int end_n = start_n + (repeat_n * step_n);


    for (int repeat_t = start_n; repeat_t <= end_n; repeat_t += step_n){

        // Initialize cuda event
        cudaEvent_t start, end;
        cudaEventCreate(&start);
        cudaEventCreate(&end);

        // Memory size assignment
        N = repeat_t;
        nBytes = N * N * sizeof(data_type);

        // Allocate memory of the host to store data.
        A = (data_type*)malloc(nBytes);
        B = (data_type*)malloc(nBytes);
        C = (data_type*)malloc(nBytes);

        for (int i = 0; i < N * N; i++)
        {
            A[i] = i;
            B[i] = i * 2;
            C[i] = 0.0;
        }

        // Allocate memory of the device to store data.
        data_type *d_A, *d_B, *d_C;
        cudaMalloc((void**)&d_A, nBytes);
        cudaMalloc((void**)&d_B, nBytes);
        cudaMalloc((void**)&d_C, nBytes);

        // Copy data from host to device.
        cudaMemcpy((void*)d_A, (void*)A, nBytes, cudaMemcpyHostToDevice);
        cudaMemcpy((void*)d_B, (void*)B, nBytes, cudaMemcpyHostToDevice);
        cudaMemcpy((void*)d_C, (void*)C, nBytes, cudaMemcpyHostToDevice);

        // Define the configuration.
        dim3 blockSize(block_size);
        dim3 gridSize((N + (batch * 16) - 1) / (batch * 16),(N + (batch * 16) - 1) / (batch * 16));
        // printf("%d",gridSize.x);

        //Start timer.
        cudaEventRecord(start);

        // Run the kernel.
        sgemm1 <<< gridSize, blockSize >>>(d_A, d_B, d_C, N);

        // End timer, Calculate performance.
        cudaEventRecord(end);
        cudaEventSynchronize(start);
        cudaEventSynchronize(end);
        float elapsedtime = 0.0;
        double flops;
        cudaEventElapsedTime(&elapsedtime, start, end);
        flops = (double)((2 * pow(N, 3.0) - pow(N, 2.0))) / (double)elapsedtime;
        flops /= 1000000.0;

        // Copy the result from device to host.
        cudaMemcpy((void*)C, (void*)d_C, nBytes, cudaMemcpyDeviceToHost);

        
        for(int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    printf("%f ", A[p(i,j,N)]);
                }
                printf("\n");
            }
            printf("\n\n");

        for(int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    printf("%f ", B[p(i,j,N)]);
                }
                printf("\n");
            }
            printf("\n\n");
        for(int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    printf("%f ", C[p(i,j,N)]);
                }
                printf("\n");
            }

        printf("------------------------\n");
        printf("Time spent: %f ms\n", elapsedtime);
        printf("Performance: %f GFLOPS", flops);
        printf("\n====================\n\n");

        // Release memory on device.
        cudaFree(d_A);
        cudaFree(d_B);
        cudaFree(d_C);

         // Release memory on host.
        free(A);
        free(B);
        free(C);

        
    }   

}




        // for(int i = 0; i < N; i++)
        //     {
        //         for (int j = 0; j < N; j++)
        //         {
        //             printf("%f ", A[position(i,j,N)]);
        //         }
        //         printf("\n");
        //     }
        //     printf("\n\n");

        // for(int i = 0; i < N; i++)
        //     {
        //         for (int j = 0; j < N; j++)
        //         {
        //             printf("%f ", B[position(i,j,N)]);
        //         }
        //         printf("\n");
        //     }
        //     printf("\n\n");
        // for(int i = 0; i < N; i++)
        //     {
        //         for (int j = 0; j < N; j++)
        //         {
        //             printf("%f ", C[position(i,j,N)]);
        //         }
        //         printf("\n");
        //     }
        