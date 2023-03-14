
#include <stdio.h>
#include <math_constants.h>
__global__  void ft_fft(int N, cufftComplex * data ){
    int tx = threadIdx.x;
    int bx = blockIdx.x;
    int block_dim = blockDim.x;
    int R = 2;
    int j = tx + bx * block_dim; 
    cufftComplex * data0;
    cufftComplex * data1;
    if(j >= N / R) return;
    int k = 0;
    for(int ns = 1; ns < N; ns *= R){
        data0 = data + N * (k % 2);
        data1 = data + N * ((k + 1) % 2);
        k++;
        cufftComplex v[2];
        float angle = -2 * CUDART_PI_F * (j % ns) / (ns * R);
        for(int r = 0; r < R; ++r){
            v[r] =  data0[j+r*N/R];
            v[r] = cuCmulf(v[r], make_cuComplex(cosf(r*angle), sinf(r*angle)));
        }
        cufftComplex tmp = v[0];
        v[0] = cuCaddf(tmp, v[1]);
        v[1] = cuCsubf(tmp, v[1]);

        int idxD = (j / ns) * ns * R + (j % ns);

        for(int r = 0; r < R; ++r){
            data1[idxD + r * ns] = v[r];
        }
        __syncthreads();
    }
    
}