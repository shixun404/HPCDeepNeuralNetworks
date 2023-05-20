extern __shared__ float shared[];
__global__ void __launch_bounds__(32) fft_radix2_logN8(float2* inputs, float2* outputs) {

    float2 temp_0;
    float2 temp_1;
    float2 temp_2;
    float2 temp_3;
    float2 temp_4;
    float2 temp_5;
    float2 temp_6;
    float2 temp_7;
    
    float2* sdata = (float2*)shared;
    int tx = threadIdx.x;
    int N = 256;
    int __id[8];
    float2 tmp;
    float2 tmp_angle;
    float j;
    int k;
    int tmp_id;
    int n = 1, n_global = 1;
    
    temp_0 = inputs[0 * blockDim.x + tx];
    temp_1 = inputs[1 * blockDim.x + tx];
    temp_2 = inputs[2 * blockDim.x + tx];
    temp_3 = inputs[3 * blockDim.x + tx];
    temp_4 = inputs[4 * blockDim.x + tx];
    temp_5 = inputs[5 * blockDim.x + tx];
    temp_6 = inputs[6 * blockDim.x + tx];
    temp_7 = inputs[7 * blockDim.x + tx];
    
    __id[0] = 0 * blockDim.x + tx;
    __id[1] = 1 * blockDim.x + tx;
    __id[2] = 2 * blockDim.x + tx;
    __id[3] = 3 * blockDim.x + tx;
    __id[4] = 4 * blockDim.x + tx;
    __id[5] = 5 * blockDim.x + tx;
    __id[6] = 6 * blockDim.x + tx;
    __id[7] = 7 * blockDim.x + tx;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  4, __id[4]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    j = 1;
    k = __id[5] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  5, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[6] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  6, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[7] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  7, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 1;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 1;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 1;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 1;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  4, __id[2]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    j = 1;
    k = __id[6] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  5, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[3] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  6, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[7] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  7, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 2;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 2;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 2;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 2;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  4, __id[1]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    j = 1;
    k = __id[5] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  5, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[3] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  6, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[7] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  7, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[1] = tmp_id + 4;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 4;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 4;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 4;
    
    n_global *= 2;
    
        sdata[(__id[0] / 16) * 17 + 
        (__id[0] % 16)] = temp_0;
        
        sdata[(__id[4] / 16) * 17 + 
        (__id[4] % 16)] = temp_4;
        
        sdata[(__id[2] / 16) * 17 + 
        (__id[2] % 16)] = temp_2;
        
        sdata[(__id[6] / 16) * 17 + 
        (__id[6] % 16)] = temp_6;
        
        sdata[(__id[1] / 16) * 17 + 
        (__id[1] % 16)] = temp_1;
        
        sdata[(__id[5] / 16) * 17 + 
        (__id[5] % 16)] = temp_5;
        
        sdata[(__id[3] / 16) * 17 + 
        (__id[3] % 16)] = temp_3;
        
        sdata[(__id[7] / 16) * 17 + 
        (__id[7] % 16)] = temp_7;
        __syncthreads();
        
        temp_0 = sdata[((0 * blockDim.x + tx) / 16) * 17 +
                          ((0 * blockDim.x + tx) % 16)];
        __id[0] = tx + 0 * 32;
        
        temp_1 = sdata[((1 * blockDim.x + tx) / 16) * 17 +
                          ((1 * blockDim.x + tx) % 16)];
        __id[1] = tx + 1 * 32;
        
        temp_2 = sdata[((2 * blockDim.x + tx) / 16) * 17 +
                          ((2 * blockDim.x + tx) % 16)];
        __id[2] = tx + 2 * 32;
        
        temp_3 = sdata[((3 * blockDim.x + tx) / 16) * 17 +
                          ((3 * blockDim.x + tx) % 16)];
        __id[3] = tx + 3 * 32;
        
        temp_4 = sdata[((4 * blockDim.x + tx) / 16) * 17 +
                          ((4 * blockDim.x + tx) % 16)];
        __id[4] = tx + 4 * 32;
        
        temp_5 = sdata[((5 * blockDim.x + tx) / 16) * 17 +
                          ((5 * blockDim.x + tx) % 16)];
        __id[5] = tx + 5 * 32;
        
        temp_6 = sdata[((6 * blockDim.x + tx) / 16) * 17 +
                          ((6 * blockDim.x + tx) % 16)];
        __id[6] = tx + 6 * 32;
        
        temp_7 = sdata[((7 * blockDim.x + tx) / 16) * 17 +
                          ((7 * blockDim.x + tx) % 16)];
        __id[7] = tx + 7 * 32;
        
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  4, __id[4]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    j = 1;
    k = __id[5] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  5, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[6] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  6, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[7] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  7, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 8;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 8;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 8;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 8;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  4, __id[2]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    j = 1;
    k = __id[6] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  5, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[3] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  6, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[7] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  7, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 16;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 16;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 16;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 16;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  4, __id[1]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    j = 1;
    k = __id[5] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  5, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[3] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  6, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[7] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  7, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[1] = tmp_id + 32;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 32;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 32;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 32;
    
    n_global *= 2;
    
        sdata[(__id[0] / 16) * 17 + 
        (__id[0] % 16)] = temp_0;
        
        sdata[(__id[4] / 16) * 17 + 
        (__id[4] % 16)] = temp_4;
        
        sdata[(__id[2] / 16) * 17 + 
        (__id[2] % 16)] = temp_2;
        
        sdata[(__id[6] / 16) * 17 + 
        (__id[6] % 16)] = temp_6;
        
        sdata[(__id[1] / 16) * 17 + 
        (__id[1] % 16)] = temp_1;
        
        sdata[(__id[5] / 16) * 17 + 
        (__id[5] % 16)] = temp_5;
        
        sdata[(__id[3] / 16) * 17 + 
        (__id[3] % 16)] = temp_3;
        
        sdata[(__id[7] / 16) * 17 + 
        (__id[7] % 16)] = temp_7;
        __syncthreads();
        
        temp_0 = sdata[((0 * blockDim.x + tx) / 16) * 17 +
                          ((0 * blockDim.x + tx) % 16)];
        __id[0] = tx + 0 * 32;
        
        temp_1 = sdata[((1 * blockDim.x + tx) / 16) * 17 +
                          ((1 * blockDim.x + tx) % 16)];
        __id[1] = tx + 1 * 32;
        
        temp_2 = sdata[((2 * blockDim.x + tx) / 16) * 17 +
                          ((2 * blockDim.x + tx) % 16)];
        __id[2] = tx + 2 * 32;
        
        temp_3 = sdata[((3 * blockDim.x + tx) / 16) * 17 +
                          ((3 * blockDim.x + tx) % 16)];
        __id[3] = tx + 3 * 32;
        
        temp_4 = sdata[((4 * blockDim.x + tx) / 16) * 17 +
                          ((4 * blockDim.x + tx) % 16)];
        __id[4] = tx + 4 * 32;
        
        temp_5 = sdata[((5 * blockDim.x + tx) / 16) * 17 +
                          ((5 * blockDim.x + tx) % 16)];
        __id[5] = tx + 5 * 32;
        
        temp_6 = sdata[((6 * blockDim.x + tx) / 16) * 17 +
                          ((6 * blockDim.x + tx) % 16)];
        __id[6] = tx + 6 * 32;
        
        temp_7 = sdata[((7 * blockDim.x + tx) / 16) * 17 +
                          ((7 * blockDim.x + tx) % 16)];
        __id[7] = tx + 7 * 32;
        
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  4, __id[4]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    j = 1;
    k = __id[5] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  5, __id[5]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[6] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  6, __id[6]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[7] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  7, __id[7]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 64;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 64;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 64;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 64;
    
    n_global *= 2;
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  4, __id[2]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    j = 1;
    k = __id[3] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  5, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[6] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  6, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[7] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  7, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    
    n_global *= 2;
    outputs[__id[0]] = temp_0;
    outputs[__id[1]] = temp_1;
    outputs[__id[4]] = temp_4;
    outputs[__id[5]] = temp_5;
    outputs[__id[2]] = temp_2;
    outputs[__id[3]] = temp_3;
    outputs[__id[6]] = temp_6;
    outputs[__id[7]] = temp_7;
    
    }
