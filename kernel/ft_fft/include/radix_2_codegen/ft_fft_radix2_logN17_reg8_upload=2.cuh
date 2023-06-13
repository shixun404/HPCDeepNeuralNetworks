extern __shared__ float shared[];
    __global__ void __launch_bounds__(1024) fft_radix2_logN17_2(float2* inputs, float2* outputs) {
    
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
        int ty = threadIdx.y;
        int bx = blockIdx.x;
        int N = 512;
        int __id[8];
        float2 tmp;
        float2 tmp_angle, tmp_angle_rot;
        int j;
        int k;
        int tmp_id;
        int n = 1, n_global = 1;
        
        
        temp_0 = inputs[((tx + 64 * ty + 0) % 512) + (((tx + 64 * ty + 0) / 512) + bx * 16) * 512];
        sdata[((tx + 64 * ty + 0) % 512) + ((tx + 64 * ty + 0) / 512) * 512] = temp_0;
        
        temp_1 = inputs[((tx + 64 * ty + 1024) % 512) + (((tx + 64 * ty + 1024) / 512) + bx * 16) * 512];
        sdata[((tx + 64 * ty + 1024) % 512) + ((tx + 64 * ty + 1024) / 512) * 512] = temp_1;
        
        temp_2 = inputs[((tx + 64 * ty + 2048) % 512) + (((tx + 64 * ty + 2048) / 512) + bx * 16) * 512];
        sdata[((tx + 64 * ty + 2048) % 512) + ((tx + 64 * ty + 2048) / 512) * 512] = temp_2;
        
        temp_3 = inputs[((tx + 64 * ty + 3072) % 512) + (((tx + 64 * ty + 3072) / 512) + bx * 16) * 512];
        sdata[((tx + 64 * ty + 3072) % 512) + ((tx + 64 * ty + 3072) / 512) * 512] = temp_3;
        
        temp_4 = inputs[((tx + 64 * ty + 4096) % 512) + (((tx + 64 * ty + 4096) / 512) + bx * 16) * 512];
        sdata[((tx + 64 * ty + 4096) % 512) + ((tx + 64 * ty + 4096) / 512) * 512] = temp_4;
        
        temp_5 = inputs[((tx + 64 * ty + 5120) % 512) + (((tx + 64 * ty + 5120) / 512) + bx * 16) * 512];
        sdata[((tx + 64 * ty + 5120) % 512) + ((tx + 64 * ty + 5120) / 512) * 512] = temp_5;
        
        temp_6 = inputs[((tx + 64 * ty + 6144) % 512) + (((tx + 64 * ty + 6144) / 512) + bx * 16) * 512];
        sdata[((tx + 64 * ty + 6144) % 512) + ((tx + 64 * ty + 6144) / 512) * 512] = temp_6;
        
        temp_7 = inputs[((tx + 64 * ty + 7168) % 512) + (((tx + 64 * ty + 7168) / 512) + bx * 16) * 512];
        sdata[((tx + 64 * ty + 7168) % 512) + ((tx + 64 * ty + 7168) / 512) * 512] = temp_7;
        
        __syncthreads();
        temp_0 = sdata[(tx + 0 * 64) + ty * 512];
        temp_1 = sdata[(tx + 1 * 64) + ty * 512];
        temp_2 = sdata[(tx + 2 * 64) + ty * 512];
        temp_3 = sdata[(tx + 3 * 64) + ty * 512];
        temp_4 = sdata[(tx + 4 * 64) + ty * 512];
        temp_5 = sdata[(tx + 5 * 64) + ty * 512];
        temp_6 = sdata[(tx + 6 * 64) + ty * 512];
        temp_7 = sdata[(tx + 7 * 64) + ty * 512];
        
        __id[0] = 0 + tx;
        __id[1] = 64 + tx;
        __id[2] = 128 + tx;
        __id[3] = 192 + tx;
        __id[4] = 256 + tx;
        __id[5] = 320 + tx;
        __id[6] = 384 + tx;
        __id[7] = 448 + tx;
        
        j = 1;
        k = __id[4] % 1;
        MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle, tmp);
        temp_7 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
        
        j = 1;
        k = __id[2] % 2;
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_2, tmp_angle, tmp);
        temp_2 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_6, tmp_angle_rot, tmp);
        temp_6 = tmp;
        
        MY_MUL(temp_3, tmp_angle, tmp);
        temp_3 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
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
        
        j = 1;
        k = __id[1] % 4;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
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
        
        __syncthreads();
        
        sdata[ty * 512 + __id[0]] = temp_0;
        
        sdata[ty * 512 + __id[4]] = temp_4;
        
        sdata[ty * 512 + __id[2]] = temp_2;
        
        sdata[ty * 512 + __id[6]] = temp_6;
        
        sdata[ty * 512 + __id[1]] = temp_1;
        
        sdata[ty * 512 + __id[5]] = temp_5;
        
        sdata[ty * 512 + __id[3]] = temp_3;
        
        sdata[ty * 512 + __id[7]] = temp_7;
        
        __syncthreads();
        
        temp_0 = sdata[ty * 512 + (0 + tx)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[ty * 512 + (64 + tx)];
        __id[1] = tx + 64;
        
        temp_2 = sdata[ty * 512 + (128 + tx)];
        __id[2] = tx + 128;
        
        temp_3 = sdata[ty * 512 + (192 + tx)];
        __id[3] = tx + 192;
        
        temp_4 = sdata[ty * 512 + (256 + tx)];
        __id[4] = tx + 256;
        
        temp_5 = sdata[ty * 512 + (320 + tx)];
        __id[5] = tx + 320;
        
        temp_6 = sdata[ty * 512 + (384 + tx)];
        __id[6] = tx + 384;
        
        temp_7 = sdata[ty * 512 + (448 + tx)];
        __id[7] = tx + 448;
        
        j = 1;
        k = __id[4] % 8;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle, tmp);
        temp_7 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
        
        j = 1;
        k = __id[2] % 16;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_2, tmp_angle, tmp);
        temp_2 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_6, tmp_angle_rot, tmp);
        temp_6 = tmp;
        
        MY_MUL(temp_3, tmp_angle, tmp);
        temp_3 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
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
        
        j = 1;
        k = __id[1] % 32;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
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
        
        __syncthreads();
        
        sdata[ty * 512 + __id[0]] = temp_0;
        
        sdata[ty * 512 + __id[4]] = temp_4;
        
        sdata[ty * 512 + __id[2]] = temp_2;
        
        sdata[ty * 512 + __id[6]] = temp_6;
        
        sdata[ty * 512 + __id[1]] = temp_1;
        
        sdata[ty * 512 + __id[5]] = temp_5;
        
        sdata[ty * 512 + __id[3]] = temp_3;
        
        sdata[ty * 512 + __id[7]] = temp_7;
        
        __syncthreads();
        
        temp_0 = sdata[ty * 512 + (0 + tx)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[ty * 512 + (64 + tx)];
        __id[1] = tx + 64;
        
        temp_2 = sdata[ty * 512 + (128 + tx)];
        __id[2] = tx + 128;
        
        temp_3 = sdata[ty * 512 + (192 + tx)];
        __id[3] = tx + 192;
        
        temp_4 = sdata[ty * 512 + (256 + tx)];
        __id[4] = tx + 256;
        
        temp_5 = sdata[ty * 512 + (320 + tx)];
        __id[5] = tx + 320;
        
        temp_6 = sdata[ty * 512 + (384 + tx)];
        __id[6] = tx + 384;
        
        temp_7 = sdata[ty * 512 + (448 + tx)];
        __id[7] = tx + 448;
        
        j = 1;
        k = __id[4] % 64;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 5,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle, tmp);
        temp_7 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 7,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
        
        j = 1;
        k = __id[2] % 128;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_2, tmp_angle, tmp);
        temp_2 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 4,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_6, tmp_angle_rot, tmp);
        temp_6 = tmp;
        
        MY_MUL(temp_3, tmp_angle, tmp);
        temp_3 = tmp;
        #if defined(LOG_ON)
        if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 6,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                            tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
        #endif
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
        temp_7 = tmp;
        
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
        
        j = 1;
        k = __id[1] % 256;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
        
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
        temp_7 = tmp;
        
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
        __syncthreads();
        
        sdata[ty + 16 * __id[0]] = temp_0;
        
        sdata[ty + 16 * __id[4]] = temp_4;
        
        sdata[ty + 16 * __id[2]] = temp_2;
        
        sdata[ty + 16 * __id[6]] = temp_6;
        
        sdata[ty + 16 * __id[1]] = temp_1;
        
        sdata[ty + 16 * __id[5]] = temp_5;
        
        sdata[ty + 16 * __id[3]] = temp_3;
        
        sdata[ty + 16 * __id[7]] = temp_7;
        
        __syncthreads();
         
                    temp_0 = sdata[((tx + ty * 64 + 0) % 16) + 16 * ((tx + ty * 64 + 0) / 16)];
                    outputs[(((tx + ty * 64 + 0) % 16) + bx * 16) + 256 * ((tx + ty * 64 + 0) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 64 + 1024) % 16) + 16 * ((tx + ty * 64 + 1024) / 16)];
                    outputs[(((tx + ty * 64 + 1024) % 16) + bx * 16) + 256 * ((tx + ty * 64 + 1024) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 64 + 2048) % 16) + 16 * ((tx + ty * 64 + 2048) / 16)];
                    outputs[(((tx + ty * 64 + 2048) % 16) + bx * 16) + 256 * ((tx + ty * 64 + 2048) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 64 + 3072) % 16) + 16 * ((tx + ty * 64 + 3072) / 16)];
                    outputs[(((tx + ty * 64 + 3072) % 16) + bx * 16) + 256 * ((tx + ty * 64 + 3072) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 64 + 4096) % 16) + 16 * ((tx + ty * 64 + 4096) / 16)];
                    outputs[(((tx + ty * 64 + 4096) % 16) + bx * 16) + 256 * ((tx + ty * 64 + 4096) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 64 + 5120) % 16) + 16 * ((tx + ty * 64 + 5120) / 16)];
                    outputs[(((tx + ty * 64 + 5120) % 16) + bx * 16) + 256 * ((tx + ty * 64 + 5120) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 64 + 6144) % 16) + 16 * ((tx + ty * 64 + 6144) / 16)];
                    outputs[(((tx + ty * 64 + 6144) % 16) + bx * 16) + 256 * ((tx + ty * 64 + 6144) / 16)] = temp_0;
         
                    temp_0 = sdata[((tx + ty * 64 + 7168) % 16) + 16 * ((tx + ty * 64 + 7168) / 16)];
                    outputs[(((tx + ty * 64 + 7168) % 16) + bx * 16) + 256 * ((tx + ty * 64 + 7168) / 16)] = temp_0;
        
        }
    