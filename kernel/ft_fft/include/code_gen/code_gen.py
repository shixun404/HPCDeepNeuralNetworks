
from math import *
import numpy as np
M_PI = 3.141592653589793
def ft_fft_code_gen(radix=2, N=8, signal_per_thread=8, if_abft=False):
    num_thread = int(N / signal_per_thread)
    exponent = int(log(N, radix))
    print(f"N={N}, radix={radix}, N / radix = {N/radix}, signal_per_thread={signal_per_thread}")
    plan = []
    twiddle_type = []
    i = 1
    while i <= N / radix:
        if i == N / radix:
            twiddle_type.append(2)
            plan.append(1)
            break
        elif i >= N / signal_per_thread:
            twiddle_type.append(1)
        else:
            twiddle_type.append(0)
        n = 0
        output = f""
        while i < int(N / radix) and n < int(log(signal_per_thread, radix)):
            output += f"{i}->"
            i *= radix
            n += 1
        print(output)
        plan.append(n)
    
    print("plan: ", plan)
    print("twid: ",twiddle_type)
    
    plan_id = 0
    
    
    order = []
    __id_no_tx = []
    for i in range(signal_per_thread):
        order.append(i)
        __id_no_tx.append(0)
    offset = 0
    
    ft_fft = f'''extern __shared__ float shared[];
    __global__ void __launch_bounds__({num_thread}) fft_radix{radix}_exp{exponent}''' + '''(float2* inputs, float2* outputs) {
'''
    
    for i in range(signal_per_thread):
        ft_fft += f'''
        float2 temp_{i};
    '''
    ft_fft += f'''
    int tx = threadIdx.x;
    int N = {N};
    int __id[{signal_per_thread}];
    float2 tmp;
    float2 tmp_angle;
    int n = 1, n_global = 1;
    '''
    
    n = 1
    n_global = 1
    
 	# int N = 512;
	# int __id[16];
	# // load from global
	# #pragma unroll
	# for(int i = 0; i < 8; ++i){
	# 	// printf("tx %d, inputs id %d\n", tx,  i * 2 + tx);
	# 	temp[i] = inputs[i * blockDim.x + tx];
	# 	__id[i] = tx + (i * N) / 8;
	# }
    # int offset = 8; 
	# int radix = 2;    
    # float2 tmp;
	# float2 tmp_angle;
	# int n = 1, n_global = 1;

    for i in range(signal_per_thread):
        ft_fft += f'''
        temp_{i} = inputs[{i} * blockDim.x + tx];
        __id[{i}] = {i} * blockDim.x + tx;
    '''
    
    
    for stage_id in range(len(plan)):
        if twiddle_type[stage_id] == 2:
   			ft_fft += '''
      	#if defined(LOG_ON)
		if(tx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		'''
			for i in range(signal_per_thread):
				ft_fft += f'''
				float j = {int(i / (signal_per_thread / radix))};
				int k = __id[{i}] % {n_global};
				#if defined(LOG_ON)
				if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  {i}, __id[{i}]);
				#endif			
    			MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
				MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
				temp_{order[signal_per_thread - offset + i]} = tmp;
  		'''
			for i in range(signal_per_thread / radix):
				ft_fft += f'''
				tmp = temp_{order[i + signal_per_thread - offset]};
       			MY_ADD(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
				MY_SUB(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
  		'''
				order[i + offset] = order[i + signal_per_thread - offset]
    			order[i + int(signal_per_thread / 2) + offset] = order[i + signal_per_thread + int(signal_per_thread / 2) - offset]
       			offset = 0 if  offset > 0 else signal_per_thread
  	'''
	#if defined(LOG_ON)
	if(tx==0)printf("##########reg to global ##########\n");
	#endif
    '''
        for j in range(len())
    #for(n = 1; n < 8; n *= 2, n_global *= 2){
	'''
    	#if defined(LOG_ON)
		if(tx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
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
    '''
    
    
    
    
    '''
	
	#if defined(LOG_ON)
	if(tx==0)printf("##########reg to shared ##########\n");
	#endif

	#pragma unroll
	for(int i = 0; i < 8; ++i){
		#if defined(LOG_ON)
		if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		#endif
		sdata[__id[8-offset + i]] = temp[8-offset + i];
	}
	__syncthreads();

	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[i * blockDim.x + tx];
		__id[i] = tx + (i * N) / 8;
	}
	offset = 8;
	
	#pragma unroll
	for(n = 1; n < 8; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
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
			if(tx==0)printf("tx %d, left __id[%d] = %d, right __id[%d] = %d\n", tx,  (j / n) * 2 * n + (j % n), tmp_id, (j / n) * 2 * n + (j % n) + n, tmp_id + n_global);
			#endif
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 8;
	}
	
	#if defined(LOG_ON)
	if(tx==0)printf("##########reg to shared ##########\n");
	#endif
	__syncthreads();
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		#if defined(LOG_ON)
		if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		#endif
		sdata[__id[8-offset + i]] = temp[8-offset + i];
	}
	__syncthreads();

	#pragma unroll
	for(int i = 0; i < 8; ++i){
		temp[i] = sdata[i * blockDim.x + tx];
		__id[i] = tx + (i * N) / 8;
	}
	offset = 8;
	
	
	
	for(n = 1; n < 4; n *= 2, n_global *= 2){
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
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
			if(tx==0)printf("tx %d, left __id[%d] = %d, right __id[%d] = %d\n", tx,  tmp_id_left, tmp_id, tmp_id_right, tmp_id + n_global);
			#endif
			__id[offset + tmp_id_left] = tmp_id;
			__id[offset + tmp_id_right] = tmp_id + n_global;
		}
		offset = offset > 0 ? 0 : 8;
		#if defined(LOG_ON)
		if(tx==0)printf("#############################\n");
		#endif
	}

	#pragma unroll
	for(n = 1; n < 2; n *= 2, n_global *= 2){
		#if defined(LOG_ON)
		if(tx==0)printf("############ n_global %d ###########\n", n_global);
		#endif
		#pragma unroll
		for(int i = 0; i < 8; ++i){
			int j = __id[8 - offset + i] / (N / radix);
			int k = __id[8 - offset + i] % n_global;
			#if defined(LOG_ON)
			if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
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
	if(tx==0)printf("##########reg to global ##########\n");
	#endif
	
	#pragma unroll
	for(int i = 0; i < 8; ++i){
		#if defined(LOG_ON)
		if(tx==0)printf("tx %d, __id[%d] = %d\n", tx,  i, __id[8-offset + i]);
		#endif
		outputs[__id[8-offset + i]] = temp[8-offset + i];
	}		
}
    '''
    return 
    # return ft_sgemm
