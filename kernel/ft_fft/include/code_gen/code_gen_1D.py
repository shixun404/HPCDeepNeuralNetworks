
from math import *
import numpy as np
M_PI = 3.141592653589793
def ft_1D_fft_code_gen(radix=2, N=8, signal_per_thread=8, num_thread=4, if_abft=False):
    exponent = int(log(N, radix))
    log_threadx = 0 # thread to log
    log_thready = 0 # thread to log
    log_block = 0 # thread to log
    log_thread = 0# thread to log
    N__ = N
    print(f"########################### N = 2 ** {exponent} ###########################################################")
    print(f"N={N}, radix={radix}, N / radix = {N/radix}, signal_per_thread={signal_per_thread}")
    plan = []
    twiddle_type = []
    i = 1
    while i <= N / radix:
        if i > N / radix:
            break
        elif i >= N / signal_per_thread:
            twiddle_type.append(1)
        else:
            twiddle_type.append(0)
        n = 0
        output = f""
        while i < int(N) and n < int(log(signal_per_thread, radix)):
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
    '''
    ft_fft += f'''
    float2* sdata = (float2*)shared;
    int tx = threadIdx.x;
    int ty = threadIdx.y;
    int bx = blockIdx.x;
    int N = {N};
    int __id[{signal_per_thread}];
    float2 tmp;
    float2 tmp_angle, tmp_angle_rot;
    int j;
    int k;
    int tmp_id;
    int n = 1, n_global = 1;
    float2 r[3];
    r[0].x = 1.0f;
    r[0].y = 0.0f;
    r[1].x = -0.5f;
    r[1].y = -0.866f;
    r[2].x = -0.5f;
    r[2].y = 0.866f;
    float2 warp_checksum;
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
        if True:
            n = 1 if twiddle_type[stage_id] == 0 else n_global // (N // signal_per_thread)
            for j in range(plan[stage_id]):
                i = 0 + signal_per_thread // radix
                ft_fft += f'''
    j = {int(i / (signal_per_thread // radix))};
    k = __id[{order[signal_per_thread - offset + i]}] % {n_global};
    MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
    '''
                for k in range(max(1, n // 2)):
                    i = k + signal_per_thread // radix
                    ft_fft += f'''
    tmp_angle_rot.x = {cos(- M_PI / float(n)) if k != 0 else 1.}f;
    tmp_angle_rot.y = {sin(- M_PI / float(n)) if k != 0 else 0.}f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    '''
                    for kk in range(signal_per_thread // radix // n):
                        i = kk * n + k + signal_per_thread // radix
                        ft_fft += f'''
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    '''
                        if n // 2 != 0:
                            i += n // 2
                            ft_fft += f'''
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle_rot, tmp);
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
                print(order)
                ft_fft += f'''
    n_global *= 2;
    '''
                offset = 0 if  offset > 0 else signal_per_thread
                n *= radix
                n_global *= radix

        if twiddle_type[stage_id] == 0:
            ft_fft += f'''
    __syncthreads();
    ''' if stage_id != 0 else '''
    '''
            for i in range(signal_per_thread):    
    #             ft_fft += f'''
    # MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx % {int(N__ // (2 ** plan[stage_id]))}) * {i}) / (float)({N__}), tmp_angle);
    # MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    # '''
                ft_fft += f'''
    sdata[__id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
    ''' if exponent == 13 else f'''
    sdata[(__id[{order[signal_per_thread - offset + i]}] / 16) * 17 + 
    (__id[{order[signal_per_thread - offset + i]}] % 16)] = temp_{order[signal_per_thread - offset + i]};
    '''
            ft_fft += f'''
    __syncthreads();			
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
            N__ = N__ / (2 ** plan[stage_id])
        elif twiddle_type[stage_id] == 1:
            for i in range(signal_per_thread):
                ft_fft += f'''outputs[__id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
    '''
            ft_fft += '''
    }
'''
            break    
    return ft_fft
