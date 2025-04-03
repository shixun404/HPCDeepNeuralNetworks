
from math import *
import numpy as np
M_PI = 3.141592653589793
def ft_1D_fft_code_gen(radix=2, N=8, signal_per_thread=8, num_thread=4, if_abft=False):
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
        float2 temp_c_{i};
    '''
    ft_fft += f'''
    float2* sdata = (float2*)shared;
    int tx = threadIdx.x;
    int N = {N};
    int __id[{signal_per_thread}];
    float2 tmp;
    float2 tmp_angle, tmp_angle_rot;
    int j;
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
            for i in range(signal_per_thread):
                n = signal_per_thread // radix
                j = i // radix
                ft_fft += f'''
        j = {j};
        k = __id[{order[signal_per_thread - offset + i]}] % {n_global};
        MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
        MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
        temp_{order[signal_per_thread - offset + i]} = tmp;
        '''
            for i in range(signal_per_thread // radix):
                for j in range(signal_per_thread):
                    ft_fft += f'''
                    temp_c_{j}.x = 0;
                    temp_c_{j}.y = 0;
                '''
                ft_fft += f'''
                GEMM_radix{radix}(temp_{order[i+signal_per_thread - offset]}'''
                for j in range(1, radix):
                    ft_fft += f''',temp_{order[i+signal_per_thread + + int(signal_per_thread / radix) * j - offset]}'''
                for j in range(radix):
                    ft_fft += f''',temp_c_{order[i+signal_per_thread + int(signal_per_thread / radix) * j - offset]}'''
                ft_fft += f''')
    '''
                for j in range(radix):
                    ft_fft += f'''temp_{order[i+signal_per_thread + int(signal_per_thread / radix) * j - offset]} = temp_c_{order[i+signal_per_thread + int(signal_per_thread / radix) * j - offset]}'''

                for j in range(radix):
                    order[i + int(signal_per_thread / radix) * j + offset] = order[i + signal_per_thread + int(signal_per_thread / radix) * j - offset]
            ft_fft += f'''
    n_global *= {radix};
    '''
            offset = 0 if  offset > 0 else signal_per_thread
            for i in range(signal_per_thread):
                ft_fft += f'''outputs[__id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
    '''
            ft_fft += '''
    }
'''
            break
        
        else:
            n = 1 if twiddle_type[stage_id] == 0 else n_global // (N // signal_per_thread)
            for _ in range(plan[stage_id]):
                for i in range(signal_per_thread):
                    n = signal_per_thread // radix
                    j = i // radix
                    ft_fft += f'''
            j = {j};
            k = __id[{order[signal_per_thread - offset + i]}] % {n_global};
            MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
            MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
            temp_{order[signal_per_thread - offset + i]} = tmp;
            '''
                for i in range(signal_per_thread // radix):
                    for j in range(signal_per_thread):
                        ft_fft += f'''
                        temp_c_{j}.x = 0;
                        temp_c_{j}.y = 0;
                    '''
                    ft_fft += f'''
                    GEMM_radix{radix}(temp_{order[i+signal_per_thread - offset]}'''
                    for j in range(1, radix):
                        ft_fft += f''',temp_{order[i+signal_per_thread + + int(signal_per_thread / radix) * j - offset]}'''
                    for j in range(radix):
                        ft_fft += f''',temp_c_{order[i+signal_per_thread + int(signal_per_thread / radix) * j - offset]}'''
                    ft_fft += f''')
        '''
                    for j in range(radix):
                        ft_fft += f'''temp_{order[i+signal_per_thread + int(signal_per_thread / radix) * j - offset]} = temp_c_{order[i+signal_per_thread + int(signal_per_thread / radix) * j - offset]}'''

                for i in range(signal_per_thread // radix):
                    ft_fft += f'''
        tmp_id = __id[{order[i + signal_per_thread - offset]}];
        tmp_id = (tmp_id / n_global) * {radix} * n_global + (tmp_id % n_global);        
        '''
                    for j in range(radix):
                        tmp_id = (i // n) * radix * n + (i % n) + n * j
                        ft_fft += f'''
        __id[{order[i + signal_per_thread + int(signal_per_thread / radix) * j - offset]}] = tmp_id + {n_global} * j;
        '''
                        order[tmp_id + offset] = order[i + signal_per_thread + int(signal_per_thread / radix) * j - offset]
                ft_fft += f'''
    n_global *= {radix};
    '''
                offset = 0 if  offset > 0 else signal_per_thread
                n *= radix
                n_global *= radix
        if twiddle_type[stage_id] == 0:
            ft_fft += f'''
    __syncthreads();
    '''
            for i in range(signal_per_thread):
                ft_fft += f'''
    sdata[__id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
    ''' 
            ft_fft += f'''
    __syncthreads();
        '''
            for i in range(signal_per_thread):
                ft_fft += f'''
    temp_{i} = sdata[{i} * blockDim.x + tx];
    __id[{i}] = tx + {i} * {N // signal_per_thread};
    '''
                order[i] = i
                offset = signal_per_thread
    return ft_fft
