 
from math import *
import numpy as np
M_PI = 3.141592653589793
def ft_3D_fft_code_gen_upload3(N, N1, N2, N3, num_block, num_thread,
                       radix=2, signal_per_thread=8, if_abft=False):
    print(f"N1={N1}, N2={N2}, N3={N3}")
    exponent = int(log(N, radix))
    log_threadx = 0 # thread to log
    log_thready = 0 # thread to log
    log_block = 0 # thread to log
    N2_ = N2
    N1_ = N1
    N3_ = N3
    N2 = N1 * N2
    N1 = N3
    print(f"N={N1}, radix={radix}, N1 / radix = {N1/radix}, signal_per_thread={signal_per_thread}")
    plan = []
    twiddle_type = []
    blockdim_y = int(num_thread // (N1 // signal_per_thread))
    blockdim_x = int(N1 // signal_per_thread)
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
__global__ void __launch_bounds__({num_thread}) fft_radix{radix}_logN{exponent}_3''' + '''(float2* inputs, float2* outputs) {
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
        ft_fft += f'''temp_{i} = inputs[(tx + {blockdim_x} * ty + {i} * {num_thread}) % {N3_} + (((bx % {N1_ // blockdim_y}) * {blockdim_y}) + ((tx + {blockdim_x} * ty + {i} * {num_thread}) / {N3_})) * {N3_ * N2_} + (bx / {(N1_ // blockdim_y)}) * {N3_}];
    '''
    ft_fft += '''
        float2 mem_checksum;
    mem_checksum.x = 0;
    mem_checksum.y = 0;
    '''
    
    for i in range(signal_per_thread):
        ft_fft += f'''mem_checksum.x += temp_{i}.x;
        mem_checksum.y += temp_{i}.y;
    '''
    
    
    ft_fft += f'''
    
    int tid = tx + ty * blockDim.x;
    int mem_check_i = N / {signal_per_thread};
    '''
    ft_fft += '''
    float2 mem_checksum_t1,mem_checksum_t2; 
       mem_checksum_t1.x = 0;mem_checksum_t1.y = 0; 
    mem_checksum_t2.x = 0;mem_checksum_t2.y = 0; 
    sdata[tid] = mem_checksum;
    __syncthreads();
    // if(tid < 32){
        mem_checksum_t1 = sdata[tid];
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.x, 16, 32);
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 8, 32);
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 4, 32);
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 2, 32);
        mem_checksum_t1.x += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 1, 32);
    //if(tid < 32){ 
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16,32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
    //}
    temp_0.x += 0.001 * (mem_checksum_t1.x);
    temp_0.y += 0.001 * (mem_checksum_t1.y);
    mem_check_i /= 2;
    '''
    # ft_fft += '''
    # while(mem_check_i > 0){
    
    # if(tid < bb ){
    #     mem_checksum_t1 = sdata[tid];
    #     mem_checksum_t2 = sdata[tid + mem_check_i]; 
    #     mem_checksum_t1.x += mem_checksum_t2.x;
    #     mem_checksum_t1.y += mem_checksum_t2.y;
    #     sdata[tid] = mem_checksum_t1;
    # }
    # temp_0.x += 0.001 * (mem_checksum_t1.x);
    # temp_0.y += 0.001 * (mem_checksum_t1.y );
    # mem_check_i /= 2;
    # // __syncthreads();
    # }
    # '''
    for i in range(signal_per_thread):
        ft_fft += f'''
        sdata[(tx + {blockdim_x} * ty + {i} * {num_thread}) % {N3_} + ((tx + {blockdim_x} * ty + {i} * {num_thread}) / {N3_}) * {N3_}] = temp_{i};
    '''
    
    ft_fft += '''
    __syncthreads();
    '''
    for i in range(signal_per_thread):
        ft_fft += f'''temp_{i} = sdata[(tx + {i * blockdim_x}) + ty * {N3_}];
    '''

    ft_fft += '''
    '''
    for i in range(signal_per_thread):
        ft_fft += f'''__id[{i}] = {i * blockdim_x} + tx;
    '''
    for stage_id in range(len(plan)):
        if twiddle_type[stage_id] == 2:
            n = signal_per_thread // 2
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
    // MY_ADD_ft(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    // MY_SUB_ft(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
    ''' * (2 if if_abft else 1)
                order[i + offset] = order[i + signal_per_thread - offset]
                order[i + int(signal_per_thread / 2) + offset] = order[i + signal_per_thread + int(signal_per_thread / 2) - offset]
            ft_fft += f'''
    n_global *= 2;
    __syncthreads();
    '''
            offset = 0 if  offset > 0 else signal_per_thread
            ft_fft += '''
            mem_checksum.x = 0;
            mem_checksum.y = 0;
            '''
            for i in range(signal_per_thread):
                ft_fft += f'''mem_checksum.x += temp_{i}.x;
            mem_checksum.y += temp_{i}.y;
    '''
            ft_fft += '''
            mem_checksum_t1.y = 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum.y, 16, 32);
            mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
            mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
            mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
            mem_checksum_t1.y += 0.001f * __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
    
    temp_0.x += 0.001 * (mem_checksum_t1.x);
    temp_0.y += 0.001 * (mem_checksum_t1.y);
    // if(tid == 0 && blockIdx.x == 0)printf("kernel 3, %f\\n", temp_0.x, temp_0.y);
            '''
            
            
            for i in range(signal_per_thread):
                ft_fft += f'''
    sdata[__id[{order[signal_per_thread - offset + i]}] + ty * {N3_}] = temp_{order[signal_per_thread - offset + i]};
    '''
            ft_fft += f'''
    __syncthreads();
    '''

            for i in range(signal_per_thread):
                ft_fft += f'''
    //        |    x3             |      |    x2  * N3        |                   |    x1  * N3        |
    //inputs[tx + {i * blockdim_x} + ty * {N3_ * N2_} + (bx % {N1_ // blockdim_y}) * {blockdim_y * N3_ * N2_} + (bx / {(N1_ // blockdim_y)} * {N3_})]
    // printf("############ finish bx = %d, tx = %d, ty = %d, ###########\\n", bx, tx, ty);
    
    // outputs[(bx / {(N2_ // blockdim_y)}) + ((bx % {(N2_ // blockdim_y)}) * {blockdim_y} + ty) * {N1_} + (__id[{order[signal_per_thread - offset + i]}]) * {N1_ * N2_}] = temp_{order[signal_per_thread - offset + i]};
    // outputs[(ty + (bx % {N1_ // blockdim_y}) * {blockdim_y}) + (bx / {(N1_ // blockdim_y)}) * {N1_} + (__id[{order[signal_per_thread - offset + i]}]) * {N1_ * N2_}] = temp_{order[signal_per_thread - offset + i]}; 
    
    
    temp_0 = sdata[((tx + ty * {blockdim_x} + {i * num_thread}) / {blockdim_y}) + ((tx + ty * {blockdim_x} + {i * num_thread}) % {blockdim_y}) * {N3_}];
    outputs[(((tx + ty * {blockdim_x} + {i * num_thread}) % {blockdim_y}) + (bx % {N1_ // blockdim_y}) * {blockdim_y}) + (bx / {(N1_ // blockdim_y)}) * {N1_} + ((tx + ty * {blockdim_x} + {i * num_thread}) / {blockdim_y}) * {N1_ * N2_}] = temp_0; 
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
    // MY_ADD_ft(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread - offset]});
    // MY_SUB_ft(tmp, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i + signal_per_thread + int(signal_per_thread / 2) - offset]});
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
                # # print(order, offset)
                offset = 0 if  offset > 0 else signal_per_thread
                n *= radix
                n_global *= radix

        if twiddle_type[stage_id] == 0:
            ft_fft += f'''
    __syncthreads();
    '''
            for i in range(signal_per_thread):
                ft_fft += f'''
    sdata[__id[{order[signal_per_thread - offset + i]}] + ty * {N3_} ] = temp_{order[signal_per_thread - offset + i]};
    ''' if True else f'''
    sdata[(__id[{order[signal_per_thread - offset + i]}] / 16) * 17 + 
    (__id[{order[signal_per_thread - offset + i]}] % 16)] = temp_{order[signal_per_thread - offset + i]};
    '''
            ft_fft += f'''
    __syncthreads();
    #if defined(LOG_ON)
    printf("################### syncthreads ####################\\n");
    #endif			
    '''
            for i in range(signal_per_thread):
                ft_fft += f'''
    temp_{i} = sdata[(tx + {i * blockdim_x}) + ty * {N3_}];
    __id[{i}] = tx + {i * blockdim_x};
    ''' if True else f'''
    temp_{i} = sdata[(({i} * blockDim.x + tx) / 16) * 17 +
                        (({i} * blockDim.x + tx) % 16)];
    __id[{i}] = tx + {i} * {N // signal_per_thread};
    '''
                order[i] = i
                offset = signal_per_thread
    return ft_fft