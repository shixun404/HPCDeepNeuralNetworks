extern __shared__ float shared[];
__global__ void __launch_bounds__(2) vkfft_logN4 (float2* inputs, float2* outputs) {
	float2* sdata = (float2*)shared;
	float2 temp[16];
	int tx = threadIdx.x;
	int N = 16;
	memset(temp, 0, sizeof(float2) * 16);
	int __id[16];
	// load from global
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		// printf("tx %d, inputs id %d\n", tx,  i * 2 + tx);
		temp[i] = inputs[i * 2 + tx];
		__id[i] = tx + (i * N) / 8;
	}

	int offset = 8;
	int radix = 2;
	float2 tmp;
	float2 tmp_angle;
	int n = 1, n_global = 1;
	for(n = 1; n < 8; n *= 2, n_global *= 2){
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n;
			if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n, tmp_angle);
			MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
			temp[8 - offset + i] = tmp;
		}
		
		for(int j = 0; j < 4; ++j){
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n)]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n) + n]);
			__id[offset + (j / n) * 2 * n + (j % n)] = (__id[8 - offset + j] / n) * 2 * n + (__id[8 - offset + j] % n);
			__id[offset + (j / n) * 2 * n + (j % n) + n] = (__id[8 - offset + j] / n) * 2 * n + (__id[8 - offset + j] % n) + n;
		}
		offset = offset > 0 ? 0 : 8;
		if(tx==0)printf("#############################\n");
	}
	// printf("#############################\n");
	if(tx==0)printf("##########reg to shared ##########\n");
	for(int i = 0; i < 8; ++i){
		
		if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		sdata[__id[8-offset + i]] = temp[8-offset + i];
	}
	if(tx==0)printf("####################\n");
	__syncthreads();
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[i * 2 + tx];
		__id[i] = tx + (i * N) / 8;
	}
	offset = 8;
	for(n = 1; n < 2; n *= 2, n_global *= 2){
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
			temp[8 - offset + i] = tmp;
		}
		for(int j = 0; j < 4; ++j){
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + j]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + j + 4]);
			__id[offset + j] = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global);
			__id[offset + j + 4] = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global) + n_global;
		}
		if(tx==0)printf("#############################\n");
		offset = offset > 0 ? 0 : 8;
	}
	if(tx==0)printf("##########reg to global ##########\n");
	for(int i = 0; i < 8; ++i){
		
		if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		outputs[__id[8-offset + i]] = temp[8-offset + i];
	}		
}





__global__ void __launch_bounds__(1) vkfft_logN3 (float2* inputs, float2* outputs) {
	// float2* sdata = (float2*)shared;
	float2 temp[16];
	int tx = threadIdx.x;
	memset(temp, 0, sizeof(float2) * 16);

	// load from global
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = inputs[i];
	}

	int offset = 8;
	int radix = 2;
	float2 tmp;
	float2 tmp_angle;
	int n = 1;
	for(n = 1; n < 8; n *= 2){
		for(int j = 0; j < radix; ++j){
			for(int s = 0; s < 4; s += n){
				for(int k = 0; k < n; k++){
					MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n, tmp_angle);
					MY_MUL(temp[8 - offset + k + j * 4 + s], tmp_angle, tmp);
					temp[8 - offset + k + j * 4 + s] = tmp;
				}
			}
		}
		for(int j = 0; j < 4; ++j){
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n)]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n) + n]);
		}
		offset = offset > 0 ? 0 : 8;
	}
	// for(int j = 0; j < 4; ++j){
	// 		MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n)]);
	// 		MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n) + n]);
	// }

	for(int i = 0; i < 8; ++i){
		outputs[i] = temp[8-offset + i];
	}	
}