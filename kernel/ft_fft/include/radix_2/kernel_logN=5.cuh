extern __shared__ float shared[];
__global__ void __launch_bounds__(4) fft_radix2_logN5 (float2* inputs, float2* outputs) {
	float2* sdata = (float2*)shared;
	float2 temp[16];
	int tx = threadIdx.x;
	int N = 32;
	int __id[16];
	// load from global
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = inputs[i * 4 + tx];
		__id[i] = tx + (i * N) / 8;
	}

	int offset = 8;
	int radix = 2;
	float2 tmp;
	float2 tmp_angle;
	int n = 1, n_global = 1;
	#pragma unroll
	for(n = 1; n < 8; n *= 2, n_global *= 2){
		
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(PROFILING)
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			#endif
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
	
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		// sdata[__id[8-offset + i]] = temp[8-offset + i];
		sdata[(__id[8-offset + i] / 16) * 17 + __id[8-offset + i] % 16] = temp[8-offset + i];
	}
	__syncthreads();
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[((i * 4 + tx) / 16 ) * 17 + (i * 4 + tx) % 16];
		// temp[i] = sdata[i * 4 + tx];
		__id[i] = tx + (i * N) / 8;
	}
	offset = 8;
	
	#pragma unroll
	for(n = 1; n < 2; n *= 2, n_global *= 2){
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			MY_ANGLE2COMPLEX((float)(-M_PI * j * k) / (float)n_global, tmp_angle);
			MY_MUL(temp[8 - offset + i], tmp_angle, tmp);
			temp[8 - offset + i] = tmp;
		}
		#pragma unroll
		for(int j = 0; j < 4; ++j){
			int tmp_id = (__id[8 - offset + j] / n_global) * 2 * n_global + (__id[8 - offset + j] % n_global);
			int tmp_id_left = tmp_id / blockDim.x;
			int tmp_id_right = (tmp_id + n_global) / blockDim.x;
			MY_ADD(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + tmp_id_left]);
			MY_SUB(temp[j + 8 - offset], temp[j + 4 + 8 - offset], temp[offset + tmp_id_right]);
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 8;
	}
	#pragma unroll
	for(n = 1; n < 2; n *= 2, n_global *= 2){
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
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
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		outputs[__id[8-offset + i]] = temp[8-offset + i];
	}		
}








// extern __shared__ float shared[];
// __global__ void __launch_bounds__(4) vkfft_radix2_logN5 (float2* inputs, float2* outputs) {
// unsigned int sharedStride = 48;
// float2* sdata = (float2*)shared;
// 	int stride = 16;
// 	float2 temp_0;
// 	temp_0.x=0;
// 	temp_0.y=0;
// 	float2 temp_1;
// 	temp_1.x=0;
// 	temp_1.y=0;
// 	float2 temp_2;
// 	temp_2.x=0;
// 	temp_2.y=0;
// 	float2 temp_3;
// 	temp_3.x=0;
// 	temp_3.y=0;
// 	float2 temp_4;
// 	temp_4.x=0;
// 	temp_4.y=0;
// 	float2 temp_5;
// 	temp_5.x=0;
// 	temp_5.y=0;
// 	float2 temp_6;
// 	temp_6.x=0;
// 	temp_6.y=0;
// 	float2 temp_7;
// 	temp_7.x=0;
// 	temp_7.y=0;
// 	float2 w;
// 	w.x=0;
// 	w.y=0;
// 	float2 loc_0;
// 	loc_0.x=0;
// 	loc_0.y=0;
// 	float2 iw;
// 	iw.x=0;
// 	iw.y=0;
// 	unsigned int stageInvocationID=0;
// 	unsigned int blockInvocationID=0;
// 	unsigned int sdataID=0;
// 	unsigned int combinedID=0;
// 	unsigned int inoutID=0;
// 	float angle=0;
// 		{ 
// 		combinedID = threadIdx.x + 0;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		temp_0 = inputs[inoutID];
// 		combinedID = threadIdx.x + 4;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		temp_1 = inputs[inoutID];
// 		combinedID = threadIdx.x + 8;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		temp_2 = inputs[inoutID];
// 		combinedID = threadIdx.x + 12;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		temp_3 = inputs[inoutID];
// 		combinedID = threadIdx.x + 16;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		temp_4 = inputs[inoutID];
// 		combinedID = threadIdx.x + 20;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		temp_5 = inputs[inoutID];
// 		combinedID = threadIdx.x + 24;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		temp_6 = inputs[inoutID];
// 		combinedID = threadIdx.x + 28;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		temp_7 = inputs[inoutID];
// 	}
// 		stageInvocationID = (threadIdx.x+ 0) % (1);
// 		angle = stageInvocationID * -3.14159265358979312e+00f;
// 	w.x = 1;
// 	w.y = 0;
// 	loc_0.x = temp_4.x * w.x - temp_4.y * w.y;
// 	loc_0.y = temp_4.y * w.x + temp_4.x * w.y;
// 	temp_4.x = temp_0.x - loc_0.x;
// 	temp_4.y = temp_0.y - loc_0.y;
// 	temp_0.x = temp_0.x + loc_0.x;
// 	temp_0.y = temp_0.y + loc_0.y;
// 	loc_0.x = temp_5.x * w.x - temp_5.y * w.y;
// 	loc_0.y = temp_5.y * w.x + temp_5.x * w.y;
// 	temp_5.x = temp_1.x - loc_0.x;
// 	temp_5.y = temp_1.y - loc_0.y;
// 	temp_1.x = temp_1.x + loc_0.x;
// 	temp_1.y = temp_1.y + loc_0.y;
// 	loc_0.x = temp_6.x * w.x - temp_6.y * w.y;
// 	loc_0.y = temp_6.y * w.x + temp_6.x * w.y;
// 	temp_6.x = temp_2.x - loc_0.x;
// 	temp_6.y = temp_2.y - loc_0.y;
// 	temp_2.x = temp_2.x + loc_0.x;
// 	temp_2.y = temp_2.y + loc_0.y;
// 	loc_0.x = temp_7.x * w.x - temp_7.y * w.y;
// 	loc_0.y = temp_7.y * w.x + temp_7.x * w.y;
// 	temp_7.x = temp_3.x - loc_0.x;
// 	temp_7.y = temp_3.y - loc_0.y;
// 	temp_3.x = temp_3.x + loc_0.x;
// 	temp_3.y = temp_3.y + loc_0.y;
// 	w.x = 1;
// 	w.y = 0;
// 	loc_0.x = temp_2.x * w.x - temp_2.y * w.y;
// 	loc_0.y = temp_2.y * w.x + temp_2.x * w.y;
// 	temp_2.x = temp_0.x - loc_0.x;
// 	temp_2.y = temp_0.y - loc_0.y;
// 	temp_0.x = temp_0.x + loc_0.x;
// 	temp_0.y = temp_0.y + loc_0.y;
// 	loc_0.x = temp_3.x * w.x - temp_3.y * w.y;
// 	loc_0.y = temp_3.y * w.x + temp_3.x * w.y;
// 	temp_3.x = temp_1.x - loc_0.x;
// 	temp_3.y = temp_1.y - loc_0.y;
// 	temp_1.x = temp_1.x + loc_0.x;
// 	temp_1.y = temp_1.y + loc_0.y;
// 	iw.x = w.y;
// 	iw.y = -w.x;
// 	loc_0.x = temp_6.x * iw.x - temp_6.y * iw.y;
// 	loc_0.y = temp_6.y * iw.x + temp_6.x * iw.y;
// 	temp_6.x = temp_4.x - loc_0.x;
// 	temp_6.y = temp_4.y - loc_0.y;
// 	temp_4.x = temp_4.x + loc_0.x;
// 	temp_4.y = temp_4.y + loc_0.y;
// 	loc_0.x = temp_7.x * iw.x - temp_7.y * iw.y;
// 	loc_0.y = temp_7.y * iw.x + temp_7.x * iw.y;
// 	temp_7.x = temp_5.x - loc_0.x;
// 	temp_7.y = temp_5.y - loc_0.y;
// 	temp_5.x = temp_5.x + loc_0.x;
// 	temp_5.y = temp_5.y + loc_0.y;
// 	w.x = 1;
// 	w.y = 0;
// 	loc_0.x = temp_1.x * w.x - temp_1.y * w.y;
// 	loc_0.y = temp_1.y * w.x + temp_1.x * w.y;
// 	temp_1.x = temp_0.x - loc_0.x;
// 	temp_1.y = temp_0.y - loc_0.y;
// 	temp_0.x = temp_0.x + loc_0.x;
// 	temp_0.y = temp_0.y + loc_0.y;
// 	iw.x = w.y;
// 	iw.y = -w.x;
// 	loc_0.x = temp_3.x * iw.x - temp_3.y * iw.y;
// 	loc_0.y = temp_3.y * iw.x + temp_3.x * iw.y;
// 	temp_3.x = temp_2.x - loc_0.x;
// 	temp_3.y = temp_2.y - loc_0.y;
// 	temp_2.x = temp_2.x + loc_0.x;
// 	temp_2.y = temp_2.y + loc_0.y;
// 	iw.x = w.x * 7.07106781186547573e-01f + w.y * 7.07106781186547573e-01f;
// 	iw.y = w.y * 7.07106781186547573e-01f - w.x * 7.07106781186547573e-01f;

// 	loc_0.x = temp_5.x * iw.x - temp_5.y * iw.y;
// 	loc_0.y = temp_5.y * iw.x + temp_5.x * iw.y;
// 	temp_5.x = temp_4.x - loc_0.x;
// 	temp_5.y = temp_4.y - loc_0.y;
// 	temp_4.x = temp_4.x + loc_0.x;
// 	temp_4.y = temp_4.y + loc_0.y;
// 	w.x = iw.y;
// 	w.y = -iw.x;
// 	loc_0.x = temp_7.x * w.x - temp_7.y * w.y;
// 	loc_0.y = temp_7.y * w.x + temp_7.x * w.y;
// 	temp_7.x = temp_6.x - loc_0.x;
// 	temp_7.y = temp_6.y - loc_0.y;
// 	temp_6.x = temp_6.x + loc_0.x;
// 	temp_6.y = temp_6.y + loc_0.y;
// 	__syncthreads();

// 	stageInvocationID = threadIdx.x + 0;
// 	blockInvocationID = stageInvocationID;
// 	stageInvocationID = stageInvocationID % 1;
// 	blockInvocationID = blockInvocationID - stageInvocationID;
// 	inoutID = blockInvocationID * 8;
// 	inoutID = inoutID + stageInvocationID;
// 	sdataID = inoutID + 0;
// 	sharedStride = 34;	sdataID = (sdataID / 16) * stride + sdataID % 16;	sdata[sdataID] = temp_0;
// 	sdataID = inoutID + 1;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;	sdata[sdataID] = temp_4;
// 	sdataID = inoutID + 2;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;	sdata[sdataID] = temp_2;
// 	sdataID = inoutID + 3;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;	sdata[sdataID] = temp_6;
// 	sdataID = inoutID + 4;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;	sdata[sdataID] = temp_1;
// 	sdataID = inoutID + 5;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;	sdata[sdataID] = temp_5;
// 	sdataID = inoutID + 6;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;	sdata[sdataID] = temp_3;
// 	sdataID = inoutID + 7;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;	sdata[sdataID] = temp_7;
// 	__syncthreads();

// 		stageInvocationID = (threadIdx.x+ 0) % (8);
// 		angle = stageInvocationID * -3.92699081698724139e-01f;
// 		sdataID = threadIdx.x + 0;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;		temp_0 = sdata[sdataID];
// 		sdataID = threadIdx.x + 8;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;		temp_2 = sdata[sdataID];
// 		sdataID = threadIdx.x + 16;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;		temp_1 = sdata[sdataID];
// 		sdataID = threadIdx.x + 24;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;		temp_3 = sdata[sdataID];
	
// 	w.x = __cosf(angle);
// 	w.y = __sinf(angle);
// 	loc_0.x = temp_1.x * w.x - temp_1.y * w.y;
// 	loc_0.y = temp_1.y * w.x + temp_1.x * w.y;
// 	temp_1.x = temp_0.x - loc_0.x;
// 	temp_1.y = temp_0.y - loc_0.y;
// 	temp_0.x = temp_0.x + loc_0.x;
// 	temp_0.y = temp_0.y + loc_0.y;
// 	loc_0.x = temp_3.x * w.x - temp_3.y * w.y;
// 	loc_0.y = temp_3.y * w.x + temp_3.x * w.y;
// 	temp_3.x = temp_2.x - loc_0.x;
// 	temp_3.y = temp_2.y - loc_0.y;
// 	temp_2.x = temp_2.x + loc_0.x;
// 	temp_2.y = temp_2.y + loc_0.y;
// 	w.x = __cosf(0.5f*angle);
// 	w.y = __sinf(0.5f*angle);
// 	loc_0.x = temp_2.x * w.x - temp_2.y * w.y;
// 	loc_0.y = temp_2.y * w.x + temp_2.x * w.y;
// 	temp_2.x = temp_0.x - loc_0.x;
// 	temp_2.y = temp_0.y - loc_0.y;
// 	temp_0.x = temp_0.x + loc_0.x;
// 	temp_0.y = temp_0.y + loc_0.y;
// 	loc_0.x = w.x;	w.x = w.y;
// 	w.y = -loc_0.x;
// 	loc_0.x = temp_3.x * w.x - temp_3.y * w.y;
// 	loc_0.y = temp_3.y * w.x + temp_3.x * w.y;
// 	temp_3.x = temp_1.x - loc_0.x;
// 	temp_3.y = temp_1.y - loc_0.y;
// 	temp_1.x = temp_1.x + loc_0.x;
// 	temp_1.y = temp_1.y + loc_0.y;
// 		stageInvocationID = (threadIdx.x+ 4) % (8);
// 		sdataID = threadIdx.x + 4;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;		temp_4 = sdata[sdataID];
// 		sdataID = threadIdx.x + 12;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;		temp_6 = sdata[sdataID];
// 		sdataID = threadIdx.x + 20;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;		temp_5 = sdata[sdataID];
// 		sdataID = threadIdx.x + 28;
// 	sdataID = (sdataID / 16) * stride + sdataID % 16;		temp_7 = sdata[sdataID];
// 	angle = stageInvocationID * -3.92699081698724139e-01f;
// 	w.x = __cosf(angle);
// 	w.y = __sinf(angle);
// 	loc_0.x = temp_5.x * w.x - temp_5.y * w.y;
// 	loc_0.y = temp_5.y * w.x + temp_5.x * w.y;
// 	temp_5.x = temp_4.x - loc_0.x;
// 	temp_5.y = temp_4.y - loc_0.y;
// 	temp_4.x = temp_4.x + loc_0.x;
// 	temp_4.y = temp_4.y + loc_0.y;
// 	loc_0.x = temp_7.x * w.x - temp_7.y * w.y;
// 	loc_0.y = temp_7.y * w.x + temp_7.x * w.y;
// 	temp_7.x = temp_6.x - loc_0.x;
// 	temp_7.y = temp_6.y - loc_0.y;
// 	temp_6.x = temp_6.x + loc_0.x;
// 	temp_6.y = temp_6.y + loc_0.y;
// 	w.x = __cosf(0.5f*angle);
// 	w.y = __sinf(0.5f*angle);
// 	loc_0.x = temp_6.x * w.x - temp_6.y * w.y;
// 	loc_0.y = temp_6.y * w.x + temp_6.x * w.y;
// 	temp_6.x = temp_4.x - loc_0.x;
// 	temp_6.y = temp_4.y - loc_0.y;
// 	temp_4.x = temp_4.x + loc_0.x;
// 	temp_4.y = temp_4.y + loc_0.y;
// 	loc_0.x = w.x;	w.x = w.y;
// 	w.y = -loc_0.x;
// 	loc_0.x = temp_7.x * w.x - temp_7.y * w.y;
// 	loc_0.y = temp_7.y * w.x + temp_7.x * w.y;
// 	temp_7.x = temp_5.x - loc_0.x;
// 	temp_7.y = temp_5.y - loc_0.y;
// 	temp_5.x = temp_5.x + loc_0.x;
// 	temp_5.y = temp_5.y + loc_0.y;
// 		{ 
// 		combinedID = threadIdx.x + 0;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		outputs[inoutID] = temp_0;
// 		combinedID = threadIdx.x + 4;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		outputs[inoutID] = temp_4;
// 		combinedID = threadIdx.x + 8;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		outputs[inoutID] = temp_1;
// 		combinedID = threadIdx.x + 12;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		outputs[inoutID] = temp_5;
// 		combinedID = threadIdx.x + 16;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		outputs[inoutID] = temp_2;
// 		combinedID = threadIdx.x + 20;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		outputs[inoutID] = temp_6;
// 		combinedID = threadIdx.x + 24;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		outputs[inoutID] = temp_3;
// 		combinedID = threadIdx.x + 28;
// 		inoutID = (combinedID % 32) + (combinedID / 32) * 32;
// 			inoutID = (inoutID);
// 		outputs[inoutID] = temp_7;
// 	}
// }



