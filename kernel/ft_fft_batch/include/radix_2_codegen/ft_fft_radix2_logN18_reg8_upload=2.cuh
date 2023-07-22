extern __shared__ float shared[];
    __global__ void __launch_bounds__(64) fft_radix2_logN18_2(float2* inputs, float2* outputs) {
    
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
        float2 tmp_angle_bk;
        
        temp_0 = inputs[(tx + 0 * 64) + (ty + bx * 1) * 512];
        temp_1 = inputs[(tx + 1 * 64) + (ty + bx * 1) * 512];
        temp_2 = inputs[(tx + 2 * 64) + (ty + bx * 1) * 512];
        temp_3 = inputs[(tx + 3 * 64) + (ty + bx * 1) * 512];
        temp_4 = inputs[(tx + 4 * 64) + (ty + bx * 1) * 512];
        temp_5 = inputs[(tx + 5 * 64) + (ty + bx * 1) * 512];
        temp_6 = inputs[(tx + 6 * 64) + (ty + bx * 1) * 512];
        temp_7 = inputs[(tx + 7 * 64) + (ty + bx * 1) * 512];
        
        __id[0] = 0 + tx;
        __id[1] = 64 + tx;
        __id[2] = 128 + tx;
        __id[3] = 192 + tx;
        __id[4] = 256 + tx;
        __id[5] = 320 + tx;
        __id[6] = 384 + tx;
        __id[7] = 448 + tx;
        
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
            
            MY_MUL(temp_4, tmp_angle, tmp);
            temp_4 = tmp;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_6, tmp_angle, tmp);
            temp_6 = tmp;
            
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
            
            MY_MUL(temp_2, tmp_angle, tmp);
            temp_2 = tmp;
            
            MY_MUL(temp_6, tmp_angle_rot, tmp);
            temp_6 = tmp;
            
            MY_MUL(temp_3, tmp_angle, tmp);
            temp_3 = tmp;
            
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
        
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 0) / (float)(512), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 1) / (float)(512), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 2) / (float)(512), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 3) / (float)(512), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 4) / (float)(512), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 5) / (float)(512), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 6) / (float)(512), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 7) / (float)(512), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
        sdata[((ty * 512 + __id[0]) / 16) * 17 + 
        (ty * 512 + __id[0]) % 16] = temp_0;
        
        sdata[((ty * 512 + __id[4]) / 16) * 17 + 
        (ty * 512 + __id[4]) % 16] = temp_4;
        
        sdata[((ty * 512 + __id[2]) / 16) * 17 + 
        (ty * 512 + __id[2]) % 16] = temp_2;
        
        sdata[((ty * 512 + __id[6]) / 16) * 17 + 
        (ty * 512 + __id[6]) % 16] = temp_6;
        
        sdata[((ty * 512 + __id[1]) / 16) * 17 + 
        (ty * 512 + __id[1]) % 16] = temp_1;
        
        sdata[((ty * 512 + __id[5]) / 16) * 17 + 
        (ty * 512 + __id[5]) % 16] = temp_5;
        
        sdata[((ty * 512 + __id[3]) / 16) * 17 + 
        (ty * 512 + __id[3]) % 16] = temp_3;
        
        sdata[((ty * 512 + __id[7]) / 16) * 17 + 
        (ty * 512 + __id[7]) % 16] = temp_7;
        
        __syncthreads();
        
        temp_0 = sdata[((ty * 512 + 0 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 0 * blockDim.x + tx) % 16)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[((ty * 512 + 1 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 1 * blockDim.x + tx) % 16)];
        __id[1] = tx + 64;
        
        temp_2 = sdata[((ty * 512 + 2 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 2 * blockDim.x + tx) % 16)];
        __id[2] = tx + 128;
        
        temp_3 = sdata[((ty * 512 + 3 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 3 * blockDim.x + tx) % 16)];
        __id[3] = tx + 192;
        
        temp_4 = sdata[((ty * 512 + 4 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 4 * blockDim.x + tx) % 16)];
        __id[4] = tx + 256;
        
        temp_5 = sdata[((ty * 512 + 5 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 5 * blockDim.x + tx) % 16)];
        __id[5] = tx + 320;
        
        temp_6 = sdata[((ty * 512 + 6 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 6 * blockDim.x + tx) % 16)];
        __id[6] = tx + 384;
        
        temp_7 = sdata[((ty * 512 + 7 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 7 * blockDim.x + tx) % 16)];
        __id[7] = tx + 448;
        
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
            
            MY_MUL(temp_4, tmp_angle, tmp);
            temp_4 = tmp;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_6, tmp_angle, tmp);
            temp_6 = tmp;
            
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
            
            MY_MUL(temp_2, tmp_angle, tmp);
            temp_2 = tmp;
            
            MY_MUL(temp_6, tmp_angle_rot, tmp);
            temp_6 = tmp;
            
            MY_MUL(temp_3, tmp_angle, tmp);
            temp_3 = tmp;
            
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
        
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 8) * 0) / (float)(64.0), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 8) * 1) / (float)(64.0), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 8) * 2) / (float)(64.0), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 8) * 3) / (float)(64.0), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 8) * 4) / (float)(64.0), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 8) * 5) / (float)(64.0), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 8) * 6) / (float)(64.0), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 8) * 7) / (float)(64.0), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
        sdata[((ty * 512 + __id[0]) / 16) * 17 + 
        (ty * 512 + __id[0]) % 16] = temp_0;
        
        sdata[((ty * 512 + __id[4]) / 16) * 17 + 
        (ty * 512 + __id[4]) % 16] = temp_4;
        
        sdata[((ty * 512 + __id[2]) / 16) * 17 + 
        (ty * 512 + __id[2]) % 16] = temp_2;
        
        sdata[((ty * 512 + __id[6]) / 16) * 17 + 
        (ty * 512 + __id[6]) % 16] = temp_6;
        
        sdata[((ty * 512 + __id[1]) / 16) * 17 + 
        (ty * 512 + __id[1]) % 16] = temp_1;
        
        sdata[((ty * 512 + __id[5]) / 16) * 17 + 
        (ty * 512 + __id[5]) % 16] = temp_5;
        
        sdata[((ty * 512 + __id[3]) / 16) * 17 + 
        (ty * 512 + __id[3]) % 16] = temp_3;
        
        sdata[((ty * 512 + __id[7]) / 16) * 17 + 
        (ty * 512 + __id[7]) % 16] = temp_7;
        
        __syncthreads();
        
        temp_0 = sdata[((ty * 512 + 0 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 0 * blockDim.x + tx) % 16)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[((ty * 512 + 1 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 1 * blockDim.x + tx) % 16)];
        __id[1] = tx + 64;
        
        temp_2 = sdata[((ty * 512 + 2 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 2 * blockDim.x + tx) % 16)];
        __id[2] = tx + 128;
        
        temp_3 = sdata[((ty * 512 + 3 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 3 * blockDim.x + tx) % 16)];
        __id[3] = tx + 192;
        
        temp_4 = sdata[((ty * 512 + 4 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 4 * blockDim.x + tx) % 16)];
        __id[4] = tx + 256;
        
        temp_5 = sdata[((ty * 512 + 5 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 5 * blockDim.x + tx) % 16)];
        __id[5] = tx + 320;
        
        temp_6 = sdata[((ty * 512 + 6 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 6 * blockDim.x + tx) % 16)];
        __id[6] = tx + 384;
        
        temp_7 = sdata[((ty * 512 + 7 * blockDim.x + tx) / 16) * 17 +
                            ((ty * 512 + 7 * blockDim.x + tx) % 16)];
        __id[7] = tx + 448;
        
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
            
            MY_MUL(temp_4, tmp_angle, tmp);
            temp_4 = tmp;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_6, tmp_angle, tmp);
            temp_6 = tmp;
            
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
            
            MY_MUL(temp_2, tmp_angle, tmp);
            temp_2 = tmp;
            
            MY_MUL(temp_6, tmp_angle_rot, tmp);
            temp_6 = tmp;
            
            MY_MUL(temp_3, tmp_angle, tmp);
            temp_3 = tmp;
            
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
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[1] = tmp_id + 256;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_5, temp_4);
            MY_SUB(tmp, temp_5, temp_5);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[5] = tmp_id + 256;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_3, temp_2);
            MY_SUB(tmp, temp_3, temp_3);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[3] = tmp_id + 256;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_7, temp_6);
            MY_SUB(tmp, temp_7, temp_7);
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[7] = tmp_id + 256;
            
        n_global *= 2;
        
        n_global *= 2;
        // __syncthreads();
        
        // sdata[ty + 1 * __id[0]] = temp_0;
        
        // sdata[ty + 1 * __id[4]] = temp_4;
        
        // sdata[ty + 1 * __id[2]] = temp_2;
        
        // sdata[ty + 1 * __id[6]] = temp_6;
        
        // sdata[ty + 1 * __id[1]] = temp_1;
        
        // sdata[ty + 1 * __id[5]] = temp_5;
        
        // sdata[ty + 1 * __id[3]] = temp_3;
        
        // sdata[ty + 1 * __id[7]] = temp_7;
        
        // __syncthreads();
         
                    // temp_0 = sdata[((tx + ty * 64 + 0) % 1) + 1 * ((tx + ty * 64 + 0) / 1)];
                    outputs[__id[0] + (ty + bx * blockDim.y) * 512] = temp_0;
         
                    // temp_0 = sdata[((tx + ty * 64 + 64) % 1) + 1 * ((tx + ty * 64 + 64) / 1)];
                    outputs[__id[4] + (ty + bx * blockDim.y) * 512] = temp_4;
         
                    // temp_0 = sdata[((tx + ty * 64 + 128) % 1) + 1 * ((tx + ty * 64 + 128) / 1)];
                    outputs[__id[2] + (ty + bx * blockDim.y) * 512] = temp_2;
         
                    // temp_0 = sdata[((tx + ty * 64 + 192) % 1) + 1 * ((tx + ty * 64 + 192) / 1)];
                    outputs[__id[6] + (ty + bx * blockDim.y) * 512] = temp_6;
         
                    // temp_0 = sdata[((tx + ty * 64 + 256) % 1) + 1 * ((tx + ty * 64 + 256) / 1)];
                    outputs[__id[1] + (ty + bx * blockDim.y) * 512] = temp_1;
         
                    // temp_0 = sdata[((tx + ty * 64 + 320) % 1) + 1 * ((tx + ty * 64 + 320) / 1)];
                    outputs[__id[5] + (ty + bx * blockDim.y) * 512] = temp_5;
         
                    // temp_0 = sdata[((tx + ty * 64 + 384) % 1) + 1 * ((tx + ty * 64 + 384) / 1)];
                    outputs[__id[3] + (ty + bx * blockDim.y) * 512] = temp_3;
         
                    // temp_0 = sdata[((tx + ty * 64 + 448) % 1) + 1 * ((tx + ty * 64 + 448) / 1)];
                    outputs[__id[7] + (ty + bx * blockDim.y) * 512] = temp_7;
        
        }
    