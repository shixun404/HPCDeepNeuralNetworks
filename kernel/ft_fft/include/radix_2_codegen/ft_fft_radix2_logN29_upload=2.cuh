extern __shared__ float shared[];
__global__ void __launch_bounds__(1024) fft_radix2_logN29_2(float2* inputs, float2* outputs, float2* r_1) {

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
    int N = 512;
    int __id[8];
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
    float2 tmp_angle_bk;
    int tid = tx + ty * blockDim.x;
    float2 mem_checksum ,mem_checksum_t1;
    float2 warp_checksum;
    float2 warp_checksum_;
    
    #if FT==2
    float1 tmp_r;
    tmp_r = *(float1*)(((float*)r_1) + tid * 1);
    *(float1*)(((float*)sdata) + tid * 1) = tmp_r;
    // if(bx == 0)printf("%d, hello\n", tid);
    #endif
    
    temp_0 = inputs[tx + (bx % 64) * 16 + (ty * 1024 + 0) + (bx / 64) * 524288];
    temp_1 = inputs[tx + (bx % 64) * 16 + (ty * 1024 + 65536) + (bx / 64) * 524288];
    temp_2 = inputs[tx + (bx % 64) * 16 + (ty * 1024 + 131072) + (bx / 64) * 524288];
    temp_3 = inputs[tx + (bx % 64) * 16 + (ty * 1024 + 196608) + (bx / 64) * 524288];
    temp_4 = inputs[tx + (bx % 64) * 16 + (ty * 1024 + 262144) + (bx / 64) * 524288];
    temp_5 = inputs[tx + (bx % 64) * 16 + (ty * 1024 + 327680) + (bx / 64) * 524288];
    temp_6 = inputs[tx + (bx % 64) * 16 + (ty * 1024 + 393216) + (bx / 64) * 524288];
    temp_7 = inputs[tx + (bx % 64) * 16 + (ty * 1024 + 458752) + (bx / 64) * 524288];
    __id[0] = 0 + ty;
    __id[1] = 64 + ty;
    __id[2] = 128 + ty;
    __id[3] = 192 + ty;
    __id[4] = 256 + ty;
    __id[5] = 320 + ty;
    __id[6] = 384 + ty;
    __id[7] = 448 + ty;
    
    #if FT==2
    mem_checksum.x = 0;
    mem_checksum.y = 0;
    mem_checksum_t1.x = 0;
    mem_checksum_t1.y = 0;
    __syncthreads();
    
        // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[0], sdata[__id[0]].x, sdata[__id[0]].y);
        mem_checksum.x += sdata[__id[0]].x * temp_0.x - sdata[__id[0]].y * temp_0.y;
        mem_checksum.y += sdata[__id[0]].y * temp_0.x + sdata[__id[0]].x * temp_0.y;
    
        // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[1], sdata[__id[1]].x, sdata[__id[1]].y);
        mem_checksum.x += sdata[__id[1]].x * temp_1.x - sdata[__id[1]].y * temp_1.y;
        mem_checksum.y += sdata[__id[1]].y * temp_1.x + sdata[__id[1]].x * temp_1.y;
    
        // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[2], sdata[__id[2]].x, sdata[__id[2]].y);
        mem_checksum.x += sdata[__id[2]].x * temp_2.x - sdata[__id[2]].y * temp_2.y;
        mem_checksum.y += sdata[__id[2]].y * temp_2.x + sdata[__id[2]].x * temp_2.y;
    
        // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[3], sdata[__id[3]].x, sdata[__id[3]].y);
        mem_checksum.x += sdata[__id[3]].x * temp_3.x - sdata[__id[3]].y * temp_3.y;
        mem_checksum.y += sdata[__id[3]].y * temp_3.x + sdata[__id[3]].x * temp_3.y;
    
        // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[4], sdata[__id[4]].x, sdata[__id[4]].y);
        mem_checksum.x += sdata[__id[4]].x * temp_4.x - sdata[__id[4]].y * temp_4.y;
        mem_checksum.y += sdata[__id[4]].y * temp_4.x + sdata[__id[4]].x * temp_4.y;
    
        // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[5], sdata[__id[5]].x, sdata[__id[5]].y);
        mem_checksum.x += sdata[__id[5]].x * temp_5.x - sdata[__id[5]].y * temp_5.y;
        mem_checksum.y += sdata[__id[5]].y * temp_5.x + sdata[__id[5]].x * temp_5.y;
    
        // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[6], sdata[__id[6]].x, sdata[__id[6]].y);
        mem_checksum.x += sdata[__id[6]].x * temp_6.x - sdata[__id[6]].y * temp_6.y;
        mem_checksum.y += sdata[__id[6]].y * temp_6.x + sdata[__id[6]].x * temp_6.y;
    
        // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[7], sdata[__id[7]].x, sdata[__id[7]].y);
        mem_checksum.x += sdata[__id[7]].x * temp_7.x - sdata[__id[7]].y * temp_7.y;
        mem_checksum.y += sdata[__id[7]].y * temp_7.x + sdata[__id[7]].x * temp_7.y;
    
    // __syncthreads();
    // mem_checksum_t1.x = mem_checksum.x; 
    mem_checksum_t1.y = mem_checksum.y + mem_checksum.x; 
    // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 16,32);
    // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 8, 32);
    // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 4, 32);
    // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 2, 32);
    // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 1, 32);
    
    mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 16,32);
    mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
    mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
    mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
    mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
    #endif
    
            #if FT==1
            warp_checksum.x = 0;
            warp_checksum.y = 0;
        
                        warp_checksum.x += temp_0.x * A_radix8_0_x - temp_0.y * A_radix8_0_y;
                        warp_checksum.y += temp_0.x * A_radix8_0_y + temp_0.y * A_radix8_0_x;
        
                        warp_checksum.x += temp_1.x * A_radix8_1_x - temp_1.y * A_radix8_1_y;
                        warp_checksum.y += temp_1.x * A_radix8_1_y + temp_1.y * A_radix8_1_x;
        
                        warp_checksum.x += temp_2.x * A_radix8_2_x - temp_2.y * A_radix8_2_y;
                        warp_checksum.y += temp_2.x * A_radix8_2_y + temp_2.y * A_radix8_2_x;
        
                        warp_checksum.x += temp_3.x * A_radix8_3_x - temp_3.y * A_radix8_3_y;
                        warp_checksum.y += temp_3.x * A_radix8_3_y + temp_3.y * A_radix8_3_x;
        
                        warp_checksum.x += temp_4.x * A_radix8_4_x - temp_4.y * A_radix8_4_y;
                        warp_checksum.y += temp_4.x * A_radix8_4_y + temp_4.y * A_radix8_4_x;
        
                        warp_checksum.x += temp_5.x * A_radix8_5_x - temp_5.y * A_radix8_5_y;
                        warp_checksum.y += temp_5.x * A_radix8_5_y + temp_5.y * A_radix8_5_x;
        
                        warp_checksum.x += temp_6.x * A_radix8_6_x - temp_6.y * A_radix8_6_y;
                        warp_checksum.y += temp_6.x * A_radix8_6_y + temp_6.y * A_radix8_6_x;
        
                        warp_checksum.x += temp_7.x * A_radix8_7_x - temp_7.y * A_radix8_7_y;
                        warp_checksum.y += temp_7.x * A_radix8_7_y + temp_7.y * A_radix8_7_x;
        
            #endif    
        
    j = 1;
    k = 4 % 1;
    MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
    MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
    MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
        // tmp.x = 1;
        // tmp.y = 1;
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
    
            #if FT == 1
            warp_checksum_ = warp_checksum;
            
                        warp_checksum.x -= temp_0.x * r[0].x - temp_0.y * r[0].y;
                        warp_checksum.y -= temp_0.x * r[0].y + temp_0.y * r[0].x;
                        // warp_checksum.x -= temp_0.x;
                        // warp_checksum.y -= temp_0.y;
            
                        warp_checksum.x -= temp_4.x * r[1].x - temp_4.y * r[1].y;
                        warp_checksum.y -= temp_4.x * r[1].y + temp_4.y * r[1].x;
                        // warp_checksum.x -= temp_4.x;
                        // warp_checksum.y -= temp_4.y;
            
                        warp_checksum.x -= temp_2.x * r[2].x - temp_2.y * r[2].y;
                        warp_checksum.y -= temp_2.x * r[2].y + temp_2.y * r[2].x;
                        // warp_checksum.x -= temp_2.x;
                        // warp_checksum.y -= temp_2.y;
            
                        warp_checksum.x -= temp_6.x * r[0].x - temp_6.y * r[0].y;
                        warp_checksum.y -= temp_6.x * r[0].y + temp_6.y * r[0].x;
                        // warp_checksum.x -= temp_6.x;
                        // warp_checksum.y -= temp_6.y;
            
                        warp_checksum.x -= temp_1.x * r[1].x - temp_1.y * r[1].y;
                        warp_checksum.y -= temp_1.x * r[1].y + temp_1.y * r[1].x;
                        // warp_checksum.x -= temp_1.x;
                        // warp_checksum.y -= temp_1.y;
            
                        warp_checksum.x -= temp_5.x * r[2].x - temp_5.y * r[2].y;
                        warp_checksum.y -= temp_5.x * r[2].y + temp_5.y * r[2].x;
                        // warp_checksum.x -= temp_5.x;
                        // warp_checksum.y -= temp_5.y;
            
                        warp_checksum.x -= temp_3.x * r[0].x - temp_3.y * r[0].y;
                        warp_checksum.y -= temp_3.x * r[0].y + temp_3.y * r[0].x;
                        // warp_checksum.x -= temp_3.x;
                        // warp_checksum.y -= temp_3.y;
            
                        warp_checksum.x -= temp_7.x * r[1].x - temp_7.y * r[1].y;
                        warp_checksum.y -= temp_7.x * r[1].y + temp_7.y * r[1].x;
                        // warp_checksum.x -= temp_7.x;
                        // warp_checksum.y -= temp_7.y;
            
            
            temp_0.x += warp_checksum.x;
            temp_0.y += warp_checksum.y;
            #endif
            
    __syncthreads();
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 0) / (float)(512), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 1) / (float)(512), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 2) / (float)(512), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 3) / (float)(512), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 4) / (float)(512), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 5) / (float)(512), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 6) / (float)(512), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 7) / (float)(512), tmp_angle);
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
    
    temp_1 = sdata[tx + 16 * (64 + ty)];
    __id[1] = ty + 64;
    
    temp_2 = sdata[tx + 16 * (128 + ty)];
    __id[2] = ty + 128;
    
    temp_3 = sdata[tx + 16 * (192 + ty)];
    __id[3] = ty + 192;
    
    temp_4 = sdata[tx + 16 * (256 + ty)];
    __id[4] = ty + 256;
    
    temp_5 = sdata[tx + 16 * (320 + ty)];
    __id[5] = ty + 320;
    
    temp_6 = sdata[tx + 16 * (384 + ty)];
    __id[6] = ty + 384;
    
    temp_7 = sdata[tx + 16 * (448 + ty)];
    __id[7] = ty + 448;
    
            #if FT==1
            warp_checksum.x = 0;
            warp_checksum.y = 0;
        
                        warp_checksum.x += temp_0.x * A_radix8_0_x - temp_0.y * A_radix8_0_y;
                        warp_checksum.y += temp_0.x * A_radix8_0_y + temp_0.y * A_radix8_0_x;
        
                        warp_checksum.x += temp_1.x * A_radix8_1_x - temp_1.y * A_radix8_1_y;
                        warp_checksum.y += temp_1.x * A_radix8_1_y + temp_1.y * A_radix8_1_x;
        
                        warp_checksum.x += temp_2.x * A_radix8_2_x - temp_2.y * A_radix8_2_y;
                        warp_checksum.y += temp_2.x * A_radix8_2_y + temp_2.y * A_radix8_2_x;
        
                        warp_checksum.x += temp_3.x * A_radix8_3_x - temp_3.y * A_radix8_3_y;
                        warp_checksum.y += temp_3.x * A_radix8_3_y + temp_3.y * A_radix8_3_x;
        
                        warp_checksum.x += temp_4.x * A_radix8_4_x - temp_4.y * A_radix8_4_y;
                        warp_checksum.y += temp_4.x * A_radix8_4_y + temp_4.y * A_radix8_4_x;
        
                        warp_checksum.x += temp_5.x * A_radix8_5_x - temp_5.y * A_radix8_5_y;
                        warp_checksum.y += temp_5.x * A_radix8_5_y + temp_5.y * A_radix8_5_x;
        
                        warp_checksum.x += temp_6.x * A_radix8_6_x - temp_6.y * A_radix8_6_y;
                        warp_checksum.y += temp_6.x * A_radix8_6_y + temp_6.y * A_radix8_6_x;
        
                        warp_checksum.x += temp_7.x * A_radix8_7_x - temp_7.y * A_radix8_7_y;
                        warp_checksum.y += temp_7.x * A_radix8_7_y + temp_7.y * A_radix8_7_x;
        
            #endif    
        
    j = 1;
    k = 4 % 1;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.39269908169872414f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
    MY_ANGLE2COMPLEX((float)(j * k) * -0.19634954084936207f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
    MY_ANGLE2COMPLEX((float)(j * k) * -0.09817477042468103f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
        // tmp.x = 1;
        // tmp.y = 1;
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
    
            #if FT == 1
            warp_checksum_ = warp_checksum;
            
                        warp_checksum.x -= temp_0.x * r[0].x - temp_0.y * r[0].y;
                        warp_checksum.y -= temp_0.x * r[0].y + temp_0.y * r[0].x;
                        // warp_checksum.x -= temp_0.x;
                        // warp_checksum.y -= temp_0.y;
            
                        warp_checksum.x -= temp_4.x * r[1].x - temp_4.y * r[1].y;
                        warp_checksum.y -= temp_4.x * r[1].y + temp_4.y * r[1].x;
                        // warp_checksum.x -= temp_4.x;
                        // warp_checksum.y -= temp_4.y;
            
                        warp_checksum.x -= temp_2.x * r[2].x - temp_2.y * r[2].y;
                        warp_checksum.y -= temp_2.x * r[2].y + temp_2.y * r[2].x;
                        // warp_checksum.x -= temp_2.x;
                        // warp_checksum.y -= temp_2.y;
            
                        warp_checksum.x -= temp_6.x * r[0].x - temp_6.y * r[0].y;
                        warp_checksum.y -= temp_6.x * r[0].y + temp_6.y * r[0].x;
                        // warp_checksum.x -= temp_6.x;
                        // warp_checksum.y -= temp_6.y;
            
                        warp_checksum.x -= temp_1.x * r[1].x - temp_1.y * r[1].y;
                        warp_checksum.y -= temp_1.x * r[1].y + temp_1.y * r[1].x;
                        // warp_checksum.x -= temp_1.x;
                        // warp_checksum.y -= temp_1.y;
            
                        warp_checksum.x -= temp_5.x * r[2].x - temp_5.y * r[2].y;
                        warp_checksum.y -= temp_5.x * r[2].y + temp_5.y * r[2].x;
                        // warp_checksum.x -= temp_5.x;
                        // warp_checksum.y -= temp_5.y;
            
                        warp_checksum.x -= temp_3.x * r[0].x - temp_3.y * r[0].y;
                        warp_checksum.y -= temp_3.x * r[0].y + temp_3.y * r[0].x;
                        // warp_checksum.x -= temp_3.x;
                        // warp_checksum.y -= temp_3.y;
            
                        warp_checksum.x -= temp_7.x * r[1].x - temp_7.y * r[1].y;
                        warp_checksum.y -= temp_7.x * r[1].y + temp_7.y * r[1].x;
                        // warp_checksum.x -= temp_7.x;
                        // warp_checksum.y -= temp_7.y;
            
            
            temp_0.x += warp_checksum.x;
            temp_0.y += warp_checksum.y;
            #endif
            
    __syncthreads();
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 0) / (float)(64.0), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 1) / (float)(64.0), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 2) / (float)(64.0), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 3) / (float)(64.0), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 4) / (float)(64.0), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 5) / (float)(64.0), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 6) / (float)(64.0), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 7) / (float)(64.0), tmp_angle);
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
    
    temp_1 = sdata[tx + 16 * (64 + ty)];
    __id[1] = ty + 64;
    
    temp_2 = sdata[tx + 16 * (128 + ty)];
    __id[2] = ty + 128;
    
    temp_3 = sdata[tx + 16 * (192 + ty)];
    __id[3] = ty + 192;
    
    temp_4 = sdata[tx + 16 * (256 + ty)];
    __id[4] = ty + 256;
    
    temp_5 = sdata[tx + 16 * (320 + ty)];
    __id[5] = ty + 320;
    
    temp_6 = sdata[tx + 16 * (384 + ty)];
    __id[6] = ty + 384;
    
    temp_7 = sdata[tx + 16 * (448 + ty)];
    __id[7] = ty + 448;
    
            #if FT==1
            warp_checksum.x = 0;
            warp_checksum.y = 0;
        
                        warp_checksum.x += temp_0.x * A_radix8_0_x - temp_0.y * A_radix8_0_y;
                        warp_checksum.y += temp_0.x * A_radix8_0_y + temp_0.y * A_radix8_0_x;
        
                        warp_checksum.x += temp_1.x * A_radix8_1_x - temp_1.y * A_radix8_1_y;
                        warp_checksum.y += temp_1.x * A_radix8_1_y + temp_1.y * A_radix8_1_x;
        
                        warp_checksum.x += temp_2.x * A_radix8_2_x - temp_2.y * A_radix8_2_y;
                        warp_checksum.y += temp_2.x * A_radix8_2_y + temp_2.y * A_radix8_2_x;
        
                        warp_checksum.x += temp_3.x * A_radix8_3_x - temp_3.y * A_radix8_3_y;
                        warp_checksum.y += temp_3.x * A_radix8_3_y + temp_3.y * A_radix8_3_x;
        
                        warp_checksum.x += temp_4.x * A_radix8_4_x - temp_4.y * A_radix8_4_y;
                        warp_checksum.y += temp_4.x * A_radix8_4_y + temp_4.y * A_radix8_4_x;
        
                        warp_checksum.x += temp_5.x * A_radix8_5_x - temp_5.y * A_radix8_5_y;
                        warp_checksum.y += temp_5.x * A_radix8_5_y + temp_5.y * A_radix8_5_x;
        
                        warp_checksum.x += temp_6.x * A_radix8_6_x - temp_6.y * A_radix8_6_y;
                        warp_checksum.y += temp_6.x * A_radix8_6_y + temp_6.y * A_radix8_6_x;
        
                        warp_checksum.x += temp_7.x * A_radix8_7_x - temp_7.y * A_radix8_7_y;
                        warp_checksum.y += temp_7.x * A_radix8_7_y + temp_7.y * A_radix8_7_x;
        
            #endif    
        
    j = 1;
    k = 4 % 1;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.04908738521234052f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
    
    j = 1;
    k = 4 % 2;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
        __id[2] = tmp_id + 128;
        
        tmp = temp_4;
        MY_ADD(tmp, temp_6, temp_4);
        MY_SUB(tmp, temp_6, temp_6);
        
        tmp_id = __id[4];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[4] = tmp_id;
        __id[6] = tmp_id + 128;
        
        tmp = temp_1;
        MY_ADD(tmp, temp_3, temp_1);
        MY_SUB(tmp, temp_3, temp_3);
        
        tmp_id = __id[1];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[1] = tmp_id;
        __id[3] = tmp_id + 128;
        
        tmp = temp_5;
        MY_ADD(tmp, temp_7, temp_5);
        MY_SUB(tmp, temp_7, temp_7);
        
        tmp_id = __id[5];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[5] = tmp_id;
        __id[7] = tmp_id + 128;
        
    n_global *= 2;
    
    j = 1;
    k = 4 % 4;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.01227184630308513f, tmp_angle);
    // tmp_angle.x = 1;
    // tmp_angle.y = 1;
    tmp_angle_bk = tmp_angle;
    
                    tmp_angle = tmp_angle_bk;
    
        tmp_angle_rot.x = 1.0f;
        tmp_angle_rot.y = 0.0f;
        MY_MUL(tmp_angle, tmp_angle_rot, tmp);
        // tmp.x = 1;
        // tmp.y = 1;
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
        // tmp.x = 1;
        // tmp.y = 1;
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
        __id[1] = tmp_id + 256;
        
        tmp = temp_4;
        MY_ADD(tmp, temp_5, temp_4);
        MY_SUB(tmp, temp_5, temp_5);
        
        tmp_id = __id[4];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[4] = tmp_id;
        __id[5] = tmp_id + 256;
        
        tmp = temp_2;
        MY_ADD(tmp, temp_3, temp_2);
        MY_SUB(tmp, temp_3, temp_3);
        
        tmp_id = __id[2];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[2] = tmp_id;
        __id[3] = tmp_id + 256;
        
        tmp = temp_6;
        MY_ADD(tmp, temp_7, temp_6);
        MY_SUB(tmp, temp_7, temp_7);
        
        tmp_id = __id[6];
        tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
        __id[6] = tmp_id;
        __id[7] = tmp_id + 256;
        
    n_global *= 2;
    
            #if FT == 1
            warp_checksum_ = warp_checksum;
            
                        warp_checksum.x -= temp_0.x * r[0].x - temp_0.y * r[0].y;
                        warp_checksum.y -= temp_0.x * r[0].y + temp_0.y * r[0].x;
                        // warp_checksum.x -= temp_0.x;
                        // warp_checksum.y -= temp_0.y;
            
                        warp_checksum.x -= temp_4.x * r[1].x - temp_4.y * r[1].y;
                        warp_checksum.y -= temp_4.x * r[1].y + temp_4.y * r[1].x;
                        // warp_checksum.x -= temp_4.x;
                        // warp_checksum.y -= temp_4.y;
            
                        warp_checksum.x -= temp_2.x * r[2].x - temp_2.y * r[2].y;
                        warp_checksum.y -= temp_2.x * r[2].y + temp_2.y * r[2].x;
                        // warp_checksum.x -= temp_2.x;
                        // warp_checksum.y -= temp_2.y;
            
                        warp_checksum.x -= temp_6.x * r[0].x - temp_6.y * r[0].y;
                        warp_checksum.y -= temp_6.x * r[0].y + temp_6.y * r[0].x;
                        // warp_checksum.x -= temp_6.x;
                        // warp_checksum.y -= temp_6.y;
            
                        warp_checksum.x -= temp_1.x * r[1].x - temp_1.y * r[1].y;
                        warp_checksum.y -= temp_1.x * r[1].y + temp_1.y * r[1].x;
                        // warp_checksum.x -= temp_1.x;
                        // warp_checksum.y -= temp_1.y;
            
                        warp_checksum.x -= temp_5.x * r[2].x - temp_5.y * r[2].y;
                        warp_checksum.y -= temp_5.x * r[2].y + temp_5.y * r[2].x;
                        // warp_checksum.x -= temp_5.x;
                        // warp_checksum.y -= temp_5.y;
            
                        warp_checksum.x -= temp_3.x * r[0].x - temp_3.y * r[0].y;
                        warp_checksum.y -= temp_3.x * r[0].y + temp_3.y * r[0].x;
                        // warp_checksum.x -= temp_3.x;
                        // warp_checksum.y -= temp_3.y;
            
                        warp_checksum.x -= temp_7.x * r[1].x - temp_7.y * r[1].y;
                        warp_checksum.y -= temp_7.x * r[1].y + temp_7.y * r[1].x;
                        // warp_checksum.x -= temp_7.x;
                        // warp_checksum.y -= temp_7.y;
            
            
            temp_0.x += warp_checksum.x;
            temp_0.y += warp_checksum.y;
            #endif
            
            #if FT==2
            __syncthreads();
            mem_checksum.x = 0;
            mem_checksum.y = 0;
            int r_id;
    
            r_id = __id[0] % 3;
            mem_checksum.x += temp_0.x * r[r_id].x - temp_0.y * r[r_id].y;
            mem_checksum.y += temp_0.y * r[r_id].x + temp_0.x * r[r_id].y;
    
            r_id = __id[4] % 3;
            mem_checksum.x += temp_4.x * r[r_id].x - temp_4.y * r[r_id].y;
            mem_checksum.y += temp_4.y * r[r_id].x + temp_4.x * r[r_id].y;
    
            r_id = __id[2] % 3;
            mem_checksum.x += temp_2.x * r[r_id].x - temp_2.y * r[r_id].y;
            mem_checksum.y += temp_2.y * r[r_id].x + temp_2.x * r[r_id].y;
    
            r_id = __id[6] % 3;
            mem_checksum.x += temp_6.x * r[r_id].x - temp_6.y * r[r_id].y;
            mem_checksum.y += temp_6.y * r[r_id].x + temp_6.x * r[r_id].y;
    
            r_id = __id[1] % 3;
            mem_checksum.x += temp_1.x * r[r_id].x - temp_1.y * r[r_id].y;
            mem_checksum.y += temp_1.y * r[r_id].x + temp_1.x * r[r_id].y;
    
            r_id = __id[5] % 3;
            mem_checksum.x += temp_5.x * r[r_id].x - temp_5.y * r[r_id].y;
            mem_checksum.y += temp_5.y * r[r_id].x + temp_5.x * r[r_id].y;
    
            r_id = __id[3] % 3;
            mem_checksum.x += temp_3.x * r[r_id].x - temp_3.y * r[r_id].y;
            mem_checksum.y += temp_3.y * r[r_id].x + temp_3.x * r[r_id].y;
    
            r_id = __id[7] % 3;
            mem_checksum.x += temp_7.x * r[r_id].x - temp_7.y * r[r_id].y;
            mem_checksum.y += temp_7.y * r[r_id].x + temp_7.x * r[r_id].y;
    
            mem_checksum.y = mem_checksum.y + mem_checksum.x;
            mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 16, 32);
            mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 8, 32);
            mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 4, 32);
            mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 2, 32);
            mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 1, 32);
            
            // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 16, 32);
            // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 8, 32);
            // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 4, 32);
            // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 2, 32);
            // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 1, 32);
            if(tid % 32 == 0){
                // mem_checksum.x  = mem_checksum.y;
                mem_checksum.y = mem_checksum.y - mem_checksum_t1.y;
                sdata[tid / 32] = mem_checksum;
            }
            __syncthreads();
            mem_checksum.x = 0;
            mem_checksum.y = 0;
            
            if(tid < 32)
            
            mem_checksum = sdata[tid];
            
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 16, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 16, 32);
        
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 8, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 8, 32);
        
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 4, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 4, 32);
        
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 2, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 2, 32);
        
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 1, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 1, 32);
        
            // if(mem_checksum.y > 1)printf("%f, %f, %f\n", temp_0.x, temp_0.y, mem_checksum.y );
            // if(tid == 0 && mem_checksum.y * mem_checksum.y / mem_checksum.x > 1)printf("up2 %f, %f, %f\n", mem_checksum.x, mem_checksum.y,mem_checksum.y * mem_checksum.y / mem_checksum.x);
            if(tid == 0 && bx < 128)printf("up2 %f, %f, %f\n", mem_checksum.x, mem_checksum.y,  mem_checksum.y / mem_checksum.x);
        
            temp_0.x += 0.1f * (mem_checksum.x);
            temp_0.y += 0.1f * (mem_checksum.y);
            // if(tid == 0 && blockIdx.x == 0)printf("%f, %f,%f, %f\n", temp_0.x, temp_0.y,mem_checksum_t1.x,mem_checksum_t1.y );
            #endif
            
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 1024) * (__id[0])) / (float)(524288), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    outputs[(tx + bx * 16) % 1024 + 1024 * __id[0] + ((tx + bx * 16) / 1024) * 512 * 1024] = temp_0;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 1024) * (__id[4])) / (float)(524288), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    outputs[(tx + bx * 16) % 1024 + 1024 * __id[4] + ((tx + bx * 16) / 1024) * 512 * 1024] = temp_4;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 1024) * (__id[2])) / (float)(524288), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    outputs[(tx + bx * 16) % 1024 + 1024 * __id[2] + ((tx + bx * 16) / 1024) * 512 * 1024] = temp_2;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 1024) * (__id[6])) / (float)(524288), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    outputs[(tx + bx * 16) % 1024 + 1024 * __id[6] + ((tx + bx * 16) / 1024) * 512 * 1024] = temp_6;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 1024) * (__id[1])) / (float)(524288), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    outputs[(tx + bx * 16) % 1024 + 1024 * __id[1] + ((tx + bx * 16) / 1024) * 512 * 1024] = temp_1;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 1024) * (__id[5])) / (float)(524288), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    outputs[(tx + bx * 16) % 1024 + 1024 * __id[5] + ((tx + bx * 16) / 1024) * 512 * 1024] = temp_5;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 1024) * (__id[3])) / (float)(524288), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    outputs[(tx + bx * 16) % 1024 + 1024 * __id[3] + ((tx + bx * 16) / 1024) * 512 * 1024] = temp_3;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx + bx * 16) % 1024) * (__id[7])) / (float)(524288), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    outputs[(tx + bx * 16) % 1024 + 1024 * __id[7] + ((tx + bx * 16) / 1024) * 512 * 1024] = temp_7;
    
    }
