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
    int ty = threadIdx.y;
    int bx = blockIdx.x;
    int N = 4096;
    int __id[16];
    float2 tmp;
    float2 tmp_angle, tmp_angle_rot;
    int j;
    int k;
    int tmp_id;
    int n = 1, n_global = 1;
    float2 r[3];
    r[0].x = 1.0f;
    r[0].y = 0.0f;
    r[1].x = -0.5f;
    r[1].y = -0.866f;
    r[2].x = -0.5f;
    r[2].y = 0.866f;
    float2 warp_checksum;
    float2 tmp_angle_bk;
    
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
    
    // j = 1;
    j = 1;
    // k = __id[8] % 1;
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
    
    // j = 1;
    j = 1;
    // k = __id[4] % 2;
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
    
    // j = 1;
    j = 1;
    // k = __id[2] % 4;
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
    
    // j = 1;
    j = 1;
    // k = __id[1] % 8;
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
    
    
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 0) / (float)(4096), tmp_angle);
        MY_MUL(temp_0, tmp_angle, tmp);
        temp_0 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 1) / (float)(4096), tmp_angle);
        MY_MUL(temp_8, tmp_angle, tmp);
        temp_8 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 2) / (float)(4096), tmp_angle);
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 3) / (float)(4096), tmp_angle);
        MY_MUL(temp_12, tmp_angle, tmp);
        temp_12 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 4) / (float)(4096), tmp_angle);
        MY_MUL(temp_2, tmp_angle, tmp);
        temp_2 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 5) / (float)(4096), tmp_angle);
        MY_MUL(temp_10, tmp_angle, tmp);
        temp_10 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 6) / (float)(4096), tmp_angle);
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 7) / (float)(4096), tmp_angle);
        MY_MUL(temp_14, tmp_angle, tmp);
        temp_14 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 8) / (float)(4096), tmp_angle);
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 9) / (float)(4096), tmp_angle);
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 10) / (float)(4096), tmp_angle);
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 11) / (float)(4096), tmp_angle);
        MY_MUL(temp_13, tmp_angle, tmp);
        temp_13 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 12) / (float)(4096), tmp_angle);
        MY_MUL(temp_3, tmp_angle, tmp);
        temp_3 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 13) / (float)(4096), tmp_angle);
        MY_MUL(temp_11, tmp_angle, tmp);
        temp_11 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 14) / (float)(4096), tmp_angle);
        MY_MUL(temp_7, tmp_angle, tmp);
        temp_7 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 256) * 15) / (float)(4096), tmp_angle);
        MY_MUL(temp_15, tmp_angle, tmp);
        temp_15 = tmp;
        
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
    
    // j = 1;
    j = 1;
    // k = __id[8] % 1;
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
    
    // j = 1;
    j = 1;
    // k = __id[4] % 2;
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
    
    // j = 1;
    j = 1;
    // k = __id[2] % 4;
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
    
    // j = 1;
    j = 1;
    // k = __id[1] % 8;
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
    
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 0) / (float)(256.0), tmp_angle);
        MY_MUL(temp_0, tmp_angle, tmp);
        temp_0 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 1) / (float)(256.0), tmp_angle);
        MY_MUL(temp_8, tmp_angle, tmp);
        temp_8 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 2) / (float)(256.0), tmp_angle);
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 3) / (float)(256.0), tmp_angle);
        MY_MUL(temp_12, tmp_angle, tmp);
        temp_12 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 4) / (float)(256.0), tmp_angle);
        MY_MUL(temp_2, tmp_angle, tmp);
        temp_2 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 5) / (float)(256.0), tmp_angle);
        MY_MUL(temp_10, tmp_angle, tmp);
        temp_10 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 6) / (float)(256.0), tmp_angle);
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 7) / (float)(256.0), tmp_angle);
        MY_MUL(temp_14, tmp_angle, tmp);
        temp_14 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 8) / (float)(256.0), tmp_angle);
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 9) / (float)(256.0), tmp_angle);
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 10) / (float)(256.0), tmp_angle);
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 11) / (float)(256.0), tmp_angle);
        MY_MUL(temp_13, tmp_angle, tmp);
        temp_13 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 12) / (float)(256.0), tmp_angle);
        MY_MUL(temp_3, tmp_angle, tmp);
        temp_3 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 13) / (float)(256.0), tmp_angle);
        MY_MUL(temp_11, tmp_angle, tmp);
        temp_11 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 14) / (float)(256.0), tmp_angle);
        MY_MUL(temp_7, tmp_angle, tmp);
        temp_7 = tmp;
        
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + 0 * 1) % 16) * 15) / (float)(256.0), tmp_angle);
        MY_MUL(temp_15, tmp_angle, tmp);
        temp_15 = tmp;
        
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
    
    // j = 1;
    j = 1;
    // k = __id[8] % 1;
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
    
    // j = 1;
    j = 1;
    // k = __id[4] % 2;
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
    
    // j = 1;
    j = 1;
    // k = __id[2] % 4;
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
    
    // j = 1;
    j = 1;
    // k = __id[1] % 8;
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
    __id[1] = tmp_id + 2048;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[9] = tmp_id + 2048;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 2048;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[13] = tmp_id + 2048;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 2048;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[11] = tmp_id + 2048;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 2048;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[15] = tmp_id + 2048;
    
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
