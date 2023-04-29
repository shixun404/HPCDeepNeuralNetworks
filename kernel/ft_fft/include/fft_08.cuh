#include <stdio.h>
#include <math_constants.h>
__global__  void ft_fft(int N, cufftComplex * data, int ns, int k ){
    int tx = threadIdx.x;
    int bx = blockIdx.x;
    int block_dim = blockDim.x;
    int R = 2;
    int j = tx + bx * block_dim; 
    __shared__ float sa[256 * 2 * 2];
    cufftComplex * data0;
    cufftComplex * data1;
    if(j >= N / R) return;
    data0 = data + N * (k % 2);
    data1 = data + N * ((k + 1) % 2);
    // k++;
    cufftComplex v[2];
    float angle = -2 * CUDART_PI_F * (j % ns) / (ns * R);
    for(int r = 0; r < R; ++r){
        v[r] =  data0[j+r*N/R];
        v[r] = cuCmulf(v[r], make_cuComplex(cosf(r*angle), sinf(r*angle)));
    }
    cufftComplex tmp = v[0];
    v[0] = cuCaddf(tmp, v[1]);
    v[1] = cuCsubf(tmp, v[1]);

    // int idxD = (j / ns) * ns * R + (j % ns);

    // for(int r = 0; r < R; ++r){
    //     data1[idxD + r * ns] = v[r];
    // }
    int idxD = (t/ns)*R + (t%ns), stride = 1;
    float* sr = sa, *si = sa + blockDim.x * R;
    // exchange( v, R, 1, idxD,Ns, t,block_dim.x );
    for( int r=0, ; r<R; r++ ) {
        int i = (idxD + r * ns) * stride;
        (sr[i], si[i]) = v[r]; 
    }
    __syncthreads();
    for( r=0; r<R; r++ ) {
        int i = (t + r * blockDim.x) * stride;
        v[r] = (sr[i], si[i]);
    }
    idxD = bx * R * blockDim.x + t;
    for( int r=0; r<R; r++ ) 
        data1[idxD + r * blockDim.x] = v[r];
}

// void exchange( float2* v, int R, int stride, int idxD, int incD, int idxS, int incS ){
//     float* 
//     __syncthreads();
//     for( int r=0, ; r<R; r++ ) {
//         int i = (idxD + r*incD)*stride;
//         (sr[i], si[i]) = v[r]; 
//     }
//     __syncthreads();
//     for( r=0; r<R; r++ ) {
//         int i = (idxS + r*incS)*stride;
//         v[r] = (sr[i], si[i]);
//     }
// }
