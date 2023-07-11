extern __shared__ float shared[];
__global__ void __launch_bounds__(128) fft_radix2_logN14_1(float2* inputs, float2* outputs) {

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
    int N = 64;
    int __id[8];
    float2 tmp;
    float2 tmp_angle, tmp_angle_rot;
    int j;
    int k;
    int tmp_id;
    int n = 1, n_global = 1;
    
    temp_0 = inputs[(ty + 0 * 8) * 256 + tx + bx * 16];
    temp_1 = inputs[(ty + 1 * 8) * 256 + tx + bx * 16];
    temp_2 = inputs[(ty + 2 * 8) * 256 + tx + bx * 16];
    temp_3 = inputs[(ty + 3 * 8) * 256 + tx + bx * 16];
    temp_4 = inputs[(ty + 4 * 8) * 256 + tx + bx * 16];
    temp_5 = inputs[(ty + 5 * 8) * 256 + tx + bx * 16];
    temp_6 = inputs[(ty + 6 * 8) * 256 + tx + bx * 16];
    temp_7 = inputs[(ty + 7 * 8) * 256 + tx + bx * 16];
    
    __id[0] = 0 + ty;
    __id[1] = 8 + ty;
    __id[2] = 16 + ty;
    __id[3] = 24 + ty;
    __id[4] = 32 + ty;
    __id[5] = 40 + ty;
    __id[6] = 48 + ty;
    __id[7] = 56 + ty;
    
    j = 1;
    k = __id[4] % 1;
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    
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
    MY_ADD_ft(tmp, temp_4, temp_0);
    MY_SUB_ft(tmp, temp_4, temp_4);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 1;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    MY_ADD_ft(tmp, temp_5, temp_1);
    MY_SUB_ft(tmp, temp_5, temp_5);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 1;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    MY_ADD_ft(tmp, temp_6, temp_2);
    MY_SUB_ft(tmp, temp_6, temp_6);
    
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 1;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    MY_ADD_ft(tmp, temp_7, temp_3);
    MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 1;
    
    n_global *= 2;
    
    j = 1;
    k = __id[2] % 2;
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    
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
    MY_ADD_ft(tmp, temp_2, temp_0);
    MY_SUB_ft(tmp, temp_2, temp_2);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 2;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    MY_ADD_ft(tmp, temp_6, temp_4);
    MY_SUB_ft(tmp, temp_6, temp_6);
    
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 2;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    MY_ADD_ft(tmp, temp_3, temp_1);
    MY_SUB_ft(tmp, temp_3, temp_3);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 2;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    MY_ADD_ft(tmp, temp_7, temp_5);
    MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 2;
    
    n_global *= 2;
    
    j = 1;
    k = __id[1] % 4;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    
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
    MY_ADD_ft(tmp, temp_1, temp_0);
    MY_SUB_ft(tmp, temp_1, temp_1);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[1] = tmp_id + 4;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    MY_ADD_ft(tmp, temp_5, temp_4);
    MY_SUB_ft(tmp, temp_5, temp_5);
    
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 4;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    MY_ADD_ft(tmp, temp_3, temp_2);
    MY_SUB_ft(tmp, temp_3, temp_3);
    
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 4;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    MY_ADD_ft(tmp, temp_7, temp_6);
    MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 4;
    
    n_global *= 2;
    
    
    sdata[tx + 16 * __id[0]] = temp_0;
    
    sdata[tx + 16 * __id[4]] = temp_4;
    
    sdata[tx + 16 * __id[2]] = temp_2;
    
    sdata[tx + 16 * __id[6]] = temp_6;
    
    sdata[tx + 16 * __id[1]] = temp_1;
    
    sdata[tx + 16 * __id[5]] = temp_5;
    
    sdata[tx + 16 * __id[3]] = temp_3;
    
    sdata[tx + 16 * __id[7]] = temp_7;
    
    __syncthreads();	
    
    temp_0 = sdata[tx + 16 * (0 + ty)];
    __id[0] = ty + 0;
    
    temp_1 = sdata[tx + 16 * (8 + ty)];
    __id[1] = ty + 8;
    
    temp_2 = sdata[tx + 16 * (16 + ty)];
    __id[2] = ty + 16;
    
    temp_3 = sdata[tx + 16 * (24 + ty)];
    __id[3] = ty + 24;
    
    temp_4 = sdata[tx + 16 * (32 + ty)];
    __id[4] = ty + 32;
    
    temp_5 = sdata[tx + 16 * (40 + ty)];
    __id[5] = ty + 40;
    
    temp_6 = sdata[tx + 16 * (48 + ty)];
    __id[6] = ty + 48;
    
    temp_7 = sdata[tx + 16 * (56 + ty)];
    __id[7] = ty + 56;
    
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
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    MY_ADD_ft(tmp, temp_4, temp_0);
    MY_SUB_ft(tmp, temp_4, temp_4);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 8;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    MY_ADD_ft(tmp, temp_5, temp_1);
    MY_SUB_ft(tmp, temp_5, temp_5);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 8;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    MY_ADD_ft(tmp, temp_6, temp_2);
    MY_SUB_ft(tmp, temp_6, temp_6);
    
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 8;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    MY_ADD_ft(tmp, temp_7, temp_3);
    MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 8;
    
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
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    MY_ADD_ft(tmp, temp_2, temp_0);
    MY_SUB_ft(tmp, temp_2, temp_2);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 16;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    MY_ADD_ft(tmp, temp_6, temp_4);
    MY_SUB_ft(tmp, temp_6, temp_6);
    
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 16;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    MY_ADD_ft(tmp, temp_3, temp_1);
    MY_SUB_ft(tmp, temp_3, temp_3);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 16;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    MY_ADD_ft(tmp, temp_7, temp_5);
    MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 16;
    
    n_global *= 2;
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("############ n_global %d ###########\n", n_global);
    #endif
    
    j = 1;
    k = __id[1] % 32;
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
    
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
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
    MY_ADD_ft(tmp, temp_1, temp_0);
    MY_SUB_ft(tmp, temp_1, temp_1);
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    MY_ADD_ft(tmp, temp_5, temp_4);
    MY_SUB_ft(tmp, temp_5, temp_5);
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    MY_ADD_ft(tmp, temp_3, temp_2);
    MY_SUB_ft(tmp, temp_3, temp_3);
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    MY_ADD_ft(tmp, temp_7, temp_6);
    MY_SUB_ft(tmp, temp_7, temp_7);
    
    n_global *= 2;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[0])) / (float)(16384), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    outputs[(tx + bx * 16) + 256 * __id[0]] = temp_0;
    // outputs[__id[0]] = temp_0;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[4])) / (float)(16384), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    outputs[(tx + bx * 16) + 256 * __id[4]] = temp_4;
    // outputs[__id[4]] = temp_4;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[2])) / (float)(16384), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    outputs[(tx + bx * 16) + 256 * __id[2]] = temp_2;
    // outputs[__id[2]] = temp_2;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[6])) / (float)(16384), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    outputs[(tx + bx * 16) + 256 * __id[6]] = temp_6;
    // outputs[__id[6]] = temp_6;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[1])) / (float)(16384), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    outputs[(tx + bx * 16) + 256 * __id[1]] = temp_1;
    // outputs[__id[1]] = temp_1;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[5])) / (float)(16384), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    outputs[(tx + bx * 16) + 256 * __id[5]] = temp_5;
    // outputs[__id[5]] = temp_5;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[3])) / (float)(16384), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    outputs[(tx + bx * 16) + 256 * __id[3]] = temp_3;
    // outputs[__id[3]] = temp_3;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[7])) / (float)(16384), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    outputs[(tx + bx * 16) + 256 * __id[7]] = temp_7;
    // outputs[__id[7]] = temp_7;
    
    }
