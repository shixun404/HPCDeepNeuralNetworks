extern __shared__ float shared[];
        
    __global__ void __launch_bounds__(32) fft_radix2_logN8(float2* inputs, float2* outputs, float2* r_2) {
    
    // r_1 = constData;
    // float2* r_1 = r_2 + 256 * (blockIdx.x % 1);
    float2* r_1 = r_2;
    float2 r[3];
    r[0].x = 1.0f;
    r[0].y = 0.0f;
    r[1].x = -0.5f;
    r[1].y = -0.8660253882408142f;
    r[2].x = -0.5f;
    r[2].y = 0.8660253882408142f;
    int tid = threadIdx.x + threadIdx.y * blockDim.x;
    float2 mem_checksum, mem_checksum_t1;
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
        int N = 256;
        int __id[8];
        float2 tmp;
        float2 tmp_angle, tmp_angle_rot;
        int j;
        int k;
        int tmp_id;
        int n = 1, n_global = 1;
        float2 tmp_angle_bk;
        
        #if FT==2
        float4 tmp_r;
        
        tmp_r = *(float4*)(((float*)r_1) + tid * 16 + 0 * 4);
        *(float4*)(((float*)sdata) + tid * 16 + 0 * 4) = tmp_r;
        // if(bx == 0)printf("%d, hello\n", tid);
        
        tmp_r = *(float4*)(((float*)r_1) + tid * 16 + 1 * 4);
        *(float4*)(((float*)sdata) + tid * 16 + 1 * 4) = tmp_r;
        // if(bx == 0)printf("%d, hello\n", tid);
        
        tmp_r = *(float4*)(((float*)r_1) + tid * 16 + 2 * 4);
        *(float4*)(((float*)sdata) + tid * 16 + 2 * 4) = tmp_r;
        // if(bx == 0)printf("%d, hello\n", tid);
        
        tmp_r = *(float4*)(((float*)r_1) + tid * 16 + 3 * 4);
        *(float4*)(((float*)sdata) + tid * 16 + 3 * 4) = tmp_r;
        // if(bx == 0)printf("%d, hello\n", tid);
        
        #endif
        
        temp_0 = inputs[(ty + 0 * 32) + (tx + bx * 1) * 256];
        temp_1 = inputs[(ty + 1 * 32) + (tx + bx * 1) * 256];
        temp_2 = inputs[(ty + 2 * 32) + (tx + bx * 1) * 256];
        temp_3 = inputs[(ty + 3 * 32) + (tx + bx * 1) * 256];
        temp_4 = inputs[(ty + 4 * 32) + (tx + bx * 1) * 256];
        temp_5 = inputs[(ty + 5 * 32) + (tx + bx * 1) * 256];
        temp_6 = inputs[(ty + 6 * 32) + (tx + bx * 1) * 256];
        temp_7 = inputs[(ty + 7 * 32) + (tx + bx * 1) * 256];
        
        __id[0] = 0 + ty;
        __id[1] = 32 + ty;
        __id[2] = 64 + ty;
        __id[3] = 96 + ty;
        __id[4] = 128 + ty;
        __id[5] = 160 + ty;
        __id[6] = 192 + ty;
        __id[7] = 224 + ty;
        
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
        
        __syncthreads();
        
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 0) / (float)(256), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 1) / (float)(256), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 2) / (float)(256), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 3) / (float)(256), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 4) / (float)(256), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 5) / (float)(256), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 6) / (float)(256), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 7) / (float)(256), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
        sdata[((tx + 1 * __id[0]) / 16) * 17 + 
        ((tx + 1 * __id[0]) % 16)] = temp_0;
        
        sdata[((tx + 1 * __id[4]) / 16) * 17 + 
        ((tx + 1 * __id[4]) % 16)] = temp_4;
        
        sdata[((tx + 1 * __id[2]) / 16) * 17 + 
        ((tx + 1 * __id[2]) % 16)] = temp_2;
        
        sdata[((tx + 1 * __id[6]) / 16) * 17 + 
        ((tx + 1 * __id[6]) % 16)] = temp_6;
        
        sdata[((tx + 1 * __id[1]) / 16) * 17 + 
        ((tx + 1 * __id[1]) % 16)] = temp_1;
        
        sdata[((tx + 1 * __id[5]) / 16) * 17 + 
        ((tx + 1 * __id[5]) % 16)] = temp_5;
        
        sdata[((tx + 1 * __id[3]) / 16) * 17 + 
        ((tx + 1 * __id[3]) % 16)] = temp_3;
        
        sdata[((tx + 1 * __id[7]) / 16) * 17 + 
        ((tx + 1 * __id[7]) % 16)] = temp_7;
        
        __syncthreads();		
        
        temp_0 = sdata[((tx + 1 * (0 + ty)) / 16) * 17 +
                            ((tx + 1 * (0 + ty)) % 16)];
        __id[0] = ty + 0;
        
        temp_1 = sdata[((tx + 1 * (32 + ty)) / 16) * 17 +
                            ((tx + 1 * (32 + ty)) % 16)];
        __id[1] = ty + 32;
        
        temp_2 = sdata[((tx + 1 * (64 + ty)) / 16) * 17 +
                            ((tx + 1 * (64 + ty)) % 16)];
        __id[2] = ty + 64;
        
        temp_3 = sdata[((tx + 1 * (96 + ty)) / 16) * 17 +
                            ((tx + 1 * (96 + ty)) % 16)];
        __id[3] = ty + 96;
        
        temp_4 = sdata[((tx + 1 * (128 + ty)) / 16) * 17 +
                            ((tx + 1 * (128 + ty)) % 16)];
        __id[4] = ty + 128;
        
        temp_5 = sdata[((tx + 1 * (160 + ty)) / 16) * 17 +
                            ((tx + 1 * (160 + ty)) % 16)];
        __id[5] = ty + 160;
        
        temp_6 = sdata[((tx + 1 * (192 + ty)) / 16) * 17 +
                            ((tx + 1 * (192 + ty)) % 16)];
        __id[6] = ty + 192;
        
        temp_7 = sdata[((tx + 1 * (224 + ty)) / 16) * 17 +
                            ((tx + 1 * (224 + ty)) % 16)];
        __id[7] = ty + 224;
        
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
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
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
        MY_ANGLE2COMPLEX((float)(j * k) * -0.7853981633974483f, tmp_angle);
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
        
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 0) / (float)(32.0), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 1) / (float)(32.0), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 2) / (float)(32.0), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 3) / (float)(32.0), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 4) / (float)(32.0), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 5) / (float)(32.0), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 6) / (float)(32.0), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 8) * 7) / (float)(32.0), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
        sdata[((tx + 1 * __id[0]) / 16) * 17 + 
        ((tx + 1 * __id[0]) % 16)] = temp_0;
        
        sdata[((tx + 1 * __id[4]) / 16) * 17 + 
        ((tx + 1 * __id[4]) % 16)] = temp_4;
        
        sdata[((tx + 1 * __id[2]) / 16) * 17 + 
        ((tx + 1 * __id[2]) % 16)] = temp_2;
        
        sdata[((tx + 1 * __id[6]) / 16) * 17 + 
        ((tx + 1 * __id[6]) % 16)] = temp_6;
        
        sdata[((tx + 1 * __id[1]) / 16) * 17 + 
        ((tx + 1 * __id[1]) % 16)] = temp_1;
        
        sdata[((tx + 1 * __id[5]) / 16) * 17 + 
        ((tx + 1 * __id[5]) % 16)] = temp_5;
        
        sdata[((tx + 1 * __id[3]) / 16) * 17 + 
        ((tx + 1 * __id[3]) % 16)] = temp_3;
        
        sdata[((tx + 1 * __id[7]) / 16) * 17 + 
        ((tx + 1 * __id[7]) % 16)] = temp_7;
        
        __syncthreads();		
        
        temp_0 = sdata[((tx + 1 * (0 + ty)) / 16) * 17 +
                            ((tx + 1 * (0 + ty)) % 16)];
        __id[0] = ty + 0;
        
        temp_1 = sdata[((tx + 1 * (32 + ty)) / 16) * 17 +
                            ((tx + 1 * (32 + ty)) % 16)];
        __id[1] = ty + 32;
        
        temp_2 = sdata[((tx + 1 * (64 + ty)) / 16) * 17 +
                            ((tx + 1 * (64 + ty)) % 16)];
        __id[2] = ty + 64;
        
        temp_3 = sdata[((tx + 1 * (96 + ty)) / 16) * 17 +
                            ((tx + 1 * (96 + ty)) % 16)];
        __id[3] = ty + 96;
        
        temp_4 = sdata[((tx + 1 * (128 + ty)) / 16) * 17 +
                            ((tx + 1 * (128 + ty)) % 16)];
        __id[4] = ty + 128;
        
        temp_5 = sdata[((tx + 1 * (160 + ty)) / 16) * 17 +
                            ((tx + 1 * (160 + ty)) % 16)];
        __id[5] = ty + 160;
        
        temp_6 = sdata[((tx + 1 * (192 + ty)) / 16) * 17 +
                            ((tx + 1 * (192 + ty)) % 16)];
        __id[6] = ty + 192;
        
        temp_7 = sdata[((tx + 1 * (224 + ty)) / 16) * 17 +
                            ((tx + 1 * (224 + ty)) % 16)];
        __id[7] = ty + 224;
        
        j = 1;
        k = 2 % 1;
        MY_ANGLE2COMPLEX((float)(j * k) * -3.141592653589793f, tmp_angle);
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
            
            MY_MUL(temp_6, tmp_angle, tmp);
            temp_6 = tmp;
            
                    tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_7, tmp_angle, tmp);
            temp_7 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_4, temp_0);
            MY_SUB(tmp, temp_4, temp_4);
            
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[4] = tmp_id + 64;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_6, temp_2);
            MY_SUB(tmp, temp_6, temp_6);
            
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[6] = tmp_id + 64;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_5, temp_1);
            MY_SUB(tmp, temp_5, temp_5);
            
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[5] = tmp_id + 64;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_7, temp_3);
            MY_SUB(tmp, temp_7, temp_7);
            
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[7] = tmp_id + 64;
            
        n_global *= 2;
        
        j = 1;
        k = 2 % 2;
        MY_ANGLE2COMPLEX((float)(j * k) * -1.5707963267948966f, tmp_angle);
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
            
                    tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
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
        
        n_global *= 2;
        
                #if FT==2
                mem_checksum.x = 0;
                mem_checksum.y = 0;
                int r_id;
        
                r_id = __id[0] % 3;
                mem_checksum.x += temp_0.x * r[r_id].x - temp_0.y * r[r_id].y;
                mem_checksum.y += temp_0.y * r[r_id].x + temp_0.x * r[r_id].y;
        
                r_id = __id[1] % 3;
                mem_checksum.x += temp_1.x * r[r_id].x - temp_1.y * r[r_id].y;
                mem_checksum.y += temp_1.y * r[r_id].x + temp_1.x * r[r_id].y;
        
                r_id = __id[4] % 3;
                mem_checksum.x += temp_4.x * r[r_id].x - temp_4.y * r[r_id].y;
                mem_checksum.y += temp_4.y * r[r_id].x + temp_4.x * r[r_id].y;
        
                r_id = __id[5] % 3;
                mem_checksum.x += temp_5.x * r[r_id].x - temp_5.y * r[r_id].y;
                mem_checksum.y += temp_5.y * r[r_id].x + temp_5.x * r[r_id].y;
        
                r_id = __id[2] % 3;
                mem_checksum.x += temp_2.x * r[r_id].x - temp_2.y * r[r_id].y;
                mem_checksum.y += temp_2.y * r[r_id].x + temp_2.x * r[r_id].y;
        
                r_id = __id[3] % 3;
                mem_checksum.x += temp_3.x * r[r_id].x - temp_3.y * r[r_id].y;
                mem_checksum.y += temp_3.y * r[r_id].x + temp_3.x * r[r_id].y;
        
                r_id = __id[6] % 3;
                mem_checksum.x += temp_6.x * r[r_id].x - temp_6.y * r[r_id].y;
                mem_checksum.y += temp_6.y * r[r_id].x + temp_6.x * r[r_id].y;
        
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
                // if(tid % 32 == 0){
                    mem_checksum.x  = mem_checksum.y;
                    mem_checksum.y = mem_checksum.y - mem_checksum_t1.y;
                //     sdata[tid / 32] = mem_checksum;
                // }
                // __syncthreads();
                // mem_checksum.x = 0;
                // mem_checksum.y = 0;
                
                temp_0.x += 0.1f * (mem_checksum.x);
                temp_0.y += 0.1f * (mem_checksum.y);
                
                #endif
                #if defined(LOG_ON)
                if(tid == 0 && bx < 128)printf("up2 %f, %f, %f\n", mem_checksum.x, mem_checksum.y, mem_checksum.y / mem_checksum.x);
                #endif
                
        outputs[(tx + bx * 1) * 256 +  __id[0]] = temp_0;
        
        outputs[(tx + bx * 1) * 256 +  __id[1]] = temp_1;
        
        outputs[(tx + bx * 1) * 256 +  __id[4]] = temp_4;
        
        outputs[(tx + bx * 1) * 256 +  __id[5]] = temp_5;
        
        outputs[(tx + bx * 1) * 256 +  __id[2]] = temp_2;
        
        outputs[(tx + bx * 1) * 256 +  __id[3]] = temp_3;
        
        outputs[(tx + bx * 1) * 256 +  __id[6]] = temp_6;
        
        outputs[(tx + bx * 1) * 256 +  __id[7]] = temp_7;
        
        }
    