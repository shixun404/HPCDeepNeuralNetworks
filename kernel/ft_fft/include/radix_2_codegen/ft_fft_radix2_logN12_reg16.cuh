extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_radix2_logN12(float2* inputs, float2* outputs) {

    float2 temp_0;
    float2 temp_1;
    float2 temp_2;
    float2 temp_3;
    float2 temp_4;
    float2 temp_5;
    float2 temp_6;
    float2 temp_7;
    float2 temp_8;
    float2 temp_9;
    float2 temp_10;
    float2 temp_11;
    float2 temp_12;
    float2 temp_13;
    float2 temp_14;
    float2 temp_15;
    
    float2* sdata = (float2*)shared;
    int tx = threadIdx.x;
    int N = 4096;
    int __id[16];
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
    temp_8 = inputs[8 * blockDim.x + tx];
    temp_9 = inputs[9 * blockDim.x + tx];
    temp_10 = inputs[10 * blockDim.x + tx];
    temp_11 = inputs[11 * blockDim.x + tx];
    temp_12 = inputs[12 * blockDim.x + tx];
    temp_13 = inputs[13 * blockDim.x + tx];
    temp_14 = inputs[14 * blockDim.x + tx];
    temp_15 = inputs[15 * blockDim.x + tx];
    
    __id[0] = 0 * blockDim.x + tx;
    __id[1] = 1 * blockDim.x + tx;
    __id[2] = 2 * blockDim.x + tx;
    __id[3] = 3 * blockDim.x + tx;
    __id[4] = 4 * blockDim.x + tx;
    __id[5] = 5 * blockDim.x + tx;
    __id[6] = 6 * blockDim.x + tx;
    __id[7] = 7 * blockDim.x + tx;
    __id[8] = 8 * blockDim.x + tx;
    __id[9] = 9 * blockDim.x + tx;
    __id[10] = 10 * blockDim.x + tx;
    __id[11] = 11 * blockDim.x + tx;
    __id[12] = 12 * blockDim.x + tx;
    __id[13] = 13 * blockDim.x + tx;
    __id[14] = 14 * blockDim.x + tx;
    __id[15] = 15 * blockDim.x + tx;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[8]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    j = 1;
    k = __id[9] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[9]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    j = 1;
    k = __id[10] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[10]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    j = 1;
    k = __id[11] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[11]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[12] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[12]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    j = 1;
    k = __id[13] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[13]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[14] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[14]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[15] % 1;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_8, temp_0);
    MY_SUB(tmp, temp_8, temp_8);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[8] = tmp_id + 1;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_9, temp_1);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[9] = tmp_id + 1;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_10, temp_2);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[10] = tmp_id + 1;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_11, temp_3);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[11] = tmp_id + 1;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_12, temp_4);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[12] = tmp_id + 1;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_13, temp_5);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[13] = tmp_id + 1;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_14, temp_6);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[14] = tmp_id + 1;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_15, temp_7);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[15] = tmp_id + 1;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[4]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    j = 1;
    k = __id[12] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[12]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    j = 1;
    k = __id[5] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[13] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[13]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[6] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[14] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[14]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[7] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 2;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 2;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_12, temp_8);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[12] = tmp_id + 2;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 2;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_13, temp_9);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[13] = tmp_id + 2;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 2;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_14, temp_10);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[14] = tmp_id + 2;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 2;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_15, temp_11);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[15] = tmp_id + 2;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[2]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    j = 1;
    k = __id[10] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[10]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    j = 1;
    k = __id[6] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[14] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[14]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[3] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[11] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[11]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[7] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 4;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 4;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_10, temp_8);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[10] = tmp_id + 4;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 4;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_14, temp_12);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[14] = tmp_id + 4;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 4;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_11, temp_9);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[11] = tmp_id + 4;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 4;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_15, temp_13);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[15] = tmp_id + 4;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[1]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    j = 1;
    k = __id[9] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[9]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    j = 1;
    k = __id[5] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[13] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[13]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[3] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[11] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[11]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[7] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 8;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[1] = tmp_id + 8;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[9] = tmp_id + 8;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 8;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[13] = tmp_id + 8;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 8;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[11] = tmp_id + 8;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 8;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[15] = tmp_id + 8;
    
    n_global *= 2;
    
        sdata[(__id[0] / 16) * 17 + 
        (__id[0] % 16)] = temp_0;
        
        sdata[(__id[8] / 16) * 17 + 
        (__id[8] % 16)] = temp_8;
        
        sdata[(__id[4] / 16) * 17 + 
        (__id[4] % 16)] = temp_4;
        
        sdata[(__id[12] / 16) * 17 + 
        (__id[12] % 16)] = temp_12;
        
        sdata[(__id[2] / 16) * 17 + 
        (__id[2] % 16)] = temp_2;
        
        sdata[(__id[10] / 16) * 17 + 
        (__id[10] % 16)] = temp_10;
        
        sdata[(__id[6] / 16) * 17 + 
        (__id[6] % 16)] = temp_6;
        
        sdata[(__id[14] / 16) * 17 + 
        (__id[14] % 16)] = temp_14;
        
        sdata[(__id[1] / 16) * 17 + 
        (__id[1] % 16)] = temp_1;
        
        sdata[(__id[9] / 16) * 17 + 
        (__id[9] % 16)] = temp_9;
        
        sdata[(__id[5] / 16) * 17 + 
        (__id[5] % 16)] = temp_5;
        
        sdata[(__id[13] / 16) * 17 + 
        (__id[13] % 16)] = temp_13;
        
        sdata[(__id[3] / 16) * 17 + 
        (__id[3] % 16)] = temp_3;
        
        sdata[(__id[11] / 16) * 17 + 
        (__id[11] % 16)] = temp_11;
        
        sdata[(__id[7] / 16) * 17 + 
        (__id[7] % 16)] = temp_7;
        
        sdata[(__id[15] / 16) * 17 + 
        (__id[15] % 16)] = temp_15;
        __syncthreads();
        
        temp_0 = sdata[((0 * blockDim.x + tx) / 16) * 17 +
                          ((0 * blockDim.x + tx) % 16)];
        __id[0] = tx + 0 * 256;
        
        temp_1 = sdata[((1 * blockDim.x + tx) / 16) * 17 +
                          ((1 * blockDim.x + tx) % 16)];
        __id[1] = tx + 1 * 256;
        
        temp_2 = sdata[((2 * blockDim.x + tx) / 16) * 17 +
                          ((2 * blockDim.x + tx) % 16)];
        __id[2] = tx + 2 * 256;
        
        temp_3 = sdata[((3 * blockDim.x + tx) / 16) * 17 +
                          ((3 * blockDim.x + tx) % 16)];
        __id[3] = tx + 3 * 256;
        
        temp_4 = sdata[((4 * blockDim.x + tx) / 16) * 17 +
                          ((4 * blockDim.x + tx) % 16)];
        __id[4] = tx + 4 * 256;
        
        temp_5 = sdata[((5 * blockDim.x + tx) / 16) * 17 +
                          ((5 * blockDim.x + tx) % 16)];
        __id[5] = tx + 5 * 256;
        
        temp_6 = sdata[((6 * blockDim.x + tx) / 16) * 17 +
                          ((6 * blockDim.x + tx) % 16)];
        __id[6] = tx + 6 * 256;
        
        temp_7 = sdata[((7 * blockDim.x + tx) / 16) * 17 +
                          ((7 * blockDim.x + tx) % 16)];
        __id[7] = tx + 7 * 256;
        
        temp_8 = sdata[((8 * blockDim.x + tx) / 16) * 17 +
                          ((8 * blockDim.x + tx) % 16)];
        __id[8] = tx + 8 * 256;
        
        temp_9 = sdata[((9 * blockDim.x + tx) / 16) * 17 +
                          ((9 * blockDim.x + tx) % 16)];
        __id[9] = tx + 9 * 256;
        
        temp_10 = sdata[((10 * blockDim.x + tx) / 16) * 17 +
                          ((10 * blockDim.x + tx) % 16)];
        __id[10] = tx + 10 * 256;
        
        temp_11 = sdata[((11 * blockDim.x + tx) / 16) * 17 +
                          ((11 * blockDim.x + tx) % 16)];
        __id[11] = tx + 11 * 256;
        
        temp_12 = sdata[((12 * blockDim.x + tx) / 16) * 17 +
                          ((12 * blockDim.x + tx) % 16)];
        __id[12] = tx + 12 * 256;
        
        temp_13 = sdata[((13 * blockDim.x + tx) / 16) * 17 +
                          ((13 * blockDim.x + tx) % 16)];
        __id[13] = tx + 13 * 256;
        
        temp_14 = sdata[((14 * blockDim.x + tx) / 16) * 17 +
                          ((14 * blockDim.x + tx) % 16)];
        __id[14] = tx + 14 * 256;
        
        temp_15 = sdata[((15 * blockDim.x + tx) / 16) * 17 +
                          ((15 * blockDim.x + tx) % 16)];
        __id[15] = tx + 15 * 256;
        
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[8]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    j = 1;
    k = __id[9] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[9]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    j = 1;
    k = __id[10] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[10]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    j = 1;
    k = __id[11] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[11]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[12] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[12]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    j = 1;
    k = __id[13] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[13]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[14] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[14]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[15] % 16;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_8, temp_0);
    MY_SUB(tmp, temp_8, temp_8);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[8] = tmp_id + 16;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_9, temp_1);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[9] = tmp_id + 16;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_10, temp_2);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[10] = tmp_id + 16;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_11, temp_3);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[11] = tmp_id + 16;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_12, temp_4);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[12] = tmp_id + 16;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_13, temp_5);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[13] = tmp_id + 16;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_14, temp_6);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[14] = tmp_id + 16;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_15, temp_7);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[15] = tmp_id + 16;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[4]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    j = 1;
    k = __id[12] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[12]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    j = 1;
    k = __id[5] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[13] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[13]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[6] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[14] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[14]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[7] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 32;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 32;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_12, temp_8);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[12] = tmp_id + 32;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 32;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_13, temp_9);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[13] = tmp_id + 32;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 32;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_14, temp_10);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[14] = tmp_id + 32;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 32;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_15, temp_11);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[15] = tmp_id + 32;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[2]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    j = 1;
    k = __id[10] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[10]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    j = 1;
    k = __id[6] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[6]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[14] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[14]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[3] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[11] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[11]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[7] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 64;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 64;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_10, temp_8);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[10] = tmp_id + 64;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 64;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_14, temp_12);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[14] = tmp_id + 64;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 64;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_11, temp_9);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[11] = tmp_id + 64;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 64;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_15, temp_13);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[15] = tmp_id + 64;
    
    n_global *= 2;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[1]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    j = 1;
    k = __id[9] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[9]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    j = 1;
    k = __id[5] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[13] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[13]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[3] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[11] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[11]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[7] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 128;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[1] = tmp_id + 128;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[9] = tmp_id + 128;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 128;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[13] = tmp_id + 128;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 128;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[11] = tmp_id + 128;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 128;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[15] = tmp_id + 128;
    
    n_global *= 2;
    
        sdata[(__id[0] / 16) * 17 + 
        (__id[0] % 16)] = temp_0;
        
        sdata[(__id[8] / 16) * 17 + 
        (__id[8] % 16)] = temp_8;
        
        sdata[(__id[4] / 16) * 17 + 
        (__id[4] % 16)] = temp_4;
        
        sdata[(__id[12] / 16) * 17 + 
        (__id[12] % 16)] = temp_12;
        
        sdata[(__id[2] / 16) * 17 + 
        (__id[2] % 16)] = temp_2;
        
        sdata[(__id[10] / 16) * 17 + 
        (__id[10] % 16)] = temp_10;
        
        sdata[(__id[6] / 16) * 17 + 
        (__id[6] % 16)] = temp_6;
        
        sdata[(__id[14] / 16) * 17 + 
        (__id[14] % 16)] = temp_14;
        
        sdata[(__id[1] / 16) * 17 + 
        (__id[1] % 16)] = temp_1;
        
        sdata[(__id[9] / 16) * 17 + 
        (__id[9] % 16)] = temp_9;
        
        sdata[(__id[5] / 16) * 17 + 
        (__id[5] % 16)] = temp_5;
        
        sdata[(__id[13] / 16) * 17 + 
        (__id[13] % 16)] = temp_13;
        
        sdata[(__id[3] / 16) * 17 + 
        (__id[3] % 16)] = temp_3;
        
        sdata[(__id[11] / 16) * 17 + 
        (__id[11] % 16)] = temp_11;
        
        sdata[(__id[7] / 16) * 17 + 
        (__id[7] % 16)] = temp_7;
        
        sdata[(__id[15] / 16) * 17 + 
        (__id[15] % 16)] = temp_15;
        __syncthreads();
        
        temp_0 = sdata[((0 * blockDim.x + tx) / 16) * 17 +
                          ((0 * blockDim.x + tx) % 16)];
        __id[0] = tx + 0 * 256;
        
        temp_1 = sdata[((1 * blockDim.x + tx) / 16) * 17 +
                          ((1 * blockDim.x + tx) % 16)];
        __id[1] = tx + 1 * 256;
        
        temp_2 = sdata[((2 * blockDim.x + tx) / 16) * 17 +
                          ((2 * blockDim.x + tx) % 16)];
        __id[2] = tx + 2 * 256;
        
        temp_3 = sdata[((3 * blockDim.x + tx) / 16) * 17 +
                          ((3 * blockDim.x + tx) % 16)];
        __id[3] = tx + 3 * 256;
        
        temp_4 = sdata[((4 * blockDim.x + tx) / 16) * 17 +
                          ((4 * blockDim.x + tx) % 16)];
        __id[4] = tx + 4 * 256;
        
        temp_5 = sdata[((5 * blockDim.x + tx) / 16) * 17 +
                          ((5 * blockDim.x + tx) % 16)];
        __id[5] = tx + 5 * 256;
        
        temp_6 = sdata[((6 * blockDim.x + tx) / 16) * 17 +
                          ((6 * blockDim.x + tx) % 16)];
        __id[6] = tx + 6 * 256;
        
        temp_7 = sdata[((7 * blockDim.x + tx) / 16) * 17 +
                          ((7 * blockDim.x + tx) % 16)];
        __id[7] = tx + 7 * 256;
        
        temp_8 = sdata[((8 * blockDim.x + tx) / 16) * 17 +
                          ((8 * blockDim.x + tx) % 16)];
        __id[8] = tx + 8 * 256;
        
        temp_9 = sdata[((9 * blockDim.x + tx) / 16) * 17 +
                          ((9 * blockDim.x + tx) % 16)];
        __id[9] = tx + 9 * 256;
        
        temp_10 = sdata[((10 * blockDim.x + tx) / 16) * 17 +
                          ((10 * blockDim.x + tx) % 16)];
        __id[10] = tx + 10 * 256;
        
        temp_11 = sdata[((11 * blockDim.x + tx) / 16) * 17 +
                          ((11 * blockDim.x + tx) % 16)];
        __id[11] = tx + 11 * 256;
        
        temp_12 = sdata[((12 * blockDim.x + tx) / 16) * 17 +
                          ((12 * blockDim.x + tx) % 16)];
        __id[12] = tx + 12 * 256;
        
        temp_13 = sdata[((13 * blockDim.x + tx) / 16) * 17 +
                          ((13 * blockDim.x + tx) % 16)];
        __id[13] = tx + 13 * 256;
        
        temp_14 = sdata[((14 * blockDim.x + tx) / 16) * 17 +
                          ((14 * blockDim.x + tx) % 16)];
        __id[14] = tx + 14 * 256;
        
        temp_15 = sdata[((15 * blockDim.x + tx) / 16) * 17 +
                          ((15 * blockDim.x + tx) % 16)];
        __id[15] = tx + 15 * 256;
        
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 256;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[8]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    j = 1;
    k = __id[9] % 256;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[9]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    j = 1;
    k = __id[10] % 256;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[10]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    j = 1;
    k = __id[11] % 256;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[11]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[12] % 256;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[12]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    j = 1;
    k = __id[13] % 256;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[13]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[14] % 256;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[14]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[15] % 256;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_8, temp_0);
    MY_SUB(tmp, temp_8, temp_8);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[8] = tmp_id + 256;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_9, temp_1);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[9] = tmp_id + 256;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_10, temp_2);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[10] = tmp_id + 256;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_11, temp_3);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[11] = tmp_id + 256;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_12, temp_4);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[12] = tmp_id + 256;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_13, temp_5);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[13] = tmp_id + 256;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_14, temp_6);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[14] = tmp_id + 256;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_15, temp_7);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[15] = tmp_id + 256;
    
    n_global *= 2;
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 512;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[4]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    j = 1;
    k = __id[12] % 512;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[12]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    j = 1;
    k = __id[5] % 512;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[5]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[13] % 512;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[13]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[6] % 512;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[6]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[14] % 512;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[14]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[7] % 512;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 512;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 512;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_12, temp_8);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[12] = tmp_id + 512;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 512;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_13, temp_9);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[13] = tmp_id + 512;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 512;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_14, temp_10);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[14] = tmp_id + 512;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 512;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_15, temp_11);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[15] = tmp_id + 512;
    
    n_global *= 2;
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 1024;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[2]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    j = 1;
    k = __id[10] % 1024;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[10]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    j = 1;
    k = __id[6] % 1024;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[6]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    j = 1;
    k = __id[14] % 1024;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[14]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    j = 1;
    k = __id[3] % 1024;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[3]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[11] % 1024;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[11]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[7] % 1024;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 1024;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 1024;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_10, temp_8);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[10] = tmp_id + 1024;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 1024;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_14, temp_12);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[14] = tmp_id + 1024;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 1024;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_11, temp_9);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[11] = tmp_id + 1024;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 1024;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_15, temp_13);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[15] = tmp_id + 1024;
    
    n_global *= 2;
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 2048;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  8, __id[1]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    j = 1;
    k = __id[9] % 2048;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  9, __id[9]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    j = 1;
    k = __id[5] % 2048;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  10, __id[5]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    j = 1;
    k = __id[13] % 2048;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  11, __id[13]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    j = 1;
    k = __id[3] % 2048;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  12, __id[3]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    j = 1;
    k = __id[11] % 2048;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  13, __id[11]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    j = 1;
    k = __id[7] % 2048;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  14, __id[7]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    j = 1;
    k = __id[15] % 2048;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  15, __id[15]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    
    n_global *= 2;
    outputs[__id[0]] = temp_0;
    outputs[__id[8]] = temp_8;
    outputs[__id[4]] = temp_4;
    outputs[__id[12]] = temp_12;
    outputs[__id[2]] = temp_2;
    outputs[__id[10]] = temp_10;
    outputs[__id[6]] = temp_6;
    outputs[__id[14]] = temp_14;
    outputs[__id[1]] = temp_1;
    outputs[__id[9]] = temp_9;
    outputs[__id[5]] = temp_5;
    outputs[__id[13]] = temp_13;
    outputs[__id[3]] = temp_3;
    outputs[__id[11]] = temp_11;
    outputs[__id[7]] = temp_7;
    outputs[__id[15]] = temp_15;
    
    }
