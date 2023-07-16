extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_radix2_logN23_2(float2* inputs, float2* outputs) {

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
    int N = 128;
    int __id[8];
    float2 tmp;
    float2 tmp_angle, tmp_angle_rot;
    int j;
    int k;
    int tmp_id;
    int n = 1, n_global = 1;
    float2 tmp_angle_bk;
    
    temp_0 = inputs[tx + (bx % 16) * 16 + (ty * 256 + 0) + (bx / 16) * 32768];
    temp_1 = inputs[tx + (bx % 16) * 16 + (ty * 256 + 4096) + (bx / 16) * 32768];
    temp_2 = inputs[tx + (bx % 16) * 16 + (ty * 256 + 8192) + (bx / 16) * 32768];
    temp_3 = inputs[tx + (bx % 16) * 16 + (ty * 256 + 12288) + (bx / 16) * 32768];
    temp_4 = inputs[tx + (bx % 16) * 16 + (ty * 256 + 16384) + (bx / 16) * 32768];
    temp_5 = inputs[tx + (bx % 16) * 16 + (ty * 256 + 20480) + (bx / 16) * 32768];
    temp_6 = inputs[tx + (bx % 16) * 16 + (ty * 256 + 24576) + (bx / 16) * 32768];
    temp_7 = inputs[tx + (bx % 16) * 16 + (ty * 256 + 28672) + (bx / 16) * 32768];
    __id[0] = 0 + ty;
    __id[1] = 16 + ty;
    __id[2] = 32 + ty;
    __id[3] = 48 + ty;
    __id[4] = 64 + ty;
    __id[5] = 80 + ty;
    __id[6] = 96 + ty;
    __id[7] = 112 + ty;
    
    j = 1;
    k = 4 % 1;
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
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
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
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 0) / (float)(128), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 1) / (float)(128), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 2) / (float)(128), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 3) / (float)(128), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 4) / (float)(128), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 5) / (float)(128), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 6) / (float)(128), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 7) / (float)(128), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
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
    
    temp_1 = sdata[tx + 16 * (16 + ty)];
    __id[1] = ty + 16;
    
    temp_2 = sdata[tx + 16 * (32 + ty)];
    __id[2] = ty + 32;
    
    temp_3 = sdata[tx + 16 * (48 + ty)];
    __id[3] = ty + 48;
    
    temp_4 = sdata[tx + 16 * (64 + ty)];
    __id[4] = ty + 64;
    
    temp_5 = sdata[tx + 16 * (80 + ty)];
    __id[5] = ty + 80;
    
    temp_6 = sdata[tx + 16 * (96 + ty)];
    __id[6] = ty + 96;
    
    temp_7 = sdata[tx + 16 * (112 + ty)];
    __id[7] = ty + 112;
    
    j = 1;
    k = 4 % 1;
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
        
        MY_MUL(temp_1, tmp_angle, tmp);
        temp_1 = tmp;
        
        MY_MUL(temp_3, tmp_angle_rot, tmp);
        temp_3 = tmp;
        
        tmp_angle_rot.x = 0.7071067811865476f;
        tmp_angle_rot.y = -0.7071067811865475f;
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
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 0) / (float)(16.0), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 1) / (float)(16.0), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 2) / (float)(16.0), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 3) / (float)(16.0), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 4) / (float)(16.0), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 5) / (float)(16.0), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 6) / (float)(16.0), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 7) / (float)(16.0), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
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
    
    temp_1 = sdata[tx + 16 * (16 + ty)];
    __id[1] = ty + 16;
    
    temp_2 = sdata[tx + 16 * (32 + ty)];
    __id[2] = ty + 32;
    
    temp_3 = sdata[tx + 16 * (48 + ty)];
    __id[3] = ty + 48;
    
    temp_4 = sdata[tx + 16 * (64 + ty)];
    __id[4] = ty + 64;
    
    temp_5 = sdata[tx + 16 * (80 + ty)];
    __id[5] = ty + 80;
    
    temp_6 = sdata[tx + 16 * (96 + ty)];
    __id[6] = ty + 96;
    
    temp_7 = sdata[tx + 16 * (112 + ty)];
    __id[7] = ty + 112;
    
    j = 1;
    k = 1 % 1;
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
        
        MY_MUL(temp_4, tmp_angle, tmp);
        temp_4 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_5, tmp_angle, tmp);
        temp_5 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
        MY_MUL(temp_6, tmp_angle, tmp);
        temp_6 = tmp;
        
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        // MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        tmp.x = 1;
        tmp.y = 1;
        tmp_angle = tmp;
        tmp_angle_rot.x = tmp_angle.y;
        tmp_angle_rot.y = -tmp_angle.x;
        
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
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 256) * (__id[0])) / (float)(32768), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    outputs[(tx + bx * 16) % 256 + 256 * __id[0] + ((tx + bx * 16) / 256) * 128 * 256] = temp_0;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 256) * (__id[1])) / (float)(32768), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    outputs[(tx + bx * 16) % 256 + 256 * __id[1] + ((tx + bx * 16) / 256) * 128 * 256] = temp_1;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 256) * (__id[2])) / (float)(32768), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    outputs[(tx + bx * 16) % 256 + 256 * __id[2] + ((tx + bx * 16) / 256) * 128 * 256] = temp_2;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 256) * (__id[3])) / (float)(32768), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    outputs[(tx + bx * 16) % 256 + 256 * __id[3] + ((tx + bx * 16) / 256) * 128 * 256] = temp_3;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 256) * (__id[4])) / (float)(32768), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    outputs[(tx + bx * 16) % 256 + 256 * __id[4] + ((tx + bx * 16) / 256) * 128 * 256] = temp_4;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 256) * (__id[5])) / (float)(32768), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    outputs[(tx + bx * 16) % 256 + 256 * __id[5] + ((tx + bx * 16) / 256) * 128 * 256] = temp_5;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 256) * (__id[6])) / (float)(32768), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    outputs[(tx + bx * 16) % 256 + 256 * __id[6] + ((tx + bx * 16) / 256) * 128 * 256] = temp_6;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 256) * (__id[7])) / (float)(32768), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    outputs[(tx + bx * 16) % 256 + 256 * __id[7] + ((tx + bx * 16) / 256) * 128 * 256] = temp_7;
    
    }
