__global__ void __launch_bounds__(1) radix2_exp6 (int N, float2* input, int ns){
    float2 x[64], tmp[64], tmp1, tmp2;
    
    #pragma unroll
    for(int i = 0; i < N; i += 2){
        *(float4*)(x + i) = *(float4*)(input + i);    
    }

    #pragma unroll
    for(int j = 1; j < N / 2; j *= 2){
        #pragma unroll
        for(int i = 0; i < N / 2; i+=1){
            MY_ADD(x[i], x[i + (N / 2)], tmp[(i % j) + (i / j) * j * 2]);
            MY_SUB(x[i], x[i + (N / 2)], tmp[(i % j) + (i / j) * j * 2 + j]);
        }

        #pragma unroll
        for(int i = (N / 2); i < N; i+=1){
            MY_ANGLE2COMPLEX(-M_PI * (float)(i % (j * 2)) / (float)(j * 2), tmp2);
            MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
        }

        #pragma unroll
        for(int i = 0; i < N; i+=1){
            x[i] = tmp[i];
        }
    }

    #pragma unroll
    for(int i = 0; i < (N / 2); i+=1){
        MY_ADD(x[i], x[i + (N / 2)], tmp[(i % (N / 2)) + (i / (N / 2)) * N]);
        MY_SUB(x[i], x[i + (N / 2)], tmp[(i % (N / 2)) + (i / (N / 2)) * N + (N / 2)]);
    }

    #pragma unroll
    for(int i = 0; i < N; i += 2){
        *(float4*)(input + i) = *(float4*)(tmp + i);    
    }
}