
from math import *
import numpy as np
M_PI = 3.141592653589793
def ft_2D_fft_code_gen_upload1(N, N1, N2, num_block, num_thread,
                       radix=2, signal_per_thread=8, if_abft=False):
    
    exponent = int(log(N, radix))
    log_threadx = 0# thread to log
    log_thready = 0# thread to log
    log_block = 0# thread to log
    print(f"N={N1}, radix={radix}, N1 / radix = {N1/radix}, signal_per_thread={signal_per_thread}")
    plan = []
    twiddle_type = []
    blockdim_x = int(num_thread // (N1 // signal_per_thread))
    blockdim_y = int(N1 // signal_per_thread)
    i = 1
    while i <= N1 / radix:
        if i == N1 / radix:
            twiddle_type.append(2)
            plan.append(1)
            break
        elif i >= N1 / signal_per_thread:
            twiddle_type.append(1)
        else:
            twiddle_type.append(0)
        n = 0
        output = f""
        while i < int(N1 / radix) and n < int(log(signal_per_thread, radix)):
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
__global__ void __launch_bounds__({num_thread}) fft_radix{radix}_logN{exponent}_1''' + '''(float2* inputs, float2* outputs) {
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
    int N = {N1};
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
        ft_fft += f'''temp_{i} = inputs[(ty + {i} * {(N1 // signal_per_thread)}) * {N2} + tx + bx * {num_thread // (N1 // signal_per_thread)}];
    '''
    ft_fft += '''
    '''
    for i in range(signal_per_thread):
        ft_fft += f'''__id[{i}] = {i * blockdim_y} + ty;
    '''
    for stage_id in range(len(plan)):
        if twiddle_type[stage_id] == 2:
            ft_fft += f'''#if defined(LOG_ON)
    if(tx=={log_threadx} && bx=={log_block} && ty=={log_thready})printf("############ n_global %d ###########\\n", n_global);
    #endif
    '''
            n = signal_per_thread // 2
            i = 0 + signal_per_thread // radix
            ft_fft += f'''
    j = {int(i / (signal_per_thread // radix))};
    k = __id[{order[signal_per_thread - offset + i]}] % {n_global};
    MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
    '''
            for k in range(max(1, n // 2)):
                i = k + signal_per_thread // radix
                ft_fft += f'''
    #if defined(LOG_ON)
    if(tx=={log_threadx} && bx=={log_block} && ty=={log_thready})printf("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\\ntx %d, j %d, k %d, j * k %d, n_global %d, \\n", tx,  j, k, j*k, n_global);
    #endif
    tmp_angle_rot.x = {cos(- M_PI / float(n)) if k != 0 else 1.}f;
    tmp_angle_rot.y = {sin(- M_PI / float(n)) if k != 0 else 0.}f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    ''' * (2 if if_abft else 1)
                for kk in range(signal_per_thread // radix // n):
                    i = kk * n + k + signal_per_thread // radix
                    ft_fft += f'''
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    ''' * (2 if if_abft else 1)
                    if True:
                        i += n // 2
                        ft_fft += f'''
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle_rot, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    ''' * (2 if if_abft else 1)

            for i in range(signal_per_thread // radix):
                ft_fft += f'''
    tmp = temp_{order[i + signal_per_thread - offset]};
    MY_ADD(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    MY_SUB(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
    MY_ADD_ft(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    MY_SUB_ft(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
    ''' * (2 if if_abft else 1)
                order[i + offset] = order[i + signal_per_thread - offset]
                order[i + int(signal_per_thread / 2) + offset] = order[i + signal_per_thread + int(signal_per_thread / 2) - offset]
            ft_fft += f'''
    n_global *= 2;
    '''
            # print(order, offset)
            offset = 0 if  offset > 0 else signal_per_thread
            for i in range(signal_per_thread):
                ft_fft += f'''
    
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * (tx + bx * {blockdim_x}) * (__id[{order[signal_per_thread - offset + i]}])) / (float)({N}), tmp_angle);
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    outputs[(tx + bx * {blockdim_x}) + {N2} * __id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
    // outputs[__id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
    '''
            ft_fft += '''
    }
'''
            break
        
        else:
            n = 1 if twiddle_type[stage_id] == 0 else n_global // (N1 // signal_per_thread)
            for j in range(plan[stage_id]):
                i = 0 + signal_per_thread // radix
                ft_fft += f'''
    j = {int(i / (signal_per_thread // radix))};
    k = __id[{order[signal_per_thread - offset + i]}] % {n_global};
    MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global))}f, tmp_angle);
    ''' * (2 if if_abft else 1)
                for k in range(max(1, n // 2)):
                    i = k + signal_per_thread // radix
                    ft_fft += f'''
    tmp_angle_rot.x = {cos(- M_PI / float(n)) if k != 0 else 1.}f;
    tmp_angle_rot.y = {sin(- M_PI / float(n)) if k != 0 else 0.}f;
    MY_MUL(tmp_angle, tmp_angle_rot, tmp);
    tmp_angle = tmp;
    tmp_angle_rot.x = tmp_angle.y;
    tmp_angle_rot.y = -tmp_angle.x;
    ''' * (2 if if_abft else 1)
                    for kk in range(signal_per_thread // radix // n):
                        i = kk * n + k + signal_per_thread // radix
                        ft_fft += f'''
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    ''' * (2 if if_abft else 1)
                        if n // 2 != 0:
                            i += n // 2
                            ft_fft += f'''
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle_rot, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    ''' * (2 if if_abft else 1)
    
                for i in range(signal_per_thread // radix):
                    tmp_id_left = (i // n) * 2 * n + (i % n)
                    tmp_id_right = (i // n) * 2 * n + (i % n) + n
                    ft_fft += f'''
    tmp = temp_{order[i + signal_per_thread - offset]};
    MY_ADD(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    MY_SUB(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
    MY_ADD_ft(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    MY_SUB_ft(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
    ''' * (2 if if_abft else 1)
                    ft_fft += f'''
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
                # print(order, offset)
                offset = 0 if  offset > 0 else signal_per_thread
                n *= radix
                n_global *= radix

        if twiddle_type[stage_id] == 0:
            ft_fft += f'''
    __syncthreads();
    ''' if stage_id != 0 else '''
    '''
            for i in range(signal_per_thread):
                ft_fft += f'''
    sdata[tx + {blockdim_x} * __id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
    ''' if True else f'''
    sdata[(__id[{order[signal_per_thread - offset + i]}] / 16) * 17 + 
    (__id[{order[signal_per_thread - offset + i]}] % 16)] = temp_{order[signal_per_thread - offset + i]};
    '''
            ft_fft += f'''
    __syncthreads();	
    '''
            for i in range(signal_per_thread):
                ft_fft += f'''
    temp_{i} = sdata[tx + {blockdim_x} * ({i * blockdim_y} + ty)];
    __id[{i}] = ty + {i * blockdim_y};
    ''' if True else f'''
    temp_{i} = sdata[(({i} * blockDim.x + tx) / 16) * 17 +
                        (({i} * blockDim.x + tx) % 16)];
    __id[{i}] = tx + {i} * {N // signal_per_thread};
    '''
                order[i] = i
                offset = signal_per_thread

    return ft_fft
