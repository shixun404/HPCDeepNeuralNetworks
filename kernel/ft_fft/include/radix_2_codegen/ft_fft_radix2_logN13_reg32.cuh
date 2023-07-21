extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_radix2_logN13(float2* inputs, float2* outputs) {

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
    int N = 8192;
    int __id[32];
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
    r[1].y = -0.8660253882408142f;
    r[2].x = -0.5f;
    r[2].y = 0.8660253882408142f;
    float2 warp_checksum;
    float2 warp_checksum_;
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
    temp_16 = inputs[16 * blockDim.x + tx];
    temp_17 = inputs[17 * blockDim.x + tx];
    temp_18 = inputs[18 * blockDim.x + tx];
    temp_19 = inputs[19 * blockDim.x + tx];
    temp_20 = inputs[20 * blockDim.x + tx];
    temp_21 = inputs[21 * blockDim.x + tx];
    temp_22 = inputs[22 * blockDim.x + tx];
    temp_23 = inputs[23 * blockDim.x + tx];
    temp_24 = inputs[24 * blockDim.x + tx];
    temp_25 = inputs[25 * blockDim.x + tx];
    temp_26 = inputs[26 * blockDim.x + tx];
    temp_27 = inputs[27 * blockDim.x + tx];
    temp_28 = inputs[28 * blockDim.x + tx];
    temp_29 = inputs[29 * blockDim.x + tx];
    temp_30 = inputs[30 * blockDim.x + tx];
    temp_31 = inputs[31 * blockDim.x + tx];
    
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
    __id[16] = 16 * blockDim.x + tx;
    __id[17] = 17 * blockDim.x + tx;
    __id[18] = 18 * blockDim.x + tx;
    __id[19] = 19 * blockDim.x + tx;
    __id[20] = 20 * blockDim.x + tx;
    __id[21] = 21 * blockDim.x + tx;
    __id[22] = 22 * blockDim.x + tx;
    __id[23] = 23 * blockDim.x + tx;
    __id[24] = 24 * blockDim.x + tx;
    __id[25] = 25 * blockDim.x + tx;
    __id[26] = 26 * blockDim.x + tx;
    __id[27] = 27 * blockDim.x + tx;
    __id[28] = 28 * blockDim.x + tx;
    __id[29] = 29 * blockDim.x + tx;
    __id[30] = 30 * blockDim.x + tx;
    __id[31] = 31 * blockDim.x + tx;
    
            warp_checksum.x = 0;
            warp_checksum.y = 0;
        
                        warp_checksum.x += temp_0.x * A_radix32_0_x - temp_0.y * A_radix32_0_y;
                        warp_checksum.y += temp_0.x * A_radix32_0_y + temp_0.y * A_radix32_0_x;
        
                        warp_checksum.x += temp_1.x * A_radix32_1_x - temp_1.y * A_radix32_1_y;
                        warp_checksum.y += temp_1.x * A_radix32_1_y + temp_1.y * A_radix32_1_x;
        
                        warp_checksum.x += temp_2.x * A_radix32_2_x - temp_2.y * A_radix32_2_y;
                        warp_checksum.y += temp_2.x * A_radix32_2_y + temp_2.y * A_radix32_2_x;
        
                        warp_checksum.x += temp_3.x * A_radix32_3_x - temp_3.y * A_radix32_3_y;
                        warp_checksum.y += temp_3.x * A_radix32_3_y + temp_3.y * A_radix32_3_x;
        
                        warp_checksum.x += temp_4.x * A_radix32_4_x - temp_4.y * A_radix32_4_y;
                        warp_checksum.y += temp_4.x * A_radix32_4_y + temp_4.y * A_radix32_4_x;
        
                        warp_checksum.x += temp_5.x * A_radix32_5_x - temp_5.y * A_radix32_5_y;
                        warp_checksum.y += temp_5.x * A_radix32_5_y + temp_5.y * A_radix32_5_x;
        
                        warp_checksum.x += temp_6.x * A_radix32_6_x - temp_6.y * A_radix32_6_y;
                        warp_checksum.y += temp_6.x * A_radix32_6_y + temp_6.y * A_radix32_6_x;
        
                        warp_checksum.x += temp_7.x * A_radix32_7_x - temp_7.y * A_radix32_7_y;
                        warp_checksum.y += temp_7.x * A_radix32_7_y + temp_7.y * A_radix32_7_x;
        
                        warp_checksum.x += temp_8.x * A_radix32_8_x - temp_8.y * A_radix32_8_y;
                        warp_checksum.y += temp_8.x * A_radix32_8_y + temp_8.y * A_radix32_8_x;
        
                        warp_checksum.x += temp_9.x * A_radix32_9_x - temp_9.y * A_radix32_9_y;
                        warp_checksum.y += temp_9.x * A_radix32_9_y + temp_9.y * A_radix32_9_x;
        
                        warp_checksum.x += temp_10.x * A_radix32_10_x - temp_10.y * A_radix32_10_y;
                        warp_checksum.y += temp_10.x * A_radix32_10_y + temp_10.y * A_radix32_10_x;
        
                        warp_checksum.x += temp_11.x * A_radix32_11_x - temp_11.y * A_radix32_11_y;
                        warp_checksum.y += temp_11.x * A_radix32_11_y + temp_11.y * A_radix32_11_x;
        
                        warp_checksum.x += temp_12.x * A_radix32_12_x - temp_12.y * A_radix32_12_y;
                        warp_checksum.y += temp_12.x * A_radix32_12_y + temp_12.y * A_radix32_12_x;
        
                        warp_checksum.x += temp_13.x * A_radix32_13_x - temp_13.y * A_radix32_13_y;
                        warp_checksum.y += temp_13.x * A_radix32_13_y + temp_13.y * A_radix32_13_x;
        
                        warp_checksum.x += temp_14.x * A_radix32_14_x - temp_14.y * A_radix32_14_y;
                        warp_checksum.y += temp_14.x * A_radix32_14_y + temp_14.y * A_radix32_14_x;
        
                        warp_checksum.x += temp_15.x * A_radix32_15_x - temp_15.y * A_radix32_15_y;
                        warp_checksum.y += temp_15.x * A_radix32_15_y + temp_15.y * A_radix32_15_x;
        
                        warp_checksum.x += temp_16.x * A_radix32_16_x - temp_16.y * A_radix32_16_y;
                        warp_checksum.y += temp_16.x * A_radix32_16_y + temp_16.y * A_radix32_16_x;
        
                        warp_checksum.x += temp_17.x * A_radix32_17_x - temp_17.y * A_radix32_17_y;
                        warp_checksum.y += temp_17.x * A_radix32_17_y + temp_17.y * A_radix32_17_x;
        
                        warp_checksum.x += temp_18.x * A_radix32_18_x - temp_18.y * A_radix32_18_y;
                        warp_checksum.y += temp_18.x * A_radix32_18_y + temp_18.y * A_radix32_18_x;
        
                        warp_checksum.x += temp_19.x * A_radix32_19_x - temp_19.y * A_radix32_19_y;
                        warp_checksum.y += temp_19.x * A_radix32_19_y + temp_19.y * A_radix32_19_x;
        
                        warp_checksum.x += temp_20.x * A_radix32_20_x - temp_20.y * A_radix32_20_y;
                        warp_checksum.y += temp_20.x * A_radix32_20_y + temp_20.y * A_radix32_20_x;
        
                        warp_checksum.x += temp_21.x * A_radix32_21_x - temp_21.y * A_radix32_21_y;
                        warp_checksum.y += temp_21.x * A_radix32_21_y + temp_21.y * A_radix32_21_x;
        
                        warp_checksum.x += temp_22.x * A_radix32_22_x - temp_22.y * A_radix32_22_y;
                        warp_checksum.y += temp_22.x * A_radix32_22_y + temp_22.y * A_radix32_22_x;
        
                        warp_checksum.x += temp_23.x * A_radix32_23_x - temp_23.y * A_radix32_23_y;
                        warp_checksum.y += temp_23.x * A_radix32_23_y + temp_23.y * A_radix32_23_x;
        
                        warp_checksum.x += temp_24.x * A_radix32_24_x - temp_24.y * A_radix32_24_y;
                        warp_checksum.y += temp_24.x * A_radix32_24_y + temp_24.y * A_radix32_24_x;
        
                        warp_checksum.x += temp_25.x * A_radix32_25_x - temp_25.y * A_radix32_25_y;
                        warp_checksum.y += temp_25.x * A_radix32_25_y + temp_25.y * A_radix32_25_x;
        
                        warp_checksum.x += temp_26.x * A_radix32_26_x - temp_26.y * A_radix32_26_y;
                        warp_checksum.y += temp_26.x * A_radix32_26_y + temp_26.y * A_radix32_26_x;
        
                        warp_checksum.x += temp_27.x * A_radix32_27_x - temp_27.y * A_radix32_27_y;
                        warp_checksum.y += temp_27.x * A_radix32_27_y + temp_27.y * A_radix32_27_x;
        
                        warp_checksum.x += temp_28.x * A_radix32_28_x - temp_28.y * A_radix32_28_y;
                        warp_checksum.y += temp_28.x * A_radix32_28_y + temp_28.y * A_radix32_28_x;
        
                        warp_checksum.x += temp_29.x * A_radix32_29_x - temp_29.y * A_radix32_29_y;
                        warp_checksum.y += temp_29.x * A_radix32_29_y + temp_29.y * A_radix32_29_x;
        
                        warp_checksum.x += temp_30.x * A_radix32_30_x - temp_30.y * A_radix32_30_y;
                        warp_checksum.y += temp_30.x * A_radix32_30_y + temp_30.y * A_radix32_30_x;
        
                        warp_checksum.x += temp_31.x * A_radix32_31_x - temp_31.y * A_radix32_31_y;
                        warp_checksum.y += temp_31.x * A_radix32_31_y + temp_31.y * A_radix32_31_x;
        
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
        
            warp_checksum_ = warp_checksum;
            
            
                        warp_checksum.x -= temp_0.x * r[0].x - temp_0.y * r[0].y;
                        warp_checksum.y -= temp_0.x * r[0].y + temp_0.y * r[0].x;
            
                        warp_checksum.x -= temp_16.x * r[1].x - temp_16.y * r[1].y;
                        warp_checksum.y -= temp_16.x * r[1].y + temp_16.y * r[1].x;
            
                        warp_checksum.x -= temp_8.x * r[2].x - temp_8.y * r[2].y;
                        warp_checksum.y -= temp_8.x * r[2].y + temp_8.y * r[2].x;
            
                        warp_checksum.x -= temp_24.x * r[0].x - temp_24.y * r[0].y;
                        warp_checksum.y -= temp_24.x * r[0].y + temp_24.y * r[0].x;
            
                        warp_checksum.x -= temp_4.x * r[1].x - temp_4.y * r[1].y;
                        warp_checksum.y -= temp_4.x * r[1].y + temp_4.y * r[1].x;
            
                        warp_checksum.x -= temp_20.x * r[2].x - temp_20.y * r[2].y;
                        warp_checksum.y -= temp_20.x * r[2].y + temp_20.y * r[2].x;
            
                        warp_checksum.x -= temp_12.x * r[0].x - temp_12.y * r[0].y;
                        warp_checksum.y -= temp_12.x * r[0].y + temp_12.y * r[0].x;
            
                        warp_checksum.x -= temp_28.x * r[1].x - temp_28.y * r[1].y;
                        warp_checksum.y -= temp_28.x * r[1].y + temp_28.y * r[1].x;
            
                        warp_checksum.x -= temp_2.x * r[2].x - temp_2.y * r[2].y;
                        warp_checksum.y -= temp_2.x * r[2].y + temp_2.y * r[2].x;
            
                        warp_checksum.x -= temp_18.x * r[0].x - temp_18.y * r[0].y;
                        warp_checksum.y -= temp_18.x * r[0].y + temp_18.y * r[0].x;
            
                        warp_checksum.x -= temp_10.x * r[1].x - temp_10.y * r[1].y;
                        warp_checksum.y -= temp_10.x * r[1].y + temp_10.y * r[1].x;
            
                        warp_checksum.x -= temp_26.x * r[2].x - temp_26.y * r[2].y;
                        warp_checksum.y -= temp_26.x * r[2].y + temp_26.y * r[2].x;
            
                        warp_checksum.x -= temp_6.x * r[0].x - temp_6.y * r[0].y;
                        warp_checksum.y -= temp_6.x * r[0].y + temp_6.y * r[0].x;
            
                        warp_checksum.x -= temp_22.x * r[1].x - temp_22.y * r[1].y;
                        warp_checksum.y -= temp_22.x * r[1].y + temp_22.y * r[1].x;
            
                        warp_checksum.x -= temp_14.x * r[2].x - temp_14.y * r[2].y;
                        warp_checksum.y -= temp_14.x * r[2].y + temp_14.y * r[2].x;
            
                        warp_checksum.x -= temp_30.x * r[0].x - temp_30.y * r[0].y;
                        warp_checksum.y -= temp_30.x * r[0].y + temp_30.y * r[0].x;
            
                        warp_checksum.x -= temp_1.x * r[1].x - temp_1.y * r[1].y;
                        warp_checksum.y -= temp_1.x * r[1].y + temp_1.y * r[1].x;
            
                        warp_checksum.x -= temp_17.x * r[2].x - temp_17.y * r[2].y;
                        warp_checksum.y -= temp_17.x * r[2].y + temp_17.y * r[2].x;
            
                        warp_checksum.x -= temp_9.x * r[0].x - temp_9.y * r[0].y;
                        warp_checksum.y -= temp_9.x * r[0].y + temp_9.y * r[0].x;
            
                        warp_checksum.x -= temp_25.x * r[1].x - temp_25.y * r[1].y;
                        warp_checksum.y -= temp_25.x * r[1].y + temp_25.y * r[1].x;
            
                        warp_checksum.x -= temp_5.x * r[2].x - temp_5.y * r[2].y;
                        warp_checksum.y -= temp_5.x * r[2].y + temp_5.y * r[2].x;
            
                        warp_checksum.x -= temp_21.x * r[0].x - temp_21.y * r[0].y;
                        warp_checksum.y -= temp_21.x * r[0].y + temp_21.y * r[0].x;
            
                        warp_checksum.x -= temp_13.x * r[1].x - temp_13.y * r[1].y;
                        warp_checksum.y -= temp_13.x * r[1].y + temp_13.y * r[1].x;
            
                        warp_checksum.x -= temp_29.x * r[2].x - temp_29.y * r[2].y;
                        warp_checksum.y -= temp_29.x * r[2].y + temp_29.y * r[2].x;
            
                        warp_checksum.x -= temp_3.x * r[0].x - temp_3.y * r[0].y;
                        warp_checksum.y -= temp_3.x * r[0].y + temp_3.y * r[0].x;
            
                        warp_checksum.x -= temp_19.x * r[1].x - temp_19.y * r[1].y;
                        warp_checksum.y -= temp_19.x * r[1].y + temp_19.y * r[1].x;
            
                        warp_checksum.x -= temp_11.x * r[2].x - temp_11.y * r[2].y;
                        warp_checksum.y -= temp_11.x * r[2].y + temp_11.y * r[2].x;
            
                        warp_checksum.x -= temp_27.x * r[0].x - temp_27.y * r[0].y;
                        warp_checksum.y -= temp_27.x * r[0].y + temp_27.y * r[0].x;
            
                        warp_checksum.x -= temp_7.x * r[1].x - temp_7.y * r[1].y;
                        warp_checksum.y -= temp_7.x * r[1].y + temp_7.y * r[1].x;
            
                        warp_checksum.x -= temp_23.x * r[2].x - temp_23.y * r[2].y;
                        warp_checksum.y -= temp_23.x * r[2].y + temp_23.y * r[2].x;
            
                        warp_checksum.x -= temp_15.x * r[0].x - temp_15.y * r[0].y;
                        warp_checksum.y -= temp_15.x * r[0].y + temp_15.y * r[0].x;
            
                        warp_checksum.x -= temp_31.x * r[1].x - temp_31.y * r[1].y;
                        warp_checksum.y -= temp_31.x * r[1].y + temp_31.y * r[1].x;
            
            // printf("%f, %f, %f, %f\n", warp_checksum.x, warp_checksum.y, warp_checksum_.x, warp_checksum_.y);
            
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 0) / (float)(8192), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 1) / (float)(8192), tmp_angle);
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 2) / (float)(8192), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 3) / (float)(8192), tmp_angle);
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 4) / (float)(8192), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 5) / (float)(8192), tmp_angle);
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 6) / (float)(8192), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 7) / (float)(8192), tmp_angle);
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 8) / (float)(8192), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 9) / (float)(8192), tmp_angle);
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 10) / (float)(8192), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 11) / (float)(8192), tmp_angle);
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 12) / (float)(8192), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 13) / (float)(8192), tmp_angle);
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 14) / (float)(8192), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 15) / (float)(8192), tmp_angle);
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 16) / (float)(8192), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 17) / (float)(8192), tmp_angle);
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 18) / (float)(8192), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 19) / (float)(8192), tmp_angle);
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 20) / (float)(8192), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 21) / (float)(8192), tmp_angle);
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 22) / (float)(8192), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 23) / (float)(8192), tmp_angle);
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 24) / (float)(8192), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 25) / (float)(8192), tmp_angle);
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 26) / (float)(8192), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 27) / (float)(8192), tmp_angle);
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 28) / (float)(8192), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 29) / (float)(8192), tmp_angle);
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 30) / (float)(8192), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 1) * 31) / (float)(8192), tmp_angle);
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    
    sdata[__id[0]] = temp_0;
    
    sdata[__id[16]] = temp_16;
    
    sdata[__id[8]] = temp_8;
    
    sdata[__id[24]] = temp_24;
    
    sdata[__id[4]] = temp_4;
    
    sdata[__id[20]] = temp_20;
    
    sdata[__id[12]] = temp_12;
    
    sdata[__id[28]] = temp_28;
    
    sdata[__id[2]] = temp_2;
    
    sdata[__id[18]] = temp_18;
    
    sdata[__id[10]] = temp_10;
    
    sdata[__id[26]] = temp_26;
    
    sdata[__id[6]] = temp_6;
    
    sdata[__id[22]] = temp_22;
    
    sdata[__id[14]] = temp_14;
    
    sdata[__id[30]] = temp_30;
    
    sdata[__id[1]] = temp_1;
    
    sdata[__id[17]] = temp_17;
    
    sdata[__id[9]] = temp_9;
    
    sdata[__id[25]] = temp_25;
    
    sdata[__id[5]] = temp_5;
    
    sdata[__id[21]] = temp_21;
    
    sdata[__id[13]] = temp_13;
    
    sdata[__id[29]] = temp_29;
    
    sdata[__id[3]] = temp_3;
    
    sdata[__id[19]] = temp_19;
    
    sdata[__id[11]] = temp_11;
    
    sdata[__id[27]] = temp_27;
    
    sdata[__id[7]] = temp_7;
    
    sdata[__id[23]] = temp_23;
    
    sdata[__id[15]] = temp_15;
    
    sdata[__id[31]] = temp_31;
    
    __syncthreads();
    
    temp_0 = sdata[0 * blockDim.x + tx];
    __id[0] = tx + 0 * 256;
    
    temp_1 = sdata[1 * blockDim.x + tx];
    __id[1] = tx + 1 * 256;
    
    temp_2 = sdata[2 * blockDim.x + tx];
    __id[2] = tx + 2 * 256;
    
    temp_3 = sdata[3 * blockDim.x + tx];
    __id[3] = tx + 3 * 256;
    
    temp_4 = sdata[4 * blockDim.x + tx];
    __id[4] = tx + 4 * 256;
    
    temp_5 = sdata[5 * blockDim.x + tx];
    __id[5] = tx + 5 * 256;
    
    temp_6 = sdata[6 * blockDim.x + tx];
    __id[6] = tx + 6 * 256;
    
    temp_7 = sdata[7 * blockDim.x + tx];
    __id[7] = tx + 7 * 256;
    
    temp_8 = sdata[8 * blockDim.x + tx];
    __id[8] = tx + 8 * 256;
    
    temp_9 = sdata[9 * blockDim.x + tx];
    __id[9] = tx + 9 * 256;
    
    temp_10 = sdata[10 * blockDim.x + tx];
    __id[10] = tx + 10 * 256;
    
    temp_11 = sdata[11 * blockDim.x + tx];
    __id[11] = tx + 11 * 256;
    
    temp_12 = sdata[12 * blockDim.x + tx];
    __id[12] = tx + 12 * 256;
    
    temp_13 = sdata[13 * blockDim.x + tx];
    __id[13] = tx + 13 * 256;
    
    temp_14 = sdata[14 * blockDim.x + tx];
    __id[14] = tx + 14 * 256;
    
    temp_15 = sdata[15 * blockDim.x + tx];
    __id[15] = tx + 15 * 256;
    
    temp_16 = sdata[16 * blockDim.x + tx];
    __id[16] = tx + 16 * 256;
    
    temp_17 = sdata[17 * blockDim.x + tx];
    __id[17] = tx + 17 * 256;
    
    temp_18 = sdata[18 * blockDim.x + tx];
    __id[18] = tx + 18 * 256;
    
    temp_19 = sdata[19 * blockDim.x + tx];
    __id[19] = tx + 19 * 256;
    
    temp_20 = sdata[20 * blockDim.x + tx];
    __id[20] = tx + 20 * 256;
    
    temp_21 = sdata[21 * blockDim.x + tx];
    __id[21] = tx + 21 * 256;
    
    temp_22 = sdata[22 * blockDim.x + tx];
    __id[22] = tx + 22 * 256;
    
    temp_23 = sdata[23 * blockDim.x + tx];
    __id[23] = tx + 23 * 256;
    
    temp_24 = sdata[24 * blockDim.x + tx];
    __id[24] = tx + 24 * 256;
    
    temp_25 = sdata[25 * blockDim.x + tx];
    __id[25] = tx + 25 * 256;
    
    temp_26 = sdata[26 * blockDim.x + tx];
    __id[26] = tx + 26 * 256;
    
    temp_27 = sdata[27 * blockDim.x + tx];
    __id[27] = tx + 27 * 256;
    
    temp_28 = sdata[28 * blockDim.x + tx];
    __id[28] = tx + 28 * 256;
    
    temp_29 = sdata[29 * blockDim.x + tx];
    __id[29] = tx + 29 * 256;
    
    temp_30 = sdata[30 * blockDim.x + tx];
    __id[30] = tx + 30 * 256;
    
    temp_31 = sdata[31 * blockDim.x + tx];
    __id[31] = tx + 31 * 256;
    
            warp_checksum.x = 0;
            warp_checksum.y = 0;
        
                        warp_checksum.x += temp_0.x * A_radix32_0_x - temp_0.y * A_radix32_0_y;
                        warp_checksum.y += temp_0.x * A_radix32_0_y + temp_0.y * A_radix32_0_x;
        
                        warp_checksum.x += temp_1.x * A_radix32_1_x - temp_1.y * A_radix32_1_y;
                        warp_checksum.y += temp_1.x * A_radix32_1_y + temp_1.y * A_radix32_1_x;
        
                        warp_checksum.x += temp_2.x * A_radix32_2_x - temp_2.y * A_radix32_2_y;
                        warp_checksum.y += temp_2.x * A_radix32_2_y + temp_2.y * A_radix32_2_x;
        
                        warp_checksum.x += temp_3.x * A_radix32_3_x - temp_3.y * A_radix32_3_y;
                        warp_checksum.y += temp_3.x * A_radix32_3_y + temp_3.y * A_radix32_3_x;
        
                        warp_checksum.x += temp_4.x * A_radix32_4_x - temp_4.y * A_radix32_4_y;
                        warp_checksum.y += temp_4.x * A_radix32_4_y + temp_4.y * A_radix32_4_x;
        
                        warp_checksum.x += temp_5.x * A_radix32_5_x - temp_5.y * A_radix32_5_y;
                        warp_checksum.y += temp_5.x * A_radix32_5_y + temp_5.y * A_radix32_5_x;
        
                        warp_checksum.x += temp_6.x * A_radix32_6_x - temp_6.y * A_radix32_6_y;
                        warp_checksum.y += temp_6.x * A_radix32_6_y + temp_6.y * A_radix32_6_x;
        
                        warp_checksum.x += temp_7.x * A_radix32_7_x - temp_7.y * A_radix32_7_y;
                        warp_checksum.y += temp_7.x * A_radix32_7_y + temp_7.y * A_radix32_7_x;
        
                        warp_checksum.x += temp_8.x * A_radix32_8_x - temp_8.y * A_radix32_8_y;
                        warp_checksum.y += temp_8.x * A_radix32_8_y + temp_8.y * A_radix32_8_x;
        
                        warp_checksum.x += temp_9.x * A_radix32_9_x - temp_9.y * A_radix32_9_y;
                        warp_checksum.y += temp_9.x * A_radix32_9_y + temp_9.y * A_radix32_9_x;
        
                        warp_checksum.x += temp_10.x * A_radix32_10_x - temp_10.y * A_radix32_10_y;
                        warp_checksum.y += temp_10.x * A_radix32_10_y + temp_10.y * A_radix32_10_x;
        
                        warp_checksum.x += temp_11.x * A_radix32_11_x - temp_11.y * A_radix32_11_y;
                        warp_checksum.y += temp_11.x * A_radix32_11_y + temp_11.y * A_radix32_11_x;
        
                        warp_checksum.x += temp_12.x * A_radix32_12_x - temp_12.y * A_radix32_12_y;
                        warp_checksum.y += temp_12.x * A_radix32_12_y + temp_12.y * A_radix32_12_x;
        
                        warp_checksum.x += temp_13.x * A_radix32_13_x - temp_13.y * A_radix32_13_y;
                        warp_checksum.y += temp_13.x * A_radix32_13_y + temp_13.y * A_radix32_13_x;
        
                        warp_checksum.x += temp_14.x * A_radix32_14_x - temp_14.y * A_radix32_14_y;
                        warp_checksum.y += temp_14.x * A_radix32_14_y + temp_14.y * A_radix32_14_x;
        
                        warp_checksum.x += temp_15.x * A_radix32_15_x - temp_15.y * A_radix32_15_y;
                        warp_checksum.y += temp_15.x * A_radix32_15_y + temp_15.y * A_radix32_15_x;
        
                        warp_checksum.x += temp_16.x * A_radix32_16_x - temp_16.y * A_radix32_16_y;
                        warp_checksum.y += temp_16.x * A_radix32_16_y + temp_16.y * A_radix32_16_x;
        
                        warp_checksum.x += temp_17.x * A_radix32_17_x - temp_17.y * A_radix32_17_y;
                        warp_checksum.y += temp_17.x * A_radix32_17_y + temp_17.y * A_radix32_17_x;
        
                        warp_checksum.x += temp_18.x * A_radix32_18_x - temp_18.y * A_radix32_18_y;
                        warp_checksum.y += temp_18.x * A_radix32_18_y + temp_18.y * A_radix32_18_x;
        
                        warp_checksum.x += temp_19.x * A_radix32_19_x - temp_19.y * A_radix32_19_y;
                        warp_checksum.y += temp_19.x * A_radix32_19_y + temp_19.y * A_radix32_19_x;
        
                        warp_checksum.x += temp_20.x * A_radix32_20_x - temp_20.y * A_radix32_20_y;
                        warp_checksum.y += temp_20.x * A_radix32_20_y + temp_20.y * A_radix32_20_x;
        
                        warp_checksum.x += temp_21.x * A_radix32_21_x - temp_21.y * A_radix32_21_y;
                        warp_checksum.y += temp_21.x * A_radix32_21_y + temp_21.y * A_radix32_21_x;
        
                        warp_checksum.x += temp_22.x * A_radix32_22_x - temp_22.y * A_radix32_22_y;
                        warp_checksum.y += temp_22.x * A_radix32_22_y + temp_22.y * A_radix32_22_x;
        
                        warp_checksum.x += temp_23.x * A_radix32_23_x - temp_23.y * A_radix32_23_y;
                        warp_checksum.y += temp_23.x * A_radix32_23_y + temp_23.y * A_radix32_23_x;
        
                        warp_checksum.x += temp_24.x * A_radix32_24_x - temp_24.y * A_radix32_24_y;
                        warp_checksum.y += temp_24.x * A_radix32_24_y + temp_24.y * A_radix32_24_x;
        
                        warp_checksum.x += temp_25.x * A_radix32_25_x - temp_25.y * A_radix32_25_y;
                        warp_checksum.y += temp_25.x * A_radix32_25_y + temp_25.y * A_radix32_25_x;
        
                        warp_checksum.x += temp_26.x * A_radix32_26_x - temp_26.y * A_radix32_26_y;
                        warp_checksum.y += temp_26.x * A_radix32_26_y + temp_26.y * A_radix32_26_x;
        
                        warp_checksum.x += temp_27.x * A_radix32_27_x - temp_27.y * A_radix32_27_y;
                        warp_checksum.y += temp_27.x * A_radix32_27_y + temp_27.y * A_radix32_27_x;
        
                        warp_checksum.x += temp_28.x * A_radix32_28_x - temp_28.y * A_radix32_28_y;
                        warp_checksum.y += temp_28.x * A_radix32_28_y + temp_28.y * A_radix32_28_x;
        
                        warp_checksum.x += temp_29.x * A_radix32_29_x - temp_29.y * A_radix32_29_y;
                        warp_checksum.y += temp_29.x * A_radix32_29_y + temp_29.y * A_radix32_29_x;
        
                        warp_checksum.x += temp_30.x * A_radix32_30_x - temp_30.y * A_radix32_30_y;
                        warp_checksum.y += temp_30.x * A_radix32_30_y + temp_30.y * A_radix32_30_x;
        
                        warp_checksum.x += temp_31.x * A_radix32_31_x - temp_31.y * A_radix32_31_y;
                        warp_checksum.y += temp_31.x * A_radix32_31_y + temp_31.y * A_radix32_31_x;
        
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
        
            warp_checksum_ = warp_checksum;
            
            
                        warp_checksum.x -= temp_0.x * r[0].x - temp_0.y * r[0].y;
                        warp_checksum.y -= temp_0.x * r[0].y + temp_0.y * r[0].x;
            
                        warp_checksum.x -= temp_16.x * r[1].x - temp_16.y * r[1].y;
                        warp_checksum.y -= temp_16.x * r[1].y + temp_16.y * r[1].x;
            
                        warp_checksum.x -= temp_8.x * r[2].x - temp_8.y * r[2].y;
                        warp_checksum.y -= temp_8.x * r[2].y + temp_8.y * r[2].x;
            
                        warp_checksum.x -= temp_24.x * r[0].x - temp_24.y * r[0].y;
                        warp_checksum.y -= temp_24.x * r[0].y + temp_24.y * r[0].x;
            
                        warp_checksum.x -= temp_4.x * r[1].x - temp_4.y * r[1].y;
                        warp_checksum.y -= temp_4.x * r[1].y + temp_4.y * r[1].x;
            
                        warp_checksum.x -= temp_20.x * r[2].x - temp_20.y * r[2].y;
                        warp_checksum.y -= temp_20.x * r[2].y + temp_20.y * r[2].x;
            
                        warp_checksum.x -= temp_12.x * r[0].x - temp_12.y * r[0].y;
                        warp_checksum.y -= temp_12.x * r[0].y + temp_12.y * r[0].x;
            
                        warp_checksum.x -= temp_28.x * r[1].x - temp_28.y * r[1].y;
                        warp_checksum.y -= temp_28.x * r[1].y + temp_28.y * r[1].x;
            
                        warp_checksum.x -= temp_2.x * r[2].x - temp_2.y * r[2].y;
                        warp_checksum.y -= temp_2.x * r[2].y + temp_2.y * r[2].x;
            
                        warp_checksum.x -= temp_18.x * r[0].x - temp_18.y * r[0].y;
                        warp_checksum.y -= temp_18.x * r[0].y + temp_18.y * r[0].x;
            
                        warp_checksum.x -= temp_10.x * r[1].x - temp_10.y * r[1].y;
                        warp_checksum.y -= temp_10.x * r[1].y + temp_10.y * r[1].x;
            
                        warp_checksum.x -= temp_26.x * r[2].x - temp_26.y * r[2].y;
                        warp_checksum.y -= temp_26.x * r[2].y + temp_26.y * r[2].x;
            
                        warp_checksum.x -= temp_6.x * r[0].x - temp_6.y * r[0].y;
                        warp_checksum.y -= temp_6.x * r[0].y + temp_6.y * r[0].x;
            
                        warp_checksum.x -= temp_22.x * r[1].x - temp_22.y * r[1].y;
                        warp_checksum.y -= temp_22.x * r[1].y + temp_22.y * r[1].x;
            
                        warp_checksum.x -= temp_14.x * r[2].x - temp_14.y * r[2].y;
                        warp_checksum.y -= temp_14.x * r[2].y + temp_14.y * r[2].x;
            
                        warp_checksum.x -= temp_30.x * r[0].x - temp_30.y * r[0].y;
                        warp_checksum.y -= temp_30.x * r[0].y + temp_30.y * r[0].x;
            
                        warp_checksum.x -= temp_1.x * r[1].x - temp_1.y * r[1].y;
                        warp_checksum.y -= temp_1.x * r[1].y + temp_1.y * r[1].x;
            
                        warp_checksum.x -= temp_17.x * r[2].x - temp_17.y * r[2].y;
                        warp_checksum.y -= temp_17.x * r[2].y + temp_17.y * r[2].x;
            
                        warp_checksum.x -= temp_9.x * r[0].x - temp_9.y * r[0].y;
                        warp_checksum.y -= temp_9.x * r[0].y + temp_9.y * r[0].x;
            
                        warp_checksum.x -= temp_25.x * r[1].x - temp_25.y * r[1].y;
                        warp_checksum.y -= temp_25.x * r[1].y + temp_25.y * r[1].x;
            
                        warp_checksum.x -= temp_5.x * r[2].x - temp_5.y * r[2].y;
                        warp_checksum.y -= temp_5.x * r[2].y + temp_5.y * r[2].x;
            
                        warp_checksum.x -= temp_21.x * r[0].x - temp_21.y * r[0].y;
                        warp_checksum.y -= temp_21.x * r[0].y + temp_21.y * r[0].x;
            
                        warp_checksum.x -= temp_13.x * r[1].x - temp_13.y * r[1].y;
                        warp_checksum.y -= temp_13.x * r[1].y + temp_13.y * r[1].x;
            
                        warp_checksum.x -= temp_29.x * r[2].x - temp_29.y * r[2].y;
                        warp_checksum.y -= temp_29.x * r[2].y + temp_29.y * r[2].x;
            
                        warp_checksum.x -= temp_3.x * r[0].x - temp_3.y * r[0].y;
                        warp_checksum.y -= temp_3.x * r[0].y + temp_3.y * r[0].x;
            
                        warp_checksum.x -= temp_19.x * r[1].x - temp_19.y * r[1].y;
                        warp_checksum.y -= temp_19.x * r[1].y + temp_19.y * r[1].x;
            
                        warp_checksum.x -= temp_11.x * r[2].x - temp_11.y * r[2].y;
                        warp_checksum.y -= temp_11.x * r[2].y + temp_11.y * r[2].x;
            
                        warp_checksum.x -= temp_27.x * r[0].x - temp_27.y * r[0].y;
                        warp_checksum.y -= temp_27.x * r[0].y + temp_27.y * r[0].x;
            
                        warp_checksum.x -= temp_7.x * r[1].x - temp_7.y * r[1].y;
                        warp_checksum.y -= temp_7.x * r[1].y + temp_7.y * r[1].x;
            
                        warp_checksum.x -= temp_23.x * r[2].x - temp_23.y * r[2].y;
                        warp_checksum.y -= temp_23.x * r[2].y + temp_23.y * r[2].x;
            
                        warp_checksum.x -= temp_15.x * r[0].x - temp_15.y * r[0].y;
                        warp_checksum.y -= temp_15.x * r[0].y + temp_15.y * r[0].x;
            
                        warp_checksum.x -= temp_31.x * r[1].x - temp_31.y * r[1].y;
                        warp_checksum.y -= temp_31.x * r[1].y + temp_31.y * r[1].x;
            
            // printf("%f, %f, %f, %f\n", warp_checksum.x, warp_checksum.y, warp_checksum_.x, warp_checksum_.y);
            
    __syncthreads();
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 0) / (float)(256.0), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 1) / (float)(256.0), tmp_angle);
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 2) / (float)(256.0), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 3) / (float)(256.0), tmp_angle);
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 4) / (float)(256.0), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 5) / (float)(256.0), tmp_angle);
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 6) / (float)(256.0), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 7) / (float)(256.0), tmp_angle);
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 8) / (float)(256.0), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 9) / (float)(256.0), tmp_angle);
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 10) / (float)(256.0), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 11) / (float)(256.0), tmp_angle);
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 12) / (float)(256.0), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 13) / (float)(256.0), tmp_angle);
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 14) / (float)(256.0), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 15) / (float)(256.0), tmp_angle);
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 16) / (float)(256.0), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 17) / (float)(256.0), tmp_angle);
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 18) / (float)(256.0), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 19) / (float)(256.0), tmp_angle);
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 20) / (float)(256.0), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 21) / (float)(256.0), tmp_angle);
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 22) / (float)(256.0), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 23) / (float)(256.0), tmp_angle);
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 24) / (float)(256.0), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 25) / (float)(256.0), tmp_angle);
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 26) / (float)(256.0), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 27) / (float)(256.0), tmp_angle);
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 28) / (float)(256.0), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 29) / (float)(256.0), tmp_angle);
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 30) / (float)(256.0), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx / 32) * 31) / (float)(256.0), tmp_angle);
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    
    sdata[__id[0]] = temp_0;
    
    sdata[__id[16]] = temp_16;
    
    sdata[__id[8]] = temp_8;
    
    sdata[__id[24]] = temp_24;
    
    sdata[__id[4]] = temp_4;
    
    sdata[__id[20]] = temp_20;
    
    sdata[__id[12]] = temp_12;
    
    sdata[__id[28]] = temp_28;
    
    sdata[__id[2]] = temp_2;
    
    sdata[__id[18]] = temp_18;
    
    sdata[__id[10]] = temp_10;
    
    sdata[__id[26]] = temp_26;
    
    sdata[__id[6]] = temp_6;
    
    sdata[__id[22]] = temp_22;
    
    sdata[__id[14]] = temp_14;
    
    sdata[__id[30]] = temp_30;
    
    sdata[__id[1]] = temp_1;
    
    sdata[__id[17]] = temp_17;
    
    sdata[__id[9]] = temp_9;
    
    sdata[__id[25]] = temp_25;
    
    sdata[__id[5]] = temp_5;
    
    sdata[__id[21]] = temp_21;
    
    sdata[__id[13]] = temp_13;
    
    sdata[__id[29]] = temp_29;
    
    sdata[__id[3]] = temp_3;
    
    sdata[__id[19]] = temp_19;
    
    sdata[__id[11]] = temp_11;
    
    sdata[__id[27]] = temp_27;
    
    sdata[__id[7]] = temp_7;
    
    sdata[__id[23]] = temp_23;
    
    sdata[__id[15]] = temp_15;
    
    sdata[__id[31]] = temp_31;
    
    __syncthreads();
    
    temp_0 = sdata[0 * blockDim.x + tx];
    __id[0] = tx + 0 * 256;
    
    temp_1 = sdata[1 * blockDim.x + tx];
    __id[1] = tx + 1 * 256;
    
    temp_2 = sdata[2 * blockDim.x + tx];
    __id[2] = tx + 2 * 256;
    
    temp_3 = sdata[3 * blockDim.x + tx];
    __id[3] = tx + 3 * 256;
    
    temp_4 = sdata[4 * blockDim.x + tx];
    __id[4] = tx + 4 * 256;
    
    temp_5 = sdata[5 * blockDim.x + tx];
    __id[5] = tx + 5 * 256;
    
    temp_6 = sdata[6 * blockDim.x + tx];
    __id[6] = tx + 6 * 256;
    
    temp_7 = sdata[7 * blockDim.x + tx];
    __id[7] = tx + 7 * 256;
    
    temp_8 = sdata[8 * blockDim.x + tx];
    __id[8] = tx + 8 * 256;
    
    temp_9 = sdata[9 * blockDim.x + tx];
    __id[9] = tx + 9 * 256;
    
    temp_10 = sdata[10 * blockDim.x + tx];
    __id[10] = tx + 10 * 256;
    
    temp_11 = sdata[11 * blockDim.x + tx];
    __id[11] = tx + 11 * 256;
    
    temp_12 = sdata[12 * blockDim.x + tx];
    __id[12] = tx + 12 * 256;
    
    temp_13 = sdata[13 * blockDim.x + tx];
    __id[13] = tx + 13 * 256;
    
    temp_14 = sdata[14 * blockDim.x + tx];
    __id[14] = tx + 14 * 256;
    
    temp_15 = sdata[15 * blockDim.x + tx];
    __id[15] = tx + 15 * 256;
    
    temp_16 = sdata[16 * blockDim.x + tx];
    __id[16] = tx + 16 * 256;
    
    temp_17 = sdata[17 * blockDim.x + tx];
    __id[17] = tx + 17 * 256;
    
    temp_18 = sdata[18 * blockDim.x + tx];
    __id[18] = tx + 18 * 256;
    
    temp_19 = sdata[19 * blockDim.x + tx];
    __id[19] = tx + 19 * 256;
    
    temp_20 = sdata[20 * blockDim.x + tx];
    __id[20] = tx + 20 * 256;
    
    temp_21 = sdata[21 * blockDim.x + tx];
    __id[21] = tx + 21 * 256;
    
    temp_22 = sdata[22 * blockDim.x + tx];
    __id[22] = tx + 22 * 256;
    
    temp_23 = sdata[23 * blockDim.x + tx];
    __id[23] = tx + 23 * 256;
    
    temp_24 = sdata[24 * blockDim.x + tx];
    __id[24] = tx + 24 * 256;
    
    temp_25 = sdata[25 * blockDim.x + tx];
    __id[25] = tx + 25 * 256;
    
    temp_26 = sdata[26 * blockDim.x + tx];
    __id[26] = tx + 26 * 256;
    
    temp_27 = sdata[27 * blockDim.x + tx];
    __id[27] = tx + 27 * 256;
    
    temp_28 = sdata[28 * blockDim.x + tx];
    __id[28] = tx + 28 * 256;
    
    temp_29 = sdata[29 * blockDim.x + tx];
    __id[29] = tx + 29 * 256;
    
    temp_30 = sdata[30 * blockDim.x + tx];
    __id[30] = tx + 30 * 256;
    
    temp_31 = sdata[31 * blockDim.x + tx];
    __id[31] = tx + 31 * 256;
    
            warp_checksum.x = 0;
            warp_checksum.y = 0;
        
                        warp_checksum.x += temp_0.x * A_radix8_0_x - temp_0.y * A_radix8_0_y;
                        warp_checksum.y += temp_0.x * A_radix8_0_y + temp_0.y * A_radix8_0_x;
        
                        warp_checksum.x += temp_4.x * A_radix8_1_x - temp_4.y * A_radix8_1_y;
                        warp_checksum.y += temp_4.x * A_radix8_1_y + temp_4.y * A_radix8_1_x;
        
                        warp_checksum.x += temp_8.x * A_radix8_2_x - temp_8.y * A_radix8_2_y;
                        warp_checksum.y += temp_8.x * A_radix8_2_y + temp_8.y * A_radix8_2_x;
        
                        warp_checksum.x += temp_12.x * A_radix8_3_x - temp_12.y * A_radix8_3_y;
                        warp_checksum.y += temp_12.x * A_radix8_3_y + temp_12.y * A_radix8_3_x;
        
                        warp_checksum.x += temp_16.x * A_radix8_4_x - temp_16.y * A_radix8_4_y;
                        warp_checksum.y += temp_16.x * A_radix8_4_y + temp_16.y * A_radix8_4_x;
        
                        warp_checksum.x += temp_20.x * A_radix8_5_x - temp_20.y * A_radix8_5_y;
                        warp_checksum.y += temp_20.x * A_radix8_5_y + temp_20.y * A_radix8_5_x;
        
                        warp_checksum.x += temp_24.x * A_radix8_6_x - temp_24.y * A_radix8_6_y;
                        warp_checksum.y += temp_24.x * A_radix8_6_y + temp_24.y * A_radix8_6_x;
        
                        warp_checksum.x += temp_28.x * A_radix8_7_x - temp_28.y * A_radix8_7_y;
                        warp_checksum.y += temp_28.x * A_radix8_7_y + temp_28.y * A_radix8_7_x;
        
                        warp_checksum.x += temp_1.x * A_radix8_0_x - temp_1.y * A_radix8_0_y;
                        warp_checksum.y += temp_1.x * A_radix8_0_y + temp_1.y * A_radix8_0_x;
        
                        warp_checksum.x += temp_5.x * A_radix8_1_x - temp_5.y * A_radix8_1_y;
                        warp_checksum.y += temp_5.x * A_radix8_1_y + temp_5.y * A_radix8_1_x;
        
                        warp_checksum.x += temp_9.x * A_radix8_2_x - temp_9.y * A_radix8_2_y;
                        warp_checksum.y += temp_9.x * A_radix8_2_y + temp_9.y * A_radix8_2_x;
        
                        warp_checksum.x += temp_13.x * A_radix8_3_x - temp_13.y * A_radix8_3_y;
                        warp_checksum.y += temp_13.x * A_radix8_3_y + temp_13.y * A_radix8_3_x;
        
                        warp_checksum.x += temp_17.x * A_radix8_4_x - temp_17.y * A_radix8_4_y;
                        warp_checksum.y += temp_17.x * A_radix8_4_y + temp_17.y * A_radix8_4_x;
        
                        warp_checksum.x += temp_21.x * A_radix8_5_x - temp_21.y * A_radix8_5_y;
                        warp_checksum.y += temp_21.x * A_radix8_5_y + temp_21.y * A_radix8_5_x;
        
                        warp_checksum.x += temp_25.x * A_radix8_6_x - temp_25.y * A_radix8_6_y;
                        warp_checksum.y += temp_25.x * A_radix8_6_y + temp_25.y * A_radix8_6_x;
        
                        warp_checksum.x += temp_29.x * A_radix8_7_x - temp_29.y * A_radix8_7_y;
                        warp_checksum.y += temp_29.x * A_radix8_7_y + temp_29.y * A_radix8_7_x;
        
                        warp_checksum.x += temp_2.x * A_radix8_0_x - temp_2.y * A_radix8_0_y;
                        warp_checksum.y += temp_2.x * A_radix8_0_y + temp_2.y * A_radix8_0_x;
        
                        warp_checksum.x += temp_6.x * A_radix8_1_x - temp_6.y * A_radix8_1_y;
                        warp_checksum.y += temp_6.x * A_radix8_1_y + temp_6.y * A_radix8_1_x;
        
                        warp_checksum.x += temp_10.x * A_radix8_2_x - temp_10.y * A_radix8_2_y;
                        warp_checksum.y += temp_10.x * A_radix8_2_y + temp_10.y * A_radix8_2_x;
        
                        warp_checksum.x += temp_14.x * A_radix8_3_x - temp_14.y * A_radix8_3_y;
                        warp_checksum.y += temp_14.x * A_radix8_3_y + temp_14.y * A_radix8_3_x;
        
                        warp_checksum.x += temp_18.x * A_radix8_4_x - temp_18.y * A_radix8_4_y;
                        warp_checksum.y += temp_18.x * A_radix8_4_y + temp_18.y * A_radix8_4_x;
        
                        warp_checksum.x += temp_22.x * A_radix8_5_x - temp_22.y * A_radix8_5_y;
                        warp_checksum.y += temp_22.x * A_radix8_5_y + temp_22.y * A_radix8_5_x;
        
                        warp_checksum.x += temp_26.x * A_radix8_6_x - temp_26.y * A_radix8_6_y;
                        warp_checksum.y += temp_26.x * A_radix8_6_y + temp_26.y * A_radix8_6_x;
        
                        warp_checksum.x += temp_30.x * A_radix8_7_x - temp_30.y * A_radix8_7_y;
                        warp_checksum.y += temp_30.x * A_radix8_7_y + temp_30.y * A_radix8_7_x;
        
                        warp_checksum.x += temp_3.x * A_radix8_0_x - temp_3.y * A_radix8_0_y;
                        warp_checksum.y += temp_3.x * A_radix8_0_y + temp_3.y * A_radix8_0_x;
        
                        warp_checksum.x += temp_7.x * A_radix8_1_x - temp_7.y * A_radix8_1_y;
                        warp_checksum.y += temp_7.x * A_radix8_1_y + temp_7.y * A_radix8_1_x;
        
                        warp_checksum.x += temp_11.x * A_radix8_2_x - temp_11.y * A_radix8_2_y;
                        warp_checksum.y += temp_11.x * A_radix8_2_y + temp_11.y * A_radix8_2_x;
        
                        warp_checksum.x += temp_15.x * A_radix8_3_x - temp_15.y * A_radix8_3_y;
                        warp_checksum.y += temp_15.x * A_radix8_3_y + temp_15.y * A_radix8_3_x;
        
                        warp_checksum.x += temp_19.x * A_radix8_4_x - temp_19.y * A_radix8_4_y;
                        warp_checksum.y += temp_19.x * A_radix8_4_y + temp_19.y * A_radix8_4_x;
        
                        warp_checksum.x += temp_23.x * A_radix8_5_x - temp_23.y * A_radix8_5_y;
                        warp_checksum.y += temp_23.x * A_radix8_5_y + temp_23.y * A_radix8_5_x;
        
                        warp_checksum.x += temp_27.x * A_radix8_6_x - temp_27.y * A_radix8_6_y;
                        warp_checksum.y += temp_27.x * A_radix8_6_y + temp_27.y * A_radix8_6_x;
        
                        warp_checksum.x += temp_31.x * A_radix8_7_x - temp_31.y * A_radix8_7_y;
                        warp_checksum.y += temp_31.x * A_radix8_7_y + temp_31.y * A_radix8_7_x;
        
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
        
        MY_MUL(temp_16, tmp_angle, tmp);
        temp_16 = tmp;
        
        MY_MUL(temp_20, tmp_angle, tmp);
        temp_20 = tmp;
        
        MY_MUL(temp_24, tmp_angle, tmp);
        temp_24 = tmp;
        
        MY_MUL(temp_28, tmp_angle, tmp);
        temp_28 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_17, tmp_angle, tmp);
        temp_17 = tmp;
        
        MY_MUL(temp_21, tmp_angle, tmp);
        temp_21 = tmp;
        
        MY_MUL(temp_25, tmp_angle, tmp);
        temp_25 = tmp;
        
        MY_MUL(temp_29, tmp_angle, tmp);
        temp_29 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_18, tmp_angle, tmp);
        temp_18 = tmp;
        
        MY_MUL(temp_22, tmp_angle, tmp);
        temp_22 = tmp;
        
        MY_MUL(temp_26, tmp_angle, tmp);
        temp_26 = tmp;
        
        MY_MUL(temp_30, tmp_angle, tmp);
        temp_30 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_19, tmp_angle, tmp);
        temp_19 = tmp;
        
        MY_MUL(temp_23, tmp_angle, tmp);
        temp_23 = tmp;
        
        MY_MUL(temp_27, tmp_angle, tmp);
        temp_27 = tmp;
        
        MY_MUL(temp_31, tmp_angle, tmp);
        temp_31 = tmp;
        
        tmp = temp_0;
        MY_ADD(tmp, temp_16, temp_0);
        MY_SUB(tmp, temp_16, temp_16);
        tmp_id = __id[0];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[0] = tmp_id;
        __id[16] = tmp_id + 1024;
        
        tmp = temp_4;
        MY_ADD(tmp, temp_20, temp_4);
        MY_SUB(tmp, temp_20, temp_20);
        tmp_id = __id[4];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[4] = tmp_id;
        __id[20] = tmp_id + 1024;
        
        tmp = temp_8;
        MY_ADD(tmp, temp_24, temp_8);
        MY_SUB(tmp, temp_24, temp_24);
        tmp_id = __id[8];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[8] = tmp_id;
        __id[24] = tmp_id + 1024;
        
        tmp = temp_12;
        MY_ADD(tmp, temp_28, temp_12);
        MY_SUB(tmp, temp_28, temp_28);
        tmp_id = __id[12];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[12] = tmp_id;
        __id[28] = tmp_id + 1024;
        
        tmp = temp_1;
        MY_ADD(tmp, temp_17, temp_1);
        MY_SUB(tmp, temp_17, temp_17);
        tmp_id = __id[1];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[1] = tmp_id;
        __id[17] = tmp_id + 1024;
        
        tmp = temp_5;
        MY_ADD(tmp, temp_21, temp_5);
        MY_SUB(tmp, temp_21, temp_21);
        tmp_id = __id[5];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[5] = tmp_id;
        __id[21] = tmp_id + 1024;
        
        tmp = temp_9;
        MY_ADD(tmp, temp_25, temp_9);
        MY_SUB(tmp, temp_25, temp_25);
        tmp_id = __id[9];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[9] = tmp_id;
        __id[25] = tmp_id + 1024;
        
        tmp = temp_13;
        MY_ADD(tmp, temp_29, temp_13);
        MY_SUB(tmp, temp_29, temp_29);
        tmp_id = __id[13];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[13] = tmp_id;
        __id[29] = tmp_id + 1024;
        
        tmp = temp_2;
        MY_ADD(tmp, temp_18, temp_2);
        MY_SUB(tmp, temp_18, temp_18);
        tmp_id = __id[2];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[2] = tmp_id;
        __id[18] = tmp_id + 1024;
        
        tmp = temp_6;
        MY_ADD(tmp, temp_22, temp_6);
        MY_SUB(tmp, temp_22, temp_22);
        tmp_id = __id[6];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[6] = tmp_id;
        __id[22] = tmp_id + 1024;
        
        tmp = temp_10;
        MY_ADD(tmp, temp_26, temp_10);
        MY_SUB(tmp, temp_26, temp_26);
        tmp_id = __id[10];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[10] = tmp_id;
        __id[26] = tmp_id + 1024;
        
        tmp = temp_14;
        MY_ADD(tmp, temp_30, temp_14);
        MY_SUB(tmp, temp_30, temp_30);
        tmp_id = __id[14];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[14] = tmp_id;
        __id[30] = tmp_id + 1024;
        
        tmp = temp_3;
        MY_ADD(tmp, temp_19, temp_3);
        MY_SUB(tmp, temp_19, temp_19);
        tmp_id = __id[3];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[3] = tmp_id;
        __id[19] = tmp_id + 1024;
        
        tmp = temp_7;
        MY_ADD(tmp, temp_23, temp_7);
        MY_SUB(tmp, temp_23, temp_23);
        tmp_id = __id[7];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[7] = tmp_id;
        __id[23] = tmp_id + 1024;
        
        tmp = temp_11;
        MY_ADD(tmp, temp_27, temp_11);
        MY_SUB(tmp, temp_27, temp_27);
        tmp_id = __id[11];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[11] = tmp_id;
        __id[27] = tmp_id + 1024;
        
        tmp = temp_15;
        MY_ADD(tmp, temp_31, temp_15);
        MY_SUB(tmp, temp_31, temp_31);
        tmp_id = __id[15];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[15] = tmp_id;
        __id[31] = tmp_id + 1024;
        
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
        
        MY_MUL(temp_8, tmp_angle, tmp);
        temp_8 = tmp;
        
        MY_MUL(temp_24, tmp_angle_rot, tmp);
        temp_24 = tmp;
        
        MY_MUL(temp_12, tmp_angle, tmp);
        temp_12 = tmp;
        
        MY_MUL(temp_28, tmp_angle_rot, tmp);
        temp_28 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_9, tmp_angle, tmp);
        temp_9 = tmp;
        
        MY_MUL(temp_25, tmp_angle_rot, tmp);
        temp_25 = tmp;
        
        MY_MUL(temp_13, tmp_angle, tmp);
        temp_13 = tmp;
        
        MY_MUL(temp_29, tmp_angle_rot, tmp);
        temp_29 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_10, tmp_angle, tmp);
        temp_10 = tmp;
        
        MY_MUL(temp_26, tmp_angle_rot, tmp);
        temp_26 = tmp;
        
        MY_MUL(temp_14, tmp_angle, tmp);
        temp_14 = tmp;
        
        MY_MUL(temp_30, tmp_angle_rot, tmp);
        temp_30 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_11, tmp_angle, tmp);
        temp_11 = tmp;
        
        MY_MUL(temp_27, tmp_angle_rot, tmp);
        temp_27 = tmp;
        
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
        __id[8] = tmp_id + 2048;
        
        tmp = temp_16;
        MY_ADD(tmp, temp_24, temp_16);
        MY_SUB(tmp, temp_24, temp_24);
        tmp_id = __id[16];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[16] = tmp_id;
        __id[24] = tmp_id + 2048;
        
        tmp = temp_4;
        MY_ADD(tmp, temp_12, temp_4);
        MY_SUB(tmp, temp_12, temp_12);
        tmp_id = __id[4];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[4] = tmp_id;
        __id[12] = tmp_id + 2048;
        
        tmp = temp_20;
        MY_ADD(tmp, temp_28, temp_20);
        MY_SUB(tmp, temp_28, temp_28);
        tmp_id = __id[20];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[20] = tmp_id;
        __id[28] = tmp_id + 2048;
        
        tmp = temp_1;
        MY_ADD(tmp, temp_9, temp_1);
        MY_SUB(tmp, temp_9, temp_9);
        tmp_id = __id[1];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[1] = tmp_id;
        __id[9] = tmp_id + 2048;
        
        tmp = temp_17;
        MY_ADD(tmp, temp_25, temp_17);
        MY_SUB(tmp, temp_25, temp_25);
        tmp_id = __id[17];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[17] = tmp_id;
        __id[25] = tmp_id + 2048;
        
        tmp = temp_5;
        MY_ADD(tmp, temp_13, temp_5);
        MY_SUB(tmp, temp_13, temp_13);
        tmp_id = __id[5];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[5] = tmp_id;
        __id[13] = tmp_id + 2048;
        
        tmp = temp_21;
        MY_ADD(tmp, temp_29, temp_21);
        MY_SUB(tmp, temp_29, temp_29);
        tmp_id = __id[21];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[21] = tmp_id;
        __id[29] = tmp_id + 2048;
        
        tmp = temp_2;
        MY_ADD(tmp, temp_10, temp_2);
        MY_SUB(tmp, temp_10, temp_10);
        tmp_id = __id[2];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[2] = tmp_id;
        __id[10] = tmp_id + 2048;
        
        tmp = temp_18;
        MY_ADD(tmp, temp_26, temp_18);
        MY_SUB(tmp, temp_26, temp_26);
        tmp_id = __id[18];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[18] = tmp_id;
        __id[26] = tmp_id + 2048;
        
        tmp = temp_6;
        MY_ADD(tmp, temp_14, temp_6);
        MY_SUB(tmp, temp_14, temp_14);
        tmp_id = __id[6];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[6] = tmp_id;
        __id[14] = tmp_id + 2048;
        
        tmp = temp_22;
        MY_ADD(tmp, temp_30, temp_22);
        MY_SUB(tmp, temp_30, temp_30);
        tmp_id = __id[22];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[22] = tmp_id;
        __id[30] = tmp_id + 2048;
        
        tmp = temp_3;
        MY_ADD(tmp, temp_11, temp_3);
        MY_SUB(tmp, temp_11, temp_11);
        tmp_id = __id[3];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[3] = tmp_id;
        __id[11] = tmp_id + 2048;
        
        tmp = temp_19;
        MY_ADD(tmp, temp_27, temp_19);
        MY_SUB(tmp, temp_27, temp_27);
        tmp_id = __id[19];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[19] = tmp_id;
        __id[27] = tmp_id + 2048;
        
        tmp = temp_7;
        MY_ADD(tmp, temp_15, temp_7);
        MY_SUB(tmp, temp_15, temp_15);
        tmp_id = __id[7];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[7] = tmp_id;
        __id[15] = tmp_id + 2048;
        
        tmp = temp_23;
        MY_ADD(tmp, temp_31, temp_23);
        MY_SUB(tmp, temp_31, temp_31);
        tmp_id = __id[23];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[23] = tmp_id;
        __id[31] = tmp_id + 2048;
        
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
        
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        
        MY_MUL(temp_12, tmp_angle_rot, tmp);
        temp_12 = tmp;
        
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
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_21, tmp_angle, tmp);
        temp_21 = tmp;
        
        MY_MUL(temp_29, tmp_angle_rot, tmp);
        temp_29 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        
        MY_MUL(temp_14, tmp_angle_rot, tmp);
        temp_14 = tmp;
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_22, tmp_angle, tmp);
        temp_22 = tmp;
        
        MY_MUL(temp_30, tmp_angle_rot, tmp);
        temp_30 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
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
        __id[4] = tmp_id + 4096;
        
        tmp = temp_16;
        MY_ADD(tmp, temp_20, temp_16);
        MY_SUB(tmp, temp_20, temp_20);
        tmp_id = __id[16];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[16] = tmp_id;
        __id[20] = tmp_id + 4096;
        
        tmp = temp_8;
        MY_ADD(tmp, temp_12, temp_8);
        MY_SUB(tmp, temp_12, temp_12);
        tmp_id = __id[8];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[8] = tmp_id;
        __id[12] = tmp_id + 4096;
        
        tmp = temp_24;
        MY_ADD(tmp, temp_28, temp_24);
        MY_SUB(tmp, temp_28, temp_28);
        tmp_id = __id[24];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[24] = tmp_id;
        __id[28] = tmp_id + 4096;
        
        tmp = temp_1;
        MY_ADD(tmp, temp_5, temp_1);
        MY_SUB(tmp, temp_5, temp_5);
        tmp_id = __id[1];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[1] = tmp_id;
        __id[5] = tmp_id + 4096;
        
        tmp = temp_17;
        MY_ADD(tmp, temp_21, temp_17);
        MY_SUB(tmp, temp_21, temp_21);
        tmp_id = __id[17];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[17] = tmp_id;
        __id[21] = tmp_id + 4096;
        
        tmp = temp_9;
        MY_ADD(tmp, temp_13, temp_9);
        MY_SUB(tmp, temp_13, temp_13);
        tmp_id = __id[9];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[9] = tmp_id;
        __id[13] = tmp_id + 4096;
        
        tmp = temp_25;
        MY_ADD(tmp, temp_29, temp_25);
        MY_SUB(tmp, temp_29, temp_29);
        tmp_id = __id[25];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[25] = tmp_id;
        __id[29] = tmp_id + 4096;
        
        tmp = temp_2;
        MY_ADD(tmp, temp_6, temp_2);
        MY_SUB(tmp, temp_6, temp_6);
        tmp_id = __id[2];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[2] = tmp_id;
        __id[6] = tmp_id + 4096;
        
        tmp = temp_18;
        MY_ADD(tmp, temp_22, temp_18);
        MY_SUB(tmp, temp_22, temp_22);
        tmp_id = __id[18];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[18] = tmp_id;
        __id[22] = tmp_id + 4096;
        
        tmp = temp_10;
        MY_ADD(tmp, temp_14, temp_10);
        MY_SUB(tmp, temp_14, temp_14);
        tmp_id = __id[10];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[10] = tmp_id;
        __id[14] = tmp_id + 4096;
        
        tmp = temp_26;
        MY_ADD(tmp, temp_30, temp_26);
        MY_SUB(tmp, temp_30, temp_30);
        tmp_id = __id[26];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[26] = tmp_id;
        __id[30] = tmp_id + 4096;
        
        tmp = temp_3;
        MY_ADD(tmp, temp_7, temp_3);
        MY_SUB(tmp, temp_7, temp_7);
        tmp_id = __id[3];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[3] = tmp_id;
        __id[7] = tmp_id + 4096;
        
        tmp = temp_19;
        MY_ADD(tmp, temp_23, temp_19);
        MY_SUB(tmp, temp_23, temp_23);
        tmp_id = __id[19];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[19] = tmp_id;
        __id[23] = tmp_id + 4096;
        
        tmp = temp_11;
        MY_ADD(tmp, temp_15, temp_11);
        MY_SUB(tmp, temp_15, temp_15);
        tmp_id = __id[11];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[11] = tmp_id;
        __id[15] = tmp_id + 4096;
        
        tmp = temp_27;
        MY_ADD(tmp, temp_31, temp_27);
        MY_SUB(tmp, temp_31, temp_31);
        tmp_id = __id[27];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[27] = tmp_id;
        __id[31] = tmp_id + 4096;
        
        n_global *= 2;
        
            warp_checksum_ = warp_checksum;
            
            
                        warp_checksum.x -= temp_0.x * r[0].x - temp_0.y * r[0].y;
                        warp_checksum.y -= temp_0.x * r[0].y + temp_0.y * r[0].x;
            
                        warp_checksum.x -= temp_16.x * r[1].x - temp_16.y * r[1].y;
                        warp_checksum.y -= temp_16.x * r[1].y + temp_16.y * r[1].x;
            
                        warp_checksum.x -= temp_8.x * r[2].x - temp_8.y * r[2].y;
                        warp_checksum.y -= temp_8.x * r[2].y + temp_8.y * r[2].x;
            
                        warp_checksum.x -= temp_24.x * r[0].x - temp_24.y * r[0].y;
                        warp_checksum.y -= temp_24.x * r[0].y + temp_24.y * r[0].x;
            
                        warp_checksum.x -= temp_4.x * r[1].x - temp_4.y * r[1].y;
                        warp_checksum.y -= temp_4.x * r[1].y + temp_4.y * r[1].x;
            
                        warp_checksum.x -= temp_20.x * r[2].x - temp_20.y * r[2].y;
                        warp_checksum.y -= temp_20.x * r[2].y + temp_20.y * r[2].x;
            
                        warp_checksum.x -= temp_12.x * r[0].x - temp_12.y * r[0].y;
                        warp_checksum.y -= temp_12.x * r[0].y + temp_12.y * r[0].x;
            
                        warp_checksum.x -= temp_28.x * r[1].x - temp_28.y * r[1].y;
                        warp_checksum.y -= temp_28.x * r[1].y + temp_28.y * r[1].x;
            
                        warp_checksum.x -= temp_1.x * r[0].x - temp_1.y * r[0].y;
                        warp_checksum.y -= temp_1.x * r[0].y + temp_1.y * r[0].x;
            
                        warp_checksum.x -= temp_17.x * r[1].x - temp_17.y * r[1].y;
                        warp_checksum.y -= temp_17.x * r[1].y + temp_17.y * r[1].x;
            
                        warp_checksum.x -= temp_9.x * r[2].x - temp_9.y * r[2].y;
                        warp_checksum.y -= temp_9.x * r[2].y + temp_9.y * r[2].x;
            
                        warp_checksum.x -= temp_25.x * r[0].x - temp_25.y * r[0].y;
                        warp_checksum.y -= temp_25.x * r[0].y + temp_25.y * r[0].x;
            
                        warp_checksum.x -= temp_5.x * r[1].x - temp_5.y * r[1].y;
                        warp_checksum.y -= temp_5.x * r[1].y + temp_5.y * r[1].x;
            
                        warp_checksum.x -= temp_21.x * r[2].x - temp_21.y * r[2].y;
                        warp_checksum.y -= temp_21.x * r[2].y + temp_21.y * r[2].x;
            
                        warp_checksum.x -= temp_13.x * r[0].x - temp_13.y * r[0].y;
                        warp_checksum.y -= temp_13.x * r[0].y + temp_13.y * r[0].x;
            
                        warp_checksum.x -= temp_29.x * r[1].x - temp_29.y * r[1].y;
                        warp_checksum.y -= temp_29.x * r[1].y + temp_29.y * r[1].x;
            
                        warp_checksum.x -= temp_2.x * r[0].x - temp_2.y * r[0].y;
                        warp_checksum.y -= temp_2.x * r[0].y + temp_2.y * r[0].x;
            
                        warp_checksum.x -= temp_18.x * r[1].x - temp_18.y * r[1].y;
                        warp_checksum.y -= temp_18.x * r[1].y + temp_18.y * r[1].x;
            
                        warp_checksum.x -= temp_10.x * r[2].x - temp_10.y * r[2].y;
                        warp_checksum.y -= temp_10.x * r[2].y + temp_10.y * r[2].x;
            
                        warp_checksum.x -= temp_26.x * r[0].x - temp_26.y * r[0].y;
                        warp_checksum.y -= temp_26.x * r[0].y + temp_26.y * r[0].x;
            
                        warp_checksum.x -= temp_6.x * r[1].x - temp_6.y * r[1].y;
                        warp_checksum.y -= temp_6.x * r[1].y + temp_6.y * r[1].x;
            
                        warp_checksum.x -= temp_22.x * r[2].x - temp_22.y * r[2].y;
                        warp_checksum.y -= temp_22.x * r[2].y + temp_22.y * r[2].x;
            
                        warp_checksum.x -= temp_14.x * r[0].x - temp_14.y * r[0].y;
                        warp_checksum.y -= temp_14.x * r[0].y + temp_14.y * r[0].x;
            
                        warp_checksum.x -= temp_30.x * r[1].x - temp_30.y * r[1].y;
                        warp_checksum.y -= temp_30.x * r[1].y + temp_30.y * r[1].x;
            
                        warp_checksum.x -= temp_3.x * r[0].x - temp_3.y * r[0].y;
                        warp_checksum.y -= temp_3.x * r[0].y + temp_3.y * r[0].x;
            
                        warp_checksum.x -= temp_19.x * r[1].x - temp_19.y * r[1].y;
                        warp_checksum.y -= temp_19.x * r[1].y + temp_19.y * r[1].x;
            
                        warp_checksum.x -= temp_11.x * r[2].x - temp_11.y * r[2].y;
                        warp_checksum.y -= temp_11.x * r[2].y + temp_11.y * r[2].x;
            
                        warp_checksum.x -= temp_27.x * r[0].x - temp_27.y * r[0].y;
                        warp_checksum.y -= temp_27.x * r[0].y + temp_27.y * r[0].x;
            
                        warp_checksum.x -= temp_7.x * r[1].x - temp_7.y * r[1].y;
                        warp_checksum.y -= temp_7.x * r[1].y + temp_7.y * r[1].x;
            
                        warp_checksum.x -= temp_23.x * r[2].x - temp_23.y * r[2].y;
                        warp_checksum.y -= temp_23.x * r[2].y + temp_23.y * r[2].x;
            
                        warp_checksum.x -= temp_15.x * r[0].x - temp_15.y * r[0].y;
                        warp_checksum.y -= temp_15.x * r[0].y + temp_15.y * r[0].x;
            
                        warp_checksum.x -= temp_31.x * r[1].x - temp_31.y * r[1].y;
                        warp_checksum.y -= temp_31.x * r[1].y + temp_31.y * r[1].x;
            
            // printf("%f, %f, %f, %f\n", warp_checksum.x, warp_checksum.y, warp_checksum_.x, warp_checksum_.y);
            outputs[__id[0]] = temp_0;
    outputs[__id[1]] = temp_1;
    outputs[__id[2]] = temp_2;
    outputs[__id[3]] = temp_3;
    outputs[__id[16]] = temp_16;
    outputs[__id[17]] = temp_17;
    outputs[__id[18]] = temp_18;
    outputs[__id[19]] = temp_19;
    outputs[__id[8]] = temp_8;
    outputs[__id[9]] = temp_9;
    outputs[__id[10]] = temp_10;
    outputs[__id[11]] = temp_11;
    outputs[__id[24]] = temp_24;
    outputs[__id[25]] = temp_25;
    outputs[__id[26]] = temp_26;
    outputs[__id[27]] = temp_27;
    outputs[__id[4]] = temp_4;
    outputs[__id[5]] = temp_5;
    outputs[__id[6]] = temp_6;
    outputs[__id[7]] = temp_7;
    outputs[__id[20]] = temp_20;
    outputs[__id[21]] = temp_21;
    outputs[__id[22]] = temp_22;
    outputs[__id[23]] = temp_23;
    outputs[__id[12]] = temp_12;
    outputs[__id[13]] = temp_13;
    outputs[__id[14]] = temp_14;
    outputs[__id[15]] = temp_15;
    outputs[__id[28]] = temp_28;
    outputs[__id[29]] = temp_29;
    outputs[__id[30]] = temp_30;
    outputs[__id[31]] = temp_31;
    
    }
