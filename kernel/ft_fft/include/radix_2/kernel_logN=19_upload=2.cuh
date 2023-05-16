extern __shared__ float shared[];
__global__ void __launch_bounds__(128) fft_logN19_2(float2 *inputs, float2 *outputs){
    float2 *sdata = (float2*) shared;
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int bx = blockIdx.x;
    int N = 1024;
	int __id[64];
    float2 temp[64];
    // Gobal memory to shared memory

    int block_read_id = bx * blockDim.x;
	
	#pragma unroll
	for(int i = 0; i < 32; ++i){
		temp[i] = inputs[(block_read_id + tx) * 1024 + (ty +  i * 32)];
		__id[i] = ty + i * 32;
	}
    
    // temp[ 1] = inputs[(block_read_id + tx) * 1024 + (ty +  1 * 32)];
    // temp[ 2] = inputs[(block_read_id + tx) * 1024 + (ty +  2 * 32)];
    // temp[ 3] = inputs[(block_read_id + tx) * 1024 + (ty +  3 * 32)];
    // temp[ 4] = inputs[(block_read_id + tx) * 1024 + (ty +  4 * 32)];
    // temp[ 5] = inputs[(block_read_id + tx) * 1024 + (ty +  5 * 32)];
    // temp[ 6] = inputs[(block_read_id + tx) * 1024 + (ty +  6 * 32)];
    // temp[ 7] = inputs[(block_read_id + tx) * 1024 + (ty +  7 * 32)];
	// temp[ 8] = inputs[(block_read_id + tx) * 1024 + (ty +  8 * 32)];
    // temp[ 9] = inputs[(block_read_id + tx) * 1024 + (ty +  9 * 32)];
    // temp[10] = inputs[(block_read_id + tx) * 1024 + (ty + 10 * 32)];
    // temp[11] = inputs[(block_read_id + tx) * 1024 + (ty + 11 * 32)];
    // temp[12] = inputs[(block_read_id + tx) * 1024 + (ty + 12 * 32)];
    // temp[13] = inputs[(block_read_id + tx) * 1024 + (ty + 13 * 32)];
    // temp[14] = inputs[(block_read_id + tx) * 1024 + (ty + 14 * 32)];
    // temp[15] = inputs[(block_read_id + tx) * 1024 + (ty + 15 * 32)];
	// temp[16] = inputs[(block_read_id + tx) * 1024 + (ty +  0 * 32)];
    // temp[17] = inputs[(block_read_id + tx) * 1024 + (ty +  1 * 32)];
    // temp[18] = inputs[(block_read_id + tx) * 1024 + (ty +  2 * 32)];
    // temp[19] = inputs[(block_read_id + tx) * 1024 + (ty +  3 * 32)];
    // temp[20] = inputs[(block_read_id + tx) * 1024 + (ty +  4 * 32)];
    // temp[21] = inputs[(block_read_id + tx) * 1024 + (ty +  5 * 32)];
    // temp[22] = inputs[(block_read_id + tx) * 1024 + (ty +  6 * 32)];
    // temp[23] = inputs[(block_read_id + tx) * 1024 + (ty +  7 * 32)];
	// temp[24] = inputs[(block_read_id + tx) * 1024 + (ty +  8 * 32)];
    // temp[25] = inputs[(block_read_id + tx) * 1024 + (ty +  9 * 32)];
    // temp[26] = inputs[(block_read_id + tx) * 1024 + (ty + 10 * 32)];
    // temp[27] = inputs[(block_read_id + tx) * 1024 + (ty + 11 * 32)];
    // temp[28] = inputs[(block_read_id + tx) * 1024 + (ty + 12 * 32)];
    // temp[29] = inputs[(block_read_id + tx) * 1024 + (ty + 13 * 32)];
    // temp[30] = inputs[(block_read_id + tx) * 1024 + (ty + 14 * 32)];
    // temp[31] = inputs[(block_read_id + tx) * 1024 + (ty + 15 * 32)];

    // __id[0] = tx + 0 * 64;
    // __id[1] = tx + 1 * 64;
    // __id[2] = tx + 2 * 64;
    // __id[3] = tx + 3 * 64;
    // __id[4] = tx + 4 * 64;
    // __id[5] = tx + 5 * 64;
    // __id[6] = tx + 6 * 64;
    // __id[7] = tx + 7 * 64;


    int offset = 32;
	int radix = 2;
	float2 tmp;
	float2 tmp_angle;
	int n = 1, n_global = 1;

	#pragma unroll
	for(n = 1; n < 32; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 32; ++i){
			int j = __id[32 - offset + i] / (N / radix);
			int k = __id[32 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[32 - offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[32 - offset + i], tmp_angle, tmp);
			temp[32 - offset + i] = tmp;
		}
		
		#pragma unroll
		for(int j = 0; j < 16; ++j){
			MY_ADD(temp[j + 32 - offset], temp[j + 16 + 32 - offset], temp[offset + (j / n) * 2 * n + (j % n)]);
			MY_SUB(temp[j + 32 - offset], temp[j + 16 + 32 - offset], temp[offset + (j / n) * 2 * n + (j % n) + n]);
			__id[offset + (j / n) * 2 * n + (j % n)] = (__id[32 - offset + j] / n_global) * 2 * n_global + (__id[32 - offset + j] % n_global);
			__id[offset + (j / n) * 2 * n + (j % n) + n] = (__id[32 - offset + j] / n_global) * 2 * n_global + (__id[32 - offset + j] % n_global) + n_global;
		}
		offset = offset > 0 ? 0 : 32;
	}
	
	#if defined(LOG_ON)
	if(tx==0 && ty == 0 && bx==0)printf("##########reg to shared ##########\n");
	#endif

	#pragma unroll
	for(int i = 0; i < 32; ++i){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[32 - offset + i]);
		#endif
		sdata[__id[32 - offset + i] + 1024 * tx] = temp[32 - offset + i];
	}
	__syncthreads();

	#pragma unroll
	for(int i = 0; i < 32; ++i){
		temp[i] = sdata[(i * blockDim.y + ty) + 1024 * tx];
		__id[i] = ty + (i * N) / 32;
	}
	offset = 32;
	
	#pragma unroll
	for(n = 1; n < 16; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 32; ++i){
			int j = __id[32 - offset + i] / (N / radix);
			int k = __id[32 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[32 - offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[32 - offset + i], tmp_angle, tmp);
			temp[32 - offset + i] = tmp;
		}
		
		#pragma unroll
		for(int j = 0; j < 16; ++j){
			int tmp_id = (__id[32 - offset + j] / n_global) * 2 * n_global + (__id[32 - offset + j] % n_global);
			int tmp_id_left = tmp_id / blockDim.y;
			int tmp_id_right = (tmp_id + n_global) / blockDim.y;
			MY_ADD(temp[j + 32 - offset], temp[j + 16 + 32 - offset], temp[offset + tmp_id_left]);
			MY_SUB(temp[j + 32 - offset], temp[j + 16 + 32 - offset], temp[offset + tmp_id_right]);
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, left __id[%d] = %d, right __id[%d] = %d\n", tx, tmp_id_left, tmp_id, tmp_id_right, tmp_id + n_global);
			#endif
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 32;
	}	

	#pragma unroll
	for(n = 1; n < 2; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 32; ++i){
			int j = __id[32 - offset + i] / (N / radix);
			int k = __id[32 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[32 - offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[32 - offset + i], tmp_angle, tmp);
			temp[32 - offset + i] = tmp;
		}
		
		#pragma unroll
		for(int j = 0; j < 16; ++j){
			MY_ADD(temp[j + 32 - offset], temp[j + 16 + 32 - offset], temp[offset + j]);
			MY_SUB(temp[j + 32 - offset], temp[j + 16 + 32 - offset], temp[offset + j + 16]);
			__id[offset + j] = (__id[32 - offset + j] / n_global) * 2 * n_global + (__id[32 - offset + j] % n_global);
			__id[offset + j + 16] = (__id[32 - offset + j] / n_global) * 2 * n_global + (__id[32 - offset + j] % n_global) + n_global;
		}
		offset = offset > 0 ? 0 : 32;
	}
	#if defined(LOG_ON)
	if(tx==0 && ty == 0 && bx==0)printf("##########reg to global ##########\n");
	#endif
	
	#pragma unroll
	for(int i = 0; i < 32; ++i){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[32 - offset + i]);
		#endif
		outputs[(tx + bx * blockDim.x) + 512 * __id[32 - offset + i]] = temp[32 - offset + i];
	}

    
    
    // Perform FFT like logN6

    // Each threadblock 




}