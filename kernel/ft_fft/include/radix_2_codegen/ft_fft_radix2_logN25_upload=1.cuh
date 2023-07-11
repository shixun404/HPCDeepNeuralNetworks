extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_radix2_logN25_1(float2* inputs, float2* outputs) {

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
    float2 mem_checksum;
    mem_checksum.x = 0;
    mem_checksum.y = 0;
    
    temp_0 = inputs[(ty + 0 * 16) * 131072 + tx + bx * 16];
    temp_1 = inputs[(ty + 1 * 16) * 131072 + tx + bx * 16];
    temp_2 = inputs[(ty + 2 * 16) * 131072 + tx + bx * 16];
    temp_3 = inputs[(ty + 3 * 16) * 131072 + tx + bx * 16];
    temp_4 = inputs[(ty + 4 * 16) * 131072 + tx + bx * 16];
    temp_5 = inputs[(ty + 5 * 16) * 131072 + tx + bx * 16];
    temp_6 = inputs[(ty + 6 * 16) * 131072 + tx + bx * 16];
    temp_7 = inputs[(ty + 7 * 16) * 131072 + tx + bx * 16];
    temp_8 = inputs[(ty + 8 * 16) * 131072 + tx + bx * 16];
    temp_9 = inputs[(ty + 9 * 16) * 131072 + tx + bx * 16];
    temp_10 = inputs[(ty + 10 * 16) * 131072 + tx + bx * 16];
    temp_11 = inputs[(ty + 11 * 16) * 131072 + tx + bx * 16];
    temp_12 = inputs[(ty + 12 * 16) * 131072 + tx + bx * 16];
    temp_13 = inputs[(ty + 13 * 16) * 131072 + tx + bx * 16];
    temp_14 = inputs[(ty + 14 * 16) * 131072 + tx + bx * 16];
    temp_15 = inputs[(ty + 15 * 16) * 131072 + tx + bx * 16];
    mem_checksum.x += temp_0.x;
        mem_checksum.y += temp_0.y;
    mem_checksum.x += temp_1.x;
        mem_checksum.y += temp_1.y;
    mem_checksum.x += temp_2.x;
        mem_checksum.y += temp_2.y;
    mem_checksum.x += temp_3.x;
        mem_checksum.y += temp_3.y;
    mem_checksum.x += temp_4.x;
        mem_checksum.y += temp_4.y;
    mem_checksum.x += temp_5.x;
        mem_checksum.y += temp_5.y;
    mem_checksum.x += temp_6.x;
        mem_checksum.y += temp_6.y;
    mem_checksum.x += temp_7.x;
        mem_checksum.y += temp_7.y;
    mem_checksum.x += temp_8.x;
        mem_checksum.y += temp_8.y;
    mem_checksum.x += temp_9.x;
        mem_checksum.y += temp_9.y;
    mem_checksum.x += temp_10.x;
        mem_checksum.y += temp_10.y;
    mem_checksum.x += temp_11.x;
        mem_checksum.y += temp_11.y;
    mem_checksum.x += temp_12.x;
        mem_checksum.y += temp_12.y;
    mem_checksum.x += temp_13.x;
        mem_checksum.y += temp_13.y;
    mem_checksum.x += temp_14.x;
        mem_checksum.y += temp_14.y;
    mem_checksum.x += temp_15.x;
        mem_checksum.y += temp_15.y;
    
    int tid = tx + ty * blockDim.x;
    int mem_check_i = N / 16;
    
    sdata[tid] = mem_checksum;
    __syncthreads();
    mem_check_i /= 2;
    float2 mem_checksum_t1,mem_checksum_t2; 
    mem_checksum_t1.x = 0;mem_checksum_t1.y = 0; 
    mem_checksum_t2.x = 0;mem_checksum_t2.y = 0; 
        // __syncthreads();
    // if(tid < 32){
        mem_checksum_t1 = sdata[tid];
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.x, 16,32);
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 8, 32);
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 4, 32);
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 2, 32);
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 1, 32);
    //if(tid < 32){
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
    //}
    temp_0.x += 0.001 * (mem_checksum_t1.x);
    temp_0.y += 0.001 * (mem_checksum_t1.y);
    mem_check_i /= 2;
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
    
    j = 1;
    k = __id[8] % 1;
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
    
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_8, temp_0);
    MY_SUB(tmp, temp_8, temp_8);
    //MY_ADD_ft(tmp, temp_8, temp_0);
    // MY_SUB_ft(tmp, temp_8, temp_8);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[8] = tmp_id + 1;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_9, temp_1);
    MY_SUB(tmp, temp_9, temp_9);
    //MY_ADD_ft(tmp, temp_9, temp_1);
    // MY_SUB_ft(tmp, temp_9, temp_9);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[9] = tmp_id + 1;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_10, temp_2);
    MY_SUB(tmp, temp_10, temp_10);
    //MY_ADD_ft(tmp, temp_10, temp_2);
    // MY_SUB_ft(tmp, temp_10, temp_10);
    
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[10] = tmp_id + 1;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_11, temp_3);
    MY_SUB(tmp, temp_11, temp_11);
    //MY_ADD_ft(tmp, temp_11, temp_3);
    // MY_SUB_ft(tmp, temp_11, temp_11);
    
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[11] = tmp_id + 1;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_12, temp_4);
    MY_SUB(tmp, temp_12, temp_12);
    //MY_ADD_ft(tmp, temp_12, temp_4);
    // MY_SUB_ft(tmp, temp_12, temp_12);
    
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[12] = tmp_id + 1;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_13, temp_5);
    MY_SUB(tmp, temp_13, temp_13);
    //MY_ADD_ft(tmp, temp_13, temp_5);
    // MY_SUB_ft(tmp, temp_13, temp_13);
    
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[13] = tmp_id + 1;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_14, temp_6);
    MY_SUB(tmp, temp_14, temp_14);
    //MY_ADD_ft(tmp, temp_14, temp_6);
    // MY_SUB_ft(tmp, temp_14, temp_14);
    
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[14] = tmp_id + 1;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_15, temp_7);
    MY_SUB(tmp, temp_15, temp_15);
    //MY_ADD_ft(tmp, temp_15, temp_7);
    // MY_SUB_ft(tmp, temp_15, temp_15);
    
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[15] = tmp_id + 1;
    
    n_global *= 2;
    
    j = 1;
    k = __id[4] % 2;
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
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    //MY_ADD_ft(tmp, temp_4, temp_0);
    // MY_SUB_ft(tmp, temp_4, temp_4);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 2;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_12, temp_8);
    MY_SUB(tmp, temp_12, temp_12);
    //MY_ADD_ft(tmp, temp_12, temp_8);
    // MY_SUB_ft(tmp, temp_12, temp_12);
    
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[12] = tmp_id + 2;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    //MY_ADD_ft(tmp, temp_5, temp_1);
    // MY_SUB_ft(tmp, temp_5, temp_5);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 2;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_13, temp_9);
    MY_SUB(tmp, temp_13, temp_13);
    //MY_ADD_ft(tmp, temp_13, temp_9);
    // MY_SUB_ft(tmp, temp_13, temp_13);
    
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[13] = tmp_id + 2;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    //MY_ADD_ft(tmp, temp_6, temp_2);
    // MY_SUB_ft(tmp, temp_6, temp_6);
    
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 2;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_14, temp_10);
    MY_SUB(tmp, temp_14, temp_14);
    //MY_ADD_ft(tmp, temp_14, temp_10);
    // MY_SUB_ft(tmp, temp_14, temp_14);
    
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[14] = tmp_id + 2;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    //MY_ADD_ft(tmp, temp_7, temp_3);
    // MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 2;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_15, temp_11);
    MY_SUB(tmp, temp_15, temp_15);
    //MY_ADD_ft(tmp, temp_15, temp_11);
    // MY_SUB_ft(tmp, temp_15, temp_15);
    
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[15] = tmp_id + 2;
    
    n_global *= 2;
    
    j = 1;
    k = __id[2] % 4;
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
    
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
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
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    //MY_ADD_ft(tmp, temp_2, temp_0);
    // MY_SUB_ft(tmp, temp_2, temp_2);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 4;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_10, temp_8);
    MY_SUB(tmp, temp_10, temp_10);
    //MY_ADD_ft(tmp, temp_10, temp_8);
    // MY_SUB_ft(tmp, temp_10, temp_10);
    
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[10] = tmp_id + 4;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    //MY_ADD_ft(tmp, temp_6, temp_4);
    // MY_SUB_ft(tmp, temp_6, temp_6);
    
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 4;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_14, temp_12);
    MY_SUB(tmp, temp_14, temp_14);
    //MY_ADD_ft(tmp, temp_14, temp_12);
    // MY_SUB_ft(tmp, temp_14, temp_14);
    
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[14] = tmp_id + 4;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    //MY_ADD_ft(tmp, temp_3, temp_1);
    // MY_SUB_ft(tmp, temp_3, temp_3);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 4;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_11, temp_9);
    MY_SUB(tmp, temp_11, temp_11);
    //MY_ADD_ft(tmp, temp_11, temp_9);
    // MY_SUB_ft(tmp, temp_11, temp_11);
    
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[11] = tmp_id + 4;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    //MY_ADD_ft(tmp, temp_7, temp_5);
    // MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 4;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_15, temp_13);
    MY_SUB(tmp, temp_15, temp_15);
    //MY_ADD_ft(tmp, temp_15, temp_13);
    // MY_SUB_ft(tmp, temp_15, temp_15);
    
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[15] = tmp_id + 4;
    
    n_global *= 2;
    
    j = 1;
    k = __id[1] % 8;
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
    
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    
    MY_MUL(temp_3, tmp_angle_rot, tmp);
    temp_3 = tmp;
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    //MY_ADD_ft(tmp, temp_1, temp_0);
    // MY_SUB_ft(tmp, temp_1, temp_1);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[1] = tmp_id + 8;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    //MY_ADD_ft(tmp, temp_9, temp_8);
    // MY_SUB_ft(tmp, temp_9, temp_9);
    
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[9] = tmp_id + 8;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    //MY_ADD_ft(tmp, temp_5, temp_4);
    // MY_SUB_ft(tmp, temp_5, temp_5);
    
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[5] = tmp_id + 8;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    //MY_ADD_ft(tmp, temp_13, temp_12);
    // MY_SUB_ft(tmp, temp_13, temp_13);
    
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[13] = tmp_id + 8;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    //MY_ADD_ft(tmp, temp_3, temp_2);
    // MY_SUB_ft(tmp, temp_3, temp_3);
    
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[3] = tmp_id + 8;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    //MY_ADD_ft(tmp, temp_11, temp_10);
    // MY_SUB_ft(tmp, temp_11, temp_11);
    
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[11] = tmp_id + 8;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    //MY_ADD_ft(tmp, temp_7, temp_6);
    // MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[7] = tmp_id + 8;
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    //MY_ADD_ft(tmp, temp_15, temp_14);
    // MY_SUB_ft(tmp, temp_15, temp_15);
    
    tmp_id = __id[14];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[14] = tmp_id;
    __id[15] = tmp_id + 8;
    
    n_global *= 2;
    
    
    sdata[tx + 16 * __id[0]] = temp_0;
    
    sdata[tx + 16 * __id[8]] = temp_8;
    
    sdata[tx + 16 * __id[4]] = temp_4;
    
    sdata[tx + 16 * __id[12]] = temp_12;
    
    sdata[tx + 16 * __id[2]] = temp_2;
    
    sdata[tx + 16 * __id[10]] = temp_10;
    
    sdata[tx + 16 * __id[6]] = temp_6;
    
    sdata[tx + 16 * __id[14]] = temp_14;
    
    sdata[tx + 16 * __id[1]] = temp_1;
    
    sdata[tx + 16 * __id[9]] = temp_9;
    
    sdata[tx + 16 * __id[5]] = temp_5;
    
    sdata[tx + 16 * __id[13]] = temp_13;
    
    sdata[tx + 16 * __id[3]] = temp_3;
    
    sdata[tx + 16 * __id[11]] = temp_11;
    
    sdata[tx + 16 * __id[7]] = temp_7;
    
    sdata[tx + 16 * __id[15]] = temp_15;
    
    __syncthreads();
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("################### syncthreads ####################\n");
    #endif			
    
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
    
    j = 1;
    k = __id[8] % 16;
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
    
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_8, temp_0);
    MY_SUB(tmp, temp_8, temp_8);
    //MY_ADD_ft(tmp, temp_8, temp_0);
    // MY_SUB_ft(tmp, temp_8, temp_8);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[8] = tmp_id + 16;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_9, temp_1);
    MY_SUB(tmp, temp_9, temp_9);
    //MY_ADD_ft(tmp, temp_9, temp_1);
    // MY_SUB_ft(tmp, temp_9, temp_9);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[9] = tmp_id + 16;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_10, temp_2);
    MY_SUB(tmp, temp_10, temp_10);
    //MY_ADD_ft(tmp, temp_10, temp_2);
    // MY_SUB_ft(tmp, temp_10, temp_10);
    
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[10] = tmp_id + 16;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_11, temp_3);
    MY_SUB(tmp, temp_11, temp_11);
    //MY_ADD_ft(tmp, temp_11, temp_3);
    // MY_SUB_ft(tmp, temp_11, temp_11);
    
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[11] = tmp_id + 16;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_12, temp_4);
    MY_SUB(tmp, temp_12, temp_12);
    //MY_ADD_ft(tmp, temp_12, temp_4);
    // MY_SUB_ft(tmp, temp_12, temp_12);
    
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[12] = tmp_id + 16;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_13, temp_5);
    MY_SUB(tmp, temp_13, temp_13);
    //MY_ADD_ft(tmp, temp_13, temp_5);
    // MY_SUB_ft(tmp, temp_13, temp_13);
    
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[13] = tmp_id + 16;
    
    tmp = temp_6;
    MY_ADD(tmp, temp_14, temp_6);
    MY_SUB(tmp, temp_14, temp_14);
    //MY_ADD_ft(tmp, temp_14, temp_6);
    // MY_SUB_ft(tmp, temp_14, temp_14);
    
    tmp_id = __id[6];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[6] = tmp_id;
    __id[14] = tmp_id + 16;
    
    tmp = temp_7;
    MY_ADD(tmp, temp_15, temp_7);
    MY_SUB(tmp, temp_15, temp_15);
    //MY_ADD_ft(tmp, temp_15, temp_7);
    // MY_SUB_ft(tmp, temp_15, temp_15);
    
    tmp_id = __id[7];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[7] = tmp_id;
    __id[15] = tmp_id + 16;
    
    n_global *= 2;
    
    j = 1;
    k = __id[4] % 32;
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
    
    tmp = temp_0;
    MY_ADD(tmp, temp_4, temp_0);
    MY_SUB(tmp, temp_4, temp_4);
    //MY_ADD_ft(tmp, temp_4, temp_0);
    // MY_SUB_ft(tmp, temp_4, temp_4);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[4] = tmp_id + 32;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_12, temp_8);
    MY_SUB(tmp, temp_12, temp_12);
    //MY_ADD_ft(tmp, temp_12, temp_8);
    // MY_SUB_ft(tmp, temp_12, temp_12);
    
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[12] = tmp_id + 32;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_5, temp_1);
    MY_SUB(tmp, temp_5, temp_5);
    //MY_ADD_ft(tmp, temp_5, temp_1);
    // MY_SUB_ft(tmp, temp_5, temp_5);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[5] = tmp_id + 32;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_13, temp_9);
    MY_SUB(tmp, temp_13, temp_13);
    //MY_ADD_ft(tmp, temp_13, temp_9);
    // MY_SUB_ft(tmp, temp_13, temp_13);
    
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[13] = tmp_id + 32;
    
    tmp = temp_2;
    MY_ADD(tmp, temp_6, temp_2);
    MY_SUB(tmp, temp_6, temp_6);
    //MY_ADD_ft(tmp, temp_6, temp_2);
    // MY_SUB_ft(tmp, temp_6, temp_6);
    
    tmp_id = __id[2];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[2] = tmp_id;
    __id[6] = tmp_id + 32;
    
    tmp = temp_10;
    MY_ADD(tmp, temp_14, temp_10);
    MY_SUB(tmp, temp_14, temp_14);
    //MY_ADD_ft(tmp, temp_14, temp_10);
    // MY_SUB_ft(tmp, temp_14, temp_14);
    
    tmp_id = __id[10];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[10] = tmp_id;
    __id[14] = tmp_id + 32;
    
    tmp = temp_3;
    MY_ADD(tmp, temp_7, temp_3);
    MY_SUB(tmp, temp_7, temp_7);
    //MY_ADD_ft(tmp, temp_7, temp_3);
    // MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[3];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[3] = tmp_id;
    __id[7] = tmp_id + 32;
    
    tmp = temp_11;
    MY_ADD(tmp, temp_15, temp_11);
    MY_SUB(tmp, temp_15, temp_15);
    //MY_ADD_ft(tmp, temp_15, temp_11);
    // MY_SUB_ft(tmp, temp_15, temp_15);
    
    tmp_id = __id[11];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[11] = tmp_id;
    __id[15] = tmp_id + 32;
    
    n_global *= 2;
    
    j = 1;
    k = __id[2] % 64;
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
    
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    
    MY_MUL(temp_6, tmp_angle_rot, tmp);
    temp_6 = tmp;
    
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    
    #if defined(LOG_ON)
    if(tx==0 && bx==0 && ty==0)printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\ntx %d, j %d, k %d, j * k %d, n_global %d, \n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = 0.7071067811865476f;
    tmp_angle_rot.y = -0.7071067811865475f;
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
    
    tmp = temp_0;
    MY_ADD(tmp, temp_2, temp_0);
    MY_SUB(tmp, temp_2, temp_2);
    //MY_ADD_ft(tmp, temp_2, temp_0);
    // MY_SUB_ft(tmp, temp_2, temp_2);
    
    tmp_id = __id[0];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[0] = tmp_id;
    __id[2] = tmp_id + 64;
    
    tmp = temp_8;
    MY_ADD(tmp, temp_10, temp_8);
    MY_SUB(tmp, temp_10, temp_10);
    //MY_ADD_ft(tmp, temp_10, temp_8);
    // MY_SUB_ft(tmp, temp_10, temp_10);
    
    tmp_id = __id[8];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[8] = tmp_id;
    __id[10] = tmp_id + 64;
    
    tmp = temp_4;
    MY_ADD(tmp, temp_6, temp_4);
    MY_SUB(tmp, temp_6, temp_6);
    //MY_ADD_ft(tmp, temp_6, temp_4);
    // MY_SUB_ft(tmp, temp_6, temp_6);
    
    tmp_id = __id[4];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[4] = tmp_id;
    __id[6] = tmp_id + 64;
    
    tmp = temp_12;
    MY_ADD(tmp, temp_14, temp_12);
    MY_SUB(tmp, temp_14, temp_14);
    //MY_ADD_ft(tmp, temp_14, temp_12);
    // MY_SUB_ft(tmp, temp_14, temp_14);
    
    tmp_id = __id[12];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[12] = tmp_id;
    __id[14] = tmp_id + 64;
    
    tmp = temp_1;
    MY_ADD(tmp, temp_3, temp_1);
    MY_SUB(tmp, temp_3, temp_3);
    //MY_ADD_ft(tmp, temp_3, temp_1);
    // MY_SUB_ft(tmp, temp_3, temp_3);
    
    tmp_id = __id[1];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[1] = tmp_id;
    __id[3] = tmp_id + 64;
    
    tmp = temp_9;
    MY_ADD(tmp, temp_11, temp_9);
    MY_SUB(tmp, temp_11, temp_11);
    //MY_ADD_ft(tmp, temp_11, temp_9);
    // MY_SUB_ft(tmp, temp_11, temp_11);
    
    tmp_id = __id[9];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[9] = tmp_id;
    __id[11] = tmp_id + 64;
    
    tmp = temp_5;
    MY_ADD(tmp, temp_7, temp_5);
    MY_SUB(tmp, temp_7, temp_7);
    //MY_ADD_ft(tmp, temp_7, temp_5);
    // MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp_id = __id[5];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[5] = tmp_id;
    __id[7] = tmp_id + 64;
    
    tmp = temp_13;
    MY_ADD(tmp, temp_15, temp_13);
    MY_SUB(tmp, temp_15, temp_15);
    //MY_ADD_ft(tmp, temp_15, temp_13);
    // MY_SUB_ft(tmp, temp_15, temp_15);
    
    tmp_id = __id[13];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[13] = tmp_id;
    __id[15] = tmp_id + 64;
    
    n_global *= 2;
    
    j = 1;
    k = __id[1] % 128;
    MY_ANGLE2COMPLEX((float)(j * k) * -0.02454369260617026f, tmp_angle);
    
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
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    
    MY_MUL(temp_11, tmp_angle_rot, tmp);
    temp_11 = tmp;
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    
    MY_MUL(temp_7, tmp_angle_rot, tmp);
    temp_7 = tmp;
    
    tmp_angle_rot.x = 0.9238795325112867f;
    tmp_angle_rot.y = -0.3826834323650898f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    
    MY_MUL(temp_15, tmp_angle_rot, tmp);
    temp_15 = tmp;
    
    tmp = temp_0;
    MY_ADD(tmp, temp_1, temp_0);
    MY_SUB(tmp, temp_1, temp_1);
    // MY_ADD_ft(tmp, temp_1, temp_0);
    // MY_SUB_ft(tmp, temp_1, temp_1);
    
    tmp = temp_8;
    MY_ADD(tmp, temp_9, temp_8);
    MY_SUB(tmp, temp_9, temp_9);
    // MY_ADD_ft(tmp, temp_9, temp_8);
    // MY_SUB_ft(tmp, temp_9, temp_9);
    
    tmp = temp_4;
    MY_ADD(tmp, temp_5, temp_4);
    MY_SUB(tmp, temp_5, temp_5);
    // MY_ADD_ft(tmp, temp_5, temp_4);
    // MY_SUB_ft(tmp, temp_5, temp_5);
    
    tmp = temp_12;
    MY_ADD(tmp, temp_13, temp_12);
    MY_SUB(tmp, temp_13, temp_13);
    // MY_ADD_ft(tmp, temp_13, temp_12);
    // MY_SUB_ft(tmp, temp_13, temp_13);
    
    tmp = temp_2;
    MY_ADD(tmp, temp_3, temp_2);
    MY_SUB(tmp, temp_3, temp_3);
    // MY_ADD_ft(tmp, temp_3, temp_2);
    // MY_SUB_ft(tmp, temp_3, temp_3);
    
    tmp = temp_10;
    MY_ADD(tmp, temp_11, temp_10);
    MY_SUB(tmp, temp_11, temp_11);
    // MY_ADD_ft(tmp, temp_11, temp_10);
    // MY_SUB_ft(tmp, temp_11, temp_11);
    
    tmp = temp_6;
    MY_ADD(tmp, temp_7, temp_6);
    MY_SUB(tmp, temp_7, temp_7);
    // MY_ADD_ft(tmp, temp_7, temp_6);
    // MY_SUB_ft(tmp, temp_7, temp_7);
    
    tmp = temp_14;
    MY_ADD(tmp, temp_15, temp_14);
    MY_SUB(tmp, temp_15, temp_15);
    // MY_ADD_ft(tmp, temp_15, temp_14);
    // MY_SUB_ft(tmp, temp_15, temp_15);
    
    n_global *= 2;
    
            mem_checksum.x = 0;
            mem_checksum.y = 0;
            mem_checksum.x += temp_0.x;
            mem_checksum.y += temp_0.y;
    mem_checksum.x += temp_1.x;
            mem_checksum.y += temp_1.y;
    mem_checksum.x += temp_2.x;
            mem_checksum.y += temp_2.y;
    mem_checksum.x += temp_3.x;
            mem_checksum.y += temp_3.y;
    mem_checksum.x += temp_4.x;
            mem_checksum.y += temp_4.y;
    mem_checksum.x += temp_5.x;
            mem_checksum.y += temp_5.y;
    mem_checksum.x += temp_6.x;
            mem_checksum.y += temp_6.y;
    mem_checksum.x += temp_7.x;
            mem_checksum.y += temp_7.y;
    mem_checksum.x += temp_8.x;
            mem_checksum.y += temp_8.y;
    mem_checksum.x += temp_9.x;
            mem_checksum.y += temp_9.y;
    mem_checksum.x += temp_10.x;
            mem_checksum.y += temp_10.y;
    mem_checksum.x += temp_11.x;
            mem_checksum.y += temp_11.y;
    mem_checksum.x += temp_12.x;
            mem_checksum.y += temp_12.y;
    mem_checksum.x += temp_13.x;
            mem_checksum.y += temp_13.y;
    mem_checksum.x += temp_14.x;
            mem_checksum.y += temp_14.y;
    mem_checksum.x += temp_15.x;
            mem_checksum.y += temp_15.y;
    
            mem_checksum_t1.y = 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16, 32);
            mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
            mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
            mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
            mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
    
    temp_0.x += 0.001 * (mem_checksum_t1.x);
    temp_0.y += 0.001 * (mem_checksum_t1.y);
    // if(tid == 0 && blockIdx.x == 0)printf("kernel 3, %f\n", temp_0.x, temp_0.y);
            
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[0])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_0, tmp_angle, tmp);
    temp_0 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[0]] = temp_0;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[8])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_8, tmp_angle, tmp);
    temp_8 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[8]] = temp_8;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[4])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_4, tmp_angle, tmp);
    temp_4 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[4]] = temp_4;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[12])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_12, tmp_angle, tmp);
    temp_12 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[12]] = temp_12;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[2])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_2, tmp_angle, tmp);
    temp_2 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[2]] = temp_2;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[10])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_10, tmp_angle, tmp);
    temp_10 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[10]] = temp_10;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[6])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_6, tmp_angle, tmp);
    temp_6 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[6]] = temp_6;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[14])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_14, tmp_angle, tmp);
    temp_14 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[14]] = temp_14;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[1])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_1, tmp_angle, tmp);
    temp_1 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[1]] = temp_1;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[9])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_9, tmp_angle, tmp);
    temp_9 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[9]] = temp_9;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[5])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_5, tmp_angle, tmp);
    temp_5 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[5]] = temp_5;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[13])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_13, tmp_angle, tmp);
    temp_13 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[13]] = temp_13;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[3])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_3, tmp_angle, tmp);
    temp_3 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[3]] = temp_3;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[11])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_11, tmp_angle, tmp);
    temp_11 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[11]] = temp_11;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[7])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_7, tmp_angle, tmp);
    temp_7 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[7]] = temp_7;
    
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * 16) * (__id[15])) / (float)(33554432), tmp_angle);
    MY_MUL(temp_15, tmp_angle, tmp);
    temp_15 = tmp;
    outputs[(tx + bx * 16) + 131072 * __id[15]] = temp_15;
    
    }
