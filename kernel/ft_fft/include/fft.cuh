#include <stdio.h>
#include <math_constants.h>
#define M_PI 3.14159265358979312f
#define MY_SUB(a, b, c) c.x = a.x - b.x; c.y = a.y - b.y;
#define MY_ADD(a, b, c) c.x = a.x + b.x; c.y = a.y + b.y;
#define MY_MUL(a, b, c) c.x = a.x * b.x - a.y * b.y; c.y = a.y * b.x + a.x * b.y;
#define MY_MUL_REPLACE(a, b, c, d) d.x = a.x * b.x - a.y * b.y; d.y = a.y * b.x + a.x * b.y; c = d;
#define MY_ANGLE2COMPLEX(angle, a) a.x = __cosf(angle); a.y =  __sinf(angle);



__global__ void ft_fft(int N, float2 * data, int ns, int k ){
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
    cufftComplex v[2];
    float angle = -2 * CUDART_PI_F * (j % ns) / (ns * R);
    for(int r = 0; r < R; ++r){
        v[r] =  data0[j+r*N/R];
        v[r] = cuCmulf(v[r], make_cuComplex(cosf(r*angle), sinf(r*angle)));
    }
    cufftComplex tmp = v[0];
    v[0] = cuCaddf(tmp, v[1]);
    v[1] = cuCsubf(tmp, v[1]);
    if (false){
        int idxD = (tx / ns)*R + (tx % ns), stride = 1;
        float* sr = sa, *si = sa + blockDim.x * R;
        for(int r = 0; r < R; r++) {
            int i = (idxD + r * ns) * stride;
            sr[i] = v[r].x;
            si[i] = v[r].y; 
        }
        __syncthreads();
        for(int r = 0; r < R; r++) {
            int i = (tx + r * blockDim.x) * stride;
            v[r].x = sr[i];
            v[r].y = si[i];
        }
        idxD = bx * R * blockDim.x + tx;
        for(int r = 0; r < R; r++) 
            data1[idxD + r * blockDim.x] = v[r];
    }
    else{
        int idxD = (j / ns) * ns * R + (j % ns);
        for(int r = 0; r < R; ++r){
            data1[idxD + r * ns] = v[r];
        }
    }
}

__global__ void fft_small(int N, float2* input, int ns, int k){




}

__global__ void __launch_bounds__(1) radix2_exp2 (int N, float2* input, int ns){
    float2 x[4], tmp[4], tmp1, tmp2;
    *(float4*)x = *(float4*)input;
    *(float4*)(x + 2) = *(float4*)(input + 2);
    // printf("%d\n", N);
    // printf("%f+%f i\n", input[0].x, input[0].y);
    // printf("%f+%f i\n", input[1].x, input[1].y);
    // printf("%f+%f i\n", input[2].x, input[2].y);
    // printf("%f+%f i\n", input[3].x, input[3].y);
    
    MY_ADD(x[0], x[2], tmp[0]);
    MY_SUB(x[0], x[2], tmp[1]);

    MY_ADD(x[1], x[3], tmp[2]);
    MY_SUB(x[1], x[3], tmp[3]);
    
    MY_ANGLE2COMPLEX(0, tmp2);
    MY_MUL_REPLACE(tmp[2], tmp2, tmp[2], tmp1);
    MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
    MY_MUL_REPLACE(tmp[3], tmp2, tmp[3], tmp1);

    x[0] = tmp[0];
    x[1] = tmp[1];
    x[2] = tmp[2];
    x[3] = tmp[3];

    MY_ADD(x[0], x[2], tmp[0]);
    MY_SUB(x[0], x[2], tmp[2]);

    MY_ADD(x[1], x[3], tmp[1]);
    MY_SUB(x[1], x[3], tmp[3]);

    *(float4*)input = *(float4*)tmp;
    *(float4*)(input + 2) = *(float4*)(tmp + 2);
        
}