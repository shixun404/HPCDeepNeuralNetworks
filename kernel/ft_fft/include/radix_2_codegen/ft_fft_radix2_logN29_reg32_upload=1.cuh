extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_radix2_logN29_1(float2* inputs, float2* outputs) {

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
    
    temp_0 = inputs[(ty + 0 * 32) * 524288 + tx + bx * 8];
    temp_1 = inputs[(ty + 1 * 32) * 524288 + tx + bx * 8];
    temp_2 = inputs[(ty + 2 * 32) * 524288 + tx + bx * 8];
    temp_3 = inputs[(ty + 3 * 32) * 524288 + tx + bx * 8];
    temp_4 = inputs[(ty + 4 * 32) * 524288 + tx + bx * 8];
    temp_5 = inputs[(ty + 5 * 32) * 524288 + tx + bx * 8];
    temp_6 = inputs[(ty + 6 * 32) * 524288 + tx + bx * 8];
    temp_7 = inputs[(ty + 7 * 32) * 524288 + tx + bx * 8];
    temp_8 = inputs[(ty + 8 * 32) * 524288 + tx + bx * 8];
    temp_9 = inputs[(ty + 9 * 32) * 524288 + tx + bx * 8];
    temp_10 = inputs[(ty + 10 * 32) * 524288 + tx + bx * 8];
    temp_11 = inputs[(ty + 11 * 32) * 524288 + tx + bx * 8];
    temp_12 = inputs[(ty + 12 * 32) * 524288 + tx + bx * 8];
    temp_13 = inputs[(ty + 13 * 32) * 524288 + tx + bx * 8];
    temp_14 = inputs[(ty + 14 * 32) * 524288 + tx + bx * 8];
    temp_15 = inputs[(ty + 15 * 32) * 524288 + tx + bx * 8];
    temp_16 = inputs[(ty + 16 * 32) * 524288 + tx + bx * 8];
    temp_17 = inputs[(ty + 17 * 32) * 524288 + tx + bx * 8];
    temp_18 = inputs[(ty + 18 * 32) * 524288 + tx + bx * 8];
    temp_19 = inputs[(ty + 19 * 32) * 524288 + tx + bx * 8];
    temp_20 = inputs[(ty + 20 * 32) * 524288 + tx + bx * 8];
    temp_21 = inputs[(ty + 21 * 32) * 524288 + tx + bx * 8];
    temp_22 = inputs[(ty + 22 * 32) * 524288 + tx + bx * 8];
    temp_23 = inputs[(ty + 23 * 32) * 524288 + tx + bx * 8];
    temp_24 = inputs[(ty + 24 * 32) * 524288 + tx + bx * 8];
    temp_25 = inputs[(ty + 25 * 32) * 524288 + tx + bx * 8];
    temp_26 = inputs[(ty + 26 * 32) * 524288 + tx + bx * 8];
    temp_27 = inputs[(ty + 27 * 32) * 524288 + tx + bx * 8];
    temp_28 = inputs[(ty + 28 * 32) * 524288 + tx + bx * 8];
    temp_29 = inputs[(ty + 29 * 32) * 524288 + tx + bx * 8];
    temp_30 = inputs[(ty + 30 * 32) * 524288 + tx + bx * 8];
    temp_31 = inputs[(ty + 31 * 32) * 524288 + tx + bx * 8];
    
    __id[0] = 0 + ty;
    __id[1] = 32 + ty;
    __id[2] = 64 + ty;
    __id[3] = 96 + ty;
    __id[4] = 128 + ty;
    __id[5] = 160 + ty;
    __id[6] = 192 + ty;
    __id[7] = 224 + ty;
    __id[8] = 256 + ty;
    __id[9] = 288 + ty;
    __id[10] = 320 + ty;
    __id[11] = 352 + ty;
    __id[12] = 384 + ty;
    __id[13] = 416 + ty;
    __id[14] = 448 + ty;
    __id[15] = 480 + ty;
    __id[16] = 512 + ty;
    __id[17] = 544 + ty;
    __id[18] = 576 + ty;
    __id[19] = 608 + ty;
    __id[20] = 640 + ty;
    __id[21] = 672 + ty;
    __id[22] = 704 + ty;
    __id[23] = 736 + ty;
    __id[24] = 768 + ty;
    __id[25] = 800 + ty;
    __id[26] = 832 + ty;
    __id[27] = 864 + ty;
    __id[28] = 896 + ty;
    __id[29] = 928 + ty;
    __id[30] = 960 + ty;
    __id[31] = 992 + ty;
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[16] % 1;
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[16], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[17], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[18], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[19], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[20], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[23], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[24], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 2;
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[8], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_24, tmp_angle_rot, tmp);
    temp_24 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[24], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_25, tmp_angle_rot, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_26, tmp_angle_rot, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle_rot, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle_rot, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[15], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 4;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle_rot, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle_rot, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[20], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle_rot, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle_rot, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[23], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 8;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[18], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle_rot, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[19], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[23], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 16;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[17], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle_rot, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[19], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[11], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[27], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[23], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    
    
    sdata[tx + 8 * __id[0]] = temp_0;
    
    sdata[tx + 8 * __id[16]] = temp_16;
    
    sdata[tx + 8 * __id[8]] = temp_8;
    
    sdata[tx + 8 * __id[24]] = temp_24;
    
    sdata[tx + 8 * __id[4]] = temp_4;
    
    sdata[tx + 8 * __id[20]] = temp_20;
    
    sdata[tx + 8 * __id[12]] = temp_12;
    
    sdata[tx + 8 * __id[28]] = temp_28;
    
    sdata[tx + 8 * __id[2]] = temp_2;
    
    sdata[tx + 8 * __id[18]] = temp_18;
    
    sdata[tx + 8 * __id[10]] = temp_10;
    
    sdata[tx + 8 * __id[26]] = temp_26;
    
    sdata[tx + 8 * __id[6]] = temp_6;
    
    sdata[tx + 8 * __id[22]] = temp_22;
    
    sdata[tx + 8 * __id[14]] = temp_14;
    
    sdata[tx + 8 * __id[30]] = temp_30;
    
    sdata[tx + 8 * __id[1]] = temp_1;
    
    sdata[tx + 8 * __id[17]] = temp_17;
    
    sdata[tx + 8 * __id[9]] = temp_9;
    
    sdata[tx + 8 * __id[25]] = temp_25;
    
    sdata[tx + 8 * __id[5]] = temp_5;
    
    sdata[tx + 8 * __id[21]] = temp_21;
    
    sdata[tx + 8 * __id[13]] = temp_13;
    
    sdata[tx + 8 * __id[29]] = temp_29;
    
    sdata[tx + 8 * __id[3]] = temp_3;
    
    sdata[tx + 8 * __id[19]] = temp_19;
    
    sdata[tx + 8 * __id[11]] = temp_11;
    
    sdata[tx + 8 * __id[27]] = temp_27;
    
    sdata[tx + 8 * __id[7]] = temp_7;
    
    sdata[tx + 8 * __id[23]] = temp_23;
    
    sdata[tx + 8 * __id[15]] = temp_15;
    
    sdata[tx + 8 * __id[31]] = temp_31;
    
    __syncthreads();
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("################### syncthreads ####################\n");
    #endif			
    
    temp_0 = sdata[tx + 8 * (0 + ty)];
    __id[0] = ty + 0;
    
    temp_1 = sdata[tx + 8 * (32 + ty)];
    __id[1] = ty + 32;
    
    temp_2 = sdata[tx + 8 * (64 + ty)];
    __id[2] = ty + 64;
    
    temp_3 = sdata[tx + 8 * (96 + ty)];
    __id[3] = ty + 96;
    
    temp_4 = sdata[tx + 8 * (128 + ty)];
    __id[4] = ty + 128;
    
    temp_5 = sdata[tx + 8 * (160 + ty)];
    __id[5] = ty + 160;
    
    temp_6 = sdata[tx + 8 * (192 + ty)];
    __id[6] = ty + 192;
    
    temp_7 = sdata[tx + 8 * (224 + ty)];
    __id[7] = ty + 224;
    
    temp_8 = sdata[tx + 8 * (256 + ty)];
    __id[8] = ty + 256;
    
    temp_9 = sdata[tx + 8 * (288 + ty)];
    __id[9] = ty + 288;
    
    temp_10 = sdata[tx + 8 * (320 + ty)];
    __id[10] = ty + 320;
    
    temp_11 = sdata[tx + 8 * (352 + ty)];
    __id[11] = ty + 352;
    
    temp_12 = sdata[tx + 8 * (384 + ty)];
    __id[12] = ty + 384;
    
    temp_13 = sdata[tx + 8 * (416 + ty)];
    __id[13] = ty + 416;
    
    temp_14 = sdata[tx + 8 * (448 + ty)];
    __id[14] = ty + 448;
    
    temp_15 = sdata[tx + 8 * (480 + ty)];
    __id[15] = ty + 480;
    
    temp_16 = sdata[tx + 8 * (512 + ty)];
    __id[16] = ty + 512;
    
    temp_17 = sdata[tx + 8 * (544 + ty)];
    __id[17] = ty + 544;
    
    temp_18 = sdata[tx + 8 * (576 + ty)];
    __id[18] = ty + 576;
    
    temp_19 = sdata[tx + 8 * (608 + ty)];
    __id[19] = ty + 608;
    
    temp_20 = sdata[tx + 8 * (640 + ty)];
    __id[20] = ty + 640;
    
    temp_21 = sdata[tx + 8 * (672 + ty)];
    __id[21] = ty + 672;
    
    temp_22 = sdata[tx + 8 * (704 + ty)];
    __id[22] = ty + 704;
    
    temp_23 = sdata[tx + 8 * (736 + ty)];
    __id[23] = ty + 736;
    
    temp_24 = sdata[tx + 8 * (768 + ty)];
    __id[24] = ty + 768;
    
    temp_25 = sdata[tx + 8 * (800 + ty)];
    __id[25] = ty + 800;
    
    temp_26 = sdata[tx + 8 * (832 + ty)];
    __id[26] = ty + 832;
    
    temp_27 = sdata[tx + 8 * (864 + ty)];
    __id[27] = ty + 864;
    
    temp_28 = sdata[tx + 8 * (896 + ty)];
    __id[28] = ty + 896;
    
    temp_29 = sdata[tx + 8 * (928 + ty)];
    __id[29] = ty + 928;
    
    temp_30 = sdata[tx + 8 * (960 + ty)];
    __id[30] = ty + 960;
    
    temp_31 = sdata[tx + 8 * (992 + ty)];
    __id[31] = ty + 992;
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[16] % 32;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[16], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[17], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[18], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[19], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[20], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[23], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[24], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 64;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[8], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_24, tmp_angle_rot, tmp);
    temp_24 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[24], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_25, tmp_angle_rot, tmp);
    temp_25 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_26, tmp_angle_rot, tmp);
    temp_26 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle_rot, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle_rot, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[15], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 128;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle_rot, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle_rot, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[20], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_28, tmp_angle_rot, tmp);
    temp_28 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[28], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_29, tmp_angle_rot, tmp);
    temp_29 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[23], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 256;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[18], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_22, tmp_angle_rot, tmp);
    temp_22 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[22], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[19], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[23], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[26], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_30, tmp_angle_rot, tmp);
    temp_30 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[30], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[27], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 512;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.006135923151542565f, tmp_angle);
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 16,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 24,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 17,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[17], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_19, tmp_angle_rot, tmp);
    temp_19 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 25,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[19], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 18,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 26,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[11], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 19,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[25], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_27, tmp_angle_rot, tmp);
    temp_27 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 27,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[27], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 20,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 28,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 21,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[21], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_23, tmp_angle_rot, tmp);
    temp_23 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 29,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[23], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 22,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 30,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
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
    if(tx==0 && bx==0 && ty==0)printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 23,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[29], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_31, tmp_angle_rot, tmp);
    temp_31 = tmp;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 31,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[0])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[0]] = temp_0;
    // outputs[__id[0]] = temp_0;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[16])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[16]] = temp_16;
    // outputs[__id[16]] = temp_16;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[8])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[8]] = temp_8;
    // outputs[__id[8]] = temp_8;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[24])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[24]] = temp_24;
    // outputs[__id[24]] = temp_24;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[4])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[4]] = temp_4;
    // outputs[__id[4]] = temp_4;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[20])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[20]] = temp_20;
    // outputs[__id[20]] = temp_20;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[12])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[12]] = temp_12;
    // outputs[__id[12]] = temp_12;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[28])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[28]] = temp_28;
    // outputs[__id[28]] = temp_28;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[2])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[2]] = temp_2;
    // outputs[__id[2]] = temp_2;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[18])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[18]] = temp_18;
    // outputs[__id[18]] = temp_18;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[10])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[10]] = temp_10;
    // outputs[__id[10]] = temp_10;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[26])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[26]] = temp_26;
    // outputs[__id[26]] = temp_26;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[6])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[6]] = temp_6;
    // outputs[__id[6]] = temp_6;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[22])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[22]] = temp_22;
    // outputs[__id[22]] = temp_22;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[14])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[14]] = temp_14;
    // outputs[__id[14]] = temp_14;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[30])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[30]] = temp_30;
    // outputs[__id[30]] = temp_30;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[1])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[1]] = temp_1;
    // outputs[__id[1]] = temp_1;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[17])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[17]] = temp_17;
    // outputs[__id[17]] = temp_17;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[9])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[9]] = temp_9;
    // outputs[__id[9]] = temp_9;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[25])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[25]] = temp_25;
    // outputs[__id[25]] = temp_25;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[5])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[5]] = temp_5;
    // outputs[__id[5]] = temp_5;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[21])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[21]] = temp_21;
    // outputs[__id[21]] = temp_21;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[13])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[13]] = temp_13;
    // outputs[__id[13]] = temp_13;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[29])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[29]] = temp_29;
    // outputs[__id[29]] = temp_29;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[3])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[3]] = temp_3;
    // outputs[__id[3]] = temp_3;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[19])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[19]] = temp_19;
    // outputs[__id[19]] = temp_19;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[11])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[11]] = temp_11;
    // outputs[__id[11]] = temp_11;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[27])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[27]] = temp_27;
    // outputs[__id[27]] = temp_27;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[7])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[7]] = temp_7;
    // outputs[__id[7]] = temp_7;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[23])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[23]] = temp_23;
    // outputs[__id[23]] = temp_23;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[15])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[15]] = temp_15;
    // outputs[__id[15]] = temp_15;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 8) * (__id[31])) / (float)(536870912), tmp_angle);
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    outputs[(tx + bx * 8) + 524288 * __id[31]] = temp_31;
    // outputs[__id[31]] = temp_31;
    
    }
