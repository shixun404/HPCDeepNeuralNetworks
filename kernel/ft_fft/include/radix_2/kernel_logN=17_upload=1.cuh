extern __shared__ float shared[];
__global__ void __launch_bounds__(256) fft_logN17_1(float2 *inputs, float2 *outputs){
    float2 *sdata = (float2*) shared;
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int bx = blockIdx.x;
    int N = 256;
	int __id[32];

    float2 temp[32];

    // Gobal memory to shared memory

    int block_read_id = bx * blockDim.x;

    temp[ 0] = inputs[(block_read_id + tx) + (ty +  0 * 16) * 512];
    temp[ 1] = inputs[(block_read_id + tx) + (ty +  1 * 16) * 512];
    temp[ 2] = inputs[(block_read_id + tx) + (ty +  2 * 16) * 512];
    temp[ 3] = inputs[(block_read_id + tx) + (ty +  3 * 16) * 512];
    temp[ 4] = inputs[(block_read_id + tx) + (ty +  4 * 16) * 512];
    temp[ 5] = inputs[(block_read_id + tx) + (ty +  5 * 16) * 512];
    temp[ 6] = inputs[(block_read_id + tx) + (ty +  6 * 16) * 512];
    temp[ 7] = inputs[(block_read_id + tx) + (ty +  7 * 16) * 512];
	temp[ 8] = inputs[(block_read_id + tx) + (ty +  8 * 16) * 512];
    temp[ 9] = inputs[(block_read_id + tx) + (ty +  9 * 16) * 512];
    temp[10] = inputs[(block_read_id + tx) + (ty + 10 * 16) * 512];
    temp[11] = inputs[(block_read_id + tx) + (ty + 11 * 16) * 512];
    temp[12] = inputs[(block_read_id + tx) + (ty + 12 * 16) * 512];
    temp[13] = inputs[(block_read_id + tx) + (ty + 13 * 16) * 512];
    temp[14] = inputs[(block_read_id + tx) + (ty + 14 * 16) * 512];
    temp[15] = inputs[(block_read_id + tx) + (ty + 15 * 16) * 512];

    __id[ 0] = ty +  0 * 16;
    __id[ 1] = ty +  1 * 16;
    __id[ 2] = ty +  2 * 16;
    __id[ 3] = ty +  3 * 16;
    __id[ 4] = ty +  4 * 16;
    __id[ 5] = ty +  5 * 16;
    __id[ 6] = ty +  6 * 16;
    __id[ 7] = ty +  7 * 16;
	__id[ 8] = ty +  8 * 16;
    __id[ 9] = ty +  9 * 16;
    __id[10] = ty + 10 * 16;
    __id[11] = ty + 11 * 16;
    __id[12] = ty + 12 * 16;
    __id[13] = ty + 13 * 16;
    __id[14] = ty + 14 * 16;
    __id[15] = ty + 15 * 16;


    int offset = 16;
	int radix = 2;
	float2 tmp;
	float2 tmp_angle;
	int n = 1, n_global = 1;
	for(n = 1; n < 16; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx == 0 && bx == 0 && ty == 0)printf("############ n_global %d ###########\n", n_global);
		#endif
		for(int i = 0; i < 16; ++i){
			int j = __id[16 - offset + i] / (N / radix);
			int k = __id[16 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[16-offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[16 - offset + i], tmp_angle, tmp);
			temp[16 - offset + i] = tmp;
		}
		
		for(int j = 0; j < 8; ++j){
			MY_ADD(temp[j + 16 - offset], temp[j + 8 + 16 - offset], temp[offset + (j / n) * 2 * n + (j % n)]);
			MY_SUB(temp[j + 16 - offset], temp[j + 8 + 16 - offset], temp[offset + (j / n) * 2 * n + (j % n) + n]);
			__id[offset + (j / n) * 2 * n + (j % n)] = (__id[16 - offset + j] / n_global) * 2 * n_global + (__id[16 - offset + j] % n_global);
			__id[offset + (j / n) * 2 * n + (j % n) + n] = (__id[16 - offset + j] / n_global) * 2 * n_global + (__id[16 - offset + j] % n_global) + n_global;
		}
		offset = offset > 0 ? 0 : 16;
	}
	#if defined(LOG_ON)
	if(tx==0 && bx==0 && ty==0)printf("##########reg to shared ##########\n");
	#endif

	for(int i = 0; i < 16; ++i){
		#if defined(LOG_ON)
		if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[16 - offset + i]);
		#endif
		sdata[tx + 16 * __id[16 - offset + i]] = temp[16 - offset + i];
	}
	__syncthreads();
	for(int i = 0; i < 16; ++i){
		temp[i] = sdata[tx + 16 * (i * blockDim.y + ty)];
		__id[i] = ty + (i * N) / 16;
	}
	offset = 16;
	
	for(n = 1; n < 8; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx == 0 && bx == 0 && ty == 0)printf("############ n_global %d ###########\n", n_global);
		#endif

		for(int i = 0; i < 16; ++i){
			int j = __id[16 - offset + i] / (N / radix);
			int k = __id[16 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[16 - offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[16 - offset + i], tmp_angle, tmp);
			temp[16 - offset + i] = tmp;
		}
		
		for(int j = 0; j < 8; ++j){
			int tmp_id = (__id[16 - offset + j] / n_global) * 2 * n_global + (__id[16 - offset + j] % n_global);
			int tmp_id_left = tmp_id / blockDim.y;
			int tmp_id_right = (tmp_id + n_global) / blockDim.y;
			MY_ADD(temp[j + 16 - offset], temp[j + 8 + 16 - offset], temp[offset + tmp_id_left]);
			MY_SUB(temp[j + 16 - offset], temp[j + 8 + 16 - offset], temp[offset + tmp_id_right]);
			#if defined(LOG_ON)
			if(tx==0 && bx==0 && ty==0)printf("tx %d, left __id[%d] = %d, right __id[%d] = %d\n", tx,  tmp_id_left, tmp_id, tmp_id_right, tmp_id + n_global);
			#endif
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 16;
	}

	for(n = 1; n < 2; n *= 2, n_global *= 2){
		if(tx == 0 && bx == 0 && ty == 0)printf("############ n_global %d ###########\n", n_global);
		for(int i = 0; i < 16; ++i){
			int j = __id[16 - offset + i] / (N / radix);
			int k = __id[16 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[16 - offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[16 - offset + i], tmp_angle, tmp);
			temp[16 - offset + i] = tmp;
		}
		for(int j = 0; j < 8; ++j){
			MY_ADD(temp[j + 16 - offset], temp[j + 8 + 16 - offset], temp[offset + j]);
			MY_SUB(temp[j + 16 - offset], temp[j + 8 + 16 - offset], temp[offset + j + 8]);
			__id[offset + j] = (__id[16 - offset + j] / n_global) * 2 * n_global + (__id[16 - offset + j] % n_global);
			__id[offset + j + 8] = (__id[16 - offset + j] / n_global) * 2 * n_global + (__id[16 - offset + j] % n_global) + n_global;
		}
		offset = offset > 0 ? 0 : 16;
	}
	#if defined(LOG_ON)
	if(tx==0 && bx==0 && ty==0)printf("##########reg to global ##########\n");
	#endif
	for(int i = 0; i < 16; ++i){
		#if defined(LOG_ON)
		if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[16 - offset + i]);
		#endif
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * blockDim.x) * (__id[16 - offset + i])) / (float)(65536 * 2), tmp_angle);
		MY_MUL(temp[16 - offset + i], tmp_angle, tmp);
        temp[16 - offset + i] = tmp;
		outputs[(tx + bx * blockDim.x) + 512 * __id[16 - offset + i]] = temp[16 - offset + i];
    }
}