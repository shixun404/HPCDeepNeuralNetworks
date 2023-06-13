extern __shared__ float shared[];
    __global__ void __launch_bounds__(512) fft_radix2_logN18_2(float2* inputs, float2* outputs) {
    
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
        int ty = threadIdx.y;
        int bx = blockIdx.x;
        int N = 512;
        int __id[16];
        float2 tmp;
        float2 tmp_angle, tmp_angle_rot;
        int j;
        int k;
        int tmp_id;
        int n = 1, n_global = 1;
        
        
        temp_0 = inputs[((tx + 32 * ty + 0) % 512) + (((tx + 32 * ty + 0) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 0) % 512) + ((tx + 32 * ty + 0) / 512) * 512] = temp_0;
        
        temp_1 = inputs[((tx + 32 * ty + 512) % 512) + (((tx + 32 * ty + 512) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 512) % 512) + ((tx + 32 * ty + 512) / 512) * 512] = temp_1;
        
        temp_2 = inputs[((tx + 32 * ty + 1024) % 512) + (((tx + 32 * ty + 1024) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 1024) % 512) + ((tx + 32 * ty + 1024) / 512) * 512] = temp_2;
        
        temp_3 = inputs[((tx + 32 * ty + 1536) % 512) + (((tx + 32 * ty + 1536) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 1536) % 512) + ((tx + 32 * ty + 1536) / 512) * 512] = temp_3;
        
        temp_4 = inputs[((tx + 32 * ty + 2048) % 512) + (((tx + 32 * ty + 2048) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 2048) % 512) + ((tx + 32 * ty + 2048) / 512) * 512] = temp_4;
        
        temp_5 = inputs[((tx + 32 * ty + 2560) % 512) + (((tx + 32 * ty + 2560) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 2560) % 512) + ((tx + 32 * ty + 2560) / 512) * 512] = temp_5;
        
        temp_6 = inputs[((tx + 32 * ty + 3072) % 512) + (((tx + 32 * ty + 3072) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 3072) % 512) + ((tx + 32 * ty + 3072) / 512) * 512] = temp_6;
        
        temp_7 = inputs[((tx + 32 * ty + 3584) % 512) + (((tx + 32 * ty + 3584) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 3584) % 512) + ((tx + 32 * ty + 3584) / 512) * 512] = temp_7;
        
        temp_8 = inputs[((tx + 32 * ty + 4096) % 512) + (((tx + 32 * ty + 4096) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 4096) % 512) + ((tx + 32 * ty + 4096) / 512) * 512] = temp_8;
        
        temp_9 = inputs[((tx + 32 * ty + 4608) % 512) + (((tx + 32 * ty + 4608) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 4608) % 512) + ((tx + 32 * ty + 4608) / 512) * 512] = temp_9;
        
        temp_10 = inputs[((tx + 32 * ty + 5120) % 512) + (((tx + 32 * ty + 5120) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 5120) % 512) + ((tx + 32 * ty + 5120) / 512) * 512] = temp_10;
        
        temp_11 = inputs[((tx + 32 * ty + 5632) % 512) + (((tx + 32 * ty + 5632) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 5632) % 512) + ((tx + 32 * ty + 5632) / 512) * 512] = temp_11;
        
        temp_12 = inputs[((tx + 32 * ty + 6144) % 512) + (((tx + 32 * ty + 6144) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 6144) % 512) + ((tx + 32 * ty + 6144) / 512) * 512] = temp_12;
        
        temp_13 = inputs[((tx + 32 * ty + 6656) % 512) + (((tx + 32 * ty + 6656) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 6656) % 512) + ((tx + 32 * ty + 6656) / 512) * 512] = temp_13;
        
        temp_14 = inputs[((tx + 32 * ty + 7168) % 512) + (((tx + 32 * ty + 7168) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 7168) % 512) + ((tx + 32 * ty + 7168) / 512) * 512] = temp_14;
        
        temp_15 = inputs[((tx + 32 * ty + 7680) % 512) + (((tx + 32 * ty + 7680) / 512) + bx * 16) * 512];
        sdata[((tx + 32 * ty + 7680) % 512) + ((tx + 32 * ty + 7680) / 512) * 512] = temp_15;
        
        __syncthreads();
        temp_0 = sdata[(tx + 0 * 32) + ty * 512];
        temp_1 = sdata[(tx + 1 * 32) + ty * 512];
        temp_2 = sdata[(tx + 2 * 32) + ty * 512];
        temp_3 = sdata[(tx + 3 * 32) + ty * 512];
        temp_4 = sdata[(tx + 4 * 32) + ty * 512];
        temp_5 = sdata[(tx + 5 * 32) + ty * 512];
        temp_6 = sdata[(tx + 6 * 32) + ty * 512];
        temp_7 = sdata[(tx + 7 * 32) + ty * 512];
        temp_8 = sdata[(tx + 8 * 32) + ty * 512];
        temp_9 = sdata[(tx + 9 * 32) + ty * 512];
        temp_10 = sdata[(tx + 10 * 32) + ty * 512];
        temp_11 = sdata[(tx + 11 * 32) + ty * 512];
        temp_12 = sdata[(tx + 12 * 32) + ty * 512];
        temp_13 = sdata[(tx + 13 * 32) + ty * 512];
        temp_14 = sdata[(tx + 14 * 32) + ty * 512];
        temp_15 = sdata[(tx + 15 * 32) + ty * 512];
        
        __id[0] = 0 + tx;
        __id[1] = 32 + tx;
        __id[2] = 64 + tx;
        __id[3] = 96 + tx;
        __id[4] = 128 + tx;
        __id[5] = 160 + tx;
        __id[6] = 192 + tx;
        __id[7] = 224 + tx;
        __id[8] = 256 + tx;
        __id[9] = 288 + tx;
        __id[10] = 320 + tx;
        __id[11] = 352 + tx;
        __id[12] = 384 + tx;
        __id[13] = 416 + tx;
        __id[14] = 448 + tx;
        __id[15] = 480 + tx;
        
        j = 1;
        k = __id[8] % 1;
        MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_8, tmp_angle, tmp);
        temp_8 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[8], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_10, tmp_angle, tmp);
        temp_10 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_11, tmp_angle, tmp);
        temp_11 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_12, tmp_angle, tmp);
        temp_12 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[12], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_13, tmp_angle, tmp);
        temp_13 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_14, tmp_angle, tmp);
        temp_14 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[14], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_15, tmp_angle, tmp);
        temp_15 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[15], j, k, j*k, n_global);
        #endif
        
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
        
        j = 1;
        k = __id[4] % 2;
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_12, tmp_angle_rot, tmp);
        temp_12 = tmp;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_13, tmp_angle_rot, tmp);
        temp_13 = tmp;
        
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_14, tmp_angle_rot, tmp);
        temp_14 = tmp;
        
        MY_MUL(temp_7, tmp_angle, tmp);
        temp_7 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_15, tmp_angle_rot, tmp);
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
        
        j = 1;
        k = __id[2] % 4;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_2, tmp_angle, tmp);
        temp_2 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_6, tmp_angle_rot, tmp);
        temp_6 = tmp;
        
        MY_MUL(temp_3, tmp_angle, tmp);
        temp_3 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
        temp_7 = tmp;
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_10, tmp_angle, tmp);
        temp_10 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_14, tmp_angle_rot, tmp);
        temp_14 = tmp;
        
        MY_MUL(temp_11, tmp_angle, tmp);
        temp_11 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_15, tmp_angle_rot, tmp);
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
        
        j = 1;
        k = __id[1] % 8;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_11, tmp_angle_rot, tmp);
        temp_11 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
        temp_7 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_13, tmp_angle, tmp);
        temp_13 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_15, tmp_angle_rot, tmp);
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
        
        __syncthreads();
        
        sdata[ty * 512 + __id[0]] = temp_0;
        
        sdata[ty * 512 + __id[8]] = temp_8;
        
        sdata[ty * 512 + __id[4]] = temp_4;
        
        sdata[ty * 512 + __id[12]] = temp_12;
        
        sdata[ty * 512 + __id[2]] = temp_2;
        
        sdata[ty * 512 + __id[10]] = temp_10;
        
        sdata[ty * 512 + __id[6]] = temp_6;
        
        sdata[ty * 512 + __id[14]] = temp_14;
        
        sdata[ty * 512 + __id[1]] = temp_1;
        
        sdata[ty * 512 + __id[9]] = temp_9;
        
        sdata[ty * 512 + __id[5]] = temp_5;
        
        sdata[ty * 512 + __id[13]] = temp_13;
        
        sdata[ty * 512 + __id[3]] = temp_3;
        
        sdata[ty * 512 + __id[11]] = temp_11;
        
        sdata[ty * 512 + __id[7]] = temp_7;
        
        sdata[ty * 512 + __id[15]] = temp_15;
        
        __syncthreads();
        
        temp_0 = sdata[ty * 512 + (0 + tx)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[ty * 512 + (32 + tx)];
        __id[1] = tx + 32;
        
        temp_2 = sdata[ty * 512 + (64 + tx)];
        __id[2] = tx + 64;
        
        temp_3 = sdata[ty * 512 + (96 + tx)];
        __id[3] = tx + 96;
        
        temp_4 = sdata[ty * 512 + (128 + tx)];
        __id[4] = tx + 128;
        
        temp_5 = sdata[ty * 512 + (160 + tx)];
        __id[5] = tx + 160;
        
        temp_6 = sdata[ty * 512 + (192 + tx)];
        __id[6] = tx + 192;
        
        temp_7 = sdata[ty * 512 + (224 + tx)];
        __id[7] = tx + 224;
        
        temp_8 = sdata[ty * 512 + (256 + tx)];
        __id[8] = tx + 256;
        
        temp_9 = sdata[ty * 512 + (288 + tx)];
        __id[9] = tx + 288;
        
        temp_10 = sdata[ty * 512 + (320 + tx)];
        __id[10] = tx + 320;
        
        temp_11 = sdata[ty * 512 + (352 + tx)];
        __id[11] = tx + 352;
        
        temp_12 = sdata[ty * 512 + (384 + tx)];
        __id[12] = tx + 384;
        
        temp_13 = sdata[ty * 512 + (416 + tx)];
        __id[13] = tx + 416;
        
        temp_14 = sdata[ty * 512 + (448 + tx)];
        __id[14] = tx + 448;
        
        temp_15 = sdata[ty * 512 + (480 + tx)];
        __id[15] = tx + 480;
        
        j = 1;
        k = __id[8] % 16;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_8, tmp_angle, tmp);
        temp_8 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[8], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_10, tmp_angle, tmp);
        temp_10 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_11, tmp_angle, tmp);
        temp_11 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_12, tmp_angle, tmp);
        temp_12 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[12], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_13, tmp_angle, tmp);
        temp_13 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_14, tmp_angle, tmp);
        temp_14 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[14], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_15, tmp_angle, tmp);
        temp_15 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[15], j, k, j*k, n_global);
        #endif
        
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
        
        j = 1;
        k = __id[4] % 32;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_12, tmp_angle_rot, tmp);
        temp_12 = tmp;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_13, tmp_angle_rot, tmp);
        temp_13 = tmp;
        
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_14, tmp_angle_rot, tmp);
        temp_14 = tmp;
        
        MY_MUL(temp_7, tmp_angle, tmp);
        temp_7 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_15, tmp_angle_rot, tmp);
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
        
        j = 1;
        k = __id[2] % 64;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_2, tmp_angle, tmp);
        temp_2 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_6, tmp_angle_rot, tmp);
        temp_6 = tmp;
        
        MY_MUL(temp_3, tmp_angle, tmp);
        temp_3 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
        temp_7 = tmp;
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_10, tmp_angle, tmp);
        temp_10 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_14, tmp_angle_rot, tmp);
        temp_14 = tmp;
        
        MY_MUL(temp_11, tmp_angle, tmp);
        temp_11 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_15, tmp_angle_rot, tmp);
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
        
        j = 1;
        k = __id[1] % 128;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_11, tmp_angle_rot, tmp);
        temp_11 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
        temp_7 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_13, tmp_angle, tmp);
        temp_13 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_15, tmp_angle_rot, tmp);
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
        
        __syncthreads();
        
        sdata[ty * 512 + __id[0]] = temp_0;
        
        sdata[ty * 512 + __id[8]] = temp_8;
        
        sdata[ty * 512 + __id[4]] = temp_4;
        
        sdata[ty * 512 + __id[12]] = temp_12;
        
        sdata[ty * 512 + __id[2]] = temp_2;
        
        sdata[ty * 512 + __id[10]] = temp_10;
        
        sdata[ty * 512 + __id[6]] = temp_6;
        
        sdata[ty * 512 + __id[14]] = temp_14;
        
        sdata[ty * 512 + __id[1]] = temp_1;
        
        sdata[ty * 512 + __id[9]] = temp_9;
        
        sdata[ty * 512 + __id[5]] = temp_5;
        
        sdata[ty * 512 + __id[13]] = temp_13;
        
        sdata[ty * 512 + __id[3]] = temp_3;
        
        sdata[ty * 512 + __id[11]] = temp_11;
        
        sdata[ty * 512 + __id[7]] = temp_7;
        
        sdata[ty * 512 + __id[15]] = temp_15;
        
        __syncthreads();
        
        temp_0 = sdata[ty * 512 + (0 + tx)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[ty * 512 + (32 + tx)];
        __id[1] = tx + 32;
        
        temp_2 = sdata[ty * 512 + (64 + tx)];
        __id[2] = tx + 64;
        
        temp_3 = sdata[ty * 512 + (96 + tx)];
        __id[3] = tx + 96;
        
        temp_4 = sdata[ty * 512 + (128 + tx)];
        __id[4] = tx + 128;
        
        temp_5 = sdata[ty * 512 + (160 + tx)];
        __id[5] = tx + 160;
        
        temp_6 = sdata[ty * 512 + (192 + tx)];
        __id[6] = tx + 192;
        
        temp_7 = sdata[ty * 512 + (224 + tx)];
        __id[7] = tx + 224;
        
        temp_8 = sdata[ty * 512 + (256 + tx)];
        __id[8] = tx + 256;
        
        temp_9 = sdata[ty * 512 + (288 + tx)];
        __id[9] = tx + 288;
        
        temp_10 = sdata[ty * 512 + (320 + tx)];
        __id[10] = tx + 320;
        
        temp_11 = sdata[ty * 512 + (352 + tx)];
        __id[11] = tx + 352;
        
        temp_12 = sdata[ty * 512 + (384 + tx)];
        __id[12] = tx + 384;
        
        temp_13 = sdata[ty * 512 + (416 + tx)];
        __id[13] = tx + 416;
        
        temp_14 = sdata[ty * 512 + (448 + tx)];
        __id[14] = tx + 448;
        
        temp_15 = sdata[ty * 512 + (480 + tx)];
        __id[15] = tx + 480;
        
        j = 1;
        k = __id[8] % 256;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_8, tmp_angle, tmp);
        temp_8 = tmp;
        
        MY_MUL(temp_12, tmp_angle_rot, tmp);
        temp_12 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        
        MY_MUL(temp_13, tmp_angle_rot, tmp);
        temp_13 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_10, tmp_angle, tmp);
        temp_10 = tmp;
        
        MY_MUL(temp_14, tmp_angle_rot, tmp);
        temp_14 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_11, tmp_angle, tmp);
        temp_11 = tmp;
        
        MY_MUL(temp_15, tmp_angle_rot, tmp);
        temp_15 = tmp;
        
        tmp = temp_0;
        MY_ADD(tmp, temp_8, temp_0);
        MY_SUB(tmp, temp_8, temp_8);
        
        tmp = temp_1;
        MY_ADD(tmp, temp_9, temp_1);
        MY_SUB(tmp, temp_9, temp_9);
        
        tmp = temp_2;
        MY_ADD(tmp, temp_10, temp_2);
        MY_SUB(tmp, temp_10, temp_10);
        
        tmp = temp_3;
        MY_ADD(tmp, temp_11, temp_3);
        MY_SUB(tmp, temp_11, temp_11);
        
        tmp = temp_4;
        MY_ADD(tmp, temp_12, temp_4);
        MY_SUB(tmp, temp_12, temp_12);
        
        tmp = temp_5;
        MY_ADD(tmp, temp_13, temp_5);
        MY_SUB(tmp, temp_13, temp_13);
        
        tmp = temp_6;
        MY_ADD(tmp, temp_14, temp_6);
        MY_SUB(tmp, temp_14, temp_14);
        
        tmp = temp_7;
        MY_ADD(tmp, temp_15, temp_7);
        MY_SUB(tmp, temp_15, temp_15);
        
        n_global *= 2;
        __syncthreads();
        
        sdata[ty + 16 * __id[0]] = temp_0;
        
        sdata[ty + 16 * __id[1]] = temp_1;
        
        sdata[ty + 16 * __id[2]] = temp_2;
        
        sdata[ty + 16 * __id[3]] = temp_3;
        
        sdata[ty + 16 * __id[4]] = temp_4;
        
        sdata[ty + 16 * __id[5]] = temp_5;
        
        sdata[ty + 16 * __id[6]] = temp_6;
        
        sdata[ty + 16 * __id[7]] = temp_7;
        
        sdata[ty + 16 * __id[8]] = temp_8;
        
        sdata[ty + 16 * __id[9]] = temp_9;
        
        sdata[ty + 16 * __id[10]] = temp_10;
        
        sdata[ty + 16 * __id[11]] = temp_11;
        
        sdata[ty + 16 * __id[12]] = temp_12;
        
        sdata[ty + 16 * __id[13]] = temp_13;
        
        sdata[ty + 16 * __id[14]] = temp_14;
        
        sdata[ty + 16 * __id[15]] = temp_15;
        
        __syncthreads();
         
                    temp_0 = sdata[((tx + ty * 32 + 0) % 16) + 16 * ((tx + ty * 32 + 0) / 16)];
                    outputs[(((tx + ty * 32 + 0) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 0) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 512) % 16) + 16 * ((tx + ty * 32 + 512) / 16)];
                    outputs[(((tx + ty * 32 + 512) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 512) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 1024) % 16) + 16 * ((tx + ty * 32 + 1024) / 16)];
                    outputs[(((tx + ty * 32 + 1024) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 1024) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 1536) % 16) + 16 * ((tx + ty * 32 + 1536) / 16)];
                    outputs[(((tx + ty * 32 + 1536) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 1536) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 2048) % 16) + 16 * ((tx + ty * 32 + 2048) / 16)];
                    outputs[(((tx + ty * 32 + 2048) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 2048) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 2560) % 16) + 16 * ((tx + ty * 32 + 2560) / 16)];
                    outputs[(((tx + ty * 32 + 2560) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 2560) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 3072) % 16) + 16 * ((tx + ty * 32 + 3072) / 16)];
                    outputs[(((tx + ty * 32 + 3072) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 3072) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 3584) % 16) + 16 * ((tx + ty * 32 + 3584) / 16)];
                    outputs[(((tx + ty * 32 + 3584) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 3584) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 4096) % 16) + 16 * ((tx + ty * 32 + 4096) / 16)];
                    outputs[(((tx + ty * 32 + 4096) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 4096) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 4608) % 16) + 16 * ((tx + ty * 32 + 4608) / 16)];
                    outputs[(((tx + ty * 32 + 4608) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 4608) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 5120) % 16) + 16 * ((tx + ty * 32 + 5120) / 16)];
                    outputs[(((tx + ty * 32 + 5120) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 5120) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 5632) % 16) + 16 * ((tx + ty * 32 + 5632) / 16)];
                    outputs[(((tx + ty * 32 + 5632) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 5632) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 6144) % 16) + 16 * ((tx + ty * 32 + 6144) / 16)];
                    outputs[(((tx + ty * 32 + 6144) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 6144) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 6656) % 16) + 16 * ((tx + ty * 32 + 6656) / 16)];
                    outputs[(((tx + ty * 32 + 6656) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 6656) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 7168) % 16) + 16 * ((tx + ty * 32 + 7168) / 16)];
                    outputs[(((tx + ty * 32 + 7168) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 7168) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 32 + 7680) % 16) + 16 * ((tx + ty * 32 + 7680) / 16)];
                    outputs[(((tx + ty * 32 + 7680) % 16) + bx * 16) + 512 * ((tx + ty * 32 + 7680) / 16)] = temp_0;
        
        }
    