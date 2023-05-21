extern __shared__ float shared[];
__global__ void __launch_bounds__(64) fft_radix2_logN9(float2* inputs, float2* outputs) {

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
    int N = 512;
    int __id[8];
    float2 tmp;
    float2 tmp_angle, tmp_angle_rot;
    int j;
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
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
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
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
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
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    if(tx==0)printf("################### syncthreads ####################\n");
    #endif			
        
    temp_0 = sdata[((0 * blockDim.x + tx) / 16) * 17 +
                        ((0 * blockDim.x + tx) % 16)];
    __id[0] = tx + 0 * 64;
    
    temp_1 = sdata[((1 * blockDim.x + tx) / 16) * 17 +
                        ((1 * blockDim.x + tx) % 16)];
    __id[1] = tx + 1 * 64;
    
    temp_2 = sdata[((2 * blockDim.x + tx) / 16) * 17 +
                        ((2 * blockDim.x + tx) % 16)];
    __id[2] = tx + 2 * 64;
    
    temp_3 = sdata[((3 * blockDim.x + tx) / 16) * 17 +
                        ((3 * blockDim.x + tx) % 16)];
    __id[3] = tx + 3 * 64;
    
    temp_4 = sdata[((4 * blockDim.x + tx) / 16) * 17 +
                        ((4 * blockDim.x + tx) % 16)];
    __id[4] = tx + 4 * 64;
    
    temp_5 = sdata[((5 * blockDim.x + tx) / 16) * 17 +
                        ((5 * blockDim.x + tx) % 16)];
    __id[5] = tx + 5 * 64;
    
    temp_6 = sdata[((6 * blockDim.x + tx) / 16) * 17 +
                        ((6 * blockDim.x + tx) % 16)];
    __id[6] = tx + 6 * 64;
    
    temp_7 = sdata[((7 * blockDim.x + tx) / 16) * 17 +
                        ((7 * blockDim.x + tx) % 16)];
    __id[7] = tx + 7 * 64;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 8;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
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
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
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
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
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
    
    __syncthreads();
    
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
    #if defined(LOG_ON)
    if(tx==0)printf("################### syncthreads ####################\n");
    #endif			
        
    temp_0 = sdata[((0 * blockDim.x + tx) / 16) * 17 +
                        ((0 * blockDim.x + tx) % 16)];
    __id[0] = tx + 0 * 64;
    
    temp_1 = sdata[((1 * blockDim.x + tx) / 16) * 17 +
                        ((1 * blockDim.x + tx) % 16)];
    __id[1] = tx + 1 * 64;
    
    temp_2 = sdata[((2 * blockDim.x + tx) / 16) * 17 +
                        ((2 * blockDim.x + tx) % 16)];
    __id[2] = tx + 2 * 64;
    
    temp_3 = sdata[((3 * blockDim.x + tx) / 16) * 17 +
                        ((3 * blockDim.x + tx) % 16)];
    __id[3] = tx + 3 * 64;
    
    temp_4 = sdata[((4 * blockDim.x + tx) / 16) * 17 +
                        ((4 * blockDim.x + tx) % 16)];
    __id[4] = tx + 4 * 64;
    
    temp_5 = sdata[((5 * blockDim.x + tx) / 16) * 17 +
                        ((5 * blockDim.x + tx) % 16)];
    __id[5] = tx + 5 * 64;
    
    temp_6 = sdata[((6 * blockDim.x + tx) / 16) * 17 +
                        ((6 * blockDim.x + tx) % 16)];
    __id[6] = tx + 6 * 64;
    
    temp_7 = sdata[((7 * blockDim.x + tx) / 16) * 17 +
                        ((7 * blockDim.x + tx) % 16)];
    __id[7] = tx + 7 * 64;
    
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 64;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
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
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 128;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 128;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 128;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 128;
    
    n_global *= 2;
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 256;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    
    n_global *= 2;
    outputs[__id[0]] = temp_0;
    outputs[__id[4]] = temp_4;
    outputs[__id[2]] = temp_2;
    outputs[__id[6]] = temp_6;
    outputs[__id[1]] = temp_1;
    outputs[__id[5]] = temp_5;
    outputs[__id[3]] = temp_3;
    outputs[__id[7]] = temp_7;
    
    }
