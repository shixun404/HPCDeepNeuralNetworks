extern __shared__ float shared[];
__global__ void __launch_bounds__(512) fft_logN14_2(float2 *inputs, float2 *outputs){
    float2 *sdata = (float2*) shared;
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int bx = blockIdx.x;
    int N = 256;
	int __id[16];

    float2 temp[16];

    // Gobal memory to shared memory

    int block_read_id = bx * blockDim.x;

    temp[0] = inputs[(block_read_id + tx) * 256 + (ty + 0 * 32)];
    temp[1] = inputs[(block_read_id + tx) * 256 + (ty + 1 * 32)];
    temp[2] = inputs[(block_read_id + tx) * 256 + (ty + 2 * 32)];
    temp[3] = inputs[(block_read_id + tx) * 256 + (ty + 3 * 32)];
    temp[4] = inputs[(block_read_id + tx) * 256 + (ty + 4 * 32)];
    temp[5] = inputs[(block_read_id + tx) * 256 + (ty + 5 * 32)];
    temp[6] = inputs[(block_read_id + tx) * 256 + (ty + 6 * 32)];
    temp[7] = inputs[(block_read_id + tx) * 256 + (ty + 7 * 32)];

    __id[0] = ty + 0 * 32;
    __id[1] = ty + 1 * 32;
    __id[2] = ty + 2 * 32;
    __id[3] = ty + 3 * 32;
    __id[4] = ty + 4 * 32;
    __id[5] = ty + 5 * 32;
    __id[6] = ty + 6 * 32;
    __id[7] = ty + 7 * 32;


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
		sdata[__id[8-offset + i] + 256 * tx] = temp[8-offset + i];
	}
	__syncthreads();

	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[(i * blockDim.y + ty) + 256 * tx];
		__id[i] = ty + (i * N) / 8;
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
		sdata[__id[8-offset + i] + 256 * tx] = temp[8-offset + i];
	}
	__syncthreads();

	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[(i * blockDim.y + ty) + 256 * tx];
		__id[i] = ty + (i * N) / 8;
	}
	offset = 8;
	
	
	
	for(n = 1; n < 2; n *= 2, n_global *= 2){
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
			int tmp_id_left = tmp_id / blockDim.y;
			int tmp_id_right = (tmp_id + n_global) / blockDim.y;
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
		outputs[(tx + bx * blockDim.x) + 64 * __id[8 - offset + i]] = temp[8 - offset + i];
	}

    
    
    // Perform FFT like logN6

    // Each threadblock 




}