extern __shared__ float shared[];
__global__ void __launch_bounds__(128) fft_radix2_logN15_1(float2 *inputs, float2 *outputs){
    float2 *sdata = (float2*) shared;
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int bx = blockIdx.x;
    int N = 64;
	int __id[16];

    float2 temp[16];

    // Gobal memory to shared memory

    int block_read_id = bx * blockDim.x;
    int thread_read_x = tx;
    int thread_read_y = ty * 16;

    temp[0] = inputs[(block_read_id + tx) + (ty +  0) * 512];
    temp[1] = inputs[(block_read_id + tx) + (ty +  8) * 512];
    temp[2] = inputs[(block_read_id + tx) + (ty + 16) * 512];
    temp[3] = inputs[(block_read_id + tx) + (ty + 24) * 512];
    temp[4] = inputs[(block_read_id + tx) + (ty + 32) * 512];
    temp[5] = inputs[(block_read_id + tx) + (ty + 40) * 512];
    temp[6] = inputs[(block_read_id + tx) + (ty + 48) * 512];
    temp[7] = inputs[(block_read_id + tx) + (ty + 56) * 512];

    __id[0] = ty + 0 * 8;
    __id[1] = ty + 1 * 8;
    __id[2] = ty + 2 * 8;
    __id[3] = ty + 3 * 8;
    __id[4] = ty + 4 * 8;
    __id[5] = ty + 5 * 8;
    __id[6] = ty + 6 * 8;
    __id[7] = ty + 7 * 8;


    int offset = 8;
	int radix = 2;
	float2 tmp;
	float2 tmp_angle;
	int n = 1, n_global = 1;
	for(n = 1; n < 8; n *= 2, n_global *= 2){
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
			#endif
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
			temp[8 - offset + i] = tmp;
		}
		
		for(int j = 0; j < 4; ++j){
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n)]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + (j / n) * 2 * n + (j % n) + n]);
			__id[offset + (j / n) * 2 * n + (j % n)] = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global);
			__id[offset + (j / n) * 2 * n + (j % n) + n] = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global) + n_global;
		}
		offset = offset > 0 ? 0 : 8;
		#if defined(LOG)
		if(tx==0 && bx==0 && ty==0)printf("#############################\n");
		#endif
	}
	// printf("#############################\n");
	#if defined(LOG_ON)
	if(tx==0 && bx==0 && ty==0)printf("##########reg to shared ##########\n");
	#endif

	for(int i = 0; i < 8; ++i){
		#if defined(LOG_ON)
		if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		#endif
		sdata[tx + 16 * __id[8-offset + i]] = temp[8-offset + i];
	}
	#if defined(LOG_ON)
	if(tx==0 && bx==0 && ty==0)printf("####################\n");
	#endif
	__syncthreads();
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[tx + 16 * (i * blockDim.y + ty)];
		__id[i] = ty + (i * N) / 8;
	}
	offset = 8;
	
	for(n = 1; n < 4; n *= 2, n_global *= 2){
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
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
			if(tx==0 && bx==0 && ty==0)printf("tx %d, left __id[%d] = %d, right __id[%d] = %d\n", tx,  tmp_id_left, tmp_id, tmp_id_right, tmp_id + n_global);
			#endif
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 8;
		#if defined(LOG_ON)
		if(tx==0 && bx==0 && ty==0)printf("#############################\n");
		#endif
	}

	for(n = 1; n < 2; n *= 2, n_global *= 2){
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
			#endif
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
		#if defined(LOG_ON)
		if(tx==0 && bx==0 && ty==0)printf("#############################\n");
		#endif
		offset = offset > 0 ? 0 : 8;
	}
	#if defined(LOG_ON)
	if(tx==0 && bx==0 && ty==0)printf("##########reg to global ##########\n");
	#endif
	for(int i = 0; i < 8; ++i){
		#if defined(LOG_ON)
		if(tx==0 && bx==0 && ty==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		#endif
        MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * blockDim.x) * (__id[8-offset + i])) / (float)(32768), tmp_angle);
		MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
        temp[8 - offset + i] = tmp;
		outputs[(tx + bx * blockDim.x) + 512 * __id[8 - offset + i]] = temp[8 - offset + i];
    }
}