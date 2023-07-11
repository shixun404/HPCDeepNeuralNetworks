extern __shared__ float shared[];
__global__ void __launch_bounds__(128) fft_radix2_logN13(float2* inputs, float2* outputs) {

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
    float2 temp_32;
    float2 temp_33;
    float2 temp_34;
    float2 temp_35;
    float2 temp_36;
    float2 temp_37;
    float2 temp_38;
    float2 temp_39;
    float2 temp_40;
    float2 temp_41;
    float2 temp_42;
    float2 temp_43;
    float2 temp_44;
    float2 temp_45;
    float2 temp_46;
    float2 temp_47;
    float2 temp_48;
    float2 temp_49;
    float2 temp_50;
    float2 temp_51;
    float2 temp_52;
    float2 temp_53;
    float2 temp_54;
    float2 temp_55;
    float2 temp_56;
    float2 temp_57;
    float2 temp_58;
    float2 temp_59;
    float2 temp_60;
    float2 temp_61;
    float2 temp_62;
    float2 temp_63;
    
    float2* sdata = (float2*)shared;
    int tx = threadIdx.x;
    int N = 8192;
    int __id[64];
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
    temp_32 = inputs[32 * blockDim.x + tx];
    temp_33 = inputs[33 * blockDim.x + tx];
    temp_34 = inputs[34 * blockDim.x + tx];
    temp_35 = inputs[35 * blockDim.x + tx];
    temp_36 = inputs[36 * blockDim.x + tx];
    temp_37 = inputs[37 * blockDim.x + tx];
    temp_38 = inputs[38 * blockDim.x + tx];
    temp_39 = inputs[39 * blockDim.x + tx];
    temp_40 = inputs[40 * blockDim.x + tx];
    temp_41 = inputs[41 * blockDim.x + tx];
    temp_42 = inputs[42 * blockDim.x + tx];
    temp_43 = inputs[43 * blockDim.x + tx];
    temp_44 = inputs[44 * blockDim.x + tx];
    temp_45 = inputs[45 * blockDim.x + tx];
    temp_46 = inputs[46 * blockDim.x + tx];
    temp_47 = inputs[47 * blockDim.x + tx];
    temp_48 = inputs[48 * blockDim.x + tx];
    temp_49 = inputs[49 * blockDim.x + tx];
    temp_50 = inputs[50 * blockDim.x + tx];
    temp_51 = inputs[51 * blockDim.x + tx];
    temp_52 = inputs[52 * blockDim.x + tx];
    temp_53 = inputs[53 * blockDim.x + tx];
    temp_54 = inputs[54 * blockDim.x + tx];
    temp_55 = inputs[55 * blockDim.x + tx];
    temp_56 = inputs[56 * blockDim.x + tx];
    temp_57 = inputs[57 * blockDim.x + tx];
    temp_58 = inputs[58 * blockDim.x + tx];
    temp_59 = inputs[59 * blockDim.x + tx];
    temp_60 = inputs[60 * blockDim.x + tx];
    temp_61 = inputs[61 * blockDim.x + tx];
    temp_62 = inputs[62 * blockDim.x + tx];
    temp_63 = inputs[63 * blockDim.x + tx];
    
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
    __id[32] = 32 * blockDim.x + tx;
    __id[33] = 33 * blockDim.x + tx;
    __id[34] = 34 * blockDim.x + tx;
    __id[35] = 35 * blockDim.x + tx;
    __id[36] = 36 * blockDim.x + tx;
    __id[37] = 37 * blockDim.x + tx;
    __id[38] = 38 * blockDim.x + tx;
    __id[39] = 39 * blockDim.x + tx;
    __id[40] = 40 * blockDim.x + tx;
    __id[41] = 41 * blockDim.x + tx;
    __id[42] = 42 * blockDim.x + tx;
    __id[43] = 43 * blockDim.x + tx;
    __id[44] = 44 * blockDim.x + tx;
    __id[45] = 45 * blockDim.x + tx;
    __id[46] = 46 * blockDim.x + tx;
    __id[47] = 47 * blockDim.x + tx;
    __id[48] = 48 * blockDim.x + tx;
    __id[49] = 49 * blockDim.x + tx;
    __id[50] = 50 * blockDim.x + tx;
    __id[51] = 51 * blockDim.x + tx;
    __id[52] = 52 * blockDim.x + tx;
    __id[53] = 53 * blockDim.x + tx;
    __id[54] = 54 * blockDim.x + tx;
    __id[55] = 55 * blockDim.x + tx;
    __id[56] = 56 * blockDim.x + tx;
    __id[57] = 57 * blockDim.x + tx;
    __id[58] = 58 * blockDim.x + tx;
    __id[59] = 59 * blockDim.x + tx;
    __id[60] = 60 * blockDim.x + tx;
    __id[61] = 61 * blockDim.x + tx;
    __id[62] = 62 * blockDim.x + tx;
    __id[63] = 63 * blockDim.x + tx;
    
    j = 1;
    k = __id[32] % 1;
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_32, tmp_angle, tmp);
    temp_32 = tmp;
    
    MY_MUL(temp_33, tmp_angle, tmp);
    temp_33 = tmp;
    
    MY_MUL(temp_34, tmp_angle, tmp);
    temp_34 = tmp;
    
    MY_MUL(temp_35, tmp_angle, tmp);
    temp_35 = tmp;
    
    MY_MUL(temp_36, tmp_angle, tmp);
    temp_36 = tmp;
    
    MY_MUL(temp_37, tmp_angle, tmp);
    temp_37 = tmp;
    
    MY_MUL(temp_38, tmp_angle, tmp);
    temp_38 = tmp;
    
    MY_MUL(temp_39, tmp_angle, tmp);
    temp_39 = tmp;
    
    MY_MUL(temp_40, tmp_angle, tmp);
    temp_40 = tmp;
    
    MY_MUL(temp_41, tmp_angle, tmp);
    temp_41 = tmp;
    
    MY_MUL(temp_42, tmp_angle, tmp);
    temp_42 = tmp;
    
    MY_MUL(temp_43, tmp_angle, tmp);
    temp_43 = tmp;
    
    MY_MUL(temp_44, tmp_angle, tmp);
    temp_44 = tmp;
    
    MY_MUL(temp_45, tmp_angle, tmp);
    temp_45 = tmp;
    
    MY_MUL(temp_46, tmp_angle, tmp);
    temp_46 = tmp;
    
    MY_MUL(temp_47, tmp_angle, tmp);
    temp_47 = tmp;
    
    MY_MUL(temp_48, tmp_angle, tmp);
    temp_48 = tmp;
    
    MY_MUL(temp_49, tmp_angle, tmp);
    temp_49 = tmp;
    
    MY_MUL(temp_50, tmp_angle, tmp);
    temp_50 = tmp;
    
    MY_MUL(temp_51, tmp_angle, tmp);
    temp_51 = tmp;
    
    MY_MUL(temp_52, tmp_angle, tmp);
    temp_52 = tmp;
    
    MY_MUL(temp_53, tmp_angle, tmp);
    temp_53 = tmp;
    
    MY_MUL(temp_54, tmp_angle, tmp);
    temp_54 = tmp;
    
    MY_MUL(temp_55, tmp_angle, tmp);
    temp_55 = tmp;
    
    MY_MUL(temp_56, tmp_angle, tmp);
    temp_56 = tmp;
    
    MY_MUL(temp_57, tmp_angle, tmp);
    temp_57 = tmp;
    
    MY_MUL(temp_58, tmp_angle, tmp);
    temp_58 = tmp;
    
    MY_MUL(temp_59, tmp_angle, tmp);
    temp_59 = tmp;
    
    MY_MUL(temp_60, tmp_angle, tmp);
    temp_60 = tmp;
    
    MY_MUL(temp_61, tmp_angle, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_62, tmp_angle, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_63, tmp_angle, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_32, temp_0);
    MY_SUB(tmp, temp_32, temp_32);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[32] = tmp_id + 1;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_33, temp_1);
    MY_SUB(tmp, temp_33, temp_33);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[33] = tmp_id + 1;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_34, temp_2);
    MY_SUB(tmp, temp_34, temp_34);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[34] = tmp_id + 1;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_35, temp_3);
    MY_SUB(tmp, temp_35, temp_35);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[35] = tmp_id + 1;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_36, temp_4);
    MY_SUB(tmp, temp_36, temp_36);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[36] = tmp_id + 1;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_37, temp_5);
    MY_SUB(tmp, temp_37, temp_37);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[37] = tmp_id + 1;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_38, temp_6);
    MY_SUB(tmp, temp_38, temp_38);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[38] = tmp_id + 1;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_39, temp_7);
    MY_SUB(tmp, temp_39, temp_39);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[39] = tmp_id + 1;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_40, temp_8);
    MY_SUB(tmp, temp_40, temp_40);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[40] = tmp_id + 1;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_41, temp_9);
    MY_SUB(tmp, temp_41, temp_41);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[41] = tmp_id + 1;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_42, temp_10);
    MY_SUB(tmp, temp_42, temp_42);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[42] = tmp_id + 1;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_43, temp_11);
    MY_SUB(tmp, temp_43, temp_43);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[43] = tmp_id + 1;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_44, temp_12);
    MY_SUB(tmp, temp_44, temp_44);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[44] = tmp_id + 1;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_45, temp_13);
    MY_SUB(tmp, temp_45, temp_45);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[45] = tmp_id + 1;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_46, temp_14);
    MY_SUB(tmp, temp_46, temp_46);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[46] = tmp_id + 1;
    
    tmp = temp_15;
    MY_ADD(tmp, temp_47, temp_15);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[15];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[15] = tmp_id;
    __id[47] = tmp_id + 1;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_48, temp_16);
    MY_SUB(tmp, temp_48, temp_48);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[48] = tmp_id + 1;
    
    tmp = temp_17;
    MY_ADD(tmp, temp_49, temp_17);
    MY_SUB(tmp, temp_49, temp_49);
    tmp_id = __id[17];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[17] = tmp_id;
    __id[49] = tmp_id + 1;
    
    tmp = temp_18;
    MY_ADD(tmp, temp_50, temp_18);
    MY_SUB(tmp, temp_50, temp_50);
    tmp_id = __id[18];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[18] = tmp_id;
    __id[50] = tmp_id + 1;
    
    tmp = temp_19;
    MY_ADD(tmp, temp_51, temp_19);
    MY_SUB(tmp, temp_51, temp_51);
    tmp_id = __id[19];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[19] = tmp_id;
    __id[51] = tmp_id + 1;
    
    tmp = temp_20;
    MY_ADD(tmp, temp_52, temp_20);
    MY_SUB(tmp, temp_52, temp_52);
    tmp_id = __id[20];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[20] = tmp_id;
    __id[52] = tmp_id + 1;
    
    tmp = temp_21;
    MY_ADD(tmp, temp_53, temp_21);
    MY_SUB(tmp, temp_53, temp_53);
    tmp_id = __id[21];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[21] = tmp_id;
    __id[53] = tmp_id + 1;
    
    tmp = temp_22;
    MY_ADD(tmp, temp_54, temp_22);
    MY_SUB(tmp, temp_54, temp_54);
    tmp_id = __id[22];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[22] = tmp_id;
    __id[54] = tmp_id + 1;
    
    tmp = temp_23;
    MY_ADD(tmp, temp_55, temp_23);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[23];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[23] = tmp_id;
    __id[55] = tmp_id + 1;
    
    tmp = temp_24;
    MY_ADD(tmp, temp_56, temp_24);
    MY_SUB(tmp, temp_56, temp_56);
    tmp_id = __id[24];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[24] = tmp_id;
    __id[56] = tmp_id + 1;
    
    tmp = temp_25;
    MY_ADD(tmp, temp_57, temp_25);
    MY_SUB(tmp, temp_57, temp_57);
    tmp_id = __id[25];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[25] = tmp_id;
    __id[57] = tmp_id + 1;
    
    tmp = temp_26;
    MY_ADD(tmp, temp_58, temp_26);
    MY_SUB(tmp, temp_58, temp_58);
    tmp_id = __id[26];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[26] = tmp_id;
    __id[58] = tmp_id + 1;
    
    tmp = temp_27;
    MY_ADD(tmp, temp_59, temp_27);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[27];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[27] = tmp_id;
    __id[59] = tmp_id + 1;
    
    tmp = temp_28;
    MY_ADD(tmp, temp_60, temp_28);
    MY_SUB(tmp, temp_60, temp_60);
    tmp_id = __id[28];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[28] = tmp_id;
    __id[60] = tmp_id + 1;
    
    tmp = temp_29;
    MY_ADD(tmp, temp_61, temp_29);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[29];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[29] = tmp_id;
    __id[61] = tmp_id + 1;
    
    tmp = temp_30;
    MY_ADD(tmp, temp_62, temp_30);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[30];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[30] = tmp_id;
    __id[62] = tmp_id + 1;
    
    tmp = temp_31;
    MY_ADD(tmp, temp_63, temp_31);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[31];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[31] = tmp_id;
    __id[63] = tmp_id + 1;
    
    n_global *= 2;
    
    j = 1;
    k = __id[16] % 2;
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    
    MY_MUL(temp_48, tmp_angle_rot, tmp);
    temp_48 = tmp;
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    
    MY_MUL(temp_49, tmp_angle_rot, tmp);
    temp_49 = tmp;
    
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    
    MY_MUL(temp_50, tmp_angle_rot, tmp);
    temp_50 = tmp;
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    
    MY_MUL(temp_51, tmp_angle_rot, tmp);
    temp_51 = tmp;
    
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    
    MY_MUL(temp_52, tmp_angle_rot, tmp);
    temp_52 = tmp;
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    
    MY_MUL(temp_53, tmp_angle_rot, tmp);
    temp_53 = tmp;
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    
    MY_MUL(temp_54, tmp_angle_rot, tmp);
    temp_54 = tmp;
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    
    MY_MUL(temp_55, tmp_angle_rot, tmp);
    temp_55 = tmp;
    
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    
    MY_MUL(temp_56, tmp_angle_rot, tmp);
    temp_56 = tmp;
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    
    MY_MUL(temp_57, tmp_angle_rot, tmp);
    temp_57 = tmp;
    
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    
    MY_MUL(temp_58, tmp_angle_rot, tmp);
    temp_58 = tmp;
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    
    MY_MUL(temp_59, tmp_angle_rot, tmp);
    temp_59 = tmp;
    
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    
    MY_MUL(temp_60, tmp_angle_rot, tmp);
    temp_60 = tmp;
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    
    MY_MUL(temp_61, tmp_angle_rot, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_16, temp_0);
    MY_SUB(tmp, temp_16, temp_16);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[16] = tmp_id + 2;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_48, temp_32);
    MY_SUB(tmp, temp_48, temp_48);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[48] = tmp_id + 2;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_17, temp_1);
    MY_SUB(tmp, temp_17, temp_17);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[17] = tmp_id + 2;
    
    tmp = temp_33;
    MY_ADD(tmp, temp_49, temp_33);
    MY_SUB(tmp, temp_49, temp_49);
    tmp_id = __id[33];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[33] = tmp_id;
    __id[49] = tmp_id + 2;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_18, temp_2);
    MY_SUB(tmp, temp_18, temp_18);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[18] = tmp_id + 2;
    
    tmp = temp_34;
    MY_ADD(tmp, temp_50, temp_34);
    MY_SUB(tmp, temp_50, temp_50);
    tmp_id = __id[34];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[34] = tmp_id;
    __id[50] = tmp_id + 2;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_19, temp_3);
    MY_SUB(tmp, temp_19, temp_19);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[19] = tmp_id + 2;
    
    tmp = temp_35;
    MY_ADD(tmp, temp_51, temp_35);
    MY_SUB(tmp, temp_51, temp_51);
    tmp_id = __id[35];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[35] = tmp_id;
    __id[51] = tmp_id + 2;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_20, temp_4);
    MY_SUB(tmp, temp_20, temp_20);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[20] = tmp_id + 2;
    
    tmp = temp_36;
    MY_ADD(tmp, temp_52, temp_36);
    MY_SUB(tmp, temp_52, temp_52);
    tmp_id = __id[36];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[36] = tmp_id;
    __id[52] = tmp_id + 2;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_21, temp_5);
    MY_SUB(tmp, temp_21, temp_21);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[21] = tmp_id + 2;
    
    tmp = temp_37;
    MY_ADD(tmp, temp_53, temp_37);
    MY_SUB(tmp, temp_53, temp_53);
    tmp_id = __id[37];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[37] = tmp_id;
    __id[53] = tmp_id + 2;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_22, temp_6);
    MY_SUB(tmp, temp_22, temp_22);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[22] = tmp_id + 2;
    
    tmp = temp_38;
    MY_ADD(tmp, temp_54, temp_38);
    MY_SUB(tmp, temp_54, temp_54);
    tmp_id = __id[38];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[38] = tmp_id;
    __id[54] = tmp_id + 2;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_23, temp_7);
    MY_SUB(tmp, temp_23, temp_23);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[23] = tmp_id + 2;
    
    tmp = temp_39;
    MY_ADD(tmp, temp_55, temp_39);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[39];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[39] = tmp_id;
    __id[55] = tmp_id + 2;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_24, temp_8);
    MY_SUB(tmp, temp_24, temp_24);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[24] = tmp_id + 2;
    
    tmp = temp_40;
    MY_ADD(tmp, temp_56, temp_40);
    MY_SUB(tmp, temp_56, temp_56);
    tmp_id = __id[40];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[40] = tmp_id;
    __id[56] = tmp_id + 2;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_25, temp_9);
    MY_SUB(tmp, temp_25, temp_25);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[25] = tmp_id + 2;
    
    tmp = temp_41;
    MY_ADD(tmp, temp_57, temp_41);
    MY_SUB(tmp, temp_57, temp_57);
    tmp_id = __id[41];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[41] = tmp_id;
    __id[57] = tmp_id + 2;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_26, temp_10);
    MY_SUB(tmp, temp_26, temp_26);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[26] = tmp_id + 2;
    
    tmp = temp_42;
    MY_ADD(tmp, temp_58, temp_42);
    MY_SUB(tmp, temp_58, temp_58);
    tmp_id = __id[42];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[42] = tmp_id;
    __id[58] = tmp_id + 2;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_27, temp_11);
    MY_SUB(tmp, temp_27, temp_27);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[27] = tmp_id + 2;
    
    tmp = temp_43;
    MY_ADD(tmp, temp_59, temp_43);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[43];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[43] = tmp_id;
    __id[59] = tmp_id + 2;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_28, temp_12);
    MY_SUB(tmp, temp_28, temp_28);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[28] = tmp_id + 2;
    
    tmp = temp_44;
    MY_ADD(tmp, temp_60, temp_44);
    MY_SUB(tmp, temp_60, temp_60);
    tmp_id = __id[44];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[44] = tmp_id;
    __id[60] = tmp_id + 2;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_29, temp_13);
    MY_SUB(tmp, temp_29, temp_29);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[29] = tmp_id + 2;
    
    tmp = temp_45;
    MY_ADD(tmp, temp_61, temp_45);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[45];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[45] = tmp_id;
    __id[61] = tmp_id + 2;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_30, temp_14);
    MY_SUB(tmp, temp_30, temp_30);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[30] = tmp_id + 2;
    
    tmp = temp_46;
    MY_ADD(tmp, temp_62, temp_46);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[46];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[46] = tmp_id;
    __id[62] = tmp_id + 2;
    
    tmp = temp_15;
    MY_ADD(tmp, temp_31, temp_15);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[15];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[15] = tmp_id;
    __id[31] = tmp_id + 2;
    
    tmp = temp_47;
    MY_ADD(tmp, temp_63, temp_47);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[47];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[47] = tmp_id;
    __id[63] = tmp_id + 2;
    
    n_global *= 2;
    
    j = 1;
    k = __id[8] % 4;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    
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
    
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_40, tmp_angle, tmp);
    temp_40 = tmp;
    
    MY_MUL(temp_56, tmp_angle_rot, tmp);
    temp_56 = tmp;
    
    MY_MUL(temp_41, tmp_angle, tmp);
    temp_41 = tmp;
    
    MY_MUL(temp_57, tmp_angle_rot, tmp);
    temp_57 = tmp;
    
    MY_MUL(temp_42, tmp_angle, tmp);
    temp_42 = tmp;
    
    MY_MUL(temp_58, tmp_angle_rot, tmp);
    temp_58 = tmp;
    
    MY_MUL(temp_43, tmp_angle, tmp);
    temp_43 = tmp;
    
    MY_MUL(temp_59, tmp_angle_rot, tmp);
    temp_59 = tmp;
    
    MY_MUL(temp_44, tmp_angle, tmp);
    temp_44 = tmp;
    
    MY_MUL(temp_60, tmp_angle_rot, tmp);
    temp_60 = tmp;
    
    MY_MUL(temp_45, tmp_angle, tmp);
    temp_45 = tmp;
    
    MY_MUL(temp_61, tmp_angle_rot, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_46, tmp_angle, tmp);
    temp_46 = tmp;
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_47, tmp_angle, tmp);
    temp_47 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_8, temp_0);
    MY_SUB(tmp, temp_8, temp_8);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[8] = tmp_id + 4;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_40, temp_32);
    MY_SUB(tmp, temp_40, temp_40);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[40] = tmp_id + 4;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_24, temp_16);
    MY_SUB(tmp, temp_24, temp_24);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[24] = tmp_id + 4;
    
    tmp = temp_48;
    MY_ADD(tmp, temp_56, temp_48);
    MY_SUB(tmp, temp_56, temp_56);
    tmp_id = __id[48];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[48] = tmp_id;
    __id[56] = tmp_id + 4;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_9, temp_1);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[9] = tmp_id + 4;
    
    tmp = temp_33;
    MY_ADD(tmp, temp_41, temp_33);
    MY_SUB(tmp, temp_41, temp_41);
    tmp_id = __id[33];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[33] = tmp_id;
    __id[41] = tmp_id + 4;
    
    tmp = temp_17;
    MY_ADD(tmp, temp_25, temp_17);
    MY_SUB(tmp, temp_25, temp_25);
    tmp_id = __id[17];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[17] = tmp_id;
    __id[25] = tmp_id + 4;
    
    tmp = temp_49;
    MY_ADD(tmp, temp_57, temp_49);
    MY_SUB(tmp, temp_57, temp_57);
    tmp_id = __id[49];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[49] = tmp_id;
    __id[57] = tmp_id + 4;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_10, temp_2);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[10] = tmp_id + 4;
    
    tmp = temp_34;
    MY_ADD(tmp, temp_42, temp_34);
    MY_SUB(tmp, temp_42, temp_42);
    tmp_id = __id[34];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[34] = tmp_id;
    __id[42] = tmp_id + 4;
    
    tmp = temp_18;
    MY_ADD(tmp, temp_26, temp_18);
    MY_SUB(tmp, temp_26, temp_26);
    tmp_id = __id[18];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[18] = tmp_id;
    __id[26] = tmp_id + 4;
    
    tmp = temp_50;
    MY_ADD(tmp, temp_58, temp_50);
    MY_SUB(tmp, temp_58, temp_58);
    tmp_id = __id[50];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[50] = tmp_id;
    __id[58] = tmp_id + 4;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_11, temp_3);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[11] = tmp_id + 4;
    
    tmp = temp_35;
    MY_ADD(tmp, temp_43, temp_35);
    MY_SUB(tmp, temp_43, temp_43);
    tmp_id = __id[35];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[35] = tmp_id;
    __id[43] = tmp_id + 4;
    
    tmp = temp_19;
    MY_ADD(tmp, temp_27, temp_19);
    MY_SUB(tmp, temp_27, temp_27);
    tmp_id = __id[19];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[19] = tmp_id;
    __id[27] = tmp_id + 4;
    
    tmp = temp_51;
    MY_ADD(tmp, temp_59, temp_51);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[51];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[51] = tmp_id;
    __id[59] = tmp_id + 4;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_12, temp_4);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[12] = tmp_id + 4;
    
    tmp = temp_36;
    MY_ADD(tmp, temp_44, temp_36);
    MY_SUB(tmp, temp_44, temp_44);
    tmp_id = __id[36];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[36] = tmp_id;
    __id[44] = tmp_id + 4;
    
    tmp = temp_20;
    MY_ADD(tmp, temp_28, temp_20);
    MY_SUB(tmp, temp_28, temp_28);
    tmp_id = __id[20];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[20] = tmp_id;
    __id[28] = tmp_id + 4;
    
    tmp = temp_52;
    MY_ADD(tmp, temp_60, temp_52);
    MY_SUB(tmp, temp_60, temp_60);
    tmp_id = __id[52];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[52] = tmp_id;
    __id[60] = tmp_id + 4;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_13, temp_5);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[13] = tmp_id + 4;
    
    tmp = temp_37;
    MY_ADD(tmp, temp_45, temp_37);
    MY_SUB(tmp, temp_45, temp_45);
    tmp_id = __id[37];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[37] = tmp_id;
    __id[45] = tmp_id + 4;
    
    tmp = temp_21;
    MY_ADD(tmp, temp_29, temp_21);
    MY_SUB(tmp, temp_29, temp_29);
    tmp_id = __id[21];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[21] = tmp_id;
    __id[29] = tmp_id + 4;
    
    tmp = temp_53;
    MY_ADD(tmp, temp_61, temp_53);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[53];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[53] = tmp_id;
    __id[61] = tmp_id + 4;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_14, temp_6);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[14] = tmp_id + 4;
    
    tmp = temp_38;
    MY_ADD(tmp, temp_46, temp_38);
    MY_SUB(tmp, temp_46, temp_46);
    tmp_id = __id[38];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[38] = tmp_id;
    __id[46] = tmp_id + 4;
    
    tmp = temp_22;
    MY_ADD(tmp, temp_30, temp_22);
    MY_SUB(tmp, temp_30, temp_30);
    tmp_id = __id[22];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[22] = tmp_id;
    __id[30] = tmp_id + 4;
    
    tmp = temp_54;
    MY_ADD(tmp, temp_62, temp_54);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[54];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[54] = tmp_id;
    __id[62] = tmp_id + 4;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_15, temp_7);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[15] = tmp_id + 4;
    
    tmp = temp_39;
    MY_ADD(tmp, temp_47, temp_39);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[39];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[39] = tmp_id;
    __id[47] = tmp_id + 4;
    
    tmp = temp_23;
    MY_ADD(tmp, temp_31, temp_23);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[23];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[23] = tmp_id;
    __id[31] = tmp_id + 4;
    
    tmp = temp_55;
    MY_ADD(tmp, temp_63, temp_55);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[55];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[55] = tmp_id;
    __id[63] = tmp_id + 4;
    
    n_global *= 2;
    
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
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_36, tmp_angle, tmp);
    temp_36 = tmp;
    
    MY_MUL(temp_44, tmp_angle_rot, tmp);
    temp_44 = tmp;
    
    MY_MUL(temp_37, tmp_angle, tmp);
    temp_37 = tmp;
    
    MY_MUL(temp_45, tmp_angle_rot, tmp);
    temp_45 = tmp;
    
    MY_MUL(temp_38, tmp_angle, tmp);
    temp_38 = tmp;
    
    MY_MUL(temp_46, tmp_angle_rot, tmp);
    temp_46 = tmp;
    
    MY_MUL(temp_39, tmp_angle, tmp);
    temp_39 = tmp;
    
    MY_MUL(temp_47, tmp_angle_rot, tmp);
    temp_47 = tmp;
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
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
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_52, tmp_angle, tmp);
    temp_52 = tmp;
    
    MY_MUL(temp_60, tmp_angle_rot, tmp);
    temp_60 = tmp;
    
    MY_MUL(temp_53, tmp_angle, tmp);
    temp_53 = tmp;
    
    MY_MUL(temp_61, tmp_angle_rot, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_54, tmp_angle, tmp);
    temp_54 = tmp;
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_55, tmp_angle, tmp);
    temp_55 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 8;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_36, temp_32);
    MY_SUB(tmp, temp_36, temp_36);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[36] = tmp_id + 8;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_20, temp_16);
    MY_SUB(tmp, temp_20, temp_20);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[20] = tmp_id + 8;
    
    tmp = temp_48;
    MY_ADD(tmp, temp_52, temp_48);
    MY_SUB(tmp, temp_52, temp_52);
    tmp_id = __id[48];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[48] = tmp_id;
    __id[52] = tmp_id + 8;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_12, temp_8);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[12] = tmp_id + 8;
    
    tmp = temp_40;
    MY_ADD(tmp, temp_44, temp_40);
    MY_SUB(tmp, temp_44, temp_44);
    tmp_id = __id[40];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[40] = tmp_id;
    __id[44] = tmp_id + 8;
    
    tmp = temp_24;
    MY_ADD(tmp, temp_28, temp_24);
    MY_SUB(tmp, temp_28, temp_28);
    tmp_id = __id[24];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[24] = tmp_id;
    __id[28] = tmp_id + 8;
    
    tmp = temp_56;
    MY_ADD(tmp, temp_60, temp_56);
    MY_SUB(tmp, temp_60, temp_60);
    tmp_id = __id[56];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[56] = tmp_id;
    __id[60] = tmp_id + 8;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 8;
    
    tmp = temp_33;
    MY_ADD(tmp, temp_37, temp_33);
    MY_SUB(tmp, temp_37, temp_37);
    tmp_id = __id[33];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[33] = tmp_id;
    __id[37] = tmp_id + 8;
    
    tmp = temp_17;
    MY_ADD(tmp, temp_21, temp_17);
    MY_SUB(tmp, temp_21, temp_21);
    tmp_id = __id[17];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[17] = tmp_id;
    __id[21] = tmp_id + 8;
    
    tmp = temp_49;
    MY_ADD(tmp, temp_53, temp_49);
    MY_SUB(tmp, temp_53, temp_53);
    tmp_id = __id[49];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[49] = tmp_id;
    __id[53] = tmp_id + 8;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_13, temp_9);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[13] = tmp_id + 8;
    
    tmp = temp_41;
    MY_ADD(tmp, temp_45, temp_41);
    MY_SUB(tmp, temp_45, temp_45);
    tmp_id = __id[41];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[41] = tmp_id;
    __id[45] = tmp_id + 8;
    
    tmp = temp_25;
    MY_ADD(tmp, temp_29, temp_25);
    MY_SUB(tmp, temp_29, temp_29);
    tmp_id = __id[25];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[25] = tmp_id;
    __id[29] = tmp_id + 8;
    
    tmp = temp_57;
    MY_ADD(tmp, temp_61, temp_57);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[57];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[57] = tmp_id;
    __id[61] = tmp_id + 8;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 8;
    
    tmp = temp_34;
    MY_ADD(tmp, temp_38, temp_34);
    MY_SUB(tmp, temp_38, temp_38);
    tmp_id = __id[34];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[34] = tmp_id;
    __id[38] = tmp_id + 8;
    
    tmp = temp_18;
    MY_ADD(tmp, temp_22, temp_18);
    MY_SUB(tmp, temp_22, temp_22);
    tmp_id = __id[18];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[18] = tmp_id;
    __id[22] = tmp_id + 8;
    
    tmp = temp_50;
    MY_ADD(tmp, temp_54, temp_50);
    MY_SUB(tmp, temp_54, temp_54);
    tmp_id = __id[50];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[50] = tmp_id;
    __id[54] = tmp_id + 8;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_14, temp_10);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[14] = tmp_id + 8;
    
    tmp = temp_42;
    MY_ADD(tmp, temp_46, temp_42);
    MY_SUB(tmp, temp_46, temp_46);
    tmp_id = __id[42];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[42] = tmp_id;
    __id[46] = tmp_id + 8;
    
    tmp = temp_26;
    MY_ADD(tmp, temp_30, temp_26);
    MY_SUB(tmp, temp_30, temp_30);
    tmp_id = __id[26];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[26] = tmp_id;
    __id[30] = tmp_id + 8;
    
    tmp = temp_58;
    MY_ADD(tmp, temp_62, temp_58);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[58];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[58] = tmp_id;
    __id[62] = tmp_id + 8;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 8;
    
    tmp = temp_35;
    MY_ADD(tmp, temp_39, temp_35);
    MY_SUB(tmp, temp_39, temp_39);
    tmp_id = __id[35];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[35] = tmp_id;
    __id[39] = tmp_id + 8;
    
    tmp = temp_19;
    MY_ADD(tmp, temp_23, temp_19);
    MY_SUB(tmp, temp_23, temp_23);
    tmp_id = __id[19];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[19] = tmp_id;
    __id[23] = tmp_id + 8;
    
    tmp = temp_51;
    MY_ADD(tmp, temp_55, temp_51);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[51];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[51] = tmp_id;
    __id[55] = tmp_id + 8;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_15, temp_11);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[15] = tmp_id + 8;
    
    tmp = temp_43;
    MY_ADD(tmp, temp_47, temp_43);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[43];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[43] = tmp_id;
    __id[47] = tmp_id + 8;
    
    tmp = temp_27;
    MY_ADD(tmp, temp_31, temp_27);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[27];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[27] = tmp_id;
    __id[31] = tmp_id + 8;
    
    tmp = temp_59;
    MY_ADD(tmp, temp_63, temp_59);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[59];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[59] = tmp_id;
    __id[63] = tmp_id + 8;
    
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
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_34, tmp_angle, tmp);
    temp_34 = tmp;
    
    MY_MUL(temp_38, tmp_angle_rot, tmp);
    temp_38 = tmp;
    
    MY_MUL(temp_35, tmp_angle, tmp);
    temp_35 = tmp;
    
    MY_MUL(temp_39, tmp_angle_rot, tmp);
    temp_39 = tmp;
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
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
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_50, tmp_angle, tmp);
    temp_50 = tmp;
    
    MY_MUL(temp_54, tmp_angle_rot, tmp);
    temp_54 = tmp;
    
    MY_MUL(temp_51, tmp_angle, tmp);
    temp_51 = tmp;
    
    MY_MUL(temp_55, tmp_angle_rot, tmp);
    temp_55 = tmp;
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
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
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_42, tmp_angle, tmp);
    temp_42 = tmp;
    
    MY_MUL(temp_46, tmp_angle_rot, tmp);
    temp_46 = tmp;
    
    MY_MUL(temp_43, tmp_angle, tmp);
    temp_43 = tmp;
    
    MY_MUL(temp_47, tmp_angle_rot, tmp);
    temp_47 = tmp;
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
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
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_58, tmp_angle, tmp);
    temp_58 = tmp;
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_59, tmp_angle, tmp);
    temp_59 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 16;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_34, temp_32);
    MY_SUB(tmp, temp_34, temp_34);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[34] = tmp_id + 16;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_18, temp_16);
    MY_SUB(tmp, temp_18, temp_18);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[18] = tmp_id + 16;
    
    tmp = temp_48;
    MY_ADD(tmp, temp_50, temp_48);
    MY_SUB(tmp, temp_50, temp_50);
    tmp_id = __id[48];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[48] = tmp_id;
    __id[50] = tmp_id + 16;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_10, temp_8);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[10] = tmp_id + 16;
    
    tmp = temp_40;
    MY_ADD(tmp, temp_42, temp_40);
    MY_SUB(tmp, temp_42, temp_42);
    tmp_id = __id[40];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[40] = tmp_id;
    __id[42] = tmp_id + 16;
    
    tmp = temp_24;
    MY_ADD(tmp, temp_26, temp_24);
    MY_SUB(tmp, temp_26, temp_26);
    tmp_id = __id[24];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[24] = tmp_id;
    __id[26] = tmp_id + 16;
    
    tmp = temp_56;
    MY_ADD(tmp, temp_58, temp_56);
    MY_SUB(tmp, temp_58, temp_58);
    tmp_id = __id[56];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[56] = tmp_id;
    __id[58] = tmp_id + 16;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 16;
    
    tmp = temp_36;
    MY_ADD(tmp, temp_38, temp_36);
    MY_SUB(tmp, temp_38, temp_38);
    tmp_id = __id[36];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[36] = tmp_id;
    __id[38] = tmp_id + 16;
    
    tmp = temp_20;
    MY_ADD(tmp, temp_22, temp_20);
    MY_SUB(tmp, temp_22, temp_22);
    tmp_id = __id[20];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[20] = tmp_id;
    __id[22] = tmp_id + 16;
    
    tmp = temp_52;
    MY_ADD(tmp, temp_54, temp_52);
    MY_SUB(tmp, temp_54, temp_54);
    tmp_id = __id[52];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[52] = tmp_id;
    __id[54] = tmp_id + 16;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_14, temp_12);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[14] = tmp_id + 16;
    
    tmp = temp_44;
    MY_ADD(tmp, temp_46, temp_44);
    MY_SUB(tmp, temp_46, temp_46);
    tmp_id = __id[44];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[44] = tmp_id;
    __id[46] = tmp_id + 16;
    
    tmp = temp_28;
    MY_ADD(tmp, temp_30, temp_28);
    MY_SUB(tmp, temp_30, temp_30);
    tmp_id = __id[28];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[28] = tmp_id;
    __id[30] = tmp_id + 16;
    
    tmp = temp_60;
    MY_ADD(tmp, temp_62, temp_60);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[60];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[60] = tmp_id;
    __id[62] = tmp_id + 16;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 16;
    
    tmp = temp_33;
    MY_ADD(tmp, temp_35, temp_33);
    MY_SUB(tmp, temp_35, temp_35);
    tmp_id = __id[33];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[33] = tmp_id;
    __id[35] = tmp_id + 16;
    
    tmp = temp_17;
    MY_ADD(tmp, temp_19, temp_17);
    MY_SUB(tmp, temp_19, temp_19);
    tmp_id = __id[17];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[17] = tmp_id;
    __id[19] = tmp_id + 16;
    
    tmp = temp_49;
    MY_ADD(tmp, temp_51, temp_49);
    MY_SUB(tmp, temp_51, temp_51);
    tmp_id = __id[49];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[49] = tmp_id;
    __id[51] = tmp_id + 16;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_11, temp_9);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[11] = tmp_id + 16;
    
    tmp = temp_41;
    MY_ADD(tmp, temp_43, temp_41);
    MY_SUB(tmp, temp_43, temp_43);
    tmp_id = __id[41];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[41] = tmp_id;
    __id[43] = tmp_id + 16;
    
    tmp = temp_25;
    MY_ADD(tmp, temp_27, temp_25);
    MY_SUB(tmp, temp_27, temp_27);
    tmp_id = __id[25];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[25] = tmp_id;
    __id[27] = tmp_id + 16;
    
    tmp = temp_57;
    MY_ADD(tmp, temp_59, temp_57);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[57];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[57] = tmp_id;
    __id[59] = tmp_id + 16;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 16;
    
    tmp = temp_37;
    MY_ADD(tmp, temp_39, temp_37);
    MY_SUB(tmp, temp_39, temp_39);
    tmp_id = __id[37];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[37] = tmp_id;
    __id[39] = tmp_id + 16;
    
    tmp = temp_21;
    MY_ADD(tmp, temp_23, temp_21);
    MY_SUB(tmp, temp_23, temp_23);
    tmp_id = __id[21];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[21] = tmp_id;
    __id[23] = tmp_id + 16;
    
    tmp = temp_53;
    MY_ADD(tmp, temp_55, temp_53);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[53];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[53] = tmp_id;
    __id[55] = tmp_id + 16;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_15, temp_13);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[15] = tmp_id + 16;
    
    tmp = temp_45;
    MY_ADD(tmp, temp_47, temp_45);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[45];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[45] = tmp_id;
    __id[47] = tmp_id + 16;
    
    tmp = temp_29;
    MY_ADD(tmp, temp_31, temp_29);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[29];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[29] = tmp_id;
    __id[31] = tmp_id + 16;
    
    tmp = temp_61;
    MY_ADD(tmp, temp_63, temp_61);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[61];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[61] = tmp_id;
    __id[63] = tmp_id + 16;
    
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
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_33, tmp_angle, tmp);
    temp_33 = tmp;
    
    MY_MUL(temp_35, tmp_angle_rot, tmp);
    temp_35 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    
    MY_MUL(temp_19, tmp_angle_rot, tmp);
    temp_19 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_49, tmp_angle, tmp);
    temp_49 = tmp;
    
    MY_MUL(temp_51, tmp_angle_rot, tmp);
    temp_51 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_41, tmp_angle, tmp);
    temp_41 = tmp;
    
    MY_MUL(temp_43, tmp_angle_rot, tmp);
    temp_43 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_57, tmp_angle, tmp);
    temp_57 = tmp;
    
    MY_MUL(temp_59, tmp_angle_rot, tmp);
    temp_59 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_37, tmp_angle, tmp);
    temp_37 = tmp;
    
    MY_MUL(temp_39, tmp_angle_rot, tmp);
    temp_39 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_53, tmp_angle, tmp);
    temp_53 = tmp;
    
    MY_MUL(temp_55, tmp_angle_rot, tmp);
    temp_55 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_45, tmp_angle, tmp);
    temp_45 = tmp;
    
    MY_MUL(temp_47, tmp_angle_rot, tmp);
    temp_47 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_61, tmp_angle, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[1] = tmp_id + 32;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_33, temp_32);
    MY_SUB(tmp, temp_33, temp_33);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[33] = tmp_id + 32;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_17, temp_16);
    MY_SUB(tmp, temp_17, temp_17);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[17] = tmp_id + 32;
    
    tmp = temp_48;
    MY_ADD(tmp, temp_49, temp_48);
    MY_SUB(tmp, temp_49, temp_49);
    tmp_id = __id[48];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[48] = tmp_id;
    __id[49] = tmp_id + 32;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[9] = tmp_id + 32;
    
    tmp = temp_40;
    MY_ADD(tmp, temp_41, temp_40);
    MY_SUB(tmp, temp_41, temp_41);
    tmp_id = __id[40];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[40] = tmp_id;
    __id[41] = tmp_id + 32;
    
    tmp = temp_24;
    MY_ADD(tmp, temp_25, temp_24);
    MY_SUB(tmp, temp_25, temp_25);
    tmp_id = __id[24];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[24] = tmp_id;
    __id[25] = tmp_id + 32;
    
    tmp = temp_56;
    MY_ADD(tmp, temp_57, temp_56);
    MY_SUB(tmp, temp_57, temp_57);
    tmp_id = __id[56];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[56] = tmp_id;
    __id[57] = tmp_id + 32;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 32;
    
    tmp = temp_36;
    MY_ADD(tmp, temp_37, temp_36);
    MY_SUB(tmp, temp_37, temp_37);
    tmp_id = __id[36];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[36] = tmp_id;
    __id[37] = tmp_id + 32;
    
    tmp = temp_20;
    MY_ADD(tmp, temp_21, temp_20);
    MY_SUB(tmp, temp_21, temp_21);
    tmp_id = __id[20];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[20] = tmp_id;
    __id[21] = tmp_id + 32;
    
    tmp = temp_52;
    MY_ADD(tmp, temp_53, temp_52);
    MY_SUB(tmp, temp_53, temp_53);
    tmp_id = __id[52];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[52] = tmp_id;
    __id[53] = tmp_id + 32;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[13] = tmp_id + 32;
    
    tmp = temp_44;
    MY_ADD(tmp, temp_45, temp_44);
    MY_SUB(tmp, temp_45, temp_45);
    tmp_id = __id[44];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[44] = tmp_id;
    __id[45] = tmp_id + 32;
    
    tmp = temp_28;
    MY_ADD(tmp, temp_29, temp_28);
    MY_SUB(tmp, temp_29, temp_29);
    tmp_id = __id[28];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[28] = tmp_id;
    __id[29] = tmp_id + 32;
    
    tmp = temp_60;
    MY_ADD(tmp, temp_61, temp_60);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[60];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[60] = tmp_id;
    __id[61] = tmp_id + 32;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 32;
    
    tmp = temp_34;
    MY_ADD(tmp, temp_35, temp_34);
    MY_SUB(tmp, temp_35, temp_35);
    tmp_id = __id[34];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[34] = tmp_id;
    __id[35] = tmp_id + 32;
    
    tmp = temp_18;
    MY_ADD(tmp, temp_19, temp_18);
    MY_SUB(tmp, temp_19, temp_19);
    tmp_id = __id[18];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[18] = tmp_id;
    __id[19] = tmp_id + 32;
    
    tmp = temp_50;
    MY_ADD(tmp, temp_51, temp_50);
    MY_SUB(tmp, temp_51, temp_51);
    tmp_id = __id[50];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[50] = tmp_id;
    __id[51] = tmp_id + 32;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[11] = tmp_id + 32;
    
    tmp = temp_42;
    MY_ADD(tmp, temp_43, temp_42);
    MY_SUB(tmp, temp_43, temp_43);
    tmp_id = __id[42];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[42] = tmp_id;
    __id[43] = tmp_id + 32;
    
    tmp = temp_26;
    MY_ADD(tmp, temp_27, temp_26);
    MY_SUB(tmp, temp_27, temp_27);
    tmp_id = __id[26];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[26] = tmp_id;
    __id[27] = tmp_id + 32;
    
    tmp = temp_58;
    MY_ADD(tmp, temp_59, temp_58);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[58];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[58] = tmp_id;
    __id[59] = tmp_id + 32;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 32;
    
    tmp = temp_38;
    MY_ADD(tmp, temp_39, temp_38);
    MY_SUB(tmp, temp_39, temp_39);
    tmp_id = __id[38];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[38] = tmp_id;
    __id[39] = tmp_id + 32;
    
    tmp = temp_22;
    MY_ADD(tmp, temp_23, temp_22);
    MY_SUB(tmp, temp_23, temp_23);
    tmp_id = __id[22];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[22] = tmp_id;
    __id[23] = tmp_id + 32;
    
    tmp = temp_54;
    MY_ADD(tmp, temp_55, temp_54);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[54];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[54] = tmp_id;
    __id[55] = tmp_id + 32;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[15] = tmp_id + 32;
    
    tmp = temp_46;
    MY_ADD(tmp, temp_47, temp_46);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[46];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[46] = tmp_id;
    __id[47] = tmp_id + 32;
    
    tmp = temp_30;
    MY_ADD(tmp, temp_31, temp_30);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[30];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[30] = tmp_id;
    __id[31] = tmp_id + 32;
    
    tmp = temp_62;
    MY_ADD(tmp, temp_63, temp_62);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[62];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[62] = tmp_id;
    __id[63] = tmp_id + 32;
    
    n_global *= 2;
    
    
    sdata[__id[0]] = temp_0;
    
    sdata[__id[32]] = temp_32;
    
    sdata[__id[16]] = temp_16;
    
    sdata[__id[48]] = temp_48;
    
    sdata[__id[8]] = temp_8;
    
    sdata[__id[40]] = temp_40;
    
    sdata[__id[24]] = temp_24;
    
    sdata[__id[56]] = temp_56;
    
    sdata[__id[4]] = temp_4;
    
    sdata[__id[36]] = temp_36;
    
    sdata[__id[20]] = temp_20;
    
    sdata[__id[52]] = temp_52;
    
    sdata[__id[12]] = temp_12;
    
    sdata[__id[44]] = temp_44;
    
    sdata[__id[28]] = temp_28;
    
    sdata[__id[60]] = temp_60;
    
    sdata[__id[2]] = temp_2;
    
    sdata[__id[34]] = temp_34;
    
    sdata[__id[18]] = temp_18;
    
    sdata[__id[50]] = temp_50;
    
    sdata[__id[10]] = temp_10;
    
    sdata[__id[42]] = temp_42;
    
    sdata[__id[26]] = temp_26;
    
    sdata[__id[58]] = temp_58;
    
    sdata[__id[6]] = temp_6;
    
    sdata[__id[38]] = temp_38;
    
    sdata[__id[22]] = temp_22;
    
    sdata[__id[54]] = temp_54;
    
    sdata[__id[14]] = temp_14;
    
    sdata[__id[46]] = temp_46;
    
    sdata[__id[30]] = temp_30;
    
    sdata[__id[62]] = temp_62;
    
    sdata[__id[1]] = temp_1;
    
    sdata[__id[33]] = temp_33;
    
    sdata[__id[17]] = temp_17;
    
    sdata[__id[49]] = temp_49;
    
    sdata[__id[9]] = temp_9;
    
    sdata[__id[41]] = temp_41;
    
    sdata[__id[25]] = temp_25;
    
    sdata[__id[57]] = temp_57;
    
    sdata[__id[5]] = temp_5;
    
    sdata[__id[37]] = temp_37;
    
    sdata[__id[21]] = temp_21;
    
    sdata[__id[53]] = temp_53;
    
    sdata[__id[13]] = temp_13;
    
    sdata[__id[45]] = temp_45;
    
    sdata[__id[29]] = temp_29;
    
    sdata[__id[61]] = temp_61;
    
    sdata[__id[3]] = temp_3;
    
    sdata[__id[35]] = temp_35;
    
    sdata[__id[19]] = temp_19;
    
    sdata[__id[51]] = temp_51;
    
    sdata[__id[11]] = temp_11;
    
    sdata[__id[43]] = temp_43;
    
    sdata[__id[27]] = temp_27;
    
    sdata[__id[59]] = temp_59;
    
    sdata[__id[7]] = temp_7;
    
    sdata[__id[39]] = temp_39;
    
    sdata[__id[23]] = temp_23;
    
    sdata[__id[55]] = temp_55;
    
    sdata[__id[15]] = temp_15;
    
    sdata[__id[47]] = temp_47;
    
    sdata[__id[31]] = temp_31;
    
    sdata[__id[63]] = temp_63;
    
    __syncthreads();
    #if defined(LOG_ON)
    if(tx==0)printf("################### syncthreads ####################\n");
    #endif			
        
    temp_0 = sdata[0 * blockDim.x + tx];
    __id[0] = tx + 0 * 128;
    
    temp_1 = sdata[1 * blockDim.x + tx];
    __id[1] = tx + 1 * 128;
    
    temp_2 = sdata[2 * blockDim.x + tx];
    __id[2] = tx + 2 * 128;
    
    temp_3 = sdata[3 * blockDim.x + tx];
    __id[3] = tx + 3 * 128;
    
    temp_4 = sdata[4 * blockDim.x + tx];
    __id[4] = tx + 4 * 128;
    
    temp_5 = sdata[5 * blockDim.x + tx];
    __id[5] = tx + 5 * 128;
    
    temp_6 = sdata[6 * blockDim.x + tx];
    __id[6] = tx + 6 * 128;
    
    temp_7 = sdata[7 * blockDim.x + tx];
    __id[7] = tx + 7 * 128;
    
    temp_8 = sdata[8 * blockDim.x + tx];
    __id[8] = tx + 8 * 128;
    
    temp_9 = sdata[9 * blockDim.x + tx];
    __id[9] = tx + 9 * 128;
    
    temp_10 = sdata[10 * blockDim.x + tx];
    __id[10] = tx + 10 * 128;
    
    temp_11 = sdata[11 * blockDim.x + tx];
    __id[11] = tx + 11 * 128;
    
    temp_12 = sdata[12 * blockDim.x + tx];
    __id[12] = tx + 12 * 128;
    
    temp_13 = sdata[13 * blockDim.x + tx];
    __id[13] = tx + 13 * 128;
    
    temp_14 = sdata[14 * blockDim.x + tx];
    __id[14] = tx + 14 * 128;
    
    temp_15 = sdata[15 * blockDim.x + tx];
    __id[15] = tx + 15 * 128;
    
    temp_16 = sdata[16 * blockDim.x + tx];
    __id[16] = tx + 16 * 128;
    
    temp_17 = sdata[17 * blockDim.x + tx];
    __id[17] = tx + 17 * 128;
    
    temp_18 = sdata[18 * blockDim.x + tx];
    __id[18] = tx + 18 * 128;
    
    temp_19 = sdata[19 * blockDim.x + tx];
    __id[19] = tx + 19 * 128;
    
    temp_20 = sdata[20 * blockDim.x + tx];
    __id[20] = tx + 20 * 128;
    
    temp_21 = sdata[21 * blockDim.x + tx];
    __id[21] = tx + 21 * 128;
    
    temp_22 = sdata[22 * blockDim.x + tx];
    __id[22] = tx + 22 * 128;
    
    temp_23 = sdata[23 * blockDim.x + tx];
    __id[23] = tx + 23 * 128;
    
    temp_24 = sdata[24 * blockDim.x + tx];
    __id[24] = tx + 24 * 128;
    
    temp_25 = sdata[25 * blockDim.x + tx];
    __id[25] = tx + 25 * 128;
    
    temp_26 = sdata[26 * blockDim.x + tx];
    __id[26] = tx + 26 * 128;
    
    temp_27 = sdata[27 * blockDim.x + tx];
    __id[27] = tx + 27 * 128;
    
    temp_28 = sdata[28 * blockDim.x + tx];
    __id[28] = tx + 28 * 128;
    
    temp_29 = sdata[29 * blockDim.x + tx];
    __id[29] = tx + 29 * 128;
    
    temp_30 = sdata[30 * blockDim.x + tx];
    __id[30] = tx + 30 * 128;
    
    temp_31 = sdata[31 * blockDim.x + tx];
    __id[31] = tx + 31 * 128;
    
    temp_32 = sdata[32 * blockDim.x + tx];
    __id[32] = tx + 32 * 128;
    
    temp_33 = sdata[33 * blockDim.x + tx];
    __id[33] = tx + 33 * 128;
    
    temp_34 = sdata[34 * blockDim.x + tx];
    __id[34] = tx + 34 * 128;
    
    temp_35 = sdata[35 * blockDim.x + tx];
    __id[35] = tx + 35 * 128;
    
    temp_36 = sdata[36 * blockDim.x + tx];
    __id[36] = tx + 36 * 128;
    
    temp_37 = sdata[37 * blockDim.x + tx];
    __id[37] = tx + 37 * 128;
    
    temp_38 = sdata[38 * blockDim.x + tx];
    __id[38] = tx + 38 * 128;
    
    temp_39 = sdata[39 * blockDim.x + tx];
    __id[39] = tx + 39 * 128;
    
    temp_40 = sdata[40 * blockDim.x + tx];
    __id[40] = tx + 40 * 128;
    
    temp_41 = sdata[41 * blockDim.x + tx];
    __id[41] = tx + 41 * 128;
    
    temp_42 = sdata[42 * blockDim.x + tx];
    __id[42] = tx + 42 * 128;
    
    temp_43 = sdata[43 * blockDim.x + tx];
    __id[43] = tx + 43 * 128;
    
    temp_44 = sdata[44 * blockDim.x + tx];
    __id[44] = tx + 44 * 128;
    
    temp_45 = sdata[45 * blockDim.x + tx];
    __id[45] = tx + 45 * 128;
    
    temp_46 = sdata[46 * blockDim.x + tx];
    __id[46] = tx + 46 * 128;
    
    temp_47 = sdata[47 * blockDim.x + tx];
    __id[47] = tx + 47 * 128;
    
    temp_48 = sdata[48 * blockDim.x + tx];
    __id[48] = tx + 48 * 128;
    
    temp_49 = sdata[49 * blockDim.x + tx];
    __id[49] = tx + 49 * 128;
    
    temp_50 = sdata[50 * blockDim.x + tx];
    __id[50] = tx + 50 * 128;
    
    temp_51 = sdata[51 * blockDim.x + tx];
    __id[51] = tx + 51 * 128;
    
    temp_52 = sdata[52 * blockDim.x + tx];
    __id[52] = tx + 52 * 128;
    
    temp_53 = sdata[53 * blockDim.x + tx];
    __id[53] = tx + 53 * 128;
    
    temp_54 = sdata[54 * blockDim.x + tx];
    __id[54] = tx + 54 * 128;
    
    temp_55 = sdata[55 * blockDim.x + tx];
    __id[55] = tx + 55 * 128;
    
    temp_56 = sdata[56 * blockDim.x + tx];
    __id[56] = tx + 56 * 128;
    
    temp_57 = sdata[57 * blockDim.x + tx];
    __id[57] = tx + 57 * 128;
    
    temp_58 = sdata[58 * blockDim.x + tx];
    __id[58] = tx + 58 * 128;
    
    temp_59 = sdata[59 * blockDim.x + tx];
    __id[59] = tx + 59 * 128;
    
    temp_60 = sdata[60 * blockDim.x + tx];
    __id[60] = tx + 60 * 128;
    
    temp_61 = sdata[61 * blockDim.x + tx];
    __id[61] = tx + 61 * 128;
    
    temp_62 = sdata[62 * blockDim.x + tx];
    __id[62] = tx + 62 * 128;
    
    temp_63 = sdata[63 * blockDim.x + tx];
    __id[63] = tx + 63 * 128;
    
    j = 1;
    k = __id[32] % 64;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_32, tmp_angle, tmp);
    temp_32 = tmp;
    
    MY_MUL(temp_33, tmp_angle, tmp);
    temp_33 = tmp;
    
    MY_MUL(temp_34, tmp_angle, tmp);
    temp_34 = tmp;
    
    MY_MUL(temp_35, tmp_angle, tmp);
    temp_35 = tmp;
    
    MY_MUL(temp_36, tmp_angle, tmp);
    temp_36 = tmp;
    
    MY_MUL(temp_37, tmp_angle, tmp);
    temp_37 = tmp;
    
    MY_MUL(temp_38, tmp_angle, tmp);
    temp_38 = tmp;
    
    MY_MUL(temp_39, tmp_angle, tmp);
    temp_39 = tmp;
    
    MY_MUL(temp_40, tmp_angle, tmp);
    temp_40 = tmp;
    
    MY_MUL(temp_41, tmp_angle, tmp);
    temp_41 = tmp;
    
    MY_MUL(temp_42, tmp_angle, tmp);
    temp_42 = tmp;
    
    MY_MUL(temp_43, tmp_angle, tmp);
    temp_43 = tmp;
    
    MY_MUL(temp_44, tmp_angle, tmp);
    temp_44 = tmp;
    
    MY_MUL(temp_45, tmp_angle, tmp);
    temp_45 = tmp;
    
    MY_MUL(temp_46, tmp_angle, tmp);
    temp_46 = tmp;
    
    MY_MUL(temp_47, tmp_angle, tmp);
    temp_47 = tmp;
    
    MY_MUL(temp_48, tmp_angle, tmp);
    temp_48 = tmp;
    
    MY_MUL(temp_49, tmp_angle, tmp);
    temp_49 = tmp;
    
    MY_MUL(temp_50, tmp_angle, tmp);
    temp_50 = tmp;
    
    MY_MUL(temp_51, tmp_angle, tmp);
    temp_51 = tmp;
    
    MY_MUL(temp_52, tmp_angle, tmp);
    temp_52 = tmp;
    
    MY_MUL(temp_53, tmp_angle, tmp);
    temp_53 = tmp;
    
    MY_MUL(temp_54, tmp_angle, tmp);
    temp_54 = tmp;
    
    MY_MUL(temp_55, tmp_angle, tmp);
    temp_55 = tmp;
    
    MY_MUL(temp_56, tmp_angle, tmp);
    temp_56 = tmp;
    
    MY_MUL(temp_57, tmp_angle, tmp);
    temp_57 = tmp;
    
    MY_MUL(temp_58, tmp_angle, tmp);
    temp_58 = tmp;
    
    MY_MUL(temp_59, tmp_angle, tmp);
    temp_59 = tmp;
    
    MY_MUL(temp_60, tmp_angle, tmp);
    temp_60 = tmp;
    
    MY_MUL(temp_61, tmp_angle, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_62, tmp_angle, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_63, tmp_angle, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_32, temp_0);
    MY_SUB(tmp, temp_32, temp_32);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[32] = tmp_id + 64;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_33, temp_1);
    MY_SUB(tmp, temp_33, temp_33);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[33] = tmp_id + 64;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_34, temp_2);
    MY_SUB(tmp, temp_34, temp_34);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[34] = tmp_id + 64;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_35, temp_3);
    MY_SUB(tmp, temp_35, temp_35);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[35] = tmp_id + 64;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_36, temp_4);
    MY_SUB(tmp, temp_36, temp_36);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[36] = tmp_id + 64;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_37, temp_5);
    MY_SUB(tmp, temp_37, temp_37);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[37] = tmp_id + 64;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_38, temp_6);
    MY_SUB(tmp, temp_38, temp_38);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[38] = tmp_id + 64;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_39, temp_7);
    MY_SUB(tmp, temp_39, temp_39);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[39] = tmp_id + 64;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_40, temp_8);
    MY_SUB(tmp, temp_40, temp_40);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[40] = tmp_id + 64;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_41, temp_9);
    MY_SUB(tmp, temp_41, temp_41);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[41] = tmp_id + 64;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_42, temp_10);
    MY_SUB(tmp, temp_42, temp_42);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[42] = tmp_id + 64;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_43, temp_11);
    MY_SUB(tmp, temp_43, temp_43);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[43] = tmp_id + 64;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_44, temp_12);
    MY_SUB(tmp, temp_44, temp_44);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[44] = tmp_id + 64;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_45, temp_13);
    MY_SUB(tmp, temp_45, temp_45);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[45] = tmp_id + 64;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_46, temp_14);
    MY_SUB(tmp, temp_46, temp_46);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[46] = tmp_id + 64;
    
    tmp = temp_15;
    MY_ADD(tmp, temp_47, temp_15);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[15];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[15] = tmp_id;
    __id[47] = tmp_id + 64;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_48, temp_16);
    MY_SUB(tmp, temp_48, temp_48);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[48] = tmp_id + 64;
    
    tmp = temp_17;
    MY_ADD(tmp, temp_49, temp_17);
    MY_SUB(tmp, temp_49, temp_49);
    tmp_id = __id[17];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[17] = tmp_id;
    __id[49] = tmp_id + 64;
    
    tmp = temp_18;
    MY_ADD(tmp, temp_50, temp_18);
    MY_SUB(tmp, temp_50, temp_50);
    tmp_id = __id[18];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[18] = tmp_id;
    __id[50] = tmp_id + 64;
    
    tmp = temp_19;
    MY_ADD(tmp, temp_51, temp_19);
    MY_SUB(tmp, temp_51, temp_51);
    tmp_id = __id[19];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[19] = tmp_id;
    __id[51] = tmp_id + 64;
    
    tmp = temp_20;
    MY_ADD(tmp, temp_52, temp_20);
    MY_SUB(tmp, temp_52, temp_52);
    tmp_id = __id[20];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[20] = tmp_id;
    __id[52] = tmp_id + 64;
    
    tmp = temp_21;
    MY_ADD(tmp, temp_53, temp_21);
    MY_SUB(tmp, temp_53, temp_53);
    tmp_id = __id[21];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[21] = tmp_id;
    __id[53] = tmp_id + 64;
    
    tmp = temp_22;
    MY_ADD(tmp, temp_54, temp_22);
    MY_SUB(tmp, temp_54, temp_54);
    tmp_id = __id[22];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[22] = tmp_id;
    __id[54] = tmp_id + 64;
    
    tmp = temp_23;
    MY_ADD(tmp, temp_55, temp_23);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[23];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[23] = tmp_id;
    __id[55] = tmp_id + 64;
    
    tmp = temp_24;
    MY_ADD(tmp, temp_56, temp_24);
    MY_SUB(tmp, temp_56, temp_56);
    tmp_id = __id[24];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[24] = tmp_id;
    __id[56] = tmp_id + 64;
    
    tmp = temp_25;
    MY_ADD(tmp, temp_57, temp_25);
    MY_SUB(tmp, temp_57, temp_57);
    tmp_id = __id[25];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[25] = tmp_id;
    __id[57] = tmp_id + 64;
    
    tmp = temp_26;
    MY_ADD(tmp, temp_58, temp_26);
    MY_SUB(tmp, temp_58, temp_58);
    tmp_id = __id[26];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[26] = tmp_id;
    __id[58] = tmp_id + 64;
    
    tmp = temp_27;
    MY_ADD(tmp, temp_59, temp_27);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[27];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[27] = tmp_id;
    __id[59] = tmp_id + 64;
    
    tmp = temp_28;
    MY_ADD(tmp, temp_60, temp_28);
    MY_SUB(tmp, temp_60, temp_60);
    tmp_id = __id[28];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[28] = tmp_id;
    __id[60] = tmp_id + 64;
    
    tmp = temp_29;
    MY_ADD(tmp, temp_61, temp_29);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[29];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[29] = tmp_id;
    __id[61] = tmp_id + 64;
    
    tmp = temp_30;
    MY_ADD(tmp, temp_62, temp_30);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[30];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[30] = tmp_id;
    __id[62] = tmp_id + 64;
    
    tmp = temp_31;
    MY_ADD(tmp, temp_63, temp_31);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[31];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[31] = tmp_id;
    __id[63] = tmp_id + 64;
    
    n_global *= 2;
    
    j = 1;
    k = __id[16] % 128;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    
    MY_MUL(temp_48, tmp_angle_rot, tmp);
    temp_48 = tmp;
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    
    MY_MUL(temp_49, tmp_angle_rot, tmp);
    temp_49 = tmp;
    
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    
    MY_MUL(temp_50, tmp_angle_rot, tmp);
    temp_50 = tmp;
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    
    MY_MUL(temp_51, tmp_angle_rot, tmp);
    temp_51 = tmp;
    
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    
    MY_MUL(temp_52, tmp_angle_rot, tmp);
    temp_52 = tmp;
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    
    MY_MUL(temp_53, tmp_angle_rot, tmp);
    temp_53 = tmp;
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    
    MY_MUL(temp_54, tmp_angle_rot, tmp);
    temp_54 = tmp;
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    
    MY_MUL(temp_55, tmp_angle_rot, tmp);
    temp_55 = tmp;
    
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    
    MY_MUL(temp_56, tmp_angle_rot, tmp);
    temp_56 = tmp;
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    
    MY_MUL(temp_57, tmp_angle_rot, tmp);
    temp_57 = tmp;
    
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    
    MY_MUL(temp_58, tmp_angle_rot, tmp);
    temp_58 = tmp;
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    
    MY_MUL(temp_59, tmp_angle_rot, tmp);
    temp_59 = tmp;
    
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    
    MY_MUL(temp_60, tmp_angle_rot, tmp);
    temp_60 = tmp;
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    
    MY_MUL(temp_61, tmp_angle_rot, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_16, temp_0);
    MY_SUB(tmp, temp_16, temp_16);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[16] = tmp_id + 128;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_48, temp_32);
    MY_SUB(tmp, temp_48, temp_48);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[48] = tmp_id + 128;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_17, temp_1);
    MY_SUB(tmp, temp_17, temp_17);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[17] = tmp_id + 128;
    
    tmp = temp_33;
    MY_ADD(tmp, temp_49, temp_33);
    MY_SUB(tmp, temp_49, temp_49);
    tmp_id = __id[33];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[33] = tmp_id;
    __id[49] = tmp_id + 128;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_18, temp_2);
    MY_SUB(tmp, temp_18, temp_18);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[18] = tmp_id + 128;
    
    tmp = temp_34;
    MY_ADD(tmp, temp_50, temp_34);
    MY_SUB(tmp, temp_50, temp_50);
    tmp_id = __id[34];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[34] = tmp_id;
    __id[50] = tmp_id + 128;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_19, temp_3);
    MY_SUB(tmp, temp_19, temp_19);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[19] = tmp_id + 128;
    
    tmp = temp_35;
    MY_ADD(tmp, temp_51, temp_35);
    MY_SUB(tmp, temp_51, temp_51);
    tmp_id = __id[35];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[35] = tmp_id;
    __id[51] = tmp_id + 128;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_20, temp_4);
    MY_SUB(tmp, temp_20, temp_20);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[20] = tmp_id + 128;
    
    tmp = temp_36;
    MY_ADD(tmp, temp_52, temp_36);
    MY_SUB(tmp, temp_52, temp_52);
    tmp_id = __id[36];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[36] = tmp_id;
    __id[52] = tmp_id + 128;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_21, temp_5);
    MY_SUB(tmp, temp_21, temp_21);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[21] = tmp_id + 128;
    
    tmp = temp_37;
    MY_ADD(tmp, temp_53, temp_37);
    MY_SUB(tmp, temp_53, temp_53);
    tmp_id = __id[37];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[37] = tmp_id;
    __id[53] = tmp_id + 128;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_22, temp_6);
    MY_SUB(tmp, temp_22, temp_22);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[22] = tmp_id + 128;
    
    tmp = temp_38;
    MY_ADD(tmp, temp_54, temp_38);
    MY_SUB(tmp, temp_54, temp_54);
    tmp_id = __id[38];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[38] = tmp_id;
    __id[54] = tmp_id + 128;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_23, temp_7);
    MY_SUB(tmp, temp_23, temp_23);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[23] = tmp_id + 128;
    
    tmp = temp_39;
    MY_ADD(tmp, temp_55, temp_39);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[39];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[39] = tmp_id;
    __id[55] = tmp_id + 128;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_24, temp_8);
    MY_SUB(tmp, temp_24, temp_24);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[24] = tmp_id + 128;
    
    tmp = temp_40;
    MY_ADD(tmp, temp_56, temp_40);
    MY_SUB(tmp, temp_56, temp_56);
    tmp_id = __id[40];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[40] = tmp_id;
    __id[56] = tmp_id + 128;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_25, temp_9);
    MY_SUB(tmp, temp_25, temp_25);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[25] = tmp_id + 128;
    
    tmp = temp_41;
    MY_ADD(tmp, temp_57, temp_41);
    MY_SUB(tmp, temp_57, temp_57);
    tmp_id = __id[41];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[41] = tmp_id;
    __id[57] = tmp_id + 128;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_26, temp_10);
    MY_SUB(tmp, temp_26, temp_26);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[26] = tmp_id + 128;
    
    tmp = temp_42;
    MY_ADD(tmp, temp_58, temp_42);
    MY_SUB(tmp, temp_58, temp_58);
    tmp_id = __id[42];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[42] = tmp_id;
    __id[58] = tmp_id + 128;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_27, temp_11);
    MY_SUB(tmp, temp_27, temp_27);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[27] = tmp_id + 128;
    
    tmp = temp_43;
    MY_ADD(tmp, temp_59, temp_43);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[43];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[43] = tmp_id;
    __id[59] = tmp_id + 128;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_28, temp_12);
    MY_SUB(tmp, temp_28, temp_28);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[28] = tmp_id + 128;
    
    tmp = temp_44;
    MY_ADD(tmp, temp_60, temp_44);
    MY_SUB(tmp, temp_60, temp_60);
    tmp_id = __id[44];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[44] = tmp_id;
    __id[60] = tmp_id + 128;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_29, temp_13);
    MY_SUB(tmp, temp_29, temp_29);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[29] = tmp_id + 128;
    
    tmp = temp_45;
    MY_ADD(tmp, temp_61, temp_45);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[45];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[45] = tmp_id;
    __id[61] = tmp_id + 128;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_30, temp_14);
    MY_SUB(tmp, temp_30, temp_30);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[30] = tmp_id + 128;
    
    tmp = temp_46;
    MY_ADD(tmp, temp_62, temp_46);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[46];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[46] = tmp_id;
    __id[62] = tmp_id + 128;
    
    tmp = temp_15;
    MY_ADD(tmp, temp_31, temp_15);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[15];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[15] = tmp_id;
    __id[31] = tmp_id + 128;
    
    tmp = temp_47;
    MY_ADD(tmp, temp_63, temp_47);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[47];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[47] = tmp_id;
    __id[63] = tmp_id + 128;
    
    n_global *= 2;
    
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
    
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_40, tmp_angle, tmp);
    temp_40 = tmp;
    
    MY_MUL(temp_56, tmp_angle_rot, tmp);
    temp_56 = tmp;
    
    MY_MUL(temp_41, tmp_angle, tmp);
    temp_41 = tmp;
    
    MY_MUL(temp_57, tmp_angle_rot, tmp);
    temp_57 = tmp;
    
    MY_MUL(temp_42, tmp_angle, tmp);
    temp_42 = tmp;
    
    MY_MUL(temp_58, tmp_angle_rot, tmp);
    temp_58 = tmp;
    
    MY_MUL(temp_43, tmp_angle, tmp);
    temp_43 = tmp;
    
    MY_MUL(temp_59, tmp_angle_rot, tmp);
    temp_59 = tmp;
    
    MY_MUL(temp_44, tmp_angle, tmp);
    temp_44 = tmp;
    
    MY_MUL(temp_60, tmp_angle_rot, tmp);
    temp_60 = tmp;
    
    MY_MUL(temp_45, tmp_angle, tmp);
    temp_45 = tmp;
    
    MY_MUL(temp_61, tmp_angle_rot, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_46, tmp_angle, tmp);
    temp_46 = tmp;
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_47, tmp_angle, tmp);
    temp_47 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_8, temp_0);
    MY_SUB(tmp, temp_8, temp_8);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[8] = tmp_id + 256;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_40, temp_32);
    MY_SUB(tmp, temp_40, temp_40);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[40] = tmp_id + 256;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_24, temp_16);
    MY_SUB(tmp, temp_24, temp_24);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[24] = tmp_id + 256;
    
    tmp = temp_48;
    MY_ADD(tmp, temp_56, temp_48);
    MY_SUB(tmp, temp_56, temp_56);
    tmp_id = __id[48];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[48] = tmp_id;
    __id[56] = tmp_id + 256;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_9, temp_1);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[9] = tmp_id + 256;
    
    tmp = temp_33;
    MY_ADD(tmp, temp_41, temp_33);
    MY_SUB(tmp, temp_41, temp_41);
    tmp_id = __id[33];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[33] = tmp_id;
    __id[41] = tmp_id + 256;
    
    tmp = temp_17;
    MY_ADD(tmp, temp_25, temp_17);
    MY_SUB(tmp, temp_25, temp_25);
    tmp_id = __id[17];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[17] = tmp_id;
    __id[25] = tmp_id + 256;
    
    tmp = temp_49;
    MY_ADD(tmp, temp_57, temp_49);
    MY_SUB(tmp, temp_57, temp_57);
    tmp_id = __id[49];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[49] = tmp_id;
    __id[57] = tmp_id + 256;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_10, temp_2);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[10] = tmp_id + 256;
    
    tmp = temp_34;
    MY_ADD(tmp, temp_42, temp_34);
    MY_SUB(tmp, temp_42, temp_42);
    tmp_id = __id[34];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[34] = tmp_id;
    __id[42] = tmp_id + 256;
    
    tmp = temp_18;
    MY_ADD(tmp, temp_26, temp_18);
    MY_SUB(tmp, temp_26, temp_26);
    tmp_id = __id[18];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[18] = tmp_id;
    __id[26] = tmp_id + 256;
    
    tmp = temp_50;
    MY_ADD(tmp, temp_58, temp_50);
    MY_SUB(tmp, temp_58, temp_58);
    tmp_id = __id[50];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[50] = tmp_id;
    __id[58] = tmp_id + 256;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_11, temp_3);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[11] = tmp_id + 256;
    
    tmp = temp_35;
    MY_ADD(tmp, temp_43, temp_35);
    MY_SUB(tmp, temp_43, temp_43);
    tmp_id = __id[35];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[35] = tmp_id;
    __id[43] = tmp_id + 256;
    
    tmp = temp_19;
    MY_ADD(tmp, temp_27, temp_19);
    MY_SUB(tmp, temp_27, temp_27);
    tmp_id = __id[19];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[19] = tmp_id;
    __id[27] = tmp_id + 256;
    
    tmp = temp_51;
    MY_ADD(tmp, temp_59, temp_51);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[51];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[51] = tmp_id;
    __id[59] = tmp_id + 256;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_12, temp_4);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[12] = tmp_id + 256;
    
    tmp = temp_36;
    MY_ADD(tmp, temp_44, temp_36);
    MY_SUB(tmp, temp_44, temp_44);
    tmp_id = __id[36];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[36] = tmp_id;
    __id[44] = tmp_id + 256;
    
    tmp = temp_20;
    MY_ADD(tmp, temp_28, temp_20);
    MY_SUB(tmp, temp_28, temp_28);
    tmp_id = __id[20];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[20] = tmp_id;
    __id[28] = tmp_id + 256;
    
    tmp = temp_52;
    MY_ADD(tmp, temp_60, temp_52);
    MY_SUB(tmp, temp_60, temp_60);
    tmp_id = __id[52];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[52] = tmp_id;
    __id[60] = tmp_id + 256;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_13, temp_5);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[13] = tmp_id + 256;
    
    tmp = temp_37;
    MY_ADD(tmp, temp_45, temp_37);
    MY_SUB(tmp, temp_45, temp_45);
    tmp_id = __id[37];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[37] = tmp_id;
    __id[45] = tmp_id + 256;
    
    tmp = temp_21;
    MY_ADD(tmp, temp_29, temp_21);
    MY_SUB(tmp, temp_29, temp_29);
    tmp_id = __id[21];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[21] = tmp_id;
    __id[29] = tmp_id + 256;
    
    tmp = temp_53;
    MY_ADD(tmp, temp_61, temp_53);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[53];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[53] = tmp_id;
    __id[61] = tmp_id + 256;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_14, temp_6);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[14] = tmp_id + 256;
    
    tmp = temp_38;
    MY_ADD(tmp, temp_46, temp_38);
    MY_SUB(tmp, temp_46, temp_46);
    tmp_id = __id[38];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[38] = tmp_id;
    __id[46] = tmp_id + 256;
    
    tmp = temp_22;
    MY_ADD(tmp, temp_30, temp_22);
    MY_SUB(tmp, temp_30, temp_30);
    tmp_id = __id[22];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[22] = tmp_id;
    __id[30] = tmp_id + 256;
    
    tmp = temp_54;
    MY_ADD(tmp, temp_62, temp_54);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[54];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[54] = tmp_id;
    __id[62] = tmp_id + 256;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_15, temp_7);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[15] = tmp_id + 256;
    
    tmp = temp_39;
    MY_ADD(tmp, temp_47, temp_39);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[39];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[39] = tmp_id;
    __id[47] = tmp_id + 256;
    
    tmp = temp_23;
    MY_ADD(tmp, temp_31, temp_23);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[23];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[23] = tmp_id;
    __id[31] = tmp_id + 256;
    
    tmp = temp_55;
    MY_ADD(tmp, temp_63, temp_55);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[55];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[55] = tmp_id;
    __id[63] = tmp_id + 256;
    
    n_global *= 2;
    
    j = 1;
    k = __id[4] % 512;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    
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
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_36, tmp_angle, tmp);
    temp_36 = tmp;
    
    MY_MUL(temp_44, tmp_angle_rot, tmp);
    temp_44 = tmp;
    
    MY_MUL(temp_37, tmp_angle, tmp);
    temp_37 = tmp;
    
    MY_MUL(temp_45, tmp_angle_rot, tmp);
    temp_45 = tmp;
    
    MY_MUL(temp_38, tmp_angle, tmp);
    temp_38 = tmp;
    
    MY_MUL(temp_46, tmp_angle_rot, tmp);
    temp_46 = tmp;
    
    MY_MUL(temp_39, tmp_angle, tmp);
    temp_39 = tmp;
    
    MY_MUL(temp_47, tmp_angle_rot, tmp);
    temp_47 = tmp;
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
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
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_52, tmp_angle, tmp);
    temp_52 = tmp;
    
    MY_MUL(temp_60, tmp_angle_rot, tmp);
    temp_60 = tmp;
    
    MY_MUL(temp_53, tmp_angle, tmp);
    temp_53 = tmp;
    
    MY_MUL(temp_61, tmp_angle_rot, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_54, tmp_angle, tmp);
    temp_54 = tmp;
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_55, tmp_angle, tmp);
    temp_55 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 512;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_36, temp_32);
    MY_SUB(tmp, temp_36, temp_36);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[36] = tmp_id + 512;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_20, temp_16);
    MY_SUB(tmp, temp_20, temp_20);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[20] = tmp_id + 512;
    
    tmp = temp_48;
    MY_ADD(tmp, temp_52, temp_48);
    MY_SUB(tmp, temp_52, temp_52);
    tmp_id = __id[48];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[48] = tmp_id;
    __id[52] = tmp_id + 512;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_12, temp_8);
    MY_SUB(tmp, temp_12, temp_12);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[12] = tmp_id + 512;
    
    tmp = temp_40;
    MY_ADD(tmp, temp_44, temp_40);
    MY_SUB(tmp, temp_44, temp_44);
    tmp_id = __id[40];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[40] = tmp_id;
    __id[44] = tmp_id + 512;
    
    tmp = temp_24;
    MY_ADD(tmp, temp_28, temp_24);
    MY_SUB(tmp, temp_28, temp_28);
    tmp_id = __id[24];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[24] = tmp_id;
    __id[28] = tmp_id + 512;
    
    tmp = temp_56;
    MY_ADD(tmp, temp_60, temp_56);
    MY_SUB(tmp, temp_60, temp_60);
    tmp_id = __id[56];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[56] = tmp_id;
    __id[60] = tmp_id + 512;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 512;
    
    tmp = temp_33;
    MY_ADD(tmp, temp_37, temp_33);
    MY_SUB(tmp, temp_37, temp_37);
    tmp_id = __id[33];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[33] = tmp_id;
    __id[37] = tmp_id + 512;
    
    tmp = temp_17;
    MY_ADD(tmp, temp_21, temp_17);
    MY_SUB(tmp, temp_21, temp_21);
    tmp_id = __id[17];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[17] = tmp_id;
    __id[21] = tmp_id + 512;
    
    tmp = temp_49;
    MY_ADD(tmp, temp_53, temp_49);
    MY_SUB(tmp, temp_53, temp_53);
    tmp_id = __id[49];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[49] = tmp_id;
    __id[53] = tmp_id + 512;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_13, temp_9);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[13] = tmp_id + 512;
    
    tmp = temp_41;
    MY_ADD(tmp, temp_45, temp_41);
    MY_SUB(tmp, temp_45, temp_45);
    tmp_id = __id[41];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[41] = tmp_id;
    __id[45] = tmp_id + 512;
    
    tmp = temp_25;
    MY_ADD(tmp, temp_29, temp_25);
    MY_SUB(tmp, temp_29, temp_29);
    tmp_id = __id[25];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[25] = tmp_id;
    __id[29] = tmp_id + 512;
    
    tmp = temp_57;
    MY_ADD(tmp, temp_61, temp_57);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[57];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[57] = tmp_id;
    __id[61] = tmp_id + 512;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 512;
    
    tmp = temp_34;
    MY_ADD(tmp, temp_38, temp_34);
    MY_SUB(tmp, temp_38, temp_38);
    tmp_id = __id[34];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[34] = tmp_id;
    __id[38] = tmp_id + 512;
    
    tmp = temp_18;
    MY_ADD(tmp, temp_22, temp_18);
    MY_SUB(tmp, temp_22, temp_22);
    tmp_id = __id[18];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[18] = tmp_id;
    __id[22] = tmp_id + 512;
    
    tmp = temp_50;
    MY_ADD(tmp, temp_54, temp_50);
    MY_SUB(tmp, temp_54, temp_54);
    tmp_id = __id[50];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[50] = tmp_id;
    __id[54] = tmp_id + 512;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_14, temp_10);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[14] = tmp_id + 512;
    
    tmp = temp_42;
    MY_ADD(tmp, temp_46, temp_42);
    MY_SUB(tmp, temp_46, temp_46);
    tmp_id = __id[42];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[42] = tmp_id;
    __id[46] = tmp_id + 512;
    
    tmp = temp_26;
    MY_ADD(tmp, temp_30, temp_26);
    MY_SUB(tmp, temp_30, temp_30);
    tmp_id = __id[26];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[26] = tmp_id;
    __id[30] = tmp_id + 512;
    
    tmp = temp_58;
    MY_ADD(tmp, temp_62, temp_58);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[58];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[58] = tmp_id;
    __id[62] = tmp_id + 512;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 512;
    
    tmp = temp_35;
    MY_ADD(tmp, temp_39, temp_35);
    MY_SUB(tmp, temp_39, temp_39);
    tmp_id = __id[35];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[35] = tmp_id;
    __id[39] = tmp_id + 512;
    
    tmp = temp_19;
    MY_ADD(tmp, temp_23, temp_19);
    MY_SUB(tmp, temp_23, temp_23);
    tmp_id = __id[19];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[19] = tmp_id;
    __id[23] = tmp_id + 512;
    
    tmp = temp_51;
    MY_ADD(tmp, temp_55, temp_51);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[51];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[51] = tmp_id;
    __id[55] = tmp_id + 512;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_15, temp_11);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[15] = tmp_id + 512;
    
    tmp = temp_43;
    MY_ADD(tmp, temp_47, temp_43);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[43];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[43] = tmp_id;
    __id[47] = tmp_id + 512;
    
    tmp = temp_27;
    MY_ADD(tmp, temp_31, temp_27);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[27];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[27] = tmp_id;
    __id[31] = tmp_id + 512;
    
    tmp = temp_59;
    MY_ADD(tmp, temp_63, temp_59);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[59];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[59] = tmp_id;
    __id[63] = tmp_id + 512;
    
    n_global *= 2;
    
    j = 1;
    k = __id[2] % 1024;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0030679615757712823f, tmp_angle);
    
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
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_34, tmp_angle, tmp);
    temp_34 = tmp;
    
    MY_MUL(temp_38, tmp_angle_rot, tmp);
    temp_38 = tmp;
    
    MY_MUL(temp_35, tmp_angle, tmp);
    temp_35 = tmp;
    
    MY_MUL(temp_39, tmp_angle_rot, tmp);
    temp_39 = tmp;
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
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
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_50, tmp_angle, tmp);
    temp_50 = tmp;
    
    MY_MUL(temp_54, tmp_angle_rot, tmp);
    temp_54 = tmp;
    
    MY_MUL(temp_51, tmp_angle, tmp);
    temp_51 = tmp;
    
    MY_MUL(temp_55, tmp_angle_rot, tmp);
    temp_55 = tmp;
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
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
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_42, tmp_angle, tmp);
    temp_42 = tmp;
    
    MY_MUL(temp_46, tmp_angle_rot, tmp);
    temp_46 = tmp;
    
    MY_MUL(temp_43, tmp_angle, tmp);
    temp_43 = tmp;
    
    MY_MUL(temp_47, tmp_angle_rot, tmp);
    temp_47 = tmp;
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
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
    
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_58, tmp_angle, tmp);
    temp_58 = tmp;
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    
    MY_MUL(temp_59, tmp_angle, tmp);
    temp_59 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 1024;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_34, temp_32);
    MY_SUB(tmp, temp_34, temp_34);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[34] = tmp_id + 1024;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_18, temp_16);
    MY_SUB(tmp, temp_18, temp_18);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[18] = tmp_id + 1024;
    
    tmp = temp_48;
    MY_ADD(tmp, temp_50, temp_48);
    MY_SUB(tmp, temp_50, temp_50);
    tmp_id = __id[48];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[48] = tmp_id;
    __id[50] = tmp_id + 1024;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_10, temp_8);
    MY_SUB(tmp, temp_10, temp_10);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[10] = tmp_id + 1024;
    
    tmp = temp_40;
    MY_ADD(tmp, temp_42, temp_40);
    MY_SUB(tmp, temp_42, temp_42);
    tmp_id = __id[40];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[40] = tmp_id;
    __id[42] = tmp_id + 1024;
    
    tmp = temp_24;
    MY_ADD(tmp, temp_26, temp_24);
    MY_SUB(tmp, temp_26, temp_26);
    tmp_id = __id[24];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[24] = tmp_id;
    __id[26] = tmp_id + 1024;
    
    tmp = temp_56;
    MY_ADD(tmp, temp_58, temp_56);
    MY_SUB(tmp, temp_58, temp_58);
    tmp_id = __id[56];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[56] = tmp_id;
    __id[58] = tmp_id + 1024;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 1024;
    
    tmp = temp_36;
    MY_ADD(tmp, temp_38, temp_36);
    MY_SUB(tmp, temp_38, temp_38);
    tmp_id = __id[36];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[36] = tmp_id;
    __id[38] = tmp_id + 1024;
    
    tmp = temp_20;
    MY_ADD(tmp, temp_22, temp_20);
    MY_SUB(tmp, temp_22, temp_22);
    tmp_id = __id[20];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[20] = tmp_id;
    __id[22] = tmp_id + 1024;
    
    tmp = temp_52;
    MY_ADD(tmp, temp_54, temp_52);
    MY_SUB(tmp, temp_54, temp_54);
    tmp_id = __id[52];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[52] = tmp_id;
    __id[54] = tmp_id + 1024;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_14, temp_12);
    MY_SUB(tmp, temp_14, temp_14);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[14] = tmp_id + 1024;
    
    tmp = temp_44;
    MY_ADD(tmp, temp_46, temp_44);
    MY_SUB(tmp, temp_46, temp_46);
    tmp_id = __id[44];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[44] = tmp_id;
    __id[46] = tmp_id + 1024;
    
    tmp = temp_28;
    MY_ADD(tmp, temp_30, temp_28);
    MY_SUB(tmp, temp_30, temp_30);
    tmp_id = __id[28];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[28] = tmp_id;
    __id[30] = tmp_id + 1024;
    
    tmp = temp_60;
    MY_ADD(tmp, temp_62, temp_60);
    MY_SUB(tmp, temp_62, temp_62);
    tmp_id = __id[60];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[60] = tmp_id;
    __id[62] = tmp_id + 1024;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 1024;
    
    tmp = temp_33;
    MY_ADD(tmp, temp_35, temp_33);
    MY_SUB(tmp, temp_35, temp_35);
    tmp_id = __id[33];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[33] = tmp_id;
    __id[35] = tmp_id + 1024;
    
    tmp = temp_17;
    MY_ADD(tmp, temp_19, temp_17);
    MY_SUB(tmp, temp_19, temp_19);
    tmp_id = __id[17];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[17] = tmp_id;
    __id[19] = tmp_id + 1024;
    
    tmp = temp_49;
    MY_ADD(tmp, temp_51, temp_49);
    MY_SUB(tmp, temp_51, temp_51);
    tmp_id = __id[49];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[49] = tmp_id;
    __id[51] = tmp_id + 1024;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_11, temp_9);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[11] = tmp_id + 1024;
    
    tmp = temp_41;
    MY_ADD(tmp, temp_43, temp_41);
    MY_SUB(tmp, temp_43, temp_43);
    tmp_id = __id[41];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[41] = tmp_id;
    __id[43] = tmp_id + 1024;
    
    tmp = temp_25;
    MY_ADD(tmp, temp_27, temp_25);
    MY_SUB(tmp, temp_27, temp_27);
    tmp_id = __id[25];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[25] = tmp_id;
    __id[27] = tmp_id + 1024;
    
    tmp = temp_57;
    MY_ADD(tmp, temp_59, temp_57);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[57];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[57] = tmp_id;
    __id[59] = tmp_id + 1024;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 1024;
    
    tmp = temp_37;
    MY_ADD(tmp, temp_39, temp_37);
    MY_SUB(tmp, temp_39, temp_39);
    tmp_id = __id[37];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[37] = tmp_id;
    __id[39] = tmp_id + 1024;
    
    tmp = temp_21;
    MY_ADD(tmp, temp_23, temp_21);
    MY_SUB(tmp, temp_23, temp_23);
    tmp_id = __id[21];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[21] = tmp_id;
    __id[23] = tmp_id + 1024;
    
    tmp = temp_53;
    MY_ADD(tmp, temp_55, temp_53);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[53];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[53] = tmp_id;
    __id[55] = tmp_id + 1024;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_15, temp_13);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[15] = tmp_id + 1024;
    
    tmp = temp_45;
    MY_ADD(tmp, temp_47, temp_45);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[45];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[45] = tmp_id;
    __id[47] = tmp_id + 1024;
    
    tmp = temp_29;
    MY_ADD(tmp, temp_31, temp_29);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[29];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[29] = tmp_id;
    __id[31] = tmp_id + 1024;
    
    tmp = temp_61;
    MY_ADD(tmp, temp_63, temp_61);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[61];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[61] = tmp_id;
    __id[63] = tmp_id + 1024;
    
    n_global *= 2;
    
    j = 1;
    k = __id[1] % 2048;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0015339807878856412f, tmp_angle);
    
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
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_33, tmp_angle, tmp);
    temp_33 = tmp;
    
    MY_MUL(temp_35, tmp_angle_rot, tmp);
    temp_35 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    
    MY_MUL(temp_19, tmp_angle_rot, tmp);
    temp_19 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_49, tmp_angle, tmp);
    temp_49 = tmp;
    
    MY_MUL(temp_51, tmp_angle_rot, tmp);
    temp_51 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_41, tmp_angle, tmp);
    temp_41 = tmp;
    
    MY_MUL(temp_43, tmp_angle_rot, tmp);
    temp_43 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_57, tmp_angle, tmp);
    temp_57 = tmp;
    
    MY_MUL(temp_59, tmp_angle_rot, tmp);
    temp_59 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_37, tmp_angle, tmp);
    temp_37 = tmp;
    
    MY_MUL(temp_39, tmp_angle_rot, tmp);
    temp_39 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_53, tmp_angle, tmp);
    temp_53 = tmp;
    
    MY_MUL(temp_55, tmp_angle_rot, tmp);
    temp_55 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_45, tmp_angle, tmp);
    temp_45 = tmp;
    
    MY_MUL(temp_47, tmp_angle_rot, tmp);
    temp_47 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_61, tmp_angle, tmp);
    temp_61 = tmp;
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[1] = tmp_id + 2048;
    
    tmp = temp_32;
    MY_ADD(tmp, temp_33, temp_32);
    MY_SUB(tmp, temp_33, temp_33);
    tmp_id = __id[32];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[32] = tmp_id;
    __id[33] = tmp_id + 2048;
    
    tmp = temp_16;
    MY_ADD(tmp, temp_17, temp_16);
    MY_SUB(tmp, temp_17, temp_17);
    tmp_id = __id[16];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[16] = tmp_id;
    __id[17] = tmp_id + 2048;
    
    tmp = temp_48;
    MY_ADD(tmp, temp_49, temp_48);
    MY_SUB(tmp, temp_49, temp_49);
    tmp_id = __id[48];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[48] = tmp_id;
    __id[49] = tmp_id + 2048;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[9] = tmp_id + 2048;
    
    tmp = temp_40;
    MY_ADD(tmp, temp_41, temp_40);
    MY_SUB(tmp, temp_41, temp_41);
    tmp_id = __id[40];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[40] = tmp_id;
    __id[41] = tmp_id + 2048;
    
    tmp = temp_24;
    MY_ADD(tmp, temp_25, temp_24);
    MY_SUB(tmp, temp_25, temp_25);
    tmp_id = __id[24];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[24] = tmp_id;
    __id[25] = tmp_id + 2048;
    
    tmp = temp_56;
    MY_ADD(tmp, temp_57, temp_56);
    MY_SUB(tmp, temp_57, temp_57);
    tmp_id = __id[56];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[56] = tmp_id;
    __id[57] = tmp_id + 2048;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 2048;
    
    tmp = temp_36;
    MY_ADD(tmp, temp_37, temp_36);
    MY_SUB(tmp, temp_37, temp_37);
    tmp_id = __id[36];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[36] = tmp_id;
    __id[37] = tmp_id + 2048;
    
    tmp = temp_20;
    MY_ADD(tmp, temp_21, temp_20);
    MY_SUB(tmp, temp_21, temp_21);
    tmp_id = __id[20];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[20] = tmp_id;
    __id[21] = tmp_id + 2048;
    
    tmp = temp_52;
    MY_ADD(tmp, temp_53, temp_52);
    MY_SUB(tmp, temp_53, temp_53);
    tmp_id = __id[52];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[52] = tmp_id;
    __id[53] = tmp_id + 2048;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[13] = tmp_id + 2048;
    
    tmp = temp_44;
    MY_ADD(tmp, temp_45, temp_44);
    MY_SUB(tmp, temp_45, temp_45);
    tmp_id = __id[44];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[44] = tmp_id;
    __id[45] = tmp_id + 2048;
    
    tmp = temp_28;
    MY_ADD(tmp, temp_29, temp_28);
    MY_SUB(tmp, temp_29, temp_29);
    tmp_id = __id[28];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[28] = tmp_id;
    __id[29] = tmp_id + 2048;
    
    tmp = temp_60;
    MY_ADD(tmp, temp_61, temp_60);
    MY_SUB(tmp, temp_61, temp_61);
    tmp_id = __id[60];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[60] = tmp_id;
    __id[61] = tmp_id + 2048;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 2048;
    
    tmp = temp_34;
    MY_ADD(tmp, temp_35, temp_34);
    MY_SUB(tmp, temp_35, temp_35);
    tmp_id = __id[34];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[34] = tmp_id;
    __id[35] = tmp_id + 2048;
    
    tmp = temp_18;
    MY_ADD(tmp, temp_19, temp_18);
    MY_SUB(tmp, temp_19, temp_19);
    tmp_id = __id[18];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[18] = tmp_id;
    __id[19] = tmp_id + 2048;
    
    tmp = temp_50;
    MY_ADD(tmp, temp_51, temp_50);
    MY_SUB(tmp, temp_51, temp_51);
    tmp_id = __id[50];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[50] = tmp_id;
    __id[51] = tmp_id + 2048;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[11] = tmp_id + 2048;
    
    tmp = temp_42;
    MY_ADD(tmp, temp_43, temp_42);
    MY_SUB(tmp, temp_43, temp_43);
    tmp_id = __id[42];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[42] = tmp_id;
    __id[43] = tmp_id + 2048;
    
    tmp = temp_26;
    MY_ADD(tmp, temp_27, temp_26);
    MY_SUB(tmp, temp_27, temp_27);
    tmp_id = __id[26];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[26] = tmp_id;
    __id[27] = tmp_id + 2048;
    
    tmp = temp_58;
    MY_ADD(tmp, temp_59, temp_58);
    MY_SUB(tmp, temp_59, temp_59);
    tmp_id = __id[58];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[58] = tmp_id;
    __id[59] = tmp_id + 2048;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 2048;
    
    tmp = temp_38;
    MY_ADD(tmp, temp_39, temp_38);
    MY_SUB(tmp, temp_39, temp_39);
    tmp_id = __id[38];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[38] = tmp_id;
    __id[39] = tmp_id + 2048;
    
    tmp = temp_22;
    MY_ADD(tmp, temp_23, temp_22);
    MY_SUB(tmp, temp_23, temp_23);
    tmp_id = __id[22];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[22] = tmp_id;
    __id[23] = tmp_id + 2048;
    
    tmp = temp_54;
    MY_ADD(tmp, temp_55, temp_54);
    MY_SUB(tmp, temp_55, temp_55);
    tmp_id = __id[54];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[54] = tmp_id;
    __id[55] = tmp_id + 2048;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[15] = tmp_id + 2048;
    
    tmp = temp_46;
    MY_ADD(tmp, temp_47, temp_46);
    MY_SUB(tmp, temp_47, temp_47);
    tmp_id = __id[46];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[46] = tmp_id;
    __id[47] = tmp_id + 2048;
    
    tmp = temp_30;
    MY_ADD(tmp, temp_31, temp_30);
    MY_SUB(tmp, temp_31, temp_31);
    tmp_id = __id[30];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[30] = tmp_id;
    __id[31] = tmp_id + 2048;
    
    tmp = temp_62;
    MY_ADD(tmp, temp_63, temp_62);
    MY_SUB(tmp, temp_63, temp_63);
    tmp_id = __id[62];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[62] = tmp_id;
    __id[63] = tmp_id + 2048;
    
    n_global *= 2;
    
    __syncthreads();
    
    sdata[__id[0]] = temp_0;
    
    sdata[__id[32]] = temp_32;
    
    sdata[__id[16]] = temp_16;
    
    sdata[__id[48]] = temp_48;
    
    sdata[__id[8]] = temp_8;
    
    sdata[__id[40]] = temp_40;
    
    sdata[__id[24]] = temp_24;
    
    sdata[__id[56]] = temp_56;
    
    sdata[__id[4]] = temp_4;
    
    sdata[__id[36]] = temp_36;
    
    sdata[__id[20]] = temp_20;
    
    sdata[__id[52]] = temp_52;
    
    sdata[__id[12]] = temp_12;
    
    sdata[__id[44]] = temp_44;
    
    sdata[__id[28]] = temp_28;
    
    sdata[__id[60]] = temp_60;
    
    sdata[__id[2]] = temp_2;
    
    sdata[__id[34]] = temp_34;
    
    sdata[__id[18]] = temp_18;
    
    sdata[__id[50]] = temp_50;
    
    sdata[__id[10]] = temp_10;
    
    sdata[__id[42]] = temp_42;
    
    sdata[__id[26]] = temp_26;
    
    sdata[__id[58]] = temp_58;
    
    sdata[__id[6]] = temp_6;
    
    sdata[__id[38]] = temp_38;
    
    sdata[__id[22]] = temp_22;
    
    sdata[__id[54]] = temp_54;
    
    sdata[__id[14]] = temp_14;
    
    sdata[__id[46]] = temp_46;
    
    sdata[__id[30]] = temp_30;
    
    sdata[__id[62]] = temp_62;
    
    sdata[__id[1]] = temp_1;
    
    sdata[__id[33]] = temp_33;
    
    sdata[__id[17]] = temp_17;
    
    sdata[__id[49]] = temp_49;
    
    sdata[__id[9]] = temp_9;
    
    sdata[__id[41]] = temp_41;
    
    sdata[__id[25]] = temp_25;
    
    sdata[__id[57]] = temp_57;
    
    sdata[__id[5]] = temp_5;
    
    sdata[__id[37]] = temp_37;
    
    sdata[__id[21]] = temp_21;
    
    sdata[__id[53]] = temp_53;
    
    sdata[__id[13]] = temp_13;
    
    sdata[__id[45]] = temp_45;
    
    sdata[__id[29]] = temp_29;
    
    sdata[__id[61]] = temp_61;
    
    sdata[__id[3]] = temp_3;
    
    sdata[__id[35]] = temp_35;
    
    sdata[__id[19]] = temp_19;
    
    sdata[__id[51]] = temp_51;
    
    sdata[__id[11]] = temp_11;
    
    sdata[__id[43]] = temp_43;
    
    sdata[__id[27]] = temp_27;
    
    sdata[__id[59]] = temp_59;
    
    sdata[__id[7]] = temp_7;
    
    sdata[__id[39]] = temp_39;
    
    sdata[__id[23]] = temp_23;
    
    sdata[__id[55]] = temp_55;
    
    sdata[__id[15]] = temp_15;
    
    sdata[__id[47]] = temp_47;
    
    sdata[__id[31]] = temp_31;
    
    sdata[__id[63]] = temp_63;
    
    __syncthreads();
    #if defined(LOG_ON)
    if(tx==0)printf("################### syncthreads ####################\n");
    #endif			
        
    temp_0 = sdata[0 * blockDim.x + tx];
    __id[0] = tx + 0 * 128;
    
    temp_1 = sdata[1 * blockDim.x + tx];
    __id[1] = tx + 1 * 128;
    
    temp_2 = sdata[2 * blockDim.x + tx];
    __id[2] = tx + 2 * 128;
    
    temp_3 = sdata[3 * blockDim.x + tx];
    __id[3] = tx + 3 * 128;
    
    temp_4 = sdata[4 * blockDim.x + tx];
    __id[4] = tx + 4 * 128;
    
    temp_5 = sdata[5 * blockDim.x + tx];
    __id[5] = tx + 5 * 128;
    
    temp_6 = sdata[6 * blockDim.x + tx];
    __id[6] = tx + 6 * 128;
    
    temp_7 = sdata[7 * blockDim.x + tx];
    __id[7] = tx + 7 * 128;
    
    temp_8 = sdata[8 * blockDim.x + tx];
    __id[8] = tx + 8 * 128;
    
    temp_9 = sdata[9 * blockDim.x + tx];
    __id[9] = tx + 9 * 128;
    
    temp_10 = sdata[10 * blockDim.x + tx];
    __id[10] = tx + 10 * 128;
    
    temp_11 = sdata[11 * blockDim.x + tx];
    __id[11] = tx + 11 * 128;
    
    temp_12 = sdata[12 * blockDim.x + tx];
    __id[12] = tx + 12 * 128;
    
    temp_13 = sdata[13 * blockDim.x + tx];
    __id[13] = tx + 13 * 128;
    
    temp_14 = sdata[14 * blockDim.x + tx];
    __id[14] = tx + 14 * 128;
    
    temp_15 = sdata[15 * blockDim.x + tx];
    __id[15] = tx + 15 * 128;
    
    temp_16 = sdata[16 * blockDim.x + tx];
    __id[16] = tx + 16 * 128;
    
    temp_17 = sdata[17 * blockDim.x + tx];
    __id[17] = tx + 17 * 128;
    
    temp_18 = sdata[18 * blockDim.x + tx];
    __id[18] = tx + 18 * 128;
    
    temp_19 = sdata[19 * blockDim.x + tx];
    __id[19] = tx + 19 * 128;
    
    temp_20 = sdata[20 * blockDim.x + tx];
    __id[20] = tx + 20 * 128;
    
    temp_21 = sdata[21 * blockDim.x + tx];
    __id[21] = tx + 21 * 128;
    
    temp_22 = sdata[22 * blockDim.x + tx];
    __id[22] = tx + 22 * 128;
    
    temp_23 = sdata[23 * blockDim.x + tx];
    __id[23] = tx + 23 * 128;
    
    temp_24 = sdata[24 * blockDim.x + tx];
    __id[24] = tx + 24 * 128;
    
    temp_25 = sdata[25 * blockDim.x + tx];
    __id[25] = tx + 25 * 128;
    
    temp_26 = sdata[26 * blockDim.x + tx];
    __id[26] = tx + 26 * 128;
    
    temp_27 = sdata[27 * blockDim.x + tx];
    __id[27] = tx + 27 * 128;
    
    temp_28 = sdata[28 * blockDim.x + tx];
    __id[28] = tx + 28 * 128;
    
    temp_29 = sdata[29 * blockDim.x + tx];
    __id[29] = tx + 29 * 128;
    
    temp_30 = sdata[30 * blockDim.x + tx];
    __id[30] = tx + 30 * 128;
    
    temp_31 = sdata[31 * blockDim.x + tx];
    __id[31] = tx + 31 * 128;
    
    temp_32 = sdata[32 * blockDim.x + tx];
    __id[32] = tx + 32 * 128;
    
    temp_33 = sdata[33 * blockDim.x + tx];
    __id[33] = tx + 33 * 128;
    
    temp_34 = sdata[34 * blockDim.x + tx];
    __id[34] = tx + 34 * 128;
    
    temp_35 = sdata[35 * blockDim.x + tx];
    __id[35] = tx + 35 * 128;
    
    temp_36 = sdata[36 * blockDim.x + tx];
    __id[36] = tx + 36 * 128;
    
    temp_37 = sdata[37 * blockDim.x + tx];
    __id[37] = tx + 37 * 128;
    
    temp_38 = sdata[38 * blockDim.x + tx];
    __id[38] = tx + 38 * 128;
    
    temp_39 = sdata[39 * blockDim.x + tx];
    __id[39] = tx + 39 * 128;
    
    temp_40 = sdata[40 * blockDim.x + tx];
    __id[40] = tx + 40 * 128;
    
    temp_41 = sdata[41 * blockDim.x + tx];
    __id[41] = tx + 41 * 128;
    
    temp_42 = sdata[42 * blockDim.x + tx];
    __id[42] = tx + 42 * 128;
    
    temp_43 = sdata[43 * blockDim.x + tx];
    __id[43] = tx + 43 * 128;
    
    temp_44 = sdata[44 * blockDim.x + tx];
    __id[44] = tx + 44 * 128;
    
    temp_45 = sdata[45 * blockDim.x + tx];
    __id[45] = tx + 45 * 128;
    
    temp_46 = sdata[46 * blockDim.x + tx];
    __id[46] = tx + 46 * 128;
    
    temp_47 = sdata[47 * blockDim.x + tx];
    __id[47] = tx + 47 * 128;
    
    temp_48 = sdata[48 * blockDim.x + tx];
    __id[48] = tx + 48 * 128;
    
    temp_49 = sdata[49 * blockDim.x + tx];
    __id[49] = tx + 49 * 128;
    
    temp_50 = sdata[50 * blockDim.x + tx];
    __id[50] = tx + 50 * 128;
    
    temp_51 = sdata[51 * blockDim.x + tx];
    __id[51] = tx + 51 * 128;
    
    temp_52 = sdata[52 * blockDim.x + tx];
    __id[52] = tx + 52 * 128;
    
    temp_53 = sdata[53 * blockDim.x + tx];
    __id[53] = tx + 53 * 128;
    
    temp_54 = sdata[54 * blockDim.x + tx];
    __id[54] = tx + 54 * 128;
    
    temp_55 = sdata[55 * blockDim.x + tx];
    __id[55] = tx + 55 * 128;
    
    temp_56 = sdata[56 * blockDim.x + tx];
    __id[56] = tx + 56 * 128;
    
    temp_57 = sdata[57 * blockDim.x + tx];
    __id[57] = tx + 57 * 128;
    
    temp_58 = sdata[58 * blockDim.x + tx];
    __id[58] = tx + 58 * 128;
    
    temp_59 = sdata[59 * blockDim.x + tx];
    __id[59] = tx + 59 * 128;
    
    temp_60 = sdata[60 * blockDim.x + tx];
    __id[60] = tx + 60 * 128;
    
    temp_61 = sdata[61 * blockDim.x + tx];
    __id[61] = tx + 61 * 128;
    
    temp_62 = sdata[62 * blockDim.x + tx];
    __id[62] = tx + 62 * 128;
    
    temp_63 = sdata[63 * blockDim.x + tx];
    __id[63] = tx + 63 * 128;
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[32] % 4096;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.0007669903939428206f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_32, tmp_angle, tmp);
    temp_32 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 32,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[32], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_48, tmp_angle_rot, tmp);
    temp_48 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 48,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[48], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_33, tmp_angle, tmp);
    temp_33 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 33,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[33], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_49, tmp_angle_rot, tmp);
    temp_49 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 49,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[49], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_34, tmp_angle, tmp);
    temp_34 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 34,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[34], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_50, tmp_angle_rot, tmp);
    temp_50 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 50,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[50], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_35, tmp_angle, tmp);
    temp_35 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 35,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[35], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_51, tmp_angle_rot, tmp);
    temp_51 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 51,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[51], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_36, tmp_angle, tmp);
    temp_36 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 36,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[36], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_52, tmp_angle_rot, tmp);
    temp_52 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 52,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[52], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_37, tmp_angle, tmp);
    temp_37 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 37,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[37], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_53, tmp_angle_rot, tmp);
    temp_53 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 53,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[53], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_38, tmp_angle, tmp);
    temp_38 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 38,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[38], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_54, tmp_angle_rot, tmp);
    temp_54 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 54,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[54], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_39, tmp_angle, tmp);
    temp_39 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 39,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[39], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_55, tmp_angle_rot, tmp);
    temp_55 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 55,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[55], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_40, tmp_angle, tmp);
    temp_40 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 40,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[40], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_56, tmp_angle_rot, tmp);
    temp_56 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 56,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[56], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_41, tmp_angle, tmp);
    temp_41 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 41,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[41], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_57, tmp_angle_rot, tmp);
    temp_57 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 57,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[57], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_42, tmp_angle, tmp);
    temp_42 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 42,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[42], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_58, tmp_angle_rot, tmp);
    temp_58 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 58,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[58], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_43, tmp_angle, tmp);
    temp_43 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 43,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[43], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_59, tmp_angle_rot, tmp);
    temp_59 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 59,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[59], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_44, tmp_angle, tmp);
    temp_44 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 44,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[44], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_60, tmp_angle_rot, tmp);
    temp_60 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 60,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[60], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_45, tmp_angle, tmp);
    temp_45 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 45,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[45], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_61, tmp_angle_rot, tmp);
    temp_61 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 61,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[61], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_46, tmp_angle, tmp);
    temp_46 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 46,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[46], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_62, tmp_angle_rot, tmp);
    temp_62 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 62,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[62], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9951847266721969f;
    tmp_angle_rot.y = -0.0980171403295606f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_47, tmp_angle, tmp);
    temp_47 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 47,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[47], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_63, tmp_angle_rot, tmp);
    temp_63 = tmp;
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 63,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[63], j, k, j*k, n_global);
    #endif
    
    tmp = temp_0;
    MY_ADD(tmp, temp_32, temp_0);
    MY_SUB(tmp, temp_32, temp_32);
    
    tmp = temp_1;
    MY_ADD(tmp, temp_33, temp_1);
    MY_SUB(tmp, temp_33, temp_33);
    
    tmp = temp_2;
    MY_ADD(tmp, temp_34, temp_2);
    MY_SUB(tmp, temp_34, temp_34);
    
    tmp = temp_3;
    MY_ADD(tmp, temp_35, temp_3);
    MY_SUB(tmp, temp_35, temp_35);
    
    tmp = temp_4;
    MY_ADD(tmp, temp_36, temp_4);
    MY_SUB(tmp, temp_36, temp_36);
    
    tmp = temp_5;
    MY_ADD(tmp, temp_37, temp_5);
    MY_SUB(tmp, temp_37, temp_37);
    
    tmp = temp_6;
    MY_ADD(tmp, temp_38, temp_6);
    MY_SUB(tmp, temp_38, temp_38);
    
    tmp = temp_7;
    MY_ADD(tmp, temp_39, temp_7);
    MY_SUB(tmp, temp_39, temp_39);
    
    tmp = temp_8;
    MY_ADD(tmp, temp_40, temp_8);
    MY_SUB(tmp, temp_40, temp_40);
    
    tmp = temp_9;
    MY_ADD(tmp, temp_41, temp_9);
    MY_SUB(tmp, temp_41, temp_41);
    
    tmp = temp_10;
    MY_ADD(tmp, temp_42, temp_10);
    MY_SUB(tmp, temp_42, temp_42);
    
    tmp = temp_11;
    MY_ADD(tmp, temp_43, temp_11);
    MY_SUB(tmp, temp_43, temp_43);
    
    tmp = temp_12;
    MY_ADD(tmp, temp_44, temp_12);
    MY_SUB(tmp, temp_44, temp_44);
    
    tmp = temp_13;
    MY_ADD(tmp, temp_45, temp_13);
    MY_SUB(tmp, temp_45, temp_45);
    
    tmp = temp_14;
    MY_ADD(tmp, temp_46, temp_14);
    MY_SUB(tmp, temp_46, temp_46);
    
    tmp = temp_15;
    MY_ADD(tmp, temp_47, temp_15);
    MY_SUB(tmp, temp_47, temp_47);
    
    tmp = temp_16;
    MY_ADD(tmp, temp_48, temp_16);
    MY_SUB(tmp, temp_48, temp_48);
    
    tmp = temp_17;
    MY_ADD(tmp, temp_49, temp_17);
    MY_SUB(tmp, temp_49, temp_49);
    
    tmp = temp_18;
    MY_ADD(tmp, temp_50, temp_18);
    MY_SUB(tmp, temp_50, temp_50);
    
    tmp = temp_19;
    MY_ADD(tmp, temp_51, temp_19);
    MY_SUB(tmp, temp_51, temp_51);
    
    tmp = temp_20;
    MY_ADD(tmp, temp_52, temp_20);
    MY_SUB(tmp, temp_52, temp_52);
    
    tmp = temp_21;
    MY_ADD(tmp, temp_53, temp_21);
    MY_SUB(tmp, temp_53, temp_53);
    
    tmp = temp_22;
    MY_ADD(tmp, temp_54, temp_22);
    MY_SUB(tmp, temp_54, temp_54);
    
    tmp = temp_23;
    MY_ADD(tmp, temp_55, temp_23);
    MY_SUB(tmp, temp_55, temp_55);
    
    tmp = temp_24;
    MY_ADD(tmp, temp_56, temp_24);
    MY_SUB(tmp, temp_56, temp_56);
    
    tmp = temp_25;
    MY_ADD(tmp, temp_57, temp_25);
    MY_SUB(tmp, temp_57, temp_57);
    
    tmp = temp_26;
    MY_ADD(tmp, temp_58, temp_26);
    MY_SUB(tmp, temp_58, temp_58);
    
    tmp = temp_27;
    MY_ADD(tmp, temp_59, temp_27);
    MY_SUB(tmp, temp_59, temp_59);
    
    tmp = temp_28;
    MY_ADD(tmp, temp_60, temp_28);
    MY_SUB(tmp, temp_60, temp_60);
    
    tmp = temp_29;
    MY_ADD(tmp, temp_61, temp_29);
    MY_SUB(tmp, temp_61, temp_61);
    
    tmp = temp_30;
    MY_ADD(tmp, temp_62, temp_30);
    MY_SUB(tmp, temp_62, temp_62);
    
    tmp = temp_31;
    MY_ADD(tmp, temp_63, temp_31);
    MY_SUB(tmp, temp_63, temp_63);
    
    n_global *= 2;
    outputs[__id[0]] = temp_0;
    outputs[__id[1]] = temp_1;
    outputs[__id[2]] = temp_2;
    outputs[__id[3]] = temp_3;
    outputs[__id[4]] = temp_4;
    outputs[__id[5]] = temp_5;
    outputs[__id[6]] = temp_6;
    outputs[__id[7]] = temp_7;
    outputs[__id[8]] = temp_8;
    outputs[__id[9]] = temp_9;
    outputs[__id[10]] = temp_10;
    outputs[__id[11]] = temp_11;
    outputs[__id[12]] = temp_12;
    outputs[__id[13]] = temp_13;
    outputs[__id[14]] = temp_14;
    outputs[__id[15]] = temp_15;
    outputs[__id[16]] = temp_16;
    outputs[__id[17]] = temp_17;
    outputs[__id[18]] = temp_18;
    outputs[__id[19]] = temp_19;
    outputs[__id[20]] = temp_20;
    outputs[__id[21]] = temp_21;
    outputs[__id[22]] = temp_22;
    outputs[__id[23]] = temp_23;
    outputs[__id[24]] = temp_24;
    outputs[__id[25]] = temp_25;
    outputs[__id[26]] = temp_26;
    outputs[__id[27]] = temp_27;
    outputs[__id[28]] = temp_28;
    outputs[__id[29]] = temp_29;
    outputs[__id[30]] = temp_30;
    outputs[__id[31]] = temp_31;
    outputs[__id[32]] = temp_32;
    outputs[__id[33]] = temp_33;
    outputs[__id[34]] = temp_34;
    outputs[__id[35]] = temp_35;
    outputs[__id[36]] = temp_36;
    outputs[__id[37]] = temp_37;
    outputs[__id[38]] = temp_38;
    outputs[__id[39]] = temp_39;
    outputs[__id[40]] = temp_40;
    outputs[__id[41]] = temp_41;
    outputs[__id[42]] = temp_42;
    outputs[__id[43]] = temp_43;
    outputs[__id[44]] = temp_44;
    outputs[__id[45]] = temp_45;
    outputs[__id[46]] = temp_46;
    outputs[__id[47]] = temp_47;
    outputs[__id[48]] = temp_48;
    outputs[__id[49]] = temp_49;
    outputs[__id[50]] = temp_50;
    outputs[__id[51]] = temp_51;
    outputs[__id[52]] = temp_52;
    outputs[__id[53]] = temp_53;
    outputs[__id[54]] = temp_54;
    outputs[__id[55]] = temp_55;
    outputs[__id[56]] = temp_56;
    outputs[__id[57]] = temp_57;
    outputs[__id[58]] = temp_58;
    outputs[__id[59]] = temp_59;
    outputs[__id[60]] = temp_60;
    outputs[__id[61]] = temp_61;
    outputs[__id[62]] = temp_62;
    outputs[__id[63]] = temp_63;
    
    }
