extern __shared__ float shared[];
__global__ void __launch_bounds__(4) fft_logN4 (float2* inputs, float2* outputs) {
	float2* sdata = (float2*)shared;
	float2 temp[8];
	int tx = threadIdx.x;
	int N = 16;
	int __id[8];
	// load from global
	#pragma unroll
	for(int i = 0; i < 4; ++i){
		temp[i] = inputs[i * 4 + tx];
		__id[i] = tx + (i * N) / 4;
	}

	int offset = 4;
	int radix = 2;
	float2 tmp;
	float2 tmp_angle;
	int n = 1, n_global = 1;
	for(n = 1; n < 4; n *= 2, n_global *= 2){
		for(int i = 0; i < 4; ++i){
			int j = __id[4 - offset + i] / (N / radix);
			int k = __id[4 - offset + i] % n;
			#if defined(PROFILING)
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n, tmp_angle);
			#endif
			MY_MUL(temp[4 - offset + i], tmp_angle, tmp);
			temp[4 - offset + i] = tmp;
		}
		
		for(int j = 0; j < 2; ++j){
			MY_ADD(temp[j + 4 - offset], temp[j + 2 + 4 - offset], temp[offset + (j / n) * 2 * n + (j % n)]);
			MY_SUB(temp[j + 4 - offset], temp[j + 2 + 4 - offset], temp[offset + (j / n) * 2 * n + (j % n) + n]);
			__id[offset + (j / n) * 2 * n + (j % n)] = (__id[4 - offset + j] / n) * 2 * n + (__id[4 - offset + j] % n);
			__id[offset + (j / n) * 2 * n + (j % n) + n] = (__id[4 - offset + j] / n) * 2 * n + (__id[4 - offset + j] % n) + n;
		}
		offset = offset > 0 ? 0 : 4;
	}
	for(int i = 0; i < 4; ++i){
		sdata[__id[4 - offset + i]] = temp[4 - offset + i];
	}
	__syncthreads();
	for(int i = 0; i < 4; ++i){
		temp[i] = sdata[i * 4 + tx];
		__id[i] = tx + (i * N) / 4;
	}
	offset = 4;
	
	for(n = 1; n < 2; n *= 2, n_global *= 2){
		for(int i = 0; i < 4; ++i){
			int j = __id[4 - offset + i] / (N / radix);
			int k = __id[4 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[4 - offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[4 - offset + i], tmp_angle, tmp);
			temp[4 - offset + i] = tmp;
		}
		
		for(int j = 0; j < 2; ++j){
			int tmp_id = (__id[4 - offset + j] / n_global) * 2 * n_global + (__id[4 - offset + j] % n_global);
			int tmp_id_left = tmp_id / blockDim.x;
			int tmp_id_right = (tmp_id + n_global) / blockDim.x;
			MY_ADD(temp[j + 4 - offset], temp[j + 2 + 4 - offset], temp[offset + tmp_id_left]);
			MY_SUB(temp[j + 4 - offset], temp[j + 2 + 4 - offset], temp[offset + tmp_id_right]);
			#if defined(LOG_ON)
			if(tx==0)printf("tx %d, left __id[%d] = %d, right __id[%d] = %d\n", tx,  tmp_id_left, tmp_id, tmp_id_right, tmp_id + n_global);
			#endif
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 4;
		#if defined(LOG_ON)
		if(tx==0)printf("#############################\n");
		#endif
	}
	
	for(n = 1; n < 2; n *= 2, n_global *= 2){
		for(int i = 0; i < 4; ++i){
			int j = __id[4 - offset + i] / (N / radix);
			int k = __id[4 - offset + i] % n_global;
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[4 - offset + i], tmp_angle, tmp);
			temp[4 - offset + i] = tmp;
		}
		for(int j = 0; j < 2; ++j){
			MY_ADD(temp[j + 4 - offset], temp[j + 2 + 4 - offset], temp[offset + j]);
			MY_SUB(temp[j + 4 - offset], temp[j + 2 + 4 - offset], temp[offset + j + 2]);
			__id[offset + j] = (__id[4 - offset + j] / n_global) * 2 * n_global + (__id[4 - offset + j] % n_global);
			__id[offset + j + 2] = (__id[4 - offset + j] / n_global) * 2 * n_global + (__id[4 - offset + j] % n_global) + n_global;
		}
		offset = offset > 0 ? 0 : 4;
	}
	for(int i = 0; i < 4; ++i){
		outputs[__id[4 - offset + i]] = temp[4 - offset + i];
	}		
}