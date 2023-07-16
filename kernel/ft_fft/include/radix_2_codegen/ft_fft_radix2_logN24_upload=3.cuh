extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_radix2_logN24_3(float2* inputs, float2* outputs) {

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
    int N = 256;
    int __id[16];
    float2 tmp;
    float2 tmp_angle, tmp_angle_rot;
    int j;
    int k;
    int tmp_id;
    int n = 1, n_global = 1;
    float2 tmp_angle_bk;
    
    temp_0 = inputs[(tx + 16 * ty + 0 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 0 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 0 * 256) % 256 + ((tx + 16 * ty + 0 * 256) / 256) * 256] = temp_0;
    temp_1 = inputs[(tx + 16 * ty + 1 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 1 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 1 * 256) % 256 + ((tx + 16 * ty + 1 * 256) / 256) * 256] = temp_1;
    temp_2 = inputs[(tx + 16 * ty + 2 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 2 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 2 * 256) % 256 + ((tx + 16 * ty + 2 * 256) / 256) * 256] = temp_2;
    temp_3 = inputs[(tx + 16 * ty + 3 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 3 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 3 * 256) % 256 + ((tx + 16 * ty + 3 * 256) / 256) * 256] = temp_3;
    temp_4 = inputs[(tx + 16 * ty + 4 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 4 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 4 * 256) % 256 + ((tx + 16 * ty + 4 * 256) / 256) * 256] = temp_4;
    temp_5 = inputs[(tx + 16 * ty + 5 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 5 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 5 * 256) % 256 + ((tx + 16 * ty + 5 * 256) / 256) * 256] = temp_5;
    temp_6 = inputs[(tx + 16 * ty + 6 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 6 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 6 * 256) % 256 + ((tx + 16 * ty + 6 * 256) / 256) * 256] = temp_6;
    temp_7 = inputs[(tx + 16 * ty + 7 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 7 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 7 * 256) % 256 + ((tx + 16 * ty + 7 * 256) / 256) * 256] = temp_7;
    temp_8 = inputs[(tx + 16 * ty + 8 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 8 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 8 * 256) % 256 + ((tx + 16 * ty + 8 * 256) / 256) * 256] = temp_8;
    temp_9 = inputs[(tx + 16 * ty + 9 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 9 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 9 * 256) % 256 + ((tx + 16 * ty + 9 * 256) / 256) * 256] = temp_9;
    temp_10 = inputs[(tx + 16 * ty + 10 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 10 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 10 * 256) % 256 + ((tx + 16 * ty + 10 * 256) / 256) * 256] = temp_10;
    temp_11 = inputs[(tx + 16 * ty + 11 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 11 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 11 * 256) % 256 + ((tx + 16 * ty + 11 * 256) / 256) * 256] = temp_11;
    temp_12 = inputs[(tx + 16 * ty + 12 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 12 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 12 * 256) % 256 + ((tx + 16 * ty + 12 * 256) / 256) * 256] = temp_12;
    temp_13 = inputs[(tx + 16 * ty + 13 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 13 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 13 * 256) % 256 + ((tx + 16 * ty + 13 * 256) / 256) * 256] = temp_13;
    temp_14 = inputs[(tx + 16 * ty + 14 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 14 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 14 * 256) % 256 + ((tx + 16 * ty + 14 * 256) / 256) * 256] = temp_14;
    temp_15 = inputs[(tx + 16 * ty + 15 * 256) % 256 + (((bx % 16) * 16) + ((tx + 16 * ty + 15 * 256) / 256)) * 65536 + (bx / 16) * 256];
        sdata[(tx + 16 * ty + 15 * 256) % 256 + ((tx + 16 * ty + 15 * 256) / 256) * 256] = temp_15;
    
    __syncthreads();
    temp_0 = sdata[(tx + 0) + ty * 256];
    temp_1 = sdata[(tx + 16) + ty * 256];
    temp_2 = sdata[(tx + 32) + ty * 256];
    temp_3 = sdata[(tx + 48) + ty * 256];
    temp_4 = sdata[(tx + 64) + ty * 256];
    temp_5 = sdata[(tx + 80) + ty * 256];
    temp_6 = sdata[(tx + 96) + ty * 256];
    temp_7 = sdata[(tx + 112) + ty * 256];
    temp_8 = sdata[(tx + 128) + ty * 256];
    temp_9 = sdata[(tx + 144) + ty * 256];
    temp_10 = sdata[(tx + 160) + ty * 256];
    temp_11 = sdata[(tx + 176) + ty * 256];
    temp_12 = sdata[(tx + 192) + ty * 256];
    temp_13 = sdata[(tx + 208) + ty * 256];
    temp_14 = sdata[(tx + 224) + ty * 256];
    temp_15 = sdata[(tx + 240) + ty * 256];
    
    __id[0] = 0 + tx;
    __id[1] = 16 + tx;
    __id[2] = 32 + tx;
    __id[3] = 48 + tx;
    __id[4] = 64 + tx;
    __id[5] = 80 + tx;
    __id[6] = 96 + tx;
    __id[7] = 112 + tx;
    __id[8] = 128 + tx;
    __id[9] = 144 + tx;
    __id[10] = 160 + tx;
    __id[11] = 176 + tx;
    __id[12] = 192 + tx;
    __id[13] = 208 + tx;
    __id[14] = 224 + tx;
    __id[15] = 240 + tx;
    
    j = 1;
    k = 8 % 1;   
    // MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    tmp_angle.x = 1;
    tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
    // MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    tmp_angle.x = 1;
    tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
    // MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    tmp_angle.x = 1;
    tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
    // MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    tmp_angle.x = 1;
    tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        
        MY_MUL(temp_11, tmp_angle_rot, tmp);
        temp_11 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
        temp_7 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 0) / (float)(256), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 1) / (float)(256), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 2) / (float)(256), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 3) / (float)(256), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 4) / (float)(256), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 5) / (float)(256), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 6) / (float)(256), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 7) / (float)(256), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 8) / (float)(256), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 9) / (float)(256), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 10) / (float)(256), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 11) / (float)(256), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 12) / (float)(256), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 13) / (float)(256), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 14) / (float)(256), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    // MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 15) / (float)(256), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    sdata[__id[0] + ty * 256 ] = temp_0;
    
    sdata[__id[8] + ty * 256 ] = temp_8;
    
    sdata[__id[4] + ty * 256 ] = temp_4;
    
    sdata[__id[12] + ty * 256 ] = temp_12;
    
    sdata[__id[2] + ty * 256 ] = temp_2;
    
    sdata[__id[10] + ty * 256 ] = temp_10;
    
    sdata[__id[6] + ty * 256 ] = temp_6;
    
    sdata[__id[14] + ty * 256 ] = temp_14;
    
    sdata[__id[1] + ty * 256 ] = temp_1;
    
    sdata[__id[9] + ty * 256 ] = temp_9;
    
    sdata[__id[5] + ty * 256 ] = temp_5;
    
    sdata[__id[13] + ty * 256 ] = temp_13;
    
    sdata[__id[3] + ty * 256 ] = temp_3;
    
    sdata[__id[11] + ty * 256 ] = temp_11;
    
    sdata[__id[7] + ty * 256 ] = temp_7;
    
    sdata[__id[15] + ty * 256 ] = temp_15;
    
    __syncthreads();
    
    temp_0 = sdata[(tx + 0) + ty * 256];
    __id[0] = tx + 0;
    
    temp_1 = sdata[(tx + 16) + ty * 256];
    __id[1] = tx + 16;
    
    temp_2 = sdata[(tx + 32) + ty * 256];
    __id[2] = tx + 32;
    
    temp_3 = sdata[(tx + 48) + ty * 256];
    __id[3] = tx + 48;
    
    temp_4 = sdata[(tx + 64) + ty * 256];
    __id[4] = tx + 64;
    
    temp_5 = sdata[(tx + 80) + ty * 256];
    __id[5] = tx + 80;
    
    temp_6 = sdata[(tx + 96) + ty * 256];
    __id[6] = tx + 96;
    
    temp_7 = sdata[(tx + 112) + ty * 256];
    __id[7] = tx + 112;
    
    temp_8 = sdata[(tx + 128) + ty * 256];
    __id[8] = tx + 128;
    
    temp_9 = sdata[(tx + 144) + ty * 256];
    __id[9] = tx + 144;
    
    temp_10 = sdata[(tx + 160) + ty * 256];
    __id[10] = tx + 160;
    
    temp_11 = sdata[(tx + 176) + ty * 256];
    __id[11] = tx + 176;
    
    temp_12 = sdata[(tx + 192) + ty * 256];
    __id[12] = tx + 192;
    
    temp_13 = sdata[(tx + 208) + ty * 256];
    __id[13] = tx + 208;
    
    temp_14 = sdata[(tx + 224) + ty * 256];
    __id[14] = tx + 224;
    
    temp_15 = sdata[(tx + 240) + ty * 256];
    __id[15] = tx + 240;
    
    j = 1;
    k = 8 % 1;   
    // MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    tmp_angle.x = 1;
    tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
    // MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    tmp_angle.x = 1;
    tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
    // MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    tmp_angle.x = 1;
    tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
    // MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    tmp_angle.x = 1;
    tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        
        MY_MUL(temp_11, tmp_angle_rot, tmp);
        temp_11 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        
        MY_MUL(temp_7, tmp_angle_rot, tmp);
        temp_7 = tmp;
        
        tmp_angle_rot.x = 0.9238795325112867f;
        tmp_angle_rot.y = -0.3826834323650898f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
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
        
    sdata[__id[0] + ty * 256] = temp_0;
    
    sdata[__id[8] + ty * 256] = temp_8;
    
    sdata[__id[4] + ty * 256] = temp_4;
    
    sdata[__id[12] + ty * 256] = temp_12;
    
    sdata[__id[2] + ty * 256] = temp_2;
    
    sdata[__id[10] + ty * 256] = temp_10;
    
    sdata[__id[6] + ty * 256] = temp_6;
    
    sdata[__id[14] + ty * 256] = temp_14;
    
    sdata[__id[1] + ty * 256] = temp_1;
    
    sdata[__id[9] + ty * 256] = temp_9;
    
    sdata[__id[5] + ty * 256] = temp_5;
    
    sdata[__id[13] + ty * 256] = temp_13;
    
    sdata[__id[3] + ty * 256] = temp_3;
    
    sdata[__id[11] + ty * 256] = temp_11;
    
    sdata[__id[7] + ty * 256] = temp_7;
    
    sdata[__id[15] + ty * 256] = temp_15;
    
    __syncthreads();
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 0 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[0]) * 65536] = temp_0;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[0]) * 65536] = temp_0; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 0) / 16) + ((tx + ty * 16 + 0) % 16) * 256];
    outputs[(((tx + ty * 16 + 0) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 0) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 16 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[8]) * 65536] = temp_8;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[8]) * 65536] = temp_8; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 256) / 16) + ((tx + ty * 16 + 256) % 16) * 256];
    outputs[(((tx + ty * 16 + 256) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 256) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 32 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[4]) * 65536] = temp_4;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[4]) * 65536] = temp_4; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 512) / 16) + ((tx + ty * 16 + 512) % 16) * 256];
    outputs[(((tx + ty * 16 + 512) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 512) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 48 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[12]) * 65536] = temp_12;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[12]) * 65536] = temp_12; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 768) / 16) + ((tx + ty * 16 + 768) % 16) * 256];
    outputs[(((tx + ty * 16 + 768) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 768) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 64 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[2]) * 65536] = temp_2;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[2]) * 65536] = temp_2; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 1024) / 16) + ((tx + ty * 16 + 1024) % 16) * 256];
    outputs[(((tx + ty * 16 + 1024) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 1024) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 80 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[10]) * 65536] = temp_10;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[10]) * 65536] = temp_10; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 1280) / 16) + ((tx + ty * 16 + 1280) % 16) * 256];
    outputs[(((tx + ty * 16 + 1280) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 1280) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 96 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[6]) * 65536] = temp_6;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[6]) * 65536] = temp_6; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 1536) / 16) + ((tx + ty * 16 + 1536) % 16) * 256];
    outputs[(((tx + ty * 16 + 1536) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 1536) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 112 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[14]) * 65536] = temp_14;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[14]) * 65536] = temp_14; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 1792) / 16) + ((tx + ty * 16 + 1792) % 16) * 256];
    outputs[(((tx + ty * 16 + 1792) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 1792) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 128 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[1]) * 65536] = temp_1;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[1]) * 65536] = temp_1; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 2048) / 16) + ((tx + ty * 16 + 2048) % 16) * 256];
    outputs[(((tx + ty * 16 + 2048) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 2048) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 144 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[9]) * 65536] = temp_9;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[9]) * 65536] = temp_9; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 2304) / 16) + ((tx + ty * 16 + 2304) % 16) * 256];
    outputs[(((tx + ty * 16 + 2304) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 2304) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 160 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[5]) * 65536] = temp_5;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[5]) * 65536] = temp_5; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 2560) / 16) + ((tx + ty * 16 + 2560) % 16) * 256];
    outputs[(((tx + ty * 16 + 2560) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 2560) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 176 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[13]) * 65536] = temp_13;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[13]) * 65536] = temp_13; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 2816) / 16) + ((tx + ty * 16 + 2816) % 16) * 256];
    outputs[(((tx + ty * 16 + 2816) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 2816) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 192 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[3]) * 65536] = temp_3;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[3]) * 65536] = temp_3; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 3072) / 16) + ((tx + ty * 16 + 3072) % 16) * 256];
    outputs[(((tx + ty * 16 + 3072) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 3072) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 208 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[11]) * 65536] = temp_11;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[11]) * 65536] = temp_11; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 3328) / 16) + ((tx + ty * 16 + 3328) % 16) * 256];
    outputs[(((tx + ty * 16 + 3328) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 3328) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 224 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[7]) * 65536] = temp_7;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[7]) * 65536] = temp_7; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 3584) / 16) + ((tx + ty * 16 + 3584) % 16) * 256];
    outputs[(((tx + ty * 16 + 3584) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 3584) / 16) * 65536] = temp_0; 
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 240 + ty * 65536 + (bx % 16) * 1048576 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    
    // outputs[(bx / 16) + ((bx % 16) * 16 + ty) * 256 + (__id[15]) * 65536] = temp_15;
    // outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[15]) * 65536] = temp_15; 
    
    
    temp_0 = sdata[((tx + ty * 16 + 3840) / 16) + ((tx + ty * 16 + 3840) % 16) * 256];
    outputs[(((tx + ty * 16 + 3840) % 16) + (bx % 16) * 16) + (bx / 16) * 256 + ((tx + ty * 16 + 3840) / 16) * 65536] = temp_0; 
    
    }
