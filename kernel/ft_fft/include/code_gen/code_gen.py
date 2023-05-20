
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
    for i in range(signal_per_thread * 2):
        order.append(i)
    offset = signal_per_thread
    
    ft_fft = f'''extern __shared__ float shared[];
__global__ void __launch_bounds__({num_thread}) fft_radix{radix}_logN{exponent}''' + '''(float2* inputs, float2* outputs) {
'''
    ft_fft += '''
    '''
    for i in range(signal_per_thread):
        ft_fft += f'''float2 temp_{i};
    '''
    ft_fft += f'''
    float2* sdata = (float2*)shared;
    int tx = threadIdx.x;
    int N = {N};
    int __id[{signal_per_thread}];
    float2 tmp;
    float2 tmp_angle;
    float j;
    int k;
    int tmp_id;
    int n = 1, n_global = 1;
    '''
    n = 1
    n_global = 1
    ft_fft += '''
    '''
    for i in range(signal_per_thread):
        ft_fft += f'''temp_{i} = inputs[{i} * blockDim.x + tx];
    '''
    ft_fft += '''
    '''
    for i in range(signal_per_thread):
        ft_fft += f'''__id[{i}] = {i} * blockDim.x + tx;
    '''
    for stage_id in range(len(plan)):
        if twiddle_type[stage_id] == 2:
            ft_fft += f'''#if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\\n", n_global);
    #endif
    '''
            for i in range((signal_per_thread // radix), signal_per_thread):
                ft_fft += f'''
    j = {int(i / (signal_per_thread / radix))};
    k = __id[{order[signal_per_thread - offset + i]}] % {n_global};
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\\n", tx,  {i}, __id[{order[signal_per_thread - offset + i]}]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    '''

            for i in range(signal_per_thread // radix):
                ft_fft += f'''
    tmp = temp_{order[i + signal_per_thread - offset]};
    MY_ADD(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    MY_SUB(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
    '''
                order[i + offset] = order[i + signal_per_thread - offset]
                order[i + int(signal_per_thread / 2) + offset] = order[i + signal_per_thread + int(signal_per_thread / 2) - offset]
            ft_fft += f'''
    n_global *= 2;
    '''
            offset = 0 if  offset > 0 else signal_per_thread
            for i in range(signal_per_thread):
                ft_fft += f'''outputs[__id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
    '''
            ft_fft += '''
    }
'''
            break
        
        if twiddle_type[stage_id] == 0:
            n = 1
            for j in range(plan[stage_id]):
                ft_fft += '''
    #if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\\n", n_global);
    #endif
    '''
                for i in range((signal_per_thread // radix), signal_per_thread):
                    ft_fft += f'''
    j = {int(i / (signal_per_thread // radix))};
    k = __id[{order[signal_per_thread - offset + i]}] % {n_global};
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\\n", tx,  {i}, __id[{order[signal_per_thread - offset + i]}]);
    #endif			
    MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    '''
                for i in range(signal_per_thread // radix):
                    tmp_id_left = (i // n) * 2 * n + (i % n)
                    tmp_id_right = (i // n) * 2 * n + (i % n) + n
                    ft_fft += f'''
    tmp = temp_{order[i + signal_per_thread - offset]};
    MY_ADD(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    MY_SUB(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
    tmp_id = __id[{order[i + signal_per_thread - offset]}];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[{order[i + signal_per_thread - offset]}] = tmp_id;
    __id[{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}] = tmp_id + {n_global};
    '''
                    order[tmp_id_left + offset] = order[i + signal_per_thread - offset]
                    order[tmp_id_right + offset] = order[i + signal_per_thread + int(signal_per_thread / 2) - offset]
                ft_fft += f'''
    n_global *= 2;
    '''
                offset = 0 if  offset > 0 else signal_per_thread
                n *= radix
                n_global *= radix
            for i in range(signal_per_thread):
                ft_fft += f'''
        sdata[__id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
        ''' if exponent == 13 else f'''
        sdata[(__id[{order[signal_per_thread - offset + i]}] / 16) * 17 + 
        (__id[{order[signal_per_thread - offset + i]}] % 16)] = temp_{order[signal_per_thread - offset + i]};
        '''
            ft_fft += '''__syncthreads();
        '''
            for i in range(signal_per_thread):
                ft_fft += f'''
        temp_{i} = sdata[{i} * blockDim.x + tx];
        __id[{i}] = tx + {i} * {N // signal_per_thread};
        ''' if exponent == 13 else f'''
        temp_{i} = sdata[(({i} * blockDim.x + tx) / 16) * 17 +
                          (({i} * blockDim.x + tx) % 16)];
        __id[{i}] = tx + {i} * {N // signal_per_thread};
        '''
                order[i] = i
                offset = signal_per_thread

        if twiddle_type[stage_id] == 1:
            ft_fft += '''
    '''
            n = n_global // (N // signal_per_thread)
            for j in range(plan[stage_id]):
                ft_fft += '''#if defined(LOG_ON)
    if(tx==0)printf("############ n_global %d ###########\\n", n_global);
    #endif
    '''
                for i in range((signal_per_thread // radix), signal_per_thread):
                    ft_fft += f'''
    j = {int(i / (signal_per_thread / radix))};
    k = __id[{order[signal_per_thread - offset + i]}] % {n_global};
    #if defined(LOG_ON)
    if(tx==0)printf("tx %d, __id[%d] = %d\\n", tx,  {i}, __id[{order[signal_per_thread - offset + i]}]);
    #endif	
    MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    '''
                for i in range(signal_per_thread // radix):
                    tmp_id_left = (i // n) * 2 * n + (i % n)
                    tmp_id_right = (i // n) * 2 * n + (i % n) + n
                    print(i + signal_per_thread + int(signal_per_thread / 2) - offset, i, signal_per_thread, offset)
                    print(order)
                    ft_fft += f'''
    tmp = temp_{order[i + signal_per_thread - offset]};
    MY_ADD(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    MY_SUB(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
    tmp_id = __id[{order[i + signal_per_thread - offset]}];
    tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
    __id[{order[i + signal_per_thread - offset]}] = tmp_id;
    __id[{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}] = tmp_id + {n_global};
    '''
                    order[tmp_id_left + offset] = order[i + signal_per_thread - offset]
                    order[tmp_id_right + offset] = order[i + signal_per_thread + int(signal_per_thread / 2) - offset]
                ft_fft += f'''
    n_global *= 2;
    '''
                offset = 0 if  offset > 0 else signal_per_thread
                n *= radix
                n_global *= radix


    return ft_fft
