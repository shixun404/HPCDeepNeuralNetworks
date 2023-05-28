extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_radix2_logN23_3(float2* inputs, float2* outputs) {

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
    
    temp_0 = inputs[(tx + 0) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_1 = inputs[(tx + 16) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_2 = inputs[(tx + 32) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_3 = inputs[(tx + 48) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_4 = inputs[(tx + 64) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_5 = inputs[(tx + 80) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_6 = inputs[(tx + 96) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_7 = inputs[(tx + 112) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_8 = inputs[(tx + 128) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_9 = inputs[(tx + 144) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_10 = inputs[(tx + 160) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_11 = inputs[(tx + 176) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_12 = inputs[(tx + 192) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_13 = inputs[(tx + 208) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_14 = inputs[(tx + 224) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    temp_15 = inputs[(tx + 240) + (bx / 16) * 256 + (ty + (bx % 16) * 16) * 32768];
    #if defined(LOG_ON)
    printf("############ after read global bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 1;
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
    
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[8], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[15], j, k, j*k, n_global);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 2;
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
    
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle_rot, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle_rot, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 4;
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
    
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
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
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
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
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 8;
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
    
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
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
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[11], j, k, j*k, n_global);
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
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    printf("################### syncthreads ####################\n");
    #endif			
    
    temp_0 = sdata[tx + 0 + ty * 256];
    __id[0] = tx + 0;
    
    temp_1 = sdata[tx + 16 + ty * 256];
    __id[1] = tx + 16;
    
    temp_2 = sdata[tx + 32 + ty * 256];
    __id[2] = tx + 32;
    
    temp_3 = sdata[tx + 48 + ty * 256];
    __id[3] = tx + 48;
    
    temp_4 = sdata[tx + 64 + ty * 256];
    __id[4] = tx + 64;
    
    temp_5 = sdata[tx + 80 + ty * 256];
    __id[5] = tx + 80;
    
    temp_6 = sdata[tx + 96 + ty * 256];
    __id[6] = tx + 96;
    
    temp_7 = sdata[tx + 112 + ty * 256];
    __id[7] = tx + 112;
    
    temp_8 = sdata[tx + 128 + ty * 256];
    __id[8] = tx + 128;
    
    temp_9 = sdata[tx + 144 + ty * 256];
    __id[9] = tx + 144;
    
    temp_10 = sdata[tx + 160 + ty * 256];
    __id[10] = tx + 160;
    
    temp_11 = sdata[tx + 176 + ty * 256];
    __id[11] = tx + 176;
    
    temp_12 = sdata[tx + 192 + ty * 256];
    __id[12] = tx + 192;
    
    temp_13 = sdata[tx + 208 + ty * 256];
    __id[13] = tx + 208;
    
    temp_14 = sdata[tx + 224 + ty * 256];
    __id[14] = tx + 224;
    
    temp_15 = sdata[tx + 240 + ty * 256];
    __id[15] = tx + 240;
    
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[8] % 16;
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
    
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[8], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[15], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[4] % 32;
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
    
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[4], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_12, tmp_angle_rot, tmp);
    temp_12 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[12], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_13, tmp_angle_rot, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[7], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[2] % 64;
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
    
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[2], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[6], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[3], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[7], j, k, j*k, n_global);
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
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[10], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_14, tmp_angle_rot, tmp);
    temp_14 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[14], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[11], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d, rot_a.real %f,  rot_a.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
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
    #if defined(LOG_ON)
    printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 128;
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
    
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 8,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[1], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 12,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[3], j, k, j*k, n_global);
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
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 9,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[9], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 13,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[11], j, k, j*k, n_global);
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
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 10,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[5], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 14,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
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
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    #if defined(LOG_ON)
    printf("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\ntx %d, a.real %f,  a.imag %f,  local_id 11,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle.x, tmp_angle.y, __id[13], j, k, j*k, n_global);
    #endif
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    #if defined(LOG_ON)
    printf("tx %d,  a_rot.real %f,  a_rot.imag %f, local_id 15,  global_id %d, j %d, k %d, j * k %d, n_global %d, \n",
                        tx, tmp_angle_rot.x, tmp_angle_rot.y, __id[15], j, k, j*k, n_global);
    #endif
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    
    n_global *= 2;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 0 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[0]) * 32768] = temp_0;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 16 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[8]) * 32768] = temp_8;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 32 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[4]) * 32768] = temp_4;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 48 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[12]) * 32768] = temp_12;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 64 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[2]) * 32768] = temp_2;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 80 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[10]) * 32768] = temp_10;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 96 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[6]) * 32768] = temp_6;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 112 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[14]) * 32768] = temp_14;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 128 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[1]) * 32768] = temp_1;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 144 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[9]) * 32768] = temp_9;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 160 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[5]) * 32768] = temp_5;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 176 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[13]) * 32768] = temp_13;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 192 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[3]) * 32768] = temp_3;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 208 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[11]) * 32768] = temp_11;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 224 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[7]) * 32768] = temp_7;
    
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + 240 + ty * 32768 + (bx % 16) * 524288 + (bx / 16 * 256)]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\n", bx, tx, ty);
    outputs[(ty + (bx % 16) * 16) + (bx / 16) * 256 + (__id[15]) * 32768] = temp_15;
    
    }
