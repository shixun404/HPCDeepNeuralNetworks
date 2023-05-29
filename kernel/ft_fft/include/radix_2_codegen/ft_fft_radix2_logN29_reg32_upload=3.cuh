extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_radix2_logN29_3(float2* inputs, float2* outputs) {

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
    
    temp_0 = inputs[(tx + 0) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_1 = inputs[(tx + 32) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_2 = inputs[(tx + 64) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_3 = inputs[(tx + 96) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_4 = inputs[(tx + 128) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_5 = inputs[(tx + 160) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_6 = inputs[(tx + 192) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_7 = inputs[(tx + 224) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_8 = inputs[(tx + 256) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_9 = inputs[(tx + 288) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_10 = inputs[(tx + 320) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_11 = inputs[(tx + 352) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_12 = inputs[(tx + 384) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_13 = inputs[(tx + 416) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_14 = inputs[(tx + 448) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_15 = inputs[(tx + 480) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_16 = inputs[(tx + 512) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_17 = inputs[(tx + 544) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_18 = inputs[(tx + 576) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_19 = inputs[(tx + 608) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_20 = inputs[(tx + 640) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_21 = inputs[(tx + 672) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_22 = inputs[(tx + 704) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_23 = inputs[(tx + 736) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_24 = inputs[(tx + 768) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_25 = inputs[(tx + 800) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_26 = inputs[(tx + 832) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_27 = inputs[(tx + 864) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_28 = inputs[(tx + 896) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_29 = inputs[(tx + 928) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_30 = inputs[(tx + 960) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    temp_31 = inputs[(tx + 992) + (bx / 128) * 1024 + (ty + (bx % 128) * 8) * 524288];
    #if defined(LOG_ON)
    printf("############ after read global bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[16] % 1;
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[16], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[17], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[18], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[19], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[20], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[23], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[24], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 2;
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[8], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_24, tmp_angle_rot, tmp);
    temp_24 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[24], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_25, tmp_angle_rot, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_26, tmp_angle_rot, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle_rot, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle_rot, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[15], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 4;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle_rot, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle_rot, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[20], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle_rot, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle_rot, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[23], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 8;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[18], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle_rot, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[19], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[23], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 16;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[17], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle_rot, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[19], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[11], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[27], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[23], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    
    
    sdata[__id[0] + ty * 1024] = temp_0;
    
    sdata[__id[16] + ty * 1024] = temp_16;
    
    sdata[__id[8] + ty * 1024] = temp_8;
    
    sdata[__id[24] + ty * 1024] = temp_24;
    
    sdata[__id[4] + ty * 1024] = temp_4;
    
    sdata[__id[20] + ty * 1024] = temp_20;
    
    sdata[__id[12] + ty * 1024] = temp_12;
    
    sdata[__id[28] + ty * 1024] = temp_28;
    
    sdata[__id[2] + ty * 1024] = temp_2;
    
    sdata[__id[18] + ty * 1024] = temp_18;
    
    sdata[__id[10] + ty * 1024] = temp_10;
    
    sdata[__id[26] + ty * 1024] = temp_26;
    
    sdata[__id[6] + ty * 1024] = temp_6;
    
    sdata[__id[22] + ty * 1024] = temp_22;
    
    sdata[__id[14] + ty * 1024] = temp_14;
    
    sdata[__id[30] + ty * 1024] = temp_30;
    
    sdata[__id[1] + ty * 1024] = temp_1;
    
    sdata[__id[17] + ty * 1024] = temp_17;
    
    sdata[__id[9] + ty * 1024] = temp_9;
    
    sdata[__id[25] + ty * 1024] = temp_25;
    
    sdata[__id[5] + ty * 1024] = temp_5;
    
    sdata[__id[21] + ty * 1024] = temp_21;
    
    sdata[__id[13] + ty * 1024] = temp_13;
    
    sdata[__id[29] + ty * 1024] = temp_29;
    
    sdata[__id[3] + ty * 1024] = temp_3;
    
    sdata[__id[19] + ty * 1024] = temp_19;
    
    sdata[__id[11] + ty * 1024] = temp_11;
    
    sdata[__id[27] + ty * 1024] = temp_27;
    
    sdata[__id[7] + ty * 1024] = temp_7;
    
    sdata[__id[23] + ty * 1024] = temp_23;
    
    sdata[__id[15] + ty * 1024] = temp_15;
    
    sdata[__id[31] + ty * 1024] = temp_31;
    
    __syncthreads();
    #if defined(LOG_ON)
    printf("################### syncthreads ####################\n");
    #endif			
    
    temp_0 = sdata[tx + 0 + ty * 1024];
    __id[0] = tx + 0;
    
    temp_1 = sdata[tx + 32 + ty * 1024];
    __id[1] = tx + 32;
    
    temp_2 = sdata[tx + 64 + ty * 1024];
    __id[2] = tx + 64;
    
    temp_3 = sdata[tx + 96 + ty * 1024];
    __id[3] = tx + 96;
    
    temp_4 = sdata[tx + 128 + ty * 1024];
    __id[4] = tx + 128;
    
    temp_5 = sdata[tx + 160 + ty * 1024];
    __id[5] = tx + 160;
    
    temp_6 = sdata[tx + 192 + ty * 1024];
    __id[6] = tx + 192;
    
    temp_7 = sdata[tx + 224 + ty * 1024];
    __id[7] = tx + 224;
    
    temp_8 = sdata[tx + 256 + ty * 1024];
    __id[8] = tx + 256;
    
    temp_9 = sdata[tx + 288 + ty * 1024];
    __id[9] = tx + 288;
    
    temp_10 = sdata[tx + 320 + ty * 1024];
    __id[10] = tx + 320;
    
    temp_11 = sdata[tx + 352 + ty * 1024];
    __id[11] = tx + 352;
    
    temp_12 = sdata[tx + 384 + ty * 1024];
    __id[12] = tx + 384;
    
    temp_13 = sdata[tx + 416 + ty * 1024];
    __id[13] = tx + 416;
    
    temp_14 = sdata[tx + 448 + ty * 1024];
    __id[14] = tx + 448;
    
    temp_15 = sdata[tx + 480 + ty * 1024];
    __id[15] = tx + 480;
    
    temp_16 = sdata[tx + 512 + ty * 1024];
    __id[16] = tx + 512;
    
    temp_17 = sdata[tx + 544 + ty * 1024];
    __id[17] = tx + 544;
    
    temp_18 = sdata[tx + 576 + ty * 1024];
    __id[18] = tx + 576;
    
    temp_19 = sdata[tx + 608 + ty * 1024];
    __id[19] = tx + 608;
    
    temp_20 = sdata[tx + 640 + ty * 1024];
    __id[20] = tx + 640;
    
    temp_21 = sdata[tx + 672 + ty * 1024];
    __id[21] = tx + 672;
    
    temp_22 = sdata[tx + 704 + ty * 1024];
    __id[22] = tx + 704;
    
    temp_23 = sdata[tx + 736 + ty * 1024];
    __id[23] = tx + 736;
    
    temp_24 = sdata[tx + 768 + ty * 1024];
    __id[24] = tx + 768;
    
    temp_25 = sdata[tx + 800 + ty * 1024];
    __id[25] = tx + 800;
    
    temp_26 = sdata[tx + 832 + ty * 1024];
    __id[26] = tx + 832;
    
    temp_27 = sdata[tx + 864 + ty * 1024];
    __id[27] = tx + 864;
    
    temp_28 = sdata[tx + 896 + ty * 1024];
    __id[28] = tx + 896;
    
    temp_29 = sdata[tx + 928 + ty * 1024];
    __id[29] = tx + 928;
    
    temp_30 = sdata[tx + 960 + ty * 1024];
    __id[30] = tx + 960;
    
    temp_31 = sdata[tx + 992 + ty * 1024];
    __id[31] = tx + 992;
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[16] % 32;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[16], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[17], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[18], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[19], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[20], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[23], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[24], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 64;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    
    tmp_angle_rot.x = 1.0f;
    tmp_angle_rot.y = 0.0f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[8], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_24, tmp_angle_rot, tmp);
    temp_24 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[24], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_25, tmp_angle_rot, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_26, tmp_angle_rot, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle_rot, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle_rot, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[15], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 128;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle_rot, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle_rot, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[20], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle_rot, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle_rot, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[23], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 256;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[18], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle_rot, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[19], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[23], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[31], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 512;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[17], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle_rot, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[19], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[11], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[27], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[23], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9807852804032304f;
    tmp_angle_rot.y = -0.19509032201612825f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[31], j, k, j*k, n_global);
    #endif
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    
    tmp = temp_16;
    MY_ADD(tmp, temp_17, temp_16);
    MY_SUB(tmp, temp_17, temp_17);
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    
    tmp = temp_24;
    MY_ADD(tmp, temp_25, temp_24);
    MY_SUB(tmp, temp_25, temp_25);
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    
    tmp = temp_20;
    MY_ADD(tmp, temp_21, temp_20);
    MY_SUB(tmp, temp_21, temp_21);
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    
    tmp = temp_28;
    MY_ADD(tmp, temp_29, temp_28);
    MY_SUB(tmp, temp_29, temp_29);
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    
    tmp = temp_18;
    MY_ADD(tmp, temp_19, temp_18);
    MY_SUB(tmp, temp_19, temp_19);
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    
    tmp = temp_26;
    MY_ADD(tmp, temp_27, temp_26);
    MY_SUB(tmp, temp_27, temp_27);
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    
    tmp = temp_22;
    MY_ADD(tmp, temp_23, temp_22);
    MY_SUB(tmp, temp_23, temp_23);
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    
    tmp = temp_30;
    MY_ADD(tmp, temp_31, temp_30);
    MY_SUB(tmp, temp_31, temp_31);
    
    n_global *= 2;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 0 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[0]) * 524288] = temp_0;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 32 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[16]) * 524288] = temp_16;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 64 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[8]) * 524288] = temp_8;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 96 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[24]) * 524288] = temp_24;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 128 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[4]) * 524288] = temp_4;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 160 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[20]) * 524288] = temp_20;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 192 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[12]) * 524288] = temp_12;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 224 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[28]) * 524288] = temp_28;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 256 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[2]) * 524288] = temp_2;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 288 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[18]) * 524288] = temp_18;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 320 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[10]) * 524288] = temp_10;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 352 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[26]) * 524288] = temp_26;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 384 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[6]) * 524288] = temp_6;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 416 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[22]) * 524288] = temp_22;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 448 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[14]) * 524288] = temp_14;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 480 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[30]) * 524288] = temp_30;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 512 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[1]) * 524288] = temp_1;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 544 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[17]) * 524288] = temp_17;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 576 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[9]) * 524288] = temp_9;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 608 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[25]) * 524288] = temp_25;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 640 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[5]) * 524288] = temp_5;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 672 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[21]) * 524288] = temp_21;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 704 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[13]) * 524288] = temp_13;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 736 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[29]) * 524288] = temp_29;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 768 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[3]) * 524288] = temp_3;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 800 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[19]) * 524288] = temp_19;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 832 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[11]) * 524288] = temp_11;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 864 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[27]) * 524288] = temp_27;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 896 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[7]) * 524288] = temp_7;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 928 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[23]) * 524288] = temp_23;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 960 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[15]) * 524288] = temp_15;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 992 + ty * 524288 + (bx % 128) * 4194304 + (bx / 128 * 1024)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 128) * 8) + (bx / 128) * 1024 + (__id[31]) * 524288] = temp_31;
    
    }
