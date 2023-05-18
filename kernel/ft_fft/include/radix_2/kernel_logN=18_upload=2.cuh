extern __shared__ float shared[];
__global__ void __launch_bounds__(1024) fft_logN18_2(float2 *inputs, float2 *outputs){
    float2 *sdata = (float2*) shared;
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int bx = blockIdx.x;
    int N = 512;
	int __id[16];
    float2 temp[16];
    // Gobal memory to shared memory

    int block_read_id = bx * blockDim.y;

    temp[0] = inputs[(block_read_id + ty) * 512 + (tx + 0 * 64)];
    temp[1] = inputs[(block_read_id + ty) * 512 + (tx + 1 * 64)];
    temp[2] = inputs[(block_read_id + ty) * 512 + (tx + 2 * 64)];
    temp[3] = inputs[(block_read_id + ty) * 512 + (tx + 3 * 64)];
    temp[4] = inputs[(block_read_id + ty) * 512 + (tx + 4 * 64)];
    temp[5] = inputs[(block_read_id + ty) * 512 + (tx + 5 * 64)];
    temp[6] = inputs[(block_read_id + ty) * 512 + (tx + 6 * 64)];
    temp[7] = inputs[(block_read_id + ty) * 512 + (tx + 7 * 64)];

    __id[0] = tx + 0 * 64;
    __id[1] = tx + 1 * 64;
    __id[2] = tx + 2 * 64;
    __id[3] = tx + 3 * 64;
    __id[4] = tx + 4 * 64;
    __id[5] = tx + 5 * 64;
    __id[6] = tx + 6 * 64;
    __id[7] = tx + 7 * 64;


    int offset = 8;
	int radix = 2;
	float2 tmp;
	float2 tmp_angle;
	int n = 1, n_global = 1;

	#pragma unroll
	for(n = 1; n < 8; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
			temp[8 - offset + i] = tmp;
		}
		
		#pragma unroll
		for(int j = 0; j < 4; ++j){
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n)]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n) + n]);
			__id[offset + (j / n) * 2 * n + (j % n)] = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global);
			__id[offset + (j / n) * 2 * n + (j % n) + n] = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global) + n_global;
		}
		offset = offset > 0 ? 0 : 8;
	}
	
	#if defined(LOG_ON)
	if(tx==0 && ty == 0 && bx==0)printf("##########reg to shared ##########\n");
	#endif

	#pragma unroll
	for(int i = 0; i < 8; ++i){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		#endif
		sdata[__id[8-offset + i] + 512 * ty] = temp[8-offset + i];
	}
	__syncthreads();

	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[(i * blockDim.x + tx) + 512 * ty];
		__id[i] = tx + (i * N) / 8;
	}
	offset = 8;
	
	#pragma unroll
	for(n = 1; n < 8; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
			temp[8 - offset + i] = tmp;
		}
		
		#pragma unroll
		for(int j = 0; j < 4; ++j){
			int tmp_id = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global);
			int tmp_id_left = (j / n) * 2 * n + (j % n);
			int tmp_id_right = (j / n) * 2 * n + (j % n) + n;
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + tmp_id_left]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + tmp_id_right]);
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, left __id[%d] = %d, right __id[%d] = %d\n", tx,  (j / n) * 2 * n + (j % n), tmp_id, (j / n) * 2 * n + (j % n) + n, tmp_id + n_global);
			#endif
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 8;
	}
	
	#if defined(LOG_ON)
	if(tx==0 && ty == 0 && bx==0)printf("##########reg to shared ##########\n");
	#endif
	__syncthreads();
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		#endif
		sdata[__id[8-offset + i] + 512 * ty] = temp[8-offset + i];
	}
	__syncthreads();

	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[(i * blockDim.x + tx) + 512 * ty];
		__id[i] = tx + (i * N) / 8;
	}
	offset = 8;
	
	
	
	for(n = 1; n < 4; n *= 2, n_global *= 2){
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
			temp[8 - offset + i] = tmp;
		}
		
		for(int j = 0; j < 4; ++j){
			int tmp_id = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global);
			int tmp_id_left = tmp_id / blockDim.x;
			int tmp_id_right = (tmp_id + n_global) / blockDim.x;
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + tmp_id_left]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + tmp_id_right]);
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, left __id[%d] = %d, right __id[%d] = %d\n", tx,  tmp_id_left, tmp_id, tmp_id_right, tmp_id + n_global);
			#endif
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 8;
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("#############################\n");
		#endif
	}

	#pragma unroll
	for(n = 1; n < 2; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
			temp[8 - offset + i] = tmp;
		}
		
		#pragma unroll
		for(int j = 0; j < 4; ++j){
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + j]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + j + 4]);
			__id[offset + j] = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global);
			__id[offset + j + 4] = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global) + n_global;
		}
		offset = offset > 0 ? 0 : 8;
	}
	#if defined(LOG_ON)
	if(tx==0 && ty == 0 && bx==0)printf("##########reg to global ##########\n");
	#endif
	
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		#if defined(LOG_ON)
		if(tx==0 && ty == 0 && bx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		#endif
		outputs[(ty + bx * blockDim.y) + 512 * __id[8 - offset + i]] = temp[8 - offset + i];
	}

    
    
    // Perform FFT like logN6

    // Each threadblock 




}