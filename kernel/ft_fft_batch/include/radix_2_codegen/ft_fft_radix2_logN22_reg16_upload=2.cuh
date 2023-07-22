extern __shared__ float shared[];
    __global__ void __launch_bounds__(512) fft_radix2_logN22_2(float2* inputs, float2* outputs) {
    
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
        int N = 2048;
        int __id[16];
        float2 tmp;
        float2 tmp_angle, tmp_angle_rot;
        int j;
        int k;
        int tmp_id;
        int n = 1, n_global = 1;
        float2 tmp_angle_bk;
        
        temp_0 = inputs[(tx + 0 * 128) + (ty + bx * 4) * 2048];
        temp_1 = inputs[(tx + 1 * 128) + (ty + bx * 4) * 2048];
        temp_2 = inputs[(tx + 2 * 128) + (ty + bx * 4) * 2048];
        temp_3 = inputs[(tx + 3 * 128) + (ty + bx * 4) * 2048];
        temp_4 = inputs[(tx + 4 * 128) + (ty + bx * 4) * 2048];
        temp_5 = inputs[(tx + 5 * 128) + (ty + bx * 4) * 2048];
        temp_6 = inputs[(tx + 6 * 128) + (ty + bx * 4) * 2048];
        temp_7 = inputs[(tx + 7 * 128) + (ty + bx * 4) * 2048];
        temp_8 = inputs[(tx + 8 * 128) + (ty + bx * 4) * 2048];
        temp_9 = inputs[(tx + 9 * 128) + (ty + bx * 4) * 2048];
        temp_10 = inputs[(tx + 10 * 128) + (ty + bx * 4) * 2048];
        temp_11 = inputs[(tx + 11 * 128) + (ty + bx * 4) * 2048];
        temp_12 = inputs[(tx + 12 * 128) + (ty + bx * 4) * 2048];
        temp_13 = inputs[(tx + 13 * 128) + (ty + bx * 4) * 2048];
        temp_14 = inputs[(tx + 14 * 128) + (ty + bx * 4) * 2048];
        temp_15 = inputs[(tx + 15 * 128) + (ty + bx * 4) * 2048];
        
        __id[0] = 0 + tx;
        __id[1] = 128 + tx;
        __id[2] = 256 + tx;
        __id[3] = 384 + tx;
        __id[4] = 512 + tx;
        __id[5] = 640 + tx;
        __id[6] = 768 + tx;
        __id[7] = 896 + tx;
        __id[8] = 1024 + tx;
        __id[9] = 1152 + tx;
        __id[10] = 1280 + tx;
        __id[11] = 1408 + tx;
        __id[12] = 1536 + tx;
        __id[13] = 1664 + tx;
        __id[14] = 1792 + tx;
        __id[15] = 1920 + tx;
        
        j = 1;
        k = 8 % 1;
        MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_8, tmp_angle, tmp);
            temp_8 = tmp;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
            MY_MUL(temp_10, tmp_angle, tmp);
            temp_10 = tmp;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_12, tmp_angle, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_13, tmp_angle, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_14, tmp_angle, tmp);
            temp_14 = tmp;
            
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
        
        j = 1;
        k = 8 % 2;
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_4, tmp_angle, tmp);
            temp_4 = tmp;
            
            MY_MUL(temp_12, tmp_angle_rot, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_13, tmp_angle_rot, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_6, tmp_angle, tmp);
            temp_6 = tmp;
            
            MY_MUL(temp_14, tmp_angle_rot, tmp);
            temp_14 = tmp;
            
            MY_MUL(temp_7, tmp_angle, tmp);
            temp_7 = tmp;
            
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
        k = 8 % 4;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_2, tmp_angle, tmp);
            temp_2 = tmp;
            
            MY_MUL(temp_6, tmp_angle_rot, tmp);
            temp_6 = tmp;
            
            MY_MUL(temp_3, tmp_angle, tmp);
            temp_3 = tmp;
            
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
            
            MY_MUL(temp_14, tmp_angle_rot, tmp);
            temp_14 = tmp;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
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
        k = 8 % 8;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
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
            
            tmp_angle_rot.x = 0.9238795325112867f;
            tmp_angle_rot.y = -0.3826834323650898f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
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
        
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 0) / (float)(2048), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 1) / (float)(2048), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 2) / (float)(2048), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 3) / (float)(2048), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 4) / (float)(2048), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 5) / (float)(2048), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 6) / (float)(2048), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 7) / (float)(2048), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 8) / (float)(2048), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 9) / (float)(2048), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 10) / (float)(2048), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 11) / (float)(2048), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 12) / (float)(2048), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 13) / (float)(2048), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 14) / (float)(2048), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 15) / (float)(2048), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
        sdata[((ty * 2048 + __id[0]) / 16) * 17 + 
        (ty * 2048 + __id[0]) % 16] = temp_0;
        
        sdata[((ty * 2048 + __id[8]) / 16) * 17 + 
        (ty * 2048 + __id[8]) % 16] = temp_8;
        
        sdata[((ty * 2048 + __id[4]) / 16) * 17 + 
        (ty * 2048 + __id[4]) % 16] = temp_4;
        
        sdata[((ty * 2048 + __id[12]) / 16) * 17 + 
        (ty * 2048 + __id[12]) % 16] = temp_12;
        
        sdata[((ty * 2048 + __id[2]) / 16) * 17 + 
        (ty * 2048 + __id[2]) % 16] = temp_2;
        
        sdata[((ty * 2048 + __id[10]) / 16) * 17 + 
        (ty * 2048 + __id[10]) % 16] = temp_10;
        
        sdata[((ty * 2048 + __id[6]) / 16) * 17 + 
        (ty * 2048 + __id[6]) % 16] = temp_6;
        
        sdata[((ty * 2048 + __id[14]) / 16) * 17 + 
        (ty * 2048 + __id[14]) % 16] = temp_14;
        
        sdata[((ty * 2048 + __id[1]) / 16) * 17 + 
        (ty * 2048 + __id[1]) % 16] = temp_1;
        
        sdata[((ty * 2048 + __id[9]) / 16) * 17 + 
        (ty * 2048 + __id[9]) % 16] = temp_9;
        
        sdata[((ty * 2048 + __id[5]) / 16) * 17 + 
        (ty * 2048 + __id[5]) % 16] = temp_5;
        
        sdata[((ty * 2048 + __id[13]) / 16) * 17 + 
        (ty * 2048 + __id[13]) % 16] = temp_13;
        
        sdata[((ty * 2048 + __id[3]) / 16) * 17 + 
        (ty * 2048 + __id[3]) % 16] = temp_3;
        
        sdata[((ty * 2048 + __id[11]) / 16) * 17 + 
        (ty * 2048 + __id[11]) % 16] = temp_11;
        
        sdata[((ty * 2048 + __id[7]) / 16) * 17 + 
        (ty * 2048 + __id[7]) % 16] = temp_7;
        
        sdata[((ty * 2048 + __id[15]) / 16) * 17 + 
        (ty * 2048 + __id[15]) % 16] = temp_15;
        
        __syncthreads();
        
        temp_0 = sdata[((ty * 2048 + 0 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 0 * blockDim.x + tx) % 16)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[((ty * 2048 + 1 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 1 * blockDim.x + tx) % 16)];
        __id[1] = tx + 128;
        
        temp_2 = sdata[((ty * 2048 + 2 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 2 * blockDim.x + tx) % 16)];
        __id[2] = tx + 256;
        
        temp_3 = sdata[((ty * 2048 + 3 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 3 * blockDim.x + tx) % 16)];
        __id[3] = tx + 384;
        
        temp_4 = sdata[((ty * 2048 + 4 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 4 * blockDim.x + tx) % 16)];
        __id[4] = tx + 512;
        
        temp_5 = sdata[((ty * 2048 + 5 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 5 * blockDim.x + tx) % 16)];
        __id[5] = tx + 640;
        
        temp_6 = sdata[((ty * 2048 + 6 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 6 * blockDim.x + tx) % 16)];
        __id[6] = tx + 768;
        
        temp_7 = sdata[((ty * 2048 + 7 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 7 * blockDim.x + tx) % 16)];
        __id[7] = tx + 896;
        
        temp_8 = sdata[((ty * 2048 + 8 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 8 * blockDim.x + tx) % 16)];
        __id[8] = tx + 1024;
        
        temp_9 = sdata[((ty * 2048 + 9 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 9 * blockDim.x + tx) % 16)];
        __id[9] = tx + 1152;
        
        temp_10 = sdata[((ty * 2048 + 10 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 10 * blockDim.x + tx) % 16)];
        __id[10] = tx + 1280;
        
        temp_11 = sdata[((ty * 2048 + 11 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 11 * blockDim.x + tx) % 16)];
        __id[11] = tx + 1408;
        
        temp_12 = sdata[((ty * 2048 + 12 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 12 * blockDim.x + tx) % 16)];
        __id[12] = tx + 1536;
        
        temp_13 = sdata[((ty * 2048 + 13 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 13 * blockDim.x + tx) % 16)];
        __id[13] = tx + 1664;
        
        temp_14 = sdata[((ty * 2048 + 14 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 14 * blockDim.x + tx) % 16)];
        __id[14] = tx + 1792;
        
        temp_15 = sdata[((ty * 2048 + 15 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 15 * blockDim.x + tx) % 16)];
        __id[15] = tx + 1920;
        
        j = 1;
        k = 8 % 1;
        MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_8, tmp_angle, tmp);
            temp_8 = tmp;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
            MY_MUL(temp_10, tmp_angle, tmp);
            temp_10 = tmp;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_12, tmp_angle, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_13, tmp_angle, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_14, tmp_angle, tmp);
            temp_14 = tmp;
            
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
        
        j = 1;
        k = 8 % 2;
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_4, tmp_angle, tmp);
            temp_4 = tmp;
            
            MY_MUL(temp_12, tmp_angle_rot, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_13, tmp_angle_rot, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_6, tmp_angle, tmp);
            temp_6 = tmp;
            
            MY_MUL(temp_14, tmp_angle_rot, tmp);
            temp_14 = tmp;
            
            MY_MUL(temp_7, tmp_angle, tmp);
            temp_7 = tmp;
            
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
        k = 8 % 4;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_2, tmp_angle, tmp);
            temp_2 = tmp;
            
            MY_MUL(temp_6, tmp_angle_rot, tmp);
            temp_6 = tmp;
            
            MY_MUL(temp_3, tmp_angle, tmp);
            temp_3 = tmp;
            
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
            
            MY_MUL(temp_14, tmp_angle_rot, tmp);
            temp_14 = tmp;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
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
        k = 8 % 8;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
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
            
            tmp_angle_rot.x = 0.9238795325112867f;
            tmp_angle_rot.y = -0.3826834323650898f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
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
        
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 0) / (float)(128.0), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 1) / (float)(128.0), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 2) / (float)(128.0), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 3) / (float)(128.0), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 4) / (float)(128.0), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 5) / (float)(128.0), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 6) / (float)(128.0), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 7) / (float)(128.0), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 8) / (float)(128.0), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 9) / (float)(128.0), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 10) / (float)(128.0), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 11) / (float)(128.0), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 12) / (float)(128.0), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 13) / (float)(128.0), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 14) / (float)(128.0), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 16) * 15) / (float)(128.0), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
        sdata[((ty * 2048 + __id[0]) / 16) * 17 + 
        (ty * 2048 + __id[0]) % 16] = temp_0;
        
        sdata[((ty * 2048 + __id[8]) / 16) * 17 + 
        (ty * 2048 + __id[8]) % 16] = temp_8;
        
        sdata[((ty * 2048 + __id[4]) / 16) * 17 + 
        (ty * 2048 + __id[4]) % 16] = temp_4;
        
        sdata[((ty * 2048 + __id[12]) / 16) * 17 + 
        (ty * 2048 + __id[12]) % 16] = temp_12;
        
        sdata[((ty * 2048 + __id[2]) / 16) * 17 + 
        (ty * 2048 + __id[2]) % 16] = temp_2;
        
        sdata[((ty * 2048 + __id[10]) / 16) * 17 + 
        (ty * 2048 + __id[10]) % 16] = temp_10;
        
        sdata[((ty * 2048 + __id[6]) / 16) * 17 + 
        (ty * 2048 + __id[6]) % 16] = temp_6;
        
        sdata[((ty * 2048 + __id[14]) / 16) * 17 + 
        (ty * 2048 + __id[14]) % 16] = temp_14;
        
        sdata[((ty * 2048 + __id[1]) / 16) * 17 + 
        (ty * 2048 + __id[1]) % 16] = temp_1;
        
        sdata[((ty * 2048 + __id[9]) / 16) * 17 + 
        (ty * 2048 + __id[9]) % 16] = temp_9;
        
        sdata[((ty * 2048 + __id[5]) / 16) * 17 + 
        (ty * 2048 + __id[5]) % 16] = temp_5;
        
        sdata[((ty * 2048 + __id[13]) / 16) * 17 + 
        (ty * 2048 + __id[13]) % 16] = temp_13;
        
        sdata[((ty * 2048 + __id[3]) / 16) * 17 + 
        (ty * 2048 + __id[3]) % 16] = temp_3;
        
        sdata[((ty * 2048 + __id[11]) / 16) * 17 + 
        (ty * 2048 + __id[11]) % 16] = temp_11;
        
        sdata[((ty * 2048 + __id[7]) / 16) * 17 + 
        (ty * 2048 + __id[7]) % 16] = temp_7;
        
        sdata[((ty * 2048 + __id[15]) / 16) * 17 + 
        (ty * 2048 + __id[15]) % 16] = temp_15;
        
        __syncthreads();
        
        temp_0 = sdata[((ty * 2048 + 0 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 0 * blockDim.x + tx) % 16)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[((ty * 2048 + 1 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 1 * blockDim.x + tx) % 16)];
        __id[1] = tx + 128;
        
        temp_2 = sdata[((ty * 2048 + 2 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 2 * blockDim.x + tx) % 16)];
        __id[2] = tx + 256;
        
        temp_3 = sdata[((ty * 2048 + 3 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 3 * blockDim.x + tx) % 16)];
        __id[3] = tx + 384;
        
        temp_4 = sdata[((ty * 2048 + 4 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 4 * blockDim.x + tx) % 16)];
        __id[4] = tx + 512;
        
        temp_5 = sdata[((ty * 2048 + 5 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 5 * blockDim.x + tx) % 16)];
        __id[5] = tx + 640;
        
        temp_6 = sdata[((ty * 2048 + 6 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 6 * blockDim.x + tx) % 16)];
        __id[6] = tx + 768;
        
        temp_7 = sdata[((ty * 2048 + 7 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 7 * blockDim.x + tx) % 16)];
        __id[7] = tx + 896;
        
        temp_8 = sdata[((ty * 2048 + 8 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 8 * blockDim.x + tx) % 16)];
        __id[8] = tx + 1024;
        
        temp_9 = sdata[((ty * 2048 + 9 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 9 * blockDim.x + tx) % 16)];
        __id[9] = tx + 1152;
        
        temp_10 = sdata[((ty * 2048 + 10 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 10 * blockDim.x + tx) % 16)];
        __id[10] = tx + 1280;
        
        temp_11 = sdata[((ty * 2048 + 11 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 11 * blockDim.x + tx) % 16)];
        __id[11] = tx + 1408;
        
        temp_12 = sdata[((ty * 2048 + 12 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 12 * blockDim.x + tx) % 16)];
        __id[12] = tx + 1536;
        
        temp_13 = sdata[((ty * 2048 + 13 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 13 * blockDim.x + tx) % 16)];
        __id[13] = tx + 1664;
        
        temp_14 = sdata[((ty * 2048 + 14 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 14 * blockDim.x + tx) % 16)];
        __id[14] = tx + 1792;
        
        temp_15 = sdata[((ty * 2048 + 15 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 2048 + 15 * blockDim.x + tx) % 16)];
        __id[15] = tx + 1920;
        
        j = 1;
        k = 4 % 1;
        MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_8, tmp_angle, tmp);
            temp_8 = tmp;
            
            MY_MUL(temp_10, tmp_angle, tmp);
            temp_10 = tmp;
            
            MY_MUL(temp_12, tmp_angle, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_14, tmp_angle, tmp);
            temp_14 = tmp;
            
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_13, tmp_angle, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_15, tmp_angle, tmp);
            temp_15 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_8, temp_0);
            MY_SUB(tmp, temp_8, temp_8);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[8] = tmp_id + 256;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_10, temp_2);
            MY_SUB(tmp, temp_10, temp_10);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[10] = tmp_id + 256;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_12, temp_4);
            MY_SUB(tmp, temp_12, temp_12);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[12] = tmp_id + 256;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_14, temp_6);
            MY_SUB(tmp, temp_14, temp_14);
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[14] = tmp_id + 256;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_9, temp_1);
            MY_SUB(tmp, temp_9, temp_9);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[9] = tmp_id + 256;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_11, temp_3);
            MY_SUB(tmp, temp_11, temp_11);
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[11] = tmp_id + 256;
            
            tmp = temp_5;
            MY_ADD(tmp, temp_13, temp_5);
            MY_SUB(tmp, temp_13, temp_13);
            tmp_id = __id[5];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[5] = tmp_id;
            __id[13] = tmp_id + 256;
            
            tmp = temp_7;
            MY_ADD(tmp, temp_15, temp_7);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[7];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[7] = tmp_id;
            __id[15] = tmp_id + 256;
            
        n_global *= 2;
        
        j = 1;
        k = 4 % 2;
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_4, tmp_angle, tmp);
            temp_4 = tmp;
            
            MY_MUL(temp_12, tmp_angle_rot, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_6, tmp_angle, tmp);
            temp_6 = tmp;
            
            MY_MUL(temp_14, tmp_angle_rot, tmp);
            temp_14 = tmp;
            
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_13, tmp_angle_rot, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_7, tmp_angle, tmp);
            temp_7 = tmp;
            
            MY_MUL(temp_15, tmp_angle_rot, tmp);
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
        
        j = 1;
        k = 4 % 4;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_2, tmp_angle, tmp);
            temp_2 = tmp;
            
            MY_MUL(temp_6, tmp_angle_rot, tmp);
            temp_6 = tmp;
            
            tmp_angle_rot.x = 0.7071067811865476f;
            tmp_angle_rot.y = -0.7071067811865475f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_10, tmp_angle, tmp);
            temp_10 = tmp;
            
            MY_MUL(temp_14, tmp_angle_rot, tmp);
            temp_14 = tmp;
            
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_3, tmp_angle, tmp);
            temp_3 = tmp;
            
            MY_MUL(temp_7, tmp_angle_rot, tmp);
            temp_7 = tmp;
            
            tmp_angle_rot.x = 0.7071067811865476f;
            tmp_angle_rot.y = -0.7071067811865475f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_15, tmp_angle_rot, tmp);
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
        
        n_global *= 2;
        // __syncthreads();
        
        // sdata[ty + 4 * __id[0]] = temp_0;
        
        // sdata[ty + 4 * __id[1]] = temp_1;
        
        // sdata[ty + 4 * __id[8]] = temp_8;
        
        // sdata[ty + 4 * __id[9]] = temp_9;
        
        // sdata[ty + 4 * __id[4]] = temp_4;
        
        // sdata[ty + 4 * __id[5]] = temp_5;
        
        // sdata[ty + 4 * __id[12]] = temp_12;
        
        // sdata[ty + 4 * __id[13]] = temp_13;
        
        // sdata[ty + 4 * __id[2]] = temp_2;
        
        // sdata[ty + 4 * __id[3]] = temp_3;
        
        // sdata[ty + 4 * __id[10]] = temp_10;
        
        // sdata[ty + 4 * __id[11]] = temp_11;
        
        // sdata[ty + 4 * __id[6]] = temp_6;
        
        // sdata[ty + 4 * __id[7]] = temp_7;
        
        // sdata[ty + 4 * __id[14]] = temp_14;
        
        // sdata[ty + 4 * __id[15]] = temp_15;
        
        // __syncthreads();
         
                    // temp_0 = sdata[((tx + ty * 128 + 0) % 4) + 4 * ((tx + ty * 128 + 0) / 4)];
                    outputs[__id[0] + (ty + bx * blockDim.y) * 2048] = temp_0;
         
                    // temp_0 = sdata[((tx + ty * 128 + 512) % 4) + 4 * ((tx + ty * 128 + 512) / 4)];
                    outputs[__id[1] + (ty + bx * blockDim.y) * 2048] = temp_1;
         
                    // temp_0 = sdata[((tx + ty * 128 + 1024) % 4) + 4 * ((tx + ty * 128 + 1024) / 4)];
                    outputs[__id[8] + (ty + bx * blockDim.y) * 2048] = temp_8;
         
                    // temp_0 = sdata[((tx + ty * 128 + 1536) % 4) + 4 * ((tx + ty * 128 + 1536) / 4)];
                    outputs[__id[9] + (ty + bx * blockDim.y) * 2048] = temp_9;
         
                    // temp_0 = sdata[((tx + ty * 128 + 2048) % 4) + 4 * ((tx + ty * 128 + 2048) / 4)];
                    outputs[__id[4] + (ty + bx * blockDim.y) * 2048] = temp_4;
         
                    // temp_0 = sdata[((tx + ty * 128 + 2560) % 4) + 4 * ((tx + ty * 128 + 2560) / 4)];
                    outputs[__id[5] + (ty + bx * blockDim.y) * 2048] = temp_5;
         
                    // temp_0 = sdata[((tx + ty * 128 + 3072) % 4) + 4 * ((tx + ty * 128 + 3072) / 4)];
                    outputs[__id[12] + (ty + bx * blockDim.y) * 2048] = temp_12;
         
                    // temp_0 = sdata[((tx + ty * 128 + 3584) % 4) + 4 * ((tx + ty * 128 + 3584) / 4)];
                    outputs[__id[13] + (ty + bx * blockDim.y) * 2048] = temp_13;
         
                    // temp_0 = sdata[((tx + ty * 128 + 4096) % 4) + 4 * ((tx + ty * 128 + 4096) / 4)];
                    outputs[__id[2] + (ty + bx * blockDim.y) * 2048] = temp_2;
         
                    // temp_0 = sdata[((tx + ty * 128 + 4608) % 4) + 4 * ((tx + ty * 128 + 4608) / 4)];
                    outputs[__id[3] + (ty + bx * blockDim.y) * 2048] = temp_3;
         
                    // temp_0 = sdata[((tx + ty * 128 + 5120) % 4) + 4 * ((tx + ty * 128 + 5120) / 4)];
                    outputs[__id[10] + (ty + bx * blockDim.y) * 2048] = temp_10;
         
                    // temp_0 = sdata[((tx + ty * 128 + 5632) % 4) + 4 * ((tx + ty * 128 + 5632) / 4)];
                    outputs[__id[11] + (ty + bx * blockDim.y) * 2048] = temp_11;
         
                    // temp_0 = sdata[((tx + ty * 128 + 6144) % 4) + 4 * ((tx + ty * 128 + 6144) / 4)];
                    outputs[__id[6] + (ty + bx * blockDim.y) * 2048] = temp_6;
         
                    // temp_0 = sdata[((tx + ty * 128 + 6656) % 4) + 4 * ((tx + ty * 128 + 6656) / 4)];
                    outputs[__id[7] + (ty + bx * blockDim.y) * 2048] = temp_7;
         
                    // temp_0 = sdata[((tx + ty * 128 + 7168) % 4) + 4 * ((tx + ty * 128 + 7168) / 4)];
                    outputs[__id[14] + (ty + bx * blockDim.y) * 2048] = temp_14;
         
                    // temp_0 = sdata[((tx + ty * 128 + 7680) % 4) + 4 * ((tx + ty * 128 + 7680) / 4)];
                    outputs[__id[15] + (ty + bx * blockDim.y) * 2048] = temp_15;
        
        }
    