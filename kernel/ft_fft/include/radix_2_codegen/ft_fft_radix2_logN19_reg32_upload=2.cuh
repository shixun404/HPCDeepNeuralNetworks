extern __shared__ float shared[];
    __global__ void __launch_bounds__(128) fft_radix2_logN19_2(float2* inputs, float2* outputs) {
    
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
        float2 temp_16;
        float2 temp_17;
        float2 temp_18;
        float2 temp_19;
        float2 temp_20;
        float2 temp_21;
        float2 temp_22;
        float2 temp_23;
        float2 temp_24;
        float2 temp_25;
        float2 temp_26;
        float2 temp_27;
        float2 temp_28;
        float2 temp_29;
        float2 temp_30;
        float2 temp_31;
        
        float2* sdata = (float2*)shared;
        int tx = threadIdx.x;
        int ty = threadIdx.y;
        int bx = blockIdx.x;
        int N = 1024;
        int __id[32];
        float2 tmp;
        float2 tmp_angle, tmp_angle_rot;
        int j;
        int k;
        int tmp_id;
        int n = 1, n_global = 1;
        float2 tmp_angle_bk;
        
        temp_0 = inputs[(tx + 0 * 32) + (ty + bx * 4) * 1024];
        temp_1 = inputs[(tx + 1 * 32) + (ty + bx * 4) * 1024];
        temp_2 = inputs[(tx + 2 * 32) + (ty + bx * 4) * 1024];
        temp_3 = inputs[(tx + 3 * 32) + (ty + bx * 4) * 1024];
        temp_4 = inputs[(tx + 4 * 32) + (ty + bx * 4) * 1024];
        temp_5 = inputs[(tx + 5 * 32) + (ty + bx * 4) * 1024];
        temp_6 = inputs[(tx + 6 * 32) + (ty + bx * 4) * 1024];
        temp_7 = inputs[(tx + 7 * 32) + (ty + bx * 4) * 1024];
        temp_8 = inputs[(tx + 8 * 32) + (ty + bx * 4) * 1024];
        temp_9 = inputs[(tx + 9 * 32) + (ty + bx * 4) * 1024];
        temp_10 = inputs[(tx + 10 * 32) + (ty + bx * 4) * 1024];
        temp_11 = inputs[(tx + 11 * 32) + (ty + bx * 4) * 1024];
        temp_12 = inputs[(tx + 12 * 32) + (ty + bx * 4) * 1024];
        temp_13 = inputs[(tx + 13 * 32) + (ty + bx * 4) * 1024];
        temp_14 = inputs[(tx + 14 * 32) + (ty + bx * 4) * 1024];
        temp_15 = inputs[(tx + 15 * 32) + (ty + bx * 4) * 1024];
        temp_16 = inputs[(tx + 16 * 32) + (ty + bx * 4) * 1024];
        temp_17 = inputs[(tx + 17 * 32) + (ty + bx * 4) * 1024];
        temp_18 = inputs[(tx + 18 * 32) + (ty + bx * 4) * 1024];
        temp_19 = inputs[(tx + 19 * 32) + (ty + bx * 4) * 1024];
        temp_20 = inputs[(tx + 20 * 32) + (ty + bx * 4) * 1024];
        temp_21 = inputs[(tx + 21 * 32) + (ty + bx * 4) * 1024];
        temp_22 = inputs[(tx + 22 * 32) + (ty + bx * 4) * 1024];
        temp_23 = inputs[(tx + 23 * 32) + (ty + bx * 4) * 1024];
        temp_24 = inputs[(tx + 24 * 32) + (ty + bx * 4) * 1024];
        temp_25 = inputs[(tx + 25 * 32) + (ty + bx * 4) * 1024];
        temp_26 = inputs[(tx + 26 * 32) + (ty + bx * 4) * 1024];
        temp_27 = inputs[(tx + 27 * 32) + (ty + bx * 4) * 1024];
        temp_28 = inputs[(tx + 28 * 32) + (ty + bx * 4) * 1024];
        temp_29 = inputs[(tx + 29 * 32) + (ty + bx * 4) * 1024];
        temp_30 = inputs[(tx + 30 * 32) + (ty + bx * 4) * 1024];
        temp_31 = inputs[(tx + 31 * 32) + (ty + bx * 4) * 1024];
        
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
        __id[16] = 512 + tx;
        __id[17] = 544 + tx;
        __id[18] = 576 + tx;
        __id[19] = 608 + tx;
        __id[20] = 640 + tx;
        __id[21] = 672 + tx;
        __id[22] = 704 + tx;
        __id[23] = 736 + tx;
        __id[24] = 768 + tx;
        __id[25] = 800 + tx;
        __id[26] = 832 + tx;
        __id[27] = 864 + tx;
        __id[28] = 896 + tx;
        __id[29] = 928 + tx;
        __id[30] = 960 + tx;
        __id[31] = 992 + tx;
        
        j = 1;
        k = 16 % 1;
        MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_16, tmp_angle, tmp);
            temp_16 = tmp;
            
            MY_MUL(temp_17, tmp_angle, tmp);
            temp_17 = tmp;
            
            MY_MUL(temp_18, tmp_angle, tmp);
            temp_18 = tmp;
            
            MY_MUL(temp_19, tmp_angle, tmp);
            temp_19 = tmp;
            
            MY_MUL(temp_20, tmp_angle, tmp);
            temp_20 = tmp;
            
            MY_MUL(temp_21, tmp_angle, tmp);
            temp_21 = tmp;
            
            MY_MUL(temp_22, tmp_angle, tmp);
            temp_22 = tmp;
            
            MY_MUL(temp_23, tmp_angle, tmp);
            temp_23 = tmp;
            
            MY_MUL(temp_24, tmp_angle, tmp);
            temp_24 = tmp;
            
            MY_MUL(temp_25, tmp_angle, tmp);
            temp_25 = tmp;
            
            MY_MUL(temp_26, tmp_angle, tmp);
            temp_26 = tmp;
            
            MY_MUL(temp_27, tmp_angle, tmp);
            temp_27 = tmp;
            
            MY_MUL(temp_28, tmp_angle, tmp);
            temp_28 = tmp;
            
            MY_MUL(temp_29, tmp_angle, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_30, tmp_angle, tmp);
            temp_30 = tmp;
            
            MY_MUL(temp_31, tmp_angle, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_16, temp_0);
            MY_SUB(tmp, temp_16, temp_16);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[16] = tmp_id + 1;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_17, temp_1);
            MY_SUB(tmp, temp_17, temp_17);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[17] = tmp_id + 1;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_18, temp_2);
            MY_SUB(tmp, temp_18, temp_18);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[18] = tmp_id + 1;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_19, temp_3);
            MY_SUB(tmp, temp_19, temp_19);
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[19] = tmp_id + 1;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_20, temp_4);
            MY_SUB(tmp, temp_20, temp_20);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[20] = tmp_id + 1;
            
            tmp = temp_5;
            MY_ADD(tmp, temp_21, temp_5);
            MY_SUB(tmp, temp_21, temp_21);
            tmp_id = __id[5];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[5] = tmp_id;
            __id[21] = tmp_id + 1;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_22, temp_6);
            MY_SUB(tmp, temp_22, temp_22);
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[22] = tmp_id + 1;
            
            tmp = temp_7;
            MY_ADD(tmp, temp_23, temp_7);
            MY_SUB(tmp, temp_23, temp_23);
            tmp_id = __id[7];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[7] = tmp_id;
            __id[23] = tmp_id + 1;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_24, temp_8);
            MY_SUB(tmp, temp_24, temp_24);
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[24] = tmp_id + 1;
            
            tmp = temp_9;
            MY_ADD(tmp, temp_25, temp_9);
            MY_SUB(tmp, temp_25, temp_25);
            tmp_id = __id[9];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[9] = tmp_id;
            __id[25] = tmp_id + 1;
            
            tmp = temp_10;
            MY_ADD(tmp, temp_26, temp_10);
            MY_SUB(tmp, temp_26, temp_26);
            tmp_id = __id[10];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[10] = tmp_id;
            __id[26] = tmp_id + 1;
            
            tmp = temp_11;
            MY_ADD(tmp, temp_27, temp_11);
            MY_SUB(tmp, temp_27, temp_27);
            tmp_id = __id[11];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[11] = tmp_id;
            __id[27] = tmp_id + 1;
            
            tmp = temp_12;
            MY_ADD(tmp, temp_28, temp_12);
            MY_SUB(tmp, temp_28, temp_28);
            tmp_id = __id[12];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[12] = tmp_id;
            __id[28] = tmp_id + 1;
            
            tmp = temp_13;
            MY_ADD(tmp, temp_29, temp_13);
            MY_SUB(tmp, temp_29, temp_29);
            tmp_id = __id[13];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[13] = tmp_id;
            __id[29] = tmp_id + 1;
            
            tmp = temp_14;
            MY_ADD(tmp, temp_30, temp_14);
            MY_SUB(tmp, temp_30, temp_30);
            tmp_id = __id[14];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[14] = tmp_id;
            __id[30] = tmp_id + 1;
            
            tmp = temp_15;
            MY_ADD(tmp, temp_31, temp_15);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[15];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[15] = tmp_id;
            __id[31] = tmp_id + 1;
            
        n_global *= 2;
        
        j = 1;
        k = 16 % 2;
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
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
            
            MY_MUL(temp_24, tmp_angle_rot, tmp);
            temp_24 = tmp;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
            MY_MUL(temp_25, tmp_angle_rot, tmp);
            temp_25 = tmp;
            
            MY_MUL(temp_10, tmp_angle, tmp);
            temp_10 = tmp;
            
            MY_MUL(temp_26, tmp_angle_rot, tmp);
            temp_26 = tmp;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_27, tmp_angle_rot, tmp);
            temp_27 = tmp;
            
            MY_MUL(temp_12, tmp_angle, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_28, tmp_angle_rot, tmp);
            temp_28 = tmp;
            
            MY_MUL(temp_13, tmp_angle, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_29, tmp_angle_rot, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_14, tmp_angle, tmp);
            temp_14 = tmp;
            
            MY_MUL(temp_30, tmp_angle_rot, tmp);
            temp_30 = tmp;
            
            MY_MUL(temp_15, tmp_angle, tmp);
            temp_15 = tmp;
            
            MY_MUL(temp_31, tmp_angle_rot, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_8, temp_0);
            MY_SUB(tmp, temp_8, temp_8);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[8] = tmp_id + 2;
            
            tmp = temp_16;
            MY_ADD(tmp, temp_24, temp_16);
            MY_SUB(tmp, temp_24, temp_24);
            tmp_id = __id[16];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[16] = tmp_id;
            __id[24] = tmp_id + 2;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_9, temp_1);
            MY_SUB(tmp, temp_9, temp_9);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[9] = tmp_id + 2;
            
            tmp = temp_17;
            MY_ADD(tmp, temp_25, temp_17);
            MY_SUB(tmp, temp_25, temp_25);
            tmp_id = __id[17];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[17] = tmp_id;
            __id[25] = tmp_id + 2;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_10, temp_2);
            MY_SUB(tmp, temp_10, temp_10);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[10] = tmp_id + 2;
            
            tmp = temp_18;
            MY_ADD(tmp, temp_26, temp_18);
            MY_SUB(tmp, temp_26, temp_26);
            tmp_id = __id[18];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[18] = tmp_id;
            __id[26] = tmp_id + 2;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_11, temp_3);
            MY_SUB(tmp, temp_11, temp_11);
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[11] = tmp_id + 2;
            
            tmp = temp_19;
            MY_ADD(tmp, temp_27, temp_19);
            MY_SUB(tmp, temp_27, temp_27);
            tmp_id = __id[19];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[19] = tmp_id;
            __id[27] = tmp_id + 2;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_12, temp_4);
            MY_SUB(tmp, temp_12, temp_12);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[12] = tmp_id + 2;
            
            tmp = temp_20;
            MY_ADD(tmp, temp_28, temp_20);
            MY_SUB(tmp, temp_28, temp_28);
            tmp_id = __id[20];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[20] = tmp_id;
            __id[28] = tmp_id + 2;
            
            tmp = temp_5;
            MY_ADD(tmp, temp_13, temp_5);
            MY_SUB(tmp, temp_13, temp_13);
            tmp_id = __id[5];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[5] = tmp_id;
            __id[13] = tmp_id + 2;
            
            tmp = temp_21;
            MY_ADD(tmp, temp_29, temp_21);
            MY_SUB(tmp, temp_29, temp_29);
            tmp_id = __id[21];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[21] = tmp_id;
            __id[29] = tmp_id + 2;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_14, temp_6);
            MY_SUB(tmp, temp_14, temp_14);
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[14] = tmp_id + 2;
            
            tmp = temp_22;
            MY_ADD(tmp, temp_30, temp_22);
            MY_SUB(tmp, temp_30, temp_30);
            tmp_id = __id[22];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[22] = tmp_id;
            __id[30] = tmp_id + 2;
            
            tmp = temp_7;
            MY_ADD(tmp, temp_15, temp_7);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[7];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[7] = tmp_id;
            __id[15] = tmp_id + 2;
            
            tmp = temp_23;
            MY_ADD(tmp, temp_31, temp_23);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[23];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[23] = tmp_id;
            __id[31] = tmp_id + 2;
            
        n_global *= 2;
        
        j = 1;
        k = 16 % 4;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
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
            
            tmp_angle_rot.x = 0.7071067811865476f;
            tmp_angle_rot.y = -0.7071067811865475f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_20, tmp_angle, tmp);
            temp_20 = tmp;
            
            MY_MUL(temp_28, tmp_angle_rot, tmp);
            temp_28 = tmp;
            
            MY_MUL(temp_21, tmp_angle, tmp);
            temp_21 = tmp;
            
            MY_MUL(temp_29, tmp_angle_rot, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_22, tmp_angle, tmp);
            temp_22 = tmp;
            
            MY_MUL(temp_30, tmp_angle_rot, tmp);
            temp_30 = tmp;
            
            MY_MUL(temp_23, tmp_angle, tmp);
            temp_23 = tmp;
            
            MY_MUL(temp_31, tmp_angle_rot, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_4, temp_0);
            MY_SUB(tmp, temp_4, temp_4);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[4] = tmp_id + 4;
            
            tmp = temp_16;
            MY_ADD(tmp, temp_20, temp_16);
            MY_SUB(tmp, temp_20, temp_20);
            tmp_id = __id[16];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[16] = tmp_id;
            __id[20] = tmp_id + 4;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_12, temp_8);
            MY_SUB(tmp, temp_12, temp_12);
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[12] = tmp_id + 4;
            
            tmp = temp_24;
            MY_ADD(tmp, temp_28, temp_24);
            MY_SUB(tmp, temp_28, temp_28);
            tmp_id = __id[24];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[24] = tmp_id;
            __id[28] = tmp_id + 4;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_5, temp_1);
            MY_SUB(tmp, temp_5, temp_5);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[5] = tmp_id + 4;
            
            tmp = temp_17;
            MY_ADD(tmp, temp_21, temp_17);
            MY_SUB(tmp, temp_21, temp_21);
            tmp_id = __id[17];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[17] = tmp_id;
            __id[21] = tmp_id + 4;
            
            tmp = temp_9;
            MY_ADD(tmp, temp_13, temp_9);
            MY_SUB(tmp, temp_13, temp_13);
            tmp_id = __id[9];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[9] = tmp_id;
            __id[13] = tmp_id + 4;
            
            tmp = temp_25;
            MY_ADD(tmp, temp_29, temp_25);
            MY_SUB(tmp, temp_29, temp_29);
            tmp_id = __id[25];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[25] = tmp_id;
            __id[29] = tmp_id + 4;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_6, temp_2);
            MY_SUB(tmp, temp_6, temp_6);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[6] = tmp_id + 4;
            
            tmp = temp_18;
            MY_ADD(tmp, temp_22, temp_18);
            MY_SUB(tmp, temp_22, temp_22);
            tmp_id = __id[18];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[18] = tmp_id;
            __id[22] = tmp_id + 4;
            
            tmp = temp_10;
            MY_ADD(tmp, temp_14, temp_10);
            MY_SUB(tmp, temp_14, temp_14);
            tmp_id = __id[10];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[10] = tmp_id;
            __id[14] = tmp_id + 4;
            
            tmp = temp_26;
            MY_ADD(tmp, temp_30, temp_26);
            MY_SUB(tmp, temp_30, temp_30);
            tmp_id = __id[26];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[26] = tmp_id;
            __id[30] = tmp_id + 4;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_7, temp_3);
            MY_SUB(tmp, temp_7, temp_7);
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[7] = tmp_id + 4;
            
            tmp = temp_19;
            MY_ADD(tmp, temp_23, temp_19);
            MY_SUB(tmp, temp_23, temp_23);
            tmp_id = __id[19];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[19] = tmp_id;
            __id[23] = tmp_id + 4;
            
            tmp = temp_11;
            MY_ADD(tmp, temp_15, temp_11);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[11];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[11] = tmp_id;
            __id[15] = tmp_id + 4;
            
            tmp = temp_27;
            MY_ADD(tmp, temp_31, temp_27);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[27];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[27] = tmp_id;
            __id[31] = tmp_id + 4;
            
        n_global *= 2;
        
        j = 1;
        k = 16 % 8;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
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
            
            tmp_angle_rot.x = 0.9238795325112867f;
            tmp_angle_rot.y = -0.3826834323650898f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_18, tmp_angle, tmp);
            temp_18 = tmp;
            
            MY_MUL(temp_22, tmp_angle_rot, tmp);
            temp_22 = tmp;
            
            MY_MUL(temp_19, tmp_angle, tmp);
            temp_19 = tmp;
            
            MY_MUL(temp_23, tmp_angle_rot, tmp);
            temp_23 = tmp;
            
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
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_15, tmp_angle_rot, tmp);
            temp_15 = tmp;
            
            tmp_angle_rot.x = 0.9238795325112867f;
            tmp_angle_rot.y = -0.3826834323650898f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_26, tmp_angle, tmp);
            temp_26 = tmp;
            
            MY_MUL(temp_30, tmp_angle_rot, tmp);
            temp_30 = tmp;
            
            MY_MUL(temp_27, tmp_angle, tmp);
            temp_27 = tmp;
            
            MY_MUL(temp_31, tmp_angle_rot, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_2, temp_0);
            MY_SUB(tmp, temp_2, temp_2);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[2] = tmp_id + 8;
            
            tmp = temp_16;
            MY_ADD(tmp, temp_18, temp_16);
            MY_SUB(tmp, temp_18, temp_18);
            tmp_id = __id[16];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[16] = tmp_id;
            __id[18] = tmp_id + 8;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_10, temp_8);
            MY_SUB(tmp, temp_10, temp_10);
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[10] = tmp_id + 8;
            
            tmp = temp_24;
            MY_ADD(tmp, temp_26, temp_24);
            MY_SUB(tmp, temp_26, temp_26);
            tmp_id = __id[24];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[24] = tmp_id;
            __id[26] = tmp_id + 8;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_6, temp_4);
            MY_SUB(tmp, temp_6, temp_6);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[6] = tmp_id + 8;
            
            tmp = temp_20;
            MY_ADD(tmp, temp_22, temp_20);
            MY_SUB(tmp, temp_22, temp_22);
            tmp_id = __id[20];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[20] = tmp_id;
            __id[22] = tmp_id + 8;
            
            tmp = temp_12;
            MY_ADD(tmp, temp_14, temp_12);
            MY_SUB(tmp, temp_14, temp_14);
            tmp_id = __id[12];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[12] = tmp_id;
            __id[14] = tmp_id + 8;
            
            tmp = temp_28;
            MY_ADD(tmp, temp_30, temp_28);
            MY_SUB(tmp, temp_30, temp_30);
            tmp_id = __id[28];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[28] = tmp_id;
            __id[30] = tmp_id + 8;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_3, temp_1);
            MY_SUB(tmp, temp_3, temp_3);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[3] = tmp_id + 8;
            
            tmp = temp_17;
            MY_ADD(tmp, temp_19, temp_17);
            MY_SUB(tmp, temp_19, temp_19);
            tmp_id = __id[17];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[17] = tmp_id;
            __id[19] = tmp_id + 8;
            
            tmp = temp_9;
            MY_ADD(tmp, temp_11, temp_9);
            MY_SUB(tmp, temp_11, temp_11);
            tmp_id = __id[9];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[9] = tmp_id;
            __id[11] = tmp_id + 8;
            
            tmp = temp_25;
            MY_ADD(tmp, temp_27, temp_25);
            MY_SUB(tmp, temp_27, temp_27);
            tmp_id = __id[25];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[25] = tmp_id;
            __id[27] = tmp_id + 8;
            
            tmp = temp_5;
            MY_ADD(tmp, temp_7, temp_5);
            MY_SUB(tmp, temp_7, temp_7);
            tmp_id = __id[5];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[5] = tmp_id;
            __id[7] = tmp_id + 8;
            
            tmp = temp_21;
            MY_ADD(tmp, temp_23, temp_21);
            MY_SUB(tmp, temp_23, temp_23);
            tmp_id = __id[21];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[21] = tmp_id;
            __id[23] = tmp_id + 8;
            
            tmp = temp_13;
            MY_ADD(tmp, temp_15, temp_13);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[13];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[13] = tmp_id;
            __id[15] = tmp_id + 8;
            
            tmp = temp_29;
            MY_ADD(tmp, temp_31, temp_29);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[29];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[29] = tmp_id;
            __id[31] = tmp_id + 8;
            
        n_global *= 2;
        
        j = 1;
        k = 16 % 16;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
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
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_17, tmp_angle, tmp);
            temp_17 = tmp;
            
            MY_MUL(temp_19, tmp_angle_rot, tmp);
            temp_19 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
            MY_MUL(temp_11, tmp_angle_rot, tmp);
            temp_11 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_25, tmp_angle, tmp);
            temp_25 = tmp;
            
            MY_MUL(temp_27, tmp_angle_rot, tmp);
            temp_27 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_7, tmp_angle_rot, tmp);
            temp_7 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_21, tmp_angle, tmp);
            temp_21 = tmp;
            
            MY_MUL(temp_23, tmp_angle_rot, tmp);
            temp_23 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_13, tmp_angle, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_15, tmp_angle_rot, tmp);
            temp_15 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_29, tmp_angle, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_31, tmp_angle_rot, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_1, temp_0);
            MY_SUB(tmp, temp_1, temp_1);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[1] = tmp_id + 16;
            
            tmp = temp_16;
            MY_ADD(tmp, temp_17, temp_16);
            MY_SUB(tmp, temp_17, temp_17);
            tmp_id = __id[16];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[16] = tmp_id;
            __id[17] = tmp_id + 16;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_9, temp_8);
            MY_SUB(tmp, temp_9, temp_9);
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[9] = tmp_id + 16;
            
            tmp = temp_24;
            MY_ADD(tmp, temp_25, temp_24);
            MY_SUB(tmp, temp_25, temp_25);
            tmp_id = __id[24];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[24] = tmp_id;
            __id[25] = tmp_id + 16;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_5, temp_4);
            MY_SUB(tmp, temp_5, temp_5);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[5] = tmp_id + 16;
            
            tmp = temp_20;
            MY_ADD(tmp, temp_21, temp_20);
            MY_SUB(tmp, temp_21, temp_21);
            tmp_id = __id[20];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[20] = tmp_id;
            __id[21] = tmp_id + 16;
            
            tmp = temp_12;
            MY_ADD(tmp, temp_13, temp_12);
            MY_SUB(tmp, temp_13, temp_13);
            tmp_id = __id[12];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[12] = tmp_id;
            __id[13] = tmp_id + 16;
            
            tmp = temp_28;
            MY_ADD(tmp, temp_29, temp_28);
            MY_SUB(tmp, temp_29, temp_29);
            tmp_id = __id[28];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[28] = tmp_id;
            __id[29] = tmp_id + 16;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_3, temp_2);
            MY_SUB(tmp, temp_3, temp_3);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[3] = tmp_id + 16;
            
            tmp = temp_18;
            MY_ADD(tmp, temp_19, temp_18);
            MY_SUB(tmp, temp_19, temp_19);
            tmp_id = __id[18];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[18] = tmp_id;
            __id[19] = tmp_id + 16;
            
            tmp = temp_10;
            MY_ADD(tmp, temp_11, temp_10);
            MY_SUB(tmp, temp_11, temp_11);
            tmp_id = __id[10];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[10] = tmp_id;
            __id[11] = tmp_id + 16;
            
            tmp = temp_26;
            MY_ADD(tmp, temp_27, temp_26);
            MY_SUB(tmp, temp_27, temp_27);
            tmp_id = __id[26];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[26] = tmp_id;
            __id[27] = tmp_id + 16;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_7, temp_6);
            MY_SUB(tmp, temp_7, temp_7);
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[7] = tmp_id + 16;
            
            tmp = temp_22;
            MY_ADD(tmp, temp_23, temp_22);
            MY_SUB(tmp, temp_23, temp_23);
            tmp_id = __id[22];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[22] = tmp_id;
            __id[23] = tmp_id + 16;
            
            tmp = temp_14;
            MY_ADD(tmp, temp_15, temp_14);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[14];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[14] = tmp_id;
            __id[15] = tmp_id + 16;
            
            tmp = temp_30;
            MY_ADD(tmp, temp_31, temp_30);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[30];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[30] = tmp_id;
            __id[31] = tmp_id + 16;
            
        n_global *= 2;
        
        __syncthreads();
        
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 0) / (float)(1024), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 1) / (float)(1024), tmp_angle);
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 2) / (float)(1024), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 3) / (float)(1024), tmp_angle);
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 4) / (float)(1024), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 5) / (float)(1024), tmp_angle);
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 6) / (float)(1024), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 7) / (float)(1024), tmp_angle);
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 8) / (float)(1024), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 9) / (float)(1024), tmp_angle);
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 10) / (float)(1024), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 11) / (float)(1024), tmp_angle);
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 12) / (float)(1024), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 13) / (float)(1024), tmp_angle);
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 14) / (float)(1024), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 15) / (float)(1024), tmp_angle);
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 16) / (float)(1024), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 17) / (float)(1024), tmp_angle);
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 18) / (float)(1024), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 19) / (float)(1024), tmp_angle);
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 20) / (float)(1024), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 21) / (float)(1024), tmp_angle);
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 22) / (float)(1024), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 23) / (float)(1024), tmp_angle);
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 24) / (float)(1024), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 25) / (float)(1024), tmp_angle);
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 26) / (float)(1024), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 27) / (float)(1024), tmp_angle);
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 28) / (float)(1024), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 29) / (float)(1024), tmp_angle);
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 30) / (float)(1024), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / 1) * 31) / (float)(1024), tmp_angle);
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    
        sdata[ty * 1024 + __id[0]] = temp_0;
        
        sdata[ty * 1024 + __id[16]] = temp_16;
        
        sdata[ty * 1024 + __id[8]] = temp_8;
        
        sdata[ty * 1024 + __id[24]] = temp_24;
        
        sdata[ty * 1024 + __id[4]] = temp_4;
        
        sdata[ty * 1024 + __id[20]] = temp_20;
        
        sdata[ty * 1024 + __id[12]] = temp_12;
        
        sdata[ty * 1024 + __id[28]] = temp_28;
        
        sdata[ty * 1024 + __id[2]] = temp_2;
        
        sdata[ty * 1024 + __id[18]] = temp_18;
        
        sdata[ty * 1024 + __id[10]] = temp_10;
        
        sdata[ty * 1024 + __id[26]] = temp_26;
        
        sdata[ty * 1024 + __id[6]] = temp_6;
        
        sdata[ty * 1024 + __id[22]] = temp_22;
        
        sdata[ty * 1024 + __id[14]] = temp_14;
        
        sdata[ty * 1024 + __id[30]] = temp_30;
        
        sdata[ty * 1024 + __id[1]] = temp_1;
        
        sdata[ty * 1024 + __id[17]] = temp_17;
        
        sdata[ty * 1024 + __id[9]] = temp_9;
        
        sdata[ty * 1024 + __id[25]] = temp_25;
        
        sdata[ty * 1024 + __id[5]] = temp_5;
        
        sdata[ty * 1024 + __id[21]] = temp_21;
        
        sdata[ty * 1024 + __id[13]] = temp_13;
        
        sdata[ty * 1024 + __id[29]] = temp_29;
        
        sdata[ty * 1024 + __id[3]] = temp_3;
        
        sdata[ty * 1024 + __id[19]] = temp_19;
        
        sdata[ty * 1024 + __id[11]] = temp_11;
        
        sdata[ty * 1024 + __id[27]] = temp_27;
        
        sdata[ty * 1024 + __id[7]] = temp_7;
        
        sdata[ty * 1024 + __id[23]] = temp_23;
        
        sdata[ty * 1024 + __id[15]] = temp_15;
        
        sdata[ty * 1024 + __id[31]] = temp_31;
        
        __syncthreads();
        
        temp_0 = sdata[ty * 1024 + (0 + tx)];
        __id[0] = tx + 0;
        
        temp_1 = sdata[ty * 1024 + (32 + tx)];
        __id[1] = tx + 32;
        
        temp_2 = sdata[ty * 1024 + (64 + tx)];
        __id[2] = tx + 64;
        
        temp_3 = sdata[ty * 1024 + (96 + tx)];
        __id[3] = tx + 96;
        
        temp_4 = sdata[ty * 1024 + (128 + tx)];
        __id[4] = tx + 128;
        
        temp_5 = sdata[ty * 1024 + (160 + tx)];
        __id[5] = tx + 160;
        
        temp_6 = sdata[ty * 1024 + (192 + tx)];
        __id[6] = tx + 192;
        
        temp_7 = sdata[ty * 1024 + (224 + tx)];
        __id[7] = tx + 224;
        
        temp_8 = sdata[ty * 1024 + (256 + tx)];
        __id[8] = tx + 256;
        
        temp_9 = sdata[ty * 1024 + (288 + tx)];
        __id[9] = tx + 288;
        
        temp_10 = sdata[ty * 1024 + (320 + tx)];
        __id[10] = tx + 320;
        
        temp_11 = sdata[ty * 1024 + (352 + tx)];
        __id[11] = tx + 352;
        
        temp_12 = sdata[ty * 1024 + (384 + tx)];
        __id[12] = tx + 384;
        
        temp_13 = sdata[ty * 1024 + (416 + tx)];
        __id[13] = tx + 416;
        
        temp_14 = sdata[ty * 1024 + (448 + tx)];
        __id[14] = tx + 448;
        
        temp_15 = sdata[ty * 1024 + (480 + tx)];
        __id[15] = tx + 480;
        
        temp_16 = sdata[ty * 1024 + (512 + tx)];
        __id[16] = tx + 512;
        
        temp_17 = sdata[ty * 1024 + (544 + tx)];
        __id[17] = tx + 544;
        
        temp_18 = sdata[ty * 1024 + (576 + tx)];
        __id[18] = tx + 576;
        
        temp_19 = sdata[ty * 1024 + (608 + tx)];
        __id[19] = tx + 608;
        
        temp_20 = sdata[ty * 1024 + (640 + tx)];
        __id[20] = tx + 640;
        
        temp_21 = sdata[ty * 1024 + (672 + tx)];
        __id[21] = tx + 672;
        
        temp_22 = sdata[ty * 1024 + (704 + tx)];
        __id[22] = tx + 704;
        
        temp_23 = sdata[ty * 1024 + (736 + tx)];
        __id[23] = tx + 736;
        
        temp_24 = sdata[ty * 1024 + (768 + tx)];
        __id[24] = tx + 768;
        
        temp_25 = sdata[ty * 1024 + (800 + tx)];
        __id[25] = tx + 800;
        
        temp_26 = sdata[ty * 1024 + (832 + tx)];
        __id[26] = tx + 832;
        
        temp_27 = sdata[ty * 1024 + (864 + tx)];
        __id[27] = tx + 864;
        
        temp_28 = sdata[ty * 1024 + (896 + tx)];
        __id[28] = tx + 896;
        
        temp_29 = sdata[ty * 1024 + (928 + tx)];
        __id[29] = tx + 928;
        
        temp_30 = sdata[ty * 1024 + (960 + tx)];
        __id[30] = tx + 960;
        
        temp_31 = sdata[ty * 1024 + (992 + tx)];
        __id[31] = tx + 992;
        
        j = 1;
        k = 16 % 1;
        MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        
                        tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_16, tmp_angle, tmp);
            temp_16 = tmp;
            
            MY_MUL(temp_17, tmp_angle, tmp);
            temp_17 = tmp;
            
            MY_MUL(temp_18, tmp_angle, tmp);
            temp_18 = tmp;
            
            MY_MUL(temp_19, tmp_angle, tmp);
            temp_19 = tmp;
            
            MY_MUL(temp_20, tmp_angle, tmp);
            temp_20 = tmp;
            
            MY_MUL(temp_21, tmp_angle, tmp);
            temp_21 = tmp;
            
            MY_MUL(temp_22, tmp_angle, tmp);
            temp_22 = tmp;
            
            MY_MUL(temp_23, tmp_angle, tmp);
            temp_23 = tmp;
            
            MY_MUL(temp_24, tmp_angle, tmp);
            temp_24 = tmp;
            
            MY_MUL(temp_25, tmp_angle, tmp);
            temp_25 = tmp;
            
            MY_MUL(temp_26, tmp_angle, tmp);
            temp_26 = tmp;
            
            MY_MUL(temp_27, tmp_angle, tmp);
            temp_27 = tmp;
            
            MY_MUL(temp_28, tmp_angle, tmp);
            temp_28 = tmp;
            
            MY_MUL(temp_29, tmp_angle, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_30, tmp_angle, tmp);
            temp_30 = tmp;
            
            MY_MUL(temp_31, tmp_angle, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_16, temp_0);
            MY_SUB(tmp, temp_16, temp_16);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[16] = tmp_id + 32;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_17, temp_1);
            MY_SUB(tmp, temp_17, temp_17);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[17] = tmp_id + 32;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_18, temp_2);
            MY_SUB(tmp, temp_18, temp_18);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[18] = tmp_id + 32;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_19, temp_3);
            MY_SUB(tmp, temp_19, temp_19);
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[19] = tmp_id + 32;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_20, temp_4);
            MY_SUB(tmp, temp_20, temp_20);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[20] = tmp_id + 32;
            
            tmp = temp_5;
            MY_ADD(tmp, temp_21, temp_5);
            MY_SUB(tmp, temp_21, temp_21);
            tmp_id = __id[5];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[5] = tmp_id;
            __id[21] = tmp_id + 32;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_22, temp_6);
            MY_SUB(tmp, temp_22, temp_22);
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[22] = tmp_id + 32;
            
            tmp = temp_7;
            MY_ADD(tmp, temp_23, temp_7);
            MY_SUB(tmp, temp_23, temp_23);
            tmp_id = __id[7];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[7] = tmp_id;
            __id[23] = tmp_id + 32;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_24, temp_8);
            MY_SUB(tmp, temp_24, temp_24);
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[24] = tmp_id + 32;
            
            tmp = temp_9;
            MY_ADD(tmp, temp_25, temp_9);
            MY_SUB(tmp, temp_25, temp_25);
            tmp_id = __id[9];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[9] = tmp_id;
            __id[25] = tmp_id + 32;
            
            tmp = temp_10;
            MY_ADD(tmp, temp_26, temp_10);
            MY_SUB(tmp, temp_26, temp_26);
            tmp_id = __id[10];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[10] = tmp_id;
            __id[26] = tmp_id + 32;
            
            tmp = temp_11;
            MY_ADD(tmp, temp_27, temp_11);
            MY_SUB(tmp, temp_27, temp_27);
            tmp_id = __id[11];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[11] = tmp_id;
            __id[27] = tmp_id + 32;
            
            tmp = temp_12;
            MY_ADD(tmp, temp_28, temp_12);
            MY_SUB(tmp, temp_28, temp_28);
            tmp_id = __id[12];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[12] = tmp_id;
            __id[28] = tmp_id + 32;
            
            tmp = temp_13;
            MY_ADD(tmp, temp_29, temp_13);
            MY_SUB(tmp, temp_29, temp_29);
            tmp_id = __id[13];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[13] = tmp_id;
            __id[29] = tmp_id + 32;
            
            tmp = temp_14;
            MY_ADD(tmp, temp_30, temp_14);
            MY_SUB(tmp, temp_30, temp_30);
            tmp_id = __id[14];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[14] = tmp_id;
            __id[30] = tmp_id + 32;
            
            tmp = temp_15;
            MY_ADD(tmp, temp_31, temp_15);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[15];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[15] = tmp_id;
            __id[31] = tmp_id + 32;
            
        n_global *= 2;
        
        j = 1;
        k = 16 % 2;
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
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
            
            MY_MUL(temp_24, tmp_angle_rot, tmp);
            temp_24 = tmp;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
            MY_MUL(temp_25, tmp_angle_rot, tmp);
            temp_25 = tmp;
            
            MY_MUL(temp_10, tmp_angle, tmp);
            temp_10 = tmp;
            
            MY_MUL(temp_26, tmp_angle_rot, tmp);
            temp_26 = tmp;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_27, tmp_angle_rot, tmp);
            temp_27 = tmp;
            
            MY_MUL(temp_12, tmp_angle, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_28, tmp_angle_rot, tmp);
            temp_28 = tmp;
            
            MY_MUL(temp_13, tmp_angle, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_29, tmp_angle_rot, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_14, tmp_angle, tmp);
            temp_14 = tmp;
            
            MY_MUL(temp_30, tmp_angle_rot, tmp);
            temp_30 = tmp;
            
            MY_MUL(temp_15, tmp_angle, tmp);
            temp_15 = tmp;
            
            MY_MUL(temp_31, tmp_angle_rot, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_8, temp_0);
            MY_SUB(tmp, temp_8, temp_8);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[8] = tmp_id + 64;
            
            tmp = temp_16;
            MY_ADD(tmp, temp_24, temp_16);
            MY_SUB(tmp, temp_24, temp_24);
            tmp_id = __id[16];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[16] = tmp_id;
            __id[24] = tmp_id + 64;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_9, temp_1);
            MY_SUB(tmp, temp_9, temp_9);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[9] = tmp_id + 64;
            
            tmp = temp_17;
            MY_ADD(tmp, temp_25, temp_17);
            MY_SUB(tmp, temp_25, temp_25);
            tmp_id = __id[17];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[17] = tmp_id;
            __id[25] = tmp_id + 64;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_10, temp_2);
            MY_SUB(tmp, temp_10, temp_10);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[10] = tmp_id + 64;
            
            tmp = temp_18;
            MY_ADD(tmp, temp_26, temp_18);
            MY_SUB(tmp, temp_26, temp_26);
            tmp_id = __id[18];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[18] = tmp_id;
            __id[26] = tmp_id + 64;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_11, temp_3);
            MY_SUB(tmp, temp_11, temp_11);
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[11] = tmp_id + 64;
            
            tmp = temp_19;
            MY_ADD(tmp, temp_27, temp_19);
            MY_SUB(tmp, temp_27, temp_27);
            tmp_id = __id[19];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[19] = tmp_id;
            __id[27] = tmp_id + 64;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_12, temp_4);
            MY_SUB(tmp, temp_12, temp_12);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[12] = tmp_id + 64;
            
            tmp = temp_20;
            MY_ADD(tmp, temp_28, temp_20);
            MY_SUB(tmp, temp_28, temp_28);
            tmp_id = __id[20];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[20] = tmp_id;
            __id[28] = tmp_id + 64;
            
            tmp = temp_5;
            MY_ADD(tmp, temp_13, temp_5);
            MY_SUB(tmp, temp_13, temp_13);
            tmp_id = __id[5];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[5] = tmp_id;
            __id[13] = tmp_id + 64;
            
            tmp = temp_21;
            MY_ADD(tmp, temp_29, temp_21);
            MY_SUB(tmp, temp_29, temp_29);
            tmp_id = __id[21];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[21] = tmp_id;
            __id[29] = tmp_id + 64;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_14, temp_6);
            MY_SUB(tmp, temp_14, temp_14);
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[14] = tmp_id + 64;
            
            tmp = temp_22;
            MY_ADD(tmp, temp_30, temp_22);
            MY_SUB(tmp, temp_30, temp_30);
            tmp_id = __id[22];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[22] = tmp_id;
            __id[30] = tmp_id + 64;
            
            tmp = temp_7;
            MY_ADD(tmp, temp_15, temp_7);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[7];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[7] = tmp_id;
            __id[15] = tmp_id + 64;
            
            tmp = temp_23;
            MY_ADD(tmp, temp_31, temp_23);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[23];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[23] = tmp_id;
            __id[31] = tmp_id + 64;
            
        n_global *= 2;
        
        j = 1;
        k = 16 % 4;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
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
            
            tmp_angle_rot.x = 0.7071067811865476f;
            tmp_angle_rot.y = -0.7071067811865475f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_20, tmp_angle, tmp);
            temp_20 = tmp;
            
            MY_MUL(temp_28, tmp_angle_rot, tmp);
            temp_28 = tmp;
            
            MY_MUL(temp_21, tmp_angle, tmp);
            temp_21 = tmp;
            
            MY_MUL(temp_29, tmp_angle_rot, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_22, tmp_angle, tmp);
            temp_22 = tmp;
            
            MY_MUL(temp_30, tmp_angle_rot, tmp);
            temp_30 = tmp;
            
            MY_MUL(temp_23, tmp_angle, tmp);
            temp_23 = tmp;
            
            MY_MUL(temp_31, tmp_angle_rot, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_4, temp_0);
            MY_SUB(tmp, temp_4, temp_4);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[4] = tmp_id + 128;
            
            tmp = temp_16;
            MY_ADD(tmp, temp_20, temp_16);
            MY_SUB(tmp, temp_20, temp_20);
            tmp_id = __id[16];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[16] = tmp_id;
            __id[20] = tmp_id + 128;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_12, temp_8);
            MY_SUB(tmp, temp_12, temp_12);
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[12] = tmp_id + 128;
            
            tmp = temp_24;
            MY_ADD(tmp, temp_28, temp_24);
            MY_SUB(tmp, temp_28, temp_28);
            tmp_id = __id[24];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[24] = tmp_id;
            __id[28] = tmp_id + 128;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_5, temp_1);
            MY_SUB(tmp, temp_5, temp_5);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[5] = tmp_id + 128;
            
            tmp = temp_17;
            MY_ADD(tmp, temp_21, temp_17);
            MY_SUB(tmp, temp_21, temp_21);
            tmp_id = __id[17];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[17] = tmp_id;
            __id[21] = tmp_id + 128;
            
            tmp = temp_9;
            MY_ADD(tmp, temp_13, temp_9);
            MY_SUB(tmp, temp_13, temp_13);
            tmp_id = __id[9];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[9] = tmp_id;
            __id[13] = tmp_id + 128;
            
            tmp = temp_25;
            MY_ADD(tmp, temp_29, temp_25);
            MY_SUB(tmp, temp_29, temp_29);
            tmp_id = __id[25];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[25] = tmp_id;
            __id[29] = tmp_id + 128;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_6, temp_2);
            MY_SUB(tmp, temp_6, temp_6);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[6] = tmp_id + 128;
            
            tmp = temp_18;
            MY_ADD(tmp, temp_22, temp_18);
            MY_SUB(tmp, temp_22, temp_22);
            tmp_id = __id[18];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[18] = tmp_id;
            __id[22] = tmp_id + 128;
            
            tmp = temp_10;
            MY_ADD(tmp, temp_14, temp_10);
            MY_SUB(tmp, temp_14, temp_14);
            tmp_id = __id[10];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[10] = tmp_id;
            __id[14] = tmp_id + 128;
            
            tmp = temp_26;
            MY_ADD(tmp, temp_30, temp_26);
            MY_SUB(tmp, temp_30, temp_30);
            tmp_id = __id[26];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[26] = tmp_id;
            __id[30] = tmp_id + 128;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_7, temp_3);
            MY_SUB(tmp, temp_7, temp_7);
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[7] = tmp_id + 128;
            
            tmp = temp_19;
            MY_ADD(tmp, temp_23, temp_19);
            MY_SUB(tmp, temp_23, temp_23);
            tmp_id = __id[19];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[19] = tmp_id;
            __id[23] = tmp_id + 128;
            
            tmp = temp_11;
            MY_ADD(tmp, temp_15, temp_11);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[11];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[11] = tmp_id;
            __id[15] = tmp_id + 128;
            
            tmp = temp_27;
            MY_ADD(tmp, temp_31, temp_27);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[27];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[27] = tmp_id;
            __id[31] = tmp_id + 128;
            
        n_global *= 2;
        
        j = 1;
        k = 16 % 8;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
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
            
            tmp_angle_rot.x = 0.9238795325112867f;
            tmp_angle_rot.y = -0.3826834323650898f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_18, tmp_angle, tmp);
            temp_18 = tmp;
            
            MY_MUL(temp_22, tmp_angle_rot, tmp);
            temp_22 = tmp;
            
            MY_MUL(temp_19, tmp_angle, tmp);
            temp_19 = tmp;
            
            MY_MUL(temp_23, tmp_angle_rot, tmp);
            temp_23 = tmp;
            
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
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_15, tmp_angle_rot, tmp);
            temp_15 = tmp;
            
            tmp_angle_rot.x = 0.9238795325112867f;
            tmp_angle_rot.y = -0.3826834323650898f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_26, tmp_angle, tmp);
            temp_26 = tmp;
            
            MY_MUL(temp_30, tmp_angle_rot, tmp);
            temp_30 = tmp;
            
            MY_MUL(temp_27, tmp_angle, tmp);
            temp_27 = tmp;
            
            MY_MUL(temp_31, tmp_angle_rot, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_2, temp_0);
            MY_SUB(tmp, temp_2, temp_2);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[2] = tmp_id + 256;
            
            tmp = temp_16;
            MY_ADD(tmp, temp_18, temp_16);
            MY_SUB(tmp, temp_18, temp_18);
            tmp_id = __id[16];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[16] = tmp_id;
            __id[18] = tmp_id + 256;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_10, temp_8);
            MY_SUB(tmp, temp_10, temp_10);
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[10] = tmp_id + 256;
            
            tmp = temp_24;
            MY_ADD(tmp, temp_26, temp_24);
            MY_SUB(tmp, temp_26, temp_26);
            tmp_id = __id[24];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[24] = tmp_id;
            __id[26] = tmp_id + 256;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_6, temp_4);
            MY_SUB(tmp, temp_6, temp_6);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[6] = tmp_id + 256;
            
            tmp = temp_20;
            MY_ADD(tmp, temp_22, temp_20);
            MY_SUB(tmp, temp_22, temp_22);
            tmp_id = __id[20];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[20] = tmp_id;
            __id[22] = tmp_id + 256;
            
            tmp = temp_12;
            MY_ADD(tmp, temp_14, temp_12);
            MY_SUB(tmp, temp_14, temp_14);
            tmp_id = __id[12];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[12] = tmp_id;
            __id[14] = tmp_id + 256;
            
            tmp = temp_28;
            MY_ADD(tmp, temp_30, temp_28);
            MY_SUB(tmp, temp_30, temp_30);
            tmp_id = __id[28];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[28] = tmp_id;
            __id[30] = tmp_id + 256;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_3, temp_1);
            MY_SUB(tmp, temp_3, temp_3);
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[3] = tmp_id + 256;
            
            tmp = temp_17;
            MY_ADD(tmp, temp_19, temp_17);
            MY_SUB(tmp, temp_19, temp_19);
            tmp_id = __id[17];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[17] = tmp_id;
            __id[19] = tmp_id + 256;
            
            tmp = temp_9;
            MY_ADD(tmp, temp_11, temp_9);
            MY_SUB(tmp, temp_11, temp_11);
            tmp_id = __id[9];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[9] = tmp_id;
            __id[11] = tmp_id + 256;
            
            tmp = temp_25;
            MY_ADD(tmp, temp_27, temp_25);
            MY_SUB(tmp, temp_27, temp_27);
            tmp_id = __id[25];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[25] = tmp_id;
            __id[27] = tmp_id + 256;
            
            tmp = temp_5;
            MY_ADD(tmp, temp_7, temp_5);
            MY_SUB(tmp, temp_7, temp_7);
            tmp_id = __id[5];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[5] = tmp_id;
            __id[7] = tmp_id + 256;
            
            tmp = temp_21;
            MY_ADD(tmp, temp_23, temp_21);
            MY_SUB(tmp, temp_23, temp_23);
            tmp_id = __id[21];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[21] = tmp_id;
            __id[23] = tmp_id + 256;
            
            tmp = temp_13;
            MY_ADD(tmp, temp_15, temp_13);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[13];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[13] = tmp_id;
            __id[15] = tmp_id + 256;
            
            tmp = temp_29;
            MY_ADD(tmp, temp_31, temp_29);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[29];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[29] = tmp_id;
            __id[31] = tmp_id + 256;
            
        n_global *= 2;
        
        j = 1;
        k = 16 % 16;
        MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
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
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_17, tmp_angle, tmp);
            temp_17 = tmp;
            
            MY_MUL(temp_19, tmp_angle_rot, tmp);
            temp_19 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
            MY_MUL(temp_11, tmp_angle_rot, tmp);
            temp_11 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_25, tmp_angle, tmp);
            temp_25 = tmp;
            
            MY_MUL(temp_27, tmp_angle_rot, tmp);
            temp_27 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_7, tmp_angle_rot, tmp);
            temp_7 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_21, tmp_angle, tmp);
            temp_21 = tmp;
            
            MY_MUL(temp_23, tmp_angle_rot, tmp);
            temp_23 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_13, tmp_angle, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_15, tmp_angle_rot, tmp);
            temp_15 = tmp;
            
            tmp_angle_rot.x = 0.9807852804032304f;
            tmp_angle_rot.y = -0.19509032201612825f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_29, tmp_angle, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_31, tmp_angle_rot, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_1, temp_0);
            MY_SUB(tmp, temp_1, temp_1);
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[1] = tmp_id + 512;
            
            tmp = temp_16;
            MY_ADD(tmp, temp_17, temp_16);
            MY_SUB(tmp, temp_17, temp_17);
            tmp_id = __id[16];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[16] = tmp_id;
            __id[17] = tmp_id + 512;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_9, temp_8);
            MY_SUB(tmp, temp_9, temp_9);
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[9] = tmp_id + 512;
            
            tmp = temp_24;
            MY_ADD(tmp, temp_25, temp_24);
            MY_SUB(tmp, temp_25, temp_25);
            tmp_id = __id[24];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[24] = tmp_id;
            __id[25] = tmp_id + 512;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_5, temp_4);
            MY_SUB(tmp, temp_5, temp_5);
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[5] = tmp_id + 512;
            
            tmp = temp_20;
            MY_ADD(tmp, temp_21, temp_20);
            MY_SUB(tmp, temp_21, temp_21);
            tmp_id = __id[20];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[20] = tmp_id;
            __id[21] = tmp_id + 512;
            
            tmp = temp_12;
            MY_ADD(tmp, temp_13, temp_12);
            MY_SUB(tmp, temp_13, temp_13);
            tmp_id = __id[12];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[12] = tmp_id;
            __id[13] = tmp_id + 512;
            
            tmp = temp_28;
            MY_ADD(tmp, temp_29, temp_28);
            MY_SUB(tmp, temp_29, temp_29);
            tmp_id = __id[28];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[28] = tmp_id;
            __id[29] = tmp_id + 512;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_3, temp_2);
            MY_SUB(tmp, temp_3, temp_3);
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[3] = tmp_id + 512;
            
            tmp = temp_18;
            MY_ADD(tmp, temp_19, temp_18);
            MY_SUB(tmp, temp_19, temp_19);
            tmp_id = __id[18];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[18] = tmp_id;
            __id[19] = tmp_id + 512;
            
            tmp = temp_10;
            MY_ADD(tmp, temp_11, temp_10);
            MY_SUB(tmp, temp_11, temp_11);
            tmp_id = __id[10];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[10] = tmp_id;
            __id[11] = tmp_id + 512;
            
            tmp = temp_26;
            MY_ADD(tmp, temp_27, temp_26);
            MY_SUB(tmp, temp_27, temp_27);
            tmp_id = __id[26];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[26] = tmp_id;
            __id[27] = tmp_id + 512;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_7, temp_6);
            MY_SUB(tmp, temp_7, temp_7);
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[7] = tmp_id + 512;
            
            tmp = temp_22;
            MY_ADD(tmp, temp_23, temp_22);
            MY_SUB(tmp, temp_23, temp_23);
            tmp_id = __id[22];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[22] = tmp_id;
            __id[23] = tmp_id + 512;
            
            tmp = temp_14;
            MY_ADD(tmp, temp_15, temp_14);
            MY_SUB(tmp, temp_15, temp_15);
            tmp_id = __id[14];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[14] = tmp_id;
            __id[15] = tmp_id + 512;
            
            tmp = temp_30;
            MY_ADD(tmp, temp_31, temp_30);
            MY_SUB(tmp, temp_31, temp_31);
            tmp_id = __id[30];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[30] = tmp_id;
            __id[31] = tmp_id + 512;
            
        n_global *= 2;
        
        n_global *= 2;
        // __syncthreads();
        
        // sdata[ty + 4 * __id[0]] = temp_0;
        
        // sdata[ty + 4 * __id[16]] = temp_16;
        
        // sdata[ty + 4 * __id[8]] = temp_8;
        
        // sdata[ty + 4 * __id[24]] = temp_24;
        
        // sdata[ty + 4 * __id[4]] = temp_4;
        
        // sdata[ty + 4 * __id[20]] = temp_20;
        
        // sdata[ty + 4 * __id[12]] = temp_12;
        
        // sdata[ty + 4 * __id[28]] = temp_28;
        
        // sdata[ty + 4 * __id[2]] = temp_2;
        
        // sdata[ty + 4 * __id[18]] = temp_18;
        
        // sdata[ty + 4 * __id[10]] = temp_10;
        
        // sdata[ty + 4 * __id[26]] = temp_26;
        
        // sdata[ty + 4 * __id[6]] = temp_6;
        
        // sdata[ty + 4 * __id[22]] = temp_22;
        
        // sdata[ty + 4 * __id[14]] = temp_14;
        
        // sdata[ty + 4 * __id[30]] = temp_30;
        
        // sdata[ty + 4 * __id[1]] = temp_1;
        
        // sdata[ty + 4 * __id[17]] = temp_17;
        
        // sdata[ty + 4 * __id[9]] = temp_9;
        
        // sdata[ty + 4 * __id[25]] = temp_25;
        
        // sdata[ty + 4 * __id[5]] = temp_5;
        
        // sdata[ty + 4 * __id[21]] = temp_21;
        
        // sdata[ty + 4 * __id[13]] = temp_13;
        
        // sdata[ty + 4 * __id[29]] = temp_29;
        
        // sdata[ty + 4 * __id[3]] = temp_3;
        
        // sdata[ty + 4 * __id[19]] = temp_19;
        
        // sdata[ty + 4 * __id[11]] = temp_11;
        
        // sdata[ty + 4 * __id[27]] = temp_27;
        
        // sdata[ty + 4 * __id[7]] = temp_7;
        
        // sdata[ty + 4 * __id[23]] = temp_23;
        
        // sdata[ty + 4 * __id[15]] = temp_15;
        
        // sdata[ty + 4 * __id[31]] = temp_31;
        
        // __syncthreads();
         
                    // temp_0 = sdata[((tx + ty * 32 + 0) % 4) + 4 * ((tx + ty * 32 + 0) / 4)];
                    outputs[__id[0] + (ty + bx * blockDim.y) * 1024] = temp_0;
         
                    // temp_0 = sdata[((tx + ty * 32 + 128) % 4) + 4 * ((tx + ty * 32 + 128) / 4)];
                    outputs[__id[16] + (ty + bx * blockDim.y) * 1024] = temp_16;
         
                    // temp_0 = sdata[((tx + ty * 32 + 256) % 4) + 4 * ((tx + ty * 32 + 256) / 4)];
                    outputs[__id[8] + (ty + bx * blockDim.y) * 1024] = temp_8;
         
                    // temp_0 = sdata[((tx + ty * 32 + 384) % 4) + 4 * ((tx + ty * 32 + 384) / 4)];
                    outputs[__id[24] + (ty + bx * blockDim.y) * 1024] = temp_24;
         
                    // temp_0 = sdata[((tx + ty * 32 + 512) % 4) + 4 * ((tx + ty * 32 + 512) / 4)];
                    outputs[__id[4] + (ty + bx * blockDim.y) * 1024] = temp_4;
         
                    // temp_0 = sdata[((tx + ty * 32 + 640) % 4) + 4 * ((tx + ty * 32 + 640) / 4)];
                    outputs[__id[20] + (ty + bx * blockDim.y) * 1024] = temp_20;
         
                    // temp_0 = sdata[((tx + ty * 32 + 768) % 4) + 4 * ((tx + ty * 32 + 768) / 4)];
                    outputs[__id[12] + (ty + bx * blockDim.y) * 1024] = temp_12;
         
                    // temp_0 = sdata[((tx + ty * 32 + 896) % 4) + 4 * ((tx + ty * 32 + 896) / 4)];
                    outputs[__id[28] + (ty + bx * blockDim.y) * 1024] = temp_28;
         
                    // temp_0 = sdata[((tx + ty * 32 + 1024) % 4) + 4 * ((tx + ty * 32 + 1024) / 4)];
                    outputs[__id[2] + (ty + bx * blockDim.y) * 1024] = temp_2;
         
                    // temp_0 = sdata[((tx + ty * 32 + 1152) % 4) + 4 * ((tx + ty * 32 + 1152) / 4)];
                    outputs[__id[18] + (ty + bx * blockDim.y) * 1024] = temp_18;
         
                    // temp_0 = sdata[((tx + ty * 32 + 1280) % 4) + 4 * ((tx + ty * 32 + 1280) / 4)];
                    outputs[__id[10] + (ty + bx * blockDim.y) * 1024] = temp_10;
         
                    // temp_0 = sdata[((tx + ty * 32 + 1408) % 4) + 4 * ((tx + ty * 32 + 1408) / 4)];
                    outputs[__id[26] + (ty + bx * blockDim.y) * 1024] = temp_26;
         
                    // temp_0 = sdata[((tx + ty * 32 + 1536) % 4) + 4 * ((tx + ty * 32 + 1536) / 4)];
                    outputs[__id[6] + (ty + bx * blockDim.y) * 1024] = temp_6;
         
                    // temp_0 = sdata[((tx + ty * 32 + 1664) % 4) + 4 * ((tx + ty * 32 + 1664) / 4)];
                    outputs[__id[22] + (ty + bx * blockDim.y) * 1024] = temp_22;
         
                    // temp_0 = sdata[((tx + ty * 32 + 1792) % 4) + 4 * ((tx + ty * 32 + 1792) / 4)];
                    outputs[__id[14] + (ty + bx * blockDim.y) * 1024] = temp_14;
         
                    // temp_0 = sdata[((tx + ty * 32 + 1920) % 4) + 4 * ((tx + ty * 32 + 1920) / 4)];
                    outputs[__id[30] + (ty + bx * blockDim.y) * 1024] = temp_30;
         
                    // temp_0 = sdata[((tx + ty * 32 + 2048) % 4) + 4 * ((tx + ty * 32 + 2048) / 4)];
                    outputs[__id[1] + (ty + bx * blockDim.y) * 1024] = temp_1;
         
                    // temp_0 = sdata[((tx + ty * 32 + 2176) % 4) + 4 * ((tx + ty * 32 + 2176) / 4)];
                    outputs[__id[17] + (ty + bx * blockDim.y) * 1024] = temp_17;
         
                    // temp_0 = sdata[((tx + ty * 32 + 2304) % 4) + 4 * ((tx + ty * 32 + 2304) / 4)];
                    outputs[__id[9] + (ty + bx * blockDim.y) * 1024] = temp_9;
         
                    // temp_0 = sdata[((tx + ty * 32 + 2432) % 4) + 4 * ((tx + ty * 32 + 2432) / 4)];
                    outputs[__id[25] + (ty + bx * blockDim.y) * 1024] = temp_25;
         
                    // temp_0 = sdata[((tx + ty * 32 + 2560) % 4) + 4 * ((tx + ty * 32 + 2560) / 4)];
                    outputs[__id[5] + (ty + bx * blockDim.y) * 1024] = temp_5;
         
                    // temp_0 = sdata[((tx + ty * 32 + 2688) % 4) + 4 * ((tx + ty * 32 + 2688) / 4)];
                    outputs[__id[21] + (ty + bx * blockDim.y) * 1024] = temp_21;
         
                    // temp_0 = sdata[((tx + ty * 32 + 2816) % 4) + 4 * ((tx + ty * 32 + 2816) / 4)];
                    outputs[__id[13] + (ty + bx * blockDim.y) * 1024] = temp_13;
         
                    // temp_0 = sdata[((tx + ty * 32 + 2944) % 4) + 4 * ((tx + ty * 32 + 2944) / 4)];
                    outputs[__id[29] + (ty + bx * blockDim.y) * 1024] = temp_29;
         
                    // temp_0 = sdata[((tx + ty * 32 + 3072) % 4) + 4 * ((tx + ty * 32 + 3072) / 4)];
                    outputs[__id[3] + (ty + bx * blockDim.y) * 1024] = temp_3;
         
                    // temp_0 = sdata[((tx + ty * 32 + 3200) % 4) + 4 * ((tx + ty * 32 + 3200) / 4)];
                    outputs[__id[19] + (ty + bx * blockDim.y) * 1024] = temp_19;
         
                    // temp_0 = sdata[((tx + ty * 32 + 3328) % 4) + 4 * ((tx + ty * 32 + 3328) / 4)];
                    outputs[__id[11] + (ty + bx * blockDim.y) * 1024] = temp_11;
         
                    // temp_0 = sdata[((tx + ty * 32 + 3456) % 4) + 4 * ((tx + ty * 32 + 3456) / 4)];
                    outputs[__id[27] + (ty + bx * blockDim.y) * 1024] = temp_27;
         
                    // temp_0 = sdata[((tx + ty * 32 + 3584) % 4) + 4 * ((tx + ty * 32 + 3584) / 4)];
                    outputs[__id[7] + (ty + bx * blockDim.y) * 1024] = temp_7;
         
                    // temp_0 = sdata[((tx + ty * 32 + 3712) % 4) + 4 * ((tx + ty * 32 + 3712) / 4)];
                    outputs[__id[23] + (ty + bx * blockDim.y) * 1024] = temp_23;
         
                    // temp_0 = sdata[((tx + ty * 32 + 3840) % 4) + 4 * ((tx + ty * 32 + 3840) / 4)];
                    outputs[__id[15] + (ty + bx * blockDim.y) * 1024] = temp_15;
         
                    // temp_0 = sdata[((tx + ty * 32 + 3968) % 4) + 4 * ((tx + ty * 32 + 3968) / 4)];
                    outputs[__id[31] + (ty + bx * blockDim.y) * 1024] = temp_31;
        
        }
    