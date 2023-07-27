extern __shared__ float shared[];
    __global__ void __launch_bounds__(256) fft_radix2_logN16_2(float2* inputs, float2* outputs, float2* r_1) {
    
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
        int N = 512;
        int __id[32];
        float2 tmp;
        float2 tmp_angle, tmp_angle_rot;
        int j;
        int k;
        int tmp_id;
        int n = 1, n_global = 1;
        float2 tmp_angle_bk;
        
        #if FT==2
        float4 tmp_r;
        tmp_r = *(float4*)(((float*)r_1) + tid * 4);
        *(float4*)(((float*)sdata) + tid * 4) = tmp_r;
        // if(bx == 0)printf("%d, hello\n", tid);
        #endif
        
        temp_0 = inputs[(ty + 0 * 16) + (tx + bx * 16) * 512];
        temp_1 = inputs[(ty + 1 * 16) + (tx + bx * 16) * 512];
        temp_2 = inputs[(ty + 2 * 16) + (tx + bx * 16) * 512];
        temp_3 = inputs[(ty + 3 * 16) + (tx + bx * 16) * 512];
        temp_4 = inputs[(ty + 4 * 16) + (tx + bx * 16) * 512];
        temp_5 = inputs[(ty + 5 * 16) + (tx + bx * 16) * 512];
        temp_6 = inputs[(ty + 6 * 16) + (tx + bx * 16) * 512];
        temp_7 = inputs[(ty + 7 * 16) + (tx + bx * 16) * 512];
        temp_8 = inputs[(ty + 8 * 16) + (tx + bx * 16) * 512];
        temp_9 = inputs[(ty + 9 * 16) + (tx + bx * 16) * 512];
        temp_10 = inputs[(ty + 10 * 16) + (tx + bx * 16) * 512];
        temp_11 = inputs[(ty + 11 * 16) + (tx + bx * 16) * 512];
        temp_12 = inputs[(ty + 12 * 16) + (tx + bx * 16) * 512];
        temp_13 = inputs[(ty + 13 * 16) + (tx + bx * 16) * 512];
        temp_14 = inputs[(ty + 14 * 16) + (tx + bx * 16) * 512];
        temp_15 = inputs[(ty + 15 * 16) + (tx + bx * 16) * 512];
        temp_16 = inputs[(ty + 16 * 16) + (tx + bx * 16) * 512];
        temp_17 = inputs[(ty + 17 * 16) + (tx + bx * 16) * 512];
        temp_18 = inputs[(ty + 18 * 16) + (tx + bx * 16) * 512];
        temp_19 = inputs[(ty + 19 * 16) + (tx + bx * 16) * 512];
        temp_20 = inputs[(ty + 20 * 16) + (tx + bx * 16) * 512];
        temp_21 = inputs[(ty + 21 * 16) + (tx + bx * 16) * 512];
        temp_22 = inputs[(ty + 22 * 16) + (tx + bx * 16) * 512];
        temp_23 = inputs[(ty + 23 * 16) + (tx + bx * 16) * 512];
        temp_24 = inputs[(ty + 24 * 16) + (tx + bx * 16) * 512];
        temp_25 = inputs[(ty + 25 * 16) + (tx + bx * 16) * 512];
        temp_26 = inputs[(ty + 26 * 16) + (tx + bx * 16) * 512];
        temp_27 = inputs[(ty + 27 * 16) + (tx + bx * 16) * 512];
        temp_28 = inputs[(ty + 28 * 16) + (tx + bx * 16) * 512];
        temp_29 = inputs[(ty + 29 * 16) + (tx + bx * 16) * 512];
        temp_30 = inputs[(ty + 30 * 16) + (tx + bx * 16) * 512];
        temp_31 = inputs[(ty + 31 * 16) + (tx + bx * 16) * 512];
        
        __id[0] = 0 + ty;
        __id[1] = 16 + ty;
        __id[2] = 32 + ty;
        __id[3] = 48 + ty;
        __id[4] = 64 + ty;
        __id[5] = 80 + ty;
        __id[6] = 96 + ty;
        __id[7] = 112 + ty;
        __id[8] = 128 + ty;
        __id[9] = 144 + ty;
        __id[10] = 160 + ty;
        __id[11] = 176 + ty;
        __id[12] = 192 + ty;
        __id[13] = 208 + ty;
        __id[14] = 224 + ty;
        __id[15] = 240 + ty;
        __id[16] = 256 + ty;
        __id[17] = 272 + ty;
        __id[18] = 288 + ty;
        __id[19] = 304 + ty;
        __id[20] = 320 + ty;
        __id[21] = 336 + ty;
        __id[22] = 352 + ty;
        __id[23] = 368 + ty;
        __id[24] = 384 + ty;
        __id[25] = 400 + ty;
        __id[26] = 416 + ty;
        __id[27] = 432 + ty;
        __id[28] = 448 + ty;
        __id[29] = 464 + ty;
        __id[30] = 480 + ty;
        __id[31] = 496 + ty;
        
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
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[8], sdata[__id[8]].x, sdata[__id[8]].y);
            mem_checksum.x += sdata[__id[8]].x * temp_8.x - sdata[__id[8]].y * temp_8.y;
            mem_checksum.y += sdata[__id[8]].y * temp_8.x + sdata[__id[8]].x * temp_8.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[9], sdata[__id[9]].x, sdata[__id[9]].y);
            mem_checksum.x += sdata[__id[9]].x * temp_9.x - sdata[__id[9]].y * temp_9.y;
            mem_checksum.y += sdata[__id[9]].y * temp_9.x + sdata[__id[9]].x * temp_9.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[10], sdata[__id[10]].x, sdata[__id[10]].y);
            mem_checksum.x += sdata[__id[10]].x * temp_10.x - sdata[__id[10]].y * temp_10.y;
            mem_checksum.y += sdata[__id[10]].y * temp_10.x + sdata[__id[10]].x * temp_10.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[11], sdata[__id[11]].x, sdata[__id[11]].y);
            mem_checksum.x += sdata[__id[11]].x * temp_11.x - sdata[__id[11]].y * temp_11.y;
            mem_checksum.y += sdata[__id[11]].y * temp_11.x + sdata[__id[11]].x * temp_11.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[12], sdata[__id[12]].x, sdata[__id[12]].y);
            mem_checksum.x += sdata[__id[12]].x * temp_12.x - sdata[__id[12]].y * temp_12.y;
            mem_checksum.y += sdata[__id[12]].y * temp_12.x + sdata[__id[12]].x * temp_12.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[13], sdata[__id[13]].x, sdata[__id[13]].y);
            mem_checksum.x += sdata[__id[13]].x * temp_13.x - sdata[__id[13]].y * temp_13.y;
            mem_checksum.y += sdata[__id[13]].y * temp_13.x + sdata[__id[13]].x * temp_13.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[14], sdata[__id[14]].x, sdata[__id[14]].y);
            mem_checksum.x += sdata[__id[14]].x * temp_14.x - sdata[__id[14]].y * temp_14.y;
            mem_checksum.y += sdata[__id[14]].y * temp_14.x + sdata[__id[14]].x * temp_14.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[15], sdata[__id[15]].x, sdata[__id[15]].y);
            mem_checksum.x += sdata[__id[15]].x * temp_15.x - sdata[__id[15]].y * temp_15.y;
            mem_checksum.y += sdata[__id[15]].y * temp_15.x + sdata[__id[15]].x * temp_15.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[16], sdata[__id[16]].x, sdata[__id[16]].y);
            mem_checksum.x += sdata[__id[16]].x * temp_16.x - sdata[__id[16]].y * temp_16.y;
            mem_checksum.y += sdata[__id[16]].y * temp_16.x + sdata[__id[16]].x * temp_16.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[17], sdata[__id[17]].x, sdata[__id[17]].y);
            mem_checksum.x += sdata[__id[17]].x * temp_17.x - sdata[__id[17]].y * temp_17.y;
            mem_checksum.y += sdata[__id[17]].y * temp_17.x + sdata[__id[17]].x * temp_17.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[18], sdata[__id[18]].x, sdata[__id[18]].y);
            mem_checksum.x += sdata[__id[18]].x * temp_18.x - sdata[__id[18]].y * temp_18.y;
            mem_checksum.y += sdata[__id[18]].y * temp_18.x + sdata[__id[18]].x * temp_18.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[19], sdata[__id[19]].x, sdata[__id[19]].y);
            mem_checksum.x += sdata[__id[19]].x * temp_19.x - sdata[__id[19]].y * temp_19.y;
            mem_checksum.y += sdata[__id[19]].y * temp_19.x + sdata[__id[19]].x * temp_19.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[20], sdata[__id[20]].x, sdata[__id[20]].y);
            mem_checksum.x += sdata[__id[20]].x * temp_20.x - sdata[__id[20]].y * temp_20.y;
            mem_checksum.y += sdata[__id[20]].y * temp_20.x + sdata[__id[20]].x * temp_20.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[21], sdata[__id[21]].x, sdata[__id[21]].y);
            mem_checksum.x += sdata[__id[21]].x * temp_21.x - sdata[__id[21]].y * temp_21.y;
            mem_checksum.y += sdata[__id[21]].y * temp_21.x + sdata[__id[21]].x * temp_21.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[22], sdata[__id[22]].x, sdata[__id[22]].y);
            mem_checksum.x += sdata[__id[22]].x * temp_22.x - sdata[__id[22]].y * temp_22.y;
            mem_checksum.y += sdata[__id[22]].y * temp_22.x + sdata[__id[22]].x * temp_22.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[23], sdata[__id[23]].x, sdata[__id[23]].y);
            mem_checksum.x += sdata[__id[23]].x * temp_23.x - sdata[__id[23]].y * temp_23.y;
            mem_checksum.y += sdata[__id[23]].y * temp_23.x + sdata[__id[23]].x * temp_23.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[24], sdata[__id[24]].x, sdata[__id[24]].y);
            mem_checksum.x += sdata[__id[24]].x * temp_24.x - sdata[__id[24]].y * temp_24.y;
            mem_checksum.y += sdata[__id[24]].y * temp_24.x + sdata[__id[24]].x * temp_24.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[25], sdata[__id[25]].x, sdata[__id[25]].y);
            mem_checksum.x += sdata[__id[25]].x * temp_25.x - sdata[__id[25]].y * temp_25.y;
            mem_checksum.y += sdata[__id[25]].y * temp_25.x + sdata[__id[25]].x * temp_25.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[26], sdata[__id[26]].x, sdata[__id[26]].y);
            mem_checksum.x += sdata[__id[26]].x * temp_26.x - sdata[__id[26]].y * temp_26.y;
            mem_checksum.y += sdata[__id[26]].y * temp_26.x + sdata[__id[26]].x * temp_26.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[27], sdata[__id[27]].x, sdata[__id[27]].y);
            mem_checksum.x += sdata[__id[27]].x * temp_27.x - sdata[__id[27]].y * temp_27.y;
            mem_checksum.y += sdata[__id[27]].y * temp_27.x + sdata[__id[27]].x * temp_27.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[28], sdata[__id[28]].x, sdata[__id[28]].y);
            mem_checksum.x += sdata[__id[28]].x * temp_28.x - sdata[__id[28]].y * temp_28.y;
            mem_checksum.y += sdata[__id[28]].y * temp_28.x + sdata[__id[28]].x * temp_28.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[29], sdata[__id[29]].x, sdata[__id[29]].y);
            mem_checksum.x += sdata[__id[29]].x * temp_29.x - sdata[__id[29]].y * temp_29.y;
            mem_checksum.y += sdata[__id[29]].y * temp_29.x + sdata[__id[29]].x * temp_29.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[30], sdata[__id[30]].x, sdata[__id[30]].y);
            mem_checksum.x += sdata[__id[30]].x * temp_30.x - sdata[__id[30]].y * temp_30.y;
            mem_checksum.y += sdata[__id[30]].y * temp_30.x + sdata[__id[30]].x * temp_30.y;
        
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\n", __id[31], sdata[__id[31]].x, sdata[__id[31]].y);
            mem_checksum.x += sdata[__id[31]].x * temp_31.x - sdata[__id[31]].y * temp_31.y;
            mem_checksum.y += sdata[__id[31]].y * temp_31.x + sdata[__id[31]].x * temp_31.y;
        
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
        
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 0) / (float)(512), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 1) / (float)(512), tmp_angle);
    MY_MUL(temp_16, tmp_angle, tmp);
    temp_16 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 2) / (float)(512), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 3) / (float)(512), tmp_angle);
    MY_MUL(temp_24, tmp_angle, tmp);
    temp_24 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 4) / (float)(512), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 5) / (float)(512), tmp_angle);
    MY_MUL(temp_20, tmp_angle, tmp);
    temp_20 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 6) / (float)(512), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 7) / (float)(512), tmp_angle);
    MY_MUL(temp_28, tmp_angle, tmp);
    temp_28 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 8) / (float)(512), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 9) / (float)(512), tmp_angle);
    MY_MUL(temp_18, tmp_angle, tmp);
    temp_18 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 10) / (float)(512), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 11) / (float)(512), tmp_angle);
    MY_MUL(temp_26, tmp_angle, tmp);
    temp_26 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 12) / (float)(512), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 13) / (float)(512), tmp_angle);
    MY_MUL(temp_22, tmp_angle, tmp);
    temp_22 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 14) / (float)(512), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 15) / (float)(512), tmp_angle);
    MY_MUL(temp_30, tmp_angle, tmp);
    temp_30 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 16) / (float)(512), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 17) / (float)(512), tmp_angle);
    MY_MUL(temp_17, tmp_angle, tmp);
    temp_17 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 18) / (float)(512), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 19) / (float)(512), tmp_angle);
    MY_MUL(temp_25, tmp_angle, tmp);
    temp_25 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 20) / (float)(512), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 21) / (float)(512), tmp_angle);
    MY_MUL(temp_21, tmp_angle, tmp);
    temp_21 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 22) / (float)(512), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 23) / (float)(512), tmp_angle);
    MY_MUL(temp_29, tmp_angle, tmp);
    temp_29 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 24) / (float)(512), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 25) / (float)(512), tmp_angle);
    MY_MUL(temp_19, tmp_angle, tmp);
    temp_19 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 26) / (float)(512), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 27) / (float)(512), tmp_angle);
    MY_MUL(temp_27, tmp_angle, tmp);
    temp_27 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 28) / (float)(512), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 29) / (float)(512), tmp_angle);
    MY_MUL(temp_23, tmp_angle, tmp);
    temp_23 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 30) / (float)(512), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / 1) * 31) / (float)(512), tmp_angle);
    MY_MUL(temp_31, tmp_angle, tmp);
    temp_31 = tmp;
    
        sdata[tx + 16 * __id[0]] = temp_0;
        
        sdata[tx + 16 * __id[16]] = temp_16;
        
        sdata[tx + 16 * __id[8]] = temp_8;
        
        sdata[tx + 16 * __id[24]] = temp_24;
        
        sdata[tx + 16 * __id[4]] = temp_4;
        
        sdata[tx + 16 * __id[20]] = temp_20;
        
        sdata[tx + 16 * __id[12]] = temp_12;
        
        sdata[tx + 16 * __id[28]] = temp_28;
        
        sdata[tx + 16 * __id[2]] = temp_2;
        
        sdata[tx + 16 * __id[18]] = temp_18;
        
        sdata[tx + 16 * __id[10]] = temp_10;
        
        sdata[tx + 16 * __id[26]] = temp_26;
        
        sdata[tx + 16 * __id[6]] = temp_6;
        
        sdata[tx + 16 * __id[22]] = temp_22;
        
        sdata[tx + 16 * __id[14]] = temp_14;
        
        sdata[tx + 16 * __id[30]] = temp_30;
        
        sdata[tx + 16 * __id[1]] = temp_1;
        
        sdata[tx + 16 * __id[17]] = temp_17;
        
        sdata[tx + 16 * __id[9]] = temp_9;
        
        sdata[tx + 16 * __id[25]] = temp_25;
        
        sdata[tx + 16 * __id[5]] = temp_5;
        
        sdata[tx + 16 * __id[21]] = temp_21;
        
        sdata[tx + 16 * __id[13]] = temp_13;
        
        sdata[tx + 16 * __id[29]] = temp_29;
        
        sdata[tx + 16 * __id[3]] = temp_3;
        
        sdata[tx + 16 * __id[19]] = temp_19;
        
        sdata[tx + 16 * __id[11]] = temp_11;
        
        sdata[tx + 16 * __id[27]] = temp_27;
        
        sdata[tx + 16 * __id[7]] = temp_7;
        
        sdata[tx + 16 * __id[23]] = temp_23;
        
        sdata[tx + 16 * __id[15]] = temp_15;
        
        sdata[tx + 16 * __id[31]] = temp_31;
        
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
        
        temp_8 = sdata[tx + 16 * (128 + ty)];
        __id[8] = ty + 128;
        
        temp_9 = sdata[tx + 16 * (144 + ty)];
        __id[9] = ty + 144;
        
        temp_10 = sdata[tx + 16 * (160 + ty)];
        __id[10] = ty + 160;
        
        temp_11 = sdata[tx + 16 * (176 + ty)];
        __id[11] = ty + 176;
        
        temp_12 = sdata[tx + 16 * (192 + ty)];
        __id[12] = ty + 192;
        
        temp_13 = sdata[tx + 16 * (208 + ty)];
        __id[13] = ty + 208;
        
        temp_14 = sdata[tx + 16 * (224 + ty)];
        __id[14] = ty + 224;
        
        temp_15 = sdata[tx + 16 * (240 + ty)];
        __id[15] = ty + 240;
        
        temp_16 = sdata[tx + 16 * (256 + ty)];
        __id[16] = ty + 256;
        
        temp_17 = sdata[tx + 16 * (272 + ty)];
        __id[17] = ty + 272;
        
        temp_18 = sdata[tx + 16 * (288 + ty)];
        __id[18] = ty + 288;
        
        temp_19 = sdata[tx + 16 * (304 + ty)];
        __id[19] = ty + 304;
        
        temp_20 = sdata[tx + 16 * (320 + ty)];
        __id[20] = ty + 320;
        
        temp_21 = sdata[tx + 16 * (336 + ty)];
        __id[21] = ty + 336;
        
        temp_22 = sdata[tx + 16 * (352 + ty)];
        __id[22] = ty + 352;
        
        temp_23 = sdata[tx + 16 * (368 + ty)];
        __id[23] = ty + 368;
        
        temp_24 = sdata[tx + 16 * (384 + ty)];
        __id[24] = ty + 384;
        
        temp_25 = sdata[tx + 16 * (400 + ty)];
        __id[25] = ty + 400;
        
        temp_26 = sdata[tx + 16 * (416 + ty)];
        __id[26] = ty + 416;
        
        temp_27 = sdata[tx + 16 * (432 + ty)];
        __id[27] = ty + 432;
        
        temp_28 = sdata[tx + 16 * (448 + ty)];
        __id[28] = ty + 448;
        
        temp_29 = sdata[tx + 16 * (464 + ty)];
        __id[29] = ty + 464;
        
        temp_30 = sdata[tx + 16 * (480 + ty)];
        __id[30] = ty + 480;
        
        temp_31 = sdata[tx + 16 * (496 + ty)];
        __id[31] = ty + 496;
        
        j = 1;
        k = 8 % 1;
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
            
            MY_MUL(temp_18, tmp_angle, tmp);
            temp_18 = tmp;
            
            MY_MUL(temp_20, tmp_angle, tmp);
            temp_20 = tmp;
            
            MY_MUL(temp_22, tmp_angle, tmp);
            temp_22 = tmp;
            
            MY_MUL(temp_24, tmp_angle, tmp);
            temp_24 = tmp;
            
            MY_MUL(temp_26, tmp_angle, tmp);
            temp_26 = tmp;
            
            MY_MUL(temp_28, tmp_angle, tmp);
            temp_28 = tmp;
            
            MY_MUL(temp_30, tmp_angle, tmp);
            temp_30 = tmp;
            
                    tmp_angle = tmp_angle_bk;
    
            tmp_angle_rot.x = 1.0f;
            tmp_angle_rot.y = 0.0f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
            MY_MUL(temp_17, tmp_angle, tmp);
            temp_17 = tmp;
            
            MY_MUL(temp_19, tmp_angle, tmp);
            temp_19 = tmp;
            
            MY_MUL(temp_21, tmp_angle, tmp);
            temp_21 = tmp;
            
            MY_MUL(temp_23, tmp_angle, tmp);
            temp_23 = tmp;
            
            MY_MUL(temp_25, tmp_angle, tmp);
            temp_25 = tmp;
            
            MY_MUL(temp_27, tmp_angle, tmp);
            temp_27 = tmp;
            
            MY_MUL(temp_29, tmp_angle, tmp);
            temp_29 = tmp;
            
            MY_MUL(temp_31, tmp_angle, tmp);
            temp_31 = tmp;
            
            tmp = temp_0;
            MY_ADD(tmp, temp_16, temp_0);
            MY_SUB(tmp, temp_16, temp_16);
            
            tmp_id = __id[0];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[0] = tmp_id;
            __id[16] = tmp_id + 32;
            
            tmp = temp_2;
            MY_ADD(tmp, temp_18, temp_2);
            MY_SUB(tmp, temp_18, temp_18);
            
            tmp_id = __id[2];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[2] = tmp_id;
            __id[18] = tmp_id + 32;
            
            tmp = temp_4;
            MY_ADD(tmp, temp_20, temp_4);
            MY_SUB(tmp, temp_20, temp_20);
            
            tmp_id = __id[4];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[4] = tmp_id;
            __id[20] = tmp_id + 32;
            
            tmp = temp_6;
            MY_ADD(tmp, temp_22, temp_6);
            MY_SUB(tmp, temp_22, temp_22);
            
            tmp_id = __id[6];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[6] = tmp_id;
            __id[22] = tmp_id + 32;
            
            tmp = temp_8;
            MY_ADD(tmp, temp_24, temp_8);
            MY_SUB(tmp, temp_24, temp_24);
            
            tmp_id = __id[8];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[8] = tmp_id;
            __id[24] = tmp_id + 32;
            
            tmp = temp_10;
            MY_ADD(tmp, temp_26, temp_10);
            MY_SUB(tmp, temp_26, temp_26);
            
            tmp_id = __id[10];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[10] = tmp_id;
            __id[26] = tmp_id + 32;
            
            tmp = temp_12;
            MY_ADD(tmp, temp_28, temp_12);
            MY_SUB(tmp, temp_28, temp_28);
            
            tmp_id = __id[12];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[12] = tmp_id;
            __id[28] = tmp_id + 32;
            
            tmp = temp_14;
            MY_ADD(tmp, temp_30, temp_14);
            MY_SUB(tmp, temp_30, temp_30);
            
            tmp_id = __id[14];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[14] = tmp_id;
            __id[30] = tmp_id + 32;
            
            tmp = temp_1;
            MY_ADD(tmp, temp_17, temp_1);
            MY_SUB(tmp, temp_17, temp_17);
            
            tmp_id = __id[1];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[1] = tmp_id;
            __id[17] = tmp_id + 32;
            
            tmp = temp_3;
            MY_ADD(tmp, temp_19, temp_3);
            MY_SUB(tmp, temp_19, temp_19);
            
            tmp_id = __id[3];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[3] = tmp_id;
            __id[19] = tmp_id + 32;
            
            tmp = temp_5;
            MY_ADD(tmp, temp_21, temp_5);
            MY_SUB(tmp, temp_21, temp_21);
            
            tmp_id = __id[5];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[5] = tmp_id;
            __id[21] = tmp_id + 32;
            
            tmp = temp_7;
            MY_ADD(tmp, temp_23, temp_7);
            MY_SUB(tmp, temp_23, temp_23);
            
            tmp_id = __id[7];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[7] = tmp_id;
            __id[23] = tmp_id + 32;
            
            tmp = temp_9;
            MY_ADD(tmp, temp_25, temp_9);
            MY_SUB(tmp, temp_25, temp_25);
            
            tmp_id = __id[9];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[9] = tmp_id;
            __id[25] = tmp_id + 32;
            
            tmp = temp_11;
            MY_ADD(tmp, temp_27, temp_11);
            MY_SUB(tmp, temp_27, temp_27);
            
            tmp_id = __id[11];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[11] = tmp_id;
            __id[27] = tmp_id + 32;
            
            tmp = temp_13;
            MY_ADD(tmp, temp_29, temp_13);
            MY_SUB(tmp, temp_29, temp_29);
            
            tmp_id = __id[13];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[13] = tmp_id;
            __id[29] = tmp_id + 32;
            
            tmp = temp_15;
            MY_ADD(tmp, temp_31, temp_15);
            MY_SUB(tmp, temp_31, temp_31);
            
            tmp_id = __id[15];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[15] = tmp_id;
            __id[31] = tmp_id + 32;
            
        n_global *= 2;
        
        j = 1;
        k = 8 % 2;
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
            
            MY_MUL(temp_10, tmp_angle, tmp);
            temp_10 = tmp;
            
            MY_MUL(temp_26, tmp_angle_rot, tmp);
            temp_26 = tmp;
            
            MY_MUL(temp_12, tmp_angle, tmp);
            temp_12 = tmp;
            
            MY_MUL(temp_28, tmp_angle_rot, tmp);
            temp_28 = tmp;
            
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
            
            MY_MUL(temp_9, tmp_angle, tmp);
            temp_9 = tmp;
            
            MY_MUL(temp_25, tmp_angle_rot, tmp);
            temp_25 = tmp;
            
            MY_MUL(temp_11, tmp_angle, tmp);
            temp_11 = tmp;
            
            MY_MUL(temp_27, tmp_angle_rot, tmp);
            temp_27 = tmp;
            
            MY_MUL(temp_13, tmp_angle, tmp);
            temp_13 = tmp;
            
            MY_MUL(temp_29, tmp_angle_rot, tmp);
            temp_29 = tmp;
            
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
        k = 8 % 4;
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
            
            MY_MUL(temp_20, tmp_angle, tmp);
            temp_20 = tmp;
            
            MY_MUL(temp_28, tmp_angle_rot, tmp);
            temp_28 = tmp;
            
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
            
            MY_MUL(temp_5, tmp_angle, tmp);
            temp_5 = tmp;
            
            MY_MUL(temp_13, tmp_angle_rot, tmp);
            temp_13 = tmp;
            
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
            
            MY_MUL(temp_21, tmp_angle, tmp);
            temp_21 = tmp;
            
            MY_MUL(temp_29, tmp_angle_rot, tmp);
            temp_29 = tmp;
            
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
        k = 8 % 8;
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
            
            tmp_angle_rot.x = 0.9238795325112867f;
            tmp_angle_rot.y = -0.3826834323650898f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            
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
        
                r_id = __id[16] % 3;
                mem_checksum.x += temp_16.x * r[r_id].x - temp_16.y * r[r_id].y;
                mem_checksum.y += temp_16.y * r[r_id].x + temp_16.x * r[r_id].y;
        
                r_id = __id[17] % 3;
                mem_checksum.x += temp_17.x * r[r_id].x - temp_17.y * r[r_id].y;
                mem_checksum.y += temp_17.y * r[r_id].x + temp_17.x * r[r_id].y;
        
                r_id = __id[8] % 3;
                mem_checksum.x += temp_8.x * r[r_id].x - temp_8.y * r[r_id].y;
                mem_checksum.y += temp_8.y * r[r_id].x + temp_8.x * r[r_id].y;
        
                r_id = __id[9] % 3;
                mem_checksum.x += temp_9.x * r[r_id].x - temp_9.y * r[r_id].y;
                mem_checksum.y += temp_9.y * r[r_id].x + temp_9.x * r[r_id].y;
        
                r_id = __id[24] % 3;
                mem_checksum.x += temp_24.x * r[r_id].x - temp_24.y * r[r_id].y;
                mem_checksum.y += temp_24.y * r[r_id].x + temp_24.x * r[r_id].y;
        
                r_id = __id[25] % 3;
                mem_checksum.x += temp_25.x * r[r_id].x - temp_25.y * r[r_id].y;
                mem_checksum.y += temp_25.y * r[r_id].x + temp_25.x * r[r_id].y;
        
                r_id = __id[4] % 3;
                mem_checksum.x += temp_4.x * r[r_id].x - temp_4.y * r[r_id].y;
                mem_checksum.y += temp_4.y * r[r_id].x + temp_4.x * r[r_id].y;
        
                r_id = __id[5] % 3;
                mem_checksum.x += temp_5.x * r[r_id].x - temp_5.y * r[r_id].y;
                mem_checksum.y += temp_5.y * r[r_id].x + temp_5.x * r[r_id].y;
        
                r_id = __id[20] % 3;
                mem_checksum.x += temp_20.x * r[r_id].x - temp_20.y * r[r_id].y;
                mem_checksum.y += temp_20.y * r[r_id].x + temp_20.x * r[r_id].y;
        
                r_id = __id[21] % 3;
                mem_checksum.x += temp_21.x * r[r_id].x - temp_21.y * r[r_id].y;
                mem_checksum.y += temp_21.y * r[r_id].x + temp_21.x * r[r_id].y;
        
                r_id = __id[12] % 3;
                mem_checksum.x += temp_12.x * r[r_id].x - temp_12.y * r[r_id].y;
                mem_checksum.y += temp_12.y * r[r_id].x + temp_12.x * r[r_id].y;
        
                r_id = __id[13] % 3;
                mem_checksum.x += temp_13.x * r[r_id].x - temp_13.y * r[r_id].y;
                mem_checksum.y += temp_13.y * r[r_id].x + temp_13.x * r[r_id].y;
        
                r_id = __id[28] % 3;
                mem_checksum.x += temp_28.x * r[r_id].x - temp_28.y * r[r_id].y;
                mem_checksum.y += temp_28.y * r[r_id].x + temp_28.x * r[r_id].y;
        
                r_id = __id[29] % 3;
                mem_checksum.x += temp_29.x * r[r_id].x - temp_29.y * r[r_id].y;
                mem_checksum.y += temp_29.y * r[r_id].x + temp_29.x * r[r_id].y;
        
                r_id = __id[2] % 3;
                mem_checksum.x += temp_2.x * r[r_id].x - temp_2.y * r[r_id].y;
                mem_checksum.y += temp_2.y * r[r_id].x + temp_2.x * r[r_id].y;
        
                r_id = __id[3] % 3;
                mem_checksum.x += temp_3.x * r[r_id].x - temp_3.y * r[r_id].y;
                mem_checksum.y += temp_3.y * r[r_id].x + temp_3.x * r[r_id].y;
        
                r_id = __id[18] % 3;
                mem_checksum.x += temp_18.x * r[r_id].x - temp_18.y * r[r_id].y;
                mem_checksum.y += temp_18.y * r[r_id].x + temp_18.x * r[r_id].y;
        
                r_id = __id[19] % 3;
                mem_checksum.x += temp_19.x * r[r_id].x - temp_19.y * r[r_id].y;
                mem_checksum.y += temp_19.y * r[r_id].x + temp_19.x * r[r_id].y;
        
                r_id = __id[10] % 3;
                mem_checksum.x += temp_10.x * r[r_id].x - temp_10.y * r[r_id].y;
                mem_checksum.y += temp_10.y * r[r_id].x + temp_10.x * r[r_id].y;
        
                r_id = __id[11] % 3;
                mem_checksum.x += temp_11.x * r[r_id].x - temp_11.y * r[r_id].y;
                mem_checksum.y += temp_11.y * r[r_id].x + temp_11.x * r[r_id].y;
        
                r_id = __id[26] % 3;
                mem_checksum.x += temp_26.x * r[r_id].x - temp_26.y * r[r_id].y;
                mem_checksum.y += temp_26.y * r[r_id].x + temp_26.x * r[r_id].y;
        
                r_id = __id[27] % 3;
                mem_checksum.x += temp_27.x * r[r_id].x - temp_27.y * r[r_id].y;
                mem_checksum.y += temp_27.y * r[r_id].x + temp_27.x * r[r_id].y;
        
                r_id = __id[6] % 3;
                mem_checksum.x += temp_6.x * r[r_id].x - temp_6.y * r[r_id].y;
                mem_checksum.y += temp_6.y * r[r_id].x + temp_6.x * r[r_id].y;
        
                r_id = __id[7] % 3;
                mem_checksum.x += temp_7.x * r[r_id].x - temp_7.y * r[r_id].y;
                mem_checksum.y += temp_7.y * r[r_id].x + temp_7.x * r[r_id].y;
        
                r_id = __id[22] % 3;
                mem_checksum.x += temp_22.x * r[r_id].x - temp_22.y * r[r_id].y;
                mem_checksum.y += temp_22.y * r[r_id].x + temp_22.x * r[r_id].y;
        
                r_id = __id[23] % 3;
                mem_checksum.x += temp_23.x * r[r_id].x - temp_23.y * r[r_id].y;
                mem_checksum.y += temp_23.y * r[r_id].x + temp_23.x * r[r_id].y;
        
                r_id = __id[14] % 3;
                mem_checksum.x += temp_14.x * r[r_id].x - temp_14.y * r[r_id].y;
                mem_checksum.y += temp_14.y * r[r_id].x + temp_14.x * r[r_id].y;
        
                r_id = __id[15] % 3;
                mem_checksum.x += temp_15.x * r[r_id].x - temp_15.y * r[r_id].y;
                mem_checksum.y += temp_15.y * r[r_id].x + temp_15.x * r[r_id].y;
        
                r_id = __id[30] % 3;
                mem_checksum.x += temp_30.x * r[r_id].x - temp_30.y * r[r_id].y;
                mem_checksum.y += temp_30.y * r[r_id].x + temp_30.x * r[r_id].y;
        
                r_id = __id[31] % 3;
                mem_checksum.x += temp_31.x * r[r_id].x - temp_31.y * r[r_id].y;
                mem_checksum.y += temp_31.y * r[r_id].x + temp_31.x * r[r_id].y;
        
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
                    mem_checksum.x  = mem_checksum.y;
                    mem_checksum.y = mem_checksum.y - mem_checksum_t1.y;
                    sdata[tid / 32] = mem_checksum;
                }
                __syncthreads();
                mem_checksum.x = 0;
                mem_checksum.y = 0;
                
                if(tid < 8)
                
                mem_checksum = sdata[tid];
                
                    // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 4, 32);
                    mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 4, 32);
            
                    // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 2, 32);
                    mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 2, 32);
            
                    // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 1, 32);
                    mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 1, 32);
            
                // if(mem_checksum.y > 1)printf("%f, %f, %f\n", temp_0.x, temp_0.y, mem_checksum.y );
                // if(tid == 0 && bx < 128)printf("up1 %f, %f, %f\n", mem_checksum.x, mem_checksum.y,mem_checksum.y * mem_checksum.y / mem_checksum.x);
            
                temp_0.x += 0.1f * (mem_checksum.x);
                temp_0.y += 0.1f * (mem_checksum.y);
                
                #endif
                #if defined(LOG_ON)
                if(tid == 0 && bx < 128)printf("up2 %f, %f, %f\n", mem_checksum.x, mem_checksum.y, mem_checksum.y / mem_checksum.x);
                #endif
                
        outputs[(tx + bx * 16) + 128 * __id[0]] = temp_0;
        
        outputs[(tx + bx * 16) + 128 * __id[1]] = temp_1;
        
        outputs[(tx + bx * 16) + 128 * __id[16]] = temp_16;
        
        outputs[(tx + bx * 16) + 128 * __id[17]] = temp_17;
        
        outputs[(tx + bx * 16) + 128 * __id[8]] = temp_8;
        
        outputs[(tx + bx * 16) + 128 * __id[9]] = temp_9;
        
        outputs[(tx + bx * 16) + 128 * __id[24]] = temp_24;
        
        outputs[(tx + bx * 16) + 128 * __id[25]] = temp_25;
        
        outputs[(tx + bx * 16) + 128 * __id[4]] = temp_4;
        
        outputs[(tx + bx * 16) + 128 * __id[5]] = temp_5;
        
        outputs[(tx + bx * 16) + 128 * __id[20]] = temp_20;
        
        outputs[(tx + bx * 16) + 128 * __id[21]] = temp_21;
        
        outputs[(tx + bx * 16) + 128 * __id[12]] = temp_12;
        
        outputs[(tx + bx * 16) + 128 * __id[13]] = temp_13;
        
        outputs[(tx + bx * 16) + 128 * __id[28]] = temp_28;
        
        outputs[(tx + bx * 16) + 128 * __id[29]] = temp_29;
        
        outputs[(tx + bx * 16) + 128 * __id[2]] = temp_2;
        
        outputs[(tx + bx * 16) + 128 * __id[3]] = temp_3;
        
        outputs[(tx + bx * 16) + 128 * __id[18]] = temp_18;
        
        outputs[(tx + bx * 16) + 128 * __id[19]] = temp_19;
        
        outputs[(tx + bx * 16) + 128 * __id[10]] = temp_10;
        
        outputs[(tx + bx * 16) + 128 * __id[11]] = temp_11;
        
        outputs[(tx + bx * 16) + 128 * __id[26]] = temp_26;
        
        outputs[(tx + bx * 16) + 128 * __id[27]] = temp_27;
        
        outputs[(tx + bx * 16) + 128 * __id[6]] = temp_6;
        
        outputs[(tx + bx * 16) + 128 * __id[7]] = temp_7;
        
        outputs[(tx + bx * 16) + 128 * __id[22]] = temp_22;
        
        outputs[(tx + bx * 16) + 128 * __id[23]] = temp_23;
        
        outputs[(tx + bx * 16) + 128 * __id[14]] = temp_14;
        
        outputs[(tx + bx * 16) + 128 * __id[15]] = temp_15;
        
        outputs[(tx + bx * 16) + 128 * __id[30]] = temp_30;
        
        outputs[(tx + bx * 16) + 128 * __id[31]] = temp_31;
        
        }
    