__global__ void __launch_bounds__(1) fft_logN3 (float2* inputs, float2* outputs) {
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