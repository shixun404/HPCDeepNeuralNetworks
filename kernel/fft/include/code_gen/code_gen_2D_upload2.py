
from math import *
import numpy as np
M_PI = 3.141592653589793
def ft_2D_fft_code_gen_upload2(N, N1, N2, num_block, num_thread,
                       radix=2, signal_per_thread=8, transpose=0, if_abft=False):
    if transpose == 0:
        
        exponent = int(log(N, radix))
        N__ = N2
        print(f"########################### Transpose= 0 N = 2 ** {exponent} ###########################################################")
        print(f"N={N2}, radix={radix}, N2 / radix = {N2 / radix}, signal_per_thread={signal_per_thread}")
        plan = []
        twiddle_type = []
        blockdim_x = int((N2 // signal_per_thread))
        blockdim_y = int(num_thread // (N2 // signal_per_thread))
        i = 1
        N2_ = N2
        while i <= N2 / radix:
            if i > N2 / radix:
                break
            elif i >= N2 / signal_per_thread:
                twiddle_type.append(1)
            else:
                twiddle_type.append(0)
            n = 0
            output = f""
            while i < int(N2) and n < int(log(signal_per_thread, radix)):
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
    __global__ void __launch_bounds__({num_thread}) fft_radix{radix}_logN{exponent}_2''' + '''(float2* inputs, float2* outputs) {
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
        int N = {N2};
        int __id[{signal_per_thread}];
        float2 tmp;
        float2 tmp_angle, tmp_angle_rot;
        int j;
        int k;
        int tmp_id;
            float2 r[3];
    r[0].x = 1.0f;
    r[0].y = 0.0f;
    r[1].x = -0.5f;
    r[1].y = -0.8660253882408142f;
    r[2].x = -0.5f;
    r[2].y = 0.8660253882408142f;
        int n = 1, n_global = 1;
        float2 tmp_angle_bk;
            int tid = tx + ty * blockDim.x;
    float2 mem_checksum ,mem_checksum_t1;
    float2 warp_checksum;
    float2 warp_checksum_;
        '''
        n = 1
        n_global = 1
        ft_fft += '''
        '''
        # for i in range(signal_per_thread):
        #     ft_fft += f'''
        # temp_{i} = inputs[((tx + {blockdim_x} * ty + {i * num_thread}) % {N2_}) + (((tx + {blockdim_x} * ty + {i * num_thread}) / {N2_}) + bx * {blockdim_y}) * {N2}];
        # sdata[((tx + {blockdim_x} * ty + {i * num_thread}) % {N2_}) + ((tx + {blockdim_x} * ty + {i * num_thread}) / {N2_}) * {N2_}] = temp_{i};
        # '''
        # ft_fft += '''
        # __syncthreads();
        # '''
        for i in range(signal_per_thread):
            ft_fft += f'''temp_{i} = inputs[(tx + {i} * {blockdim_x}) + (ty + bx * {blockdim_y}) * {N2_}];
        '''
        ft_fft += '''
        '''
        for i in range(signal_per_thread):
            ft_fft += f'''__id[{i}] = {i * blockdim_x} + tx;
        '''
        
            
        ft_fft += '''
        #if FT==2
        mem_checksum.x = 0;
        mem_checksum.y = 0;
        mem_checksum_t1.x = 0;
        mem_checksum_t1.y = 0;
        __syncthreads();
        '''
        for i in range(signal_per_thread):
            ft_fft += f'''
            // if(bx == 0 && tid == 0)printf("%d, %f %f, hello\\n", __id[{i}], sdata[__id[{i}]].x, sdata[__id[{i}]].y);
            mem_checksum.x += sdata[__id[{i}]].x * temp_{i}.x - sdata[__id[{i}]].y * temp_{i}.y;
            mem_checksum.y += sdata[__id[{i}]].y * temp_{i}.x + sdata[__id[{i}]].x * temp_{i}.y;
        '''
        ft_fft += '''
        // __syncthreads();
        // mem_checksum_t1.x = mem_checksum.x; 
        mem_checksum_t1.y = mem_checksum.y + mem_checksum.x; 
        // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 16,32);
        // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 8, 32);
        // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 4, 32);
        // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 2, 32);
        // mem_checksum_t1.x += __shfl_xor_sync(0xffffffff, mem_checksum_t1.x, 1, 32);
        
        mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 16,32);
        mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 8, 32);
        mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 4, 32);
        mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 2, 32);
        mem_checksum_t1.y += __shfl_xor_sync(0xffffffff, mem_checksum_t1.y, 1, 32);
        #endif
        '''
        
        
        for stage_id in range(len(plan)):
            if True:
                batch_size = 1 if twiddle_type[stage_id] == 0 else n_global // (N2 // signal_per_thread)
                n = 1
                n_global_ = 1
                for j in range(plan[stage_id]):
                    i = 0 + signal_per_thread // radix
                    ft_fft += f'''
        j = {int(i / ((signal_per_thread) // radix))};
        k = {i // batch_size } % {n_global_};
        MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global_))}f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        '''
                    for batch in range(batch_size):
                        ft_fft += '''
                        tmp_angle = tmp_angle_bk;
    '''
                        for k in range(max(1, n // 2)):
                            i = k * batch_size + batch + signal_per_thread // radix
                            ft_fft += f'''
            tmp_angle_rot.x = {cos(- M_PI / float(n)) if k != 0 else 1.}f;
            tmp_angle_rot.y = {sin(- M_PI / float(n)) if k != 0 else 0.}f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            '''
                            for kk in range(signal_per_thread // radix // batch_size // n):
                                i = (kk * n + k) * batch_size + batch + signal_per_thread // radix
                                ft_fft += f'''
            MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
            temp_{order[signal_per_thread - offset + i]} = tmp;
            '''
                                if n // 2 != 0:
                                    i += (n // 2) * batch_size
                                    ft_fft += f'''
            MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle_rot, tmp);
            temp_{order[signal_per_thread - offset + i]} = tmp;
            '''
                    for batch in range(batch_size):
                        for i in range(signal_per_thread // radix // batch_size):
                            tmp_id_left = ((i // n) * 2 * n + (i % n)) * batch_size + batch
                            tmp_id_right = ((i // n) * 2 * n + (i % n) + n) * batch_size + batch
                            ft_fft += f'''
            tmp = temp_{order[i * batch_size + batch + signal_per_thread - offset]};
            MY_ADD(tmp, temp_{order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i * batch_size + batch + signal_per_thread - offset]});
            MY_SUB(tmp, temp_{order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]});
            tmp_id = __id[{order[i * batch_size + batch + signal_per_thread - offset]}];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[{order[i * batch_size + batch + signal_per_thread - offset]}] = tmp_id;
            __id[{order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]}] = tmp_id + {n_global};
            '''
                            order[tmp_id_left + offset] = order[i * batch_size + batch + signal_per_thread - offset]
                            order[tmp_id_right + offset] = order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]
                    ft_fft += f'''
        n_global *= 2;
        '''
                    offset = 0 if  offset > 0 else signal_per_thread
                    n *= radix
                    n_global *= radix
                    n_global_ *= radix

            if twiddle_type[stage_id] == 0:
                ft_fft += f'''
        __syncthreads();
        '''
                for i in range(signal_per_thread):    
                    ft_fft += f'''
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((tx) / {int(N2 // N__)}) * {i}) / (float)({N__}), tmp_angle);
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
    '''
                for i in range(signal_per_thread):
                    ft_fft += f'''
        sdata[ty * {N2} + __id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
        ''' if False else f'''
        sdata[((ty * {N2} + __id[{order[signal_per_thread - offset + i]}]) / 16) * 17 + 
        (ty * {N2} + __id[{order[signal_per_thread - offset + i]}]) % 16] = temp_{order[signal_per_thread - offset + i]};
        '''
                ft_fft += f'''
        __syncthreads();
        '''
                for i in range(signal_per_thread):
                    ft_fft += f'''
        temp_{i} = sdata[ty * {N2} + ({i * blockdim_x} + tx)];
        __id[{i}] = tx + {i * blockdim_x};
        ''' if False else f'''
        temp_{i} = sdata[((ty * {N2} + {i} * blockDim.x + tx) / 16) * 17 +
                            ((ty * {N2} + {i} * blockDim.x + tx) % 16)];
        __id[{i}] = tx + {i * blockdim_x};
        '''
                    order[i] = i
                offset = signal_per_thread
                N__ = N__ / (2 ** plan[stage_id])
                    
            else:
                ft_fft += f'''
        n_global *= 2;
        // __syncthreads();
        '''
                offset = 0 if  offset > 0 else signal_per_thread
                ft_fft += '''
            #if FT==2
            __syncthreads();
            mem_checksum.x = 0;
            mem_checksum.y = 0;
            int r_id;
    '''
                for i in range(signal_per_thread):
                    temp_id = order[signal_per_thread - offset + i]
                    ft_fft += f'''
            r_id = __id[{order[signal_per_thread - offset + i]}] % 3;
            mem_checksum.x += temp_{temp_id}.x * r[r_id].x - temp_{temp_id}.y * r[r_id].y;
            mem_checksum.y += temp_{temp_id}.y * r[r_id].x + temp_{temp_id}.x * r[r_id].y;
    '''
        
                ft_fft += '''
                mem_checksum.y = mem_checksum.y + mem_checksum.x;
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 16, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 8, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 4, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 2, 32);
                mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, 1, 32);
                
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 16, 32);
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 8, 32);
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 4, 32);
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 2, 32);
                // mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, 1, 32);
                if(tid % 32 == 0){
                    mem_checksum.x  = mem_checksum.y;
                    mem_checksum.y = mem_checksum.y - mem_checksum_t1.y;
                    sdata[tid / 32] = mem_checksum;
                }
                __syncthreads();
                mem_checksum.x = 0;
                mem_checksum.y = 0;
                '''
                
                ft_fft += f'''
                if(tid < {num_thread // 32})
                '''
                ft_fft += f'''
                mem_checksum = sdata[tid];
                '''
                i = num_thread // 32
                while( i > 1):
                    i //= 2
                    ft_fft += f'''
                    mem_checksum.x += __shfl_xor_sync(0xffffffff, mem_checksum.x, {i}, 32);
                    mem_checksum.y += __shfl_xor_sync(0xffffffff, mem_checksum.y, {i}, 32);
            '''
                ft_fft += '''
                // if(mem_checksum.y > 1)printf("%f, %f, %f\\n", temp_0.x, temp_0.y, mem_checksum.y );
                // if(tid == 0 && mem_checksum.y * mem_checksum.y / mem_checksum.x > 1)printf("up2 %f, %f, %f\\n", mem_checksum.x, mem_checksum.y,mem_checksum.y * mem_checksum.y / mem_checksum.x);
                // if(tid == 0 && bx < 128)printf("up2 %f, %f, %f\\n", mem_checksum.x, mem_checksum.y,  mem_checksum.y / mem_checksum.x);
            '''
                
                ft_fft += f'''
                temp_0.x += 0.1f * (mem_checksum.x);
                temp_0.y += 0.1f * (mem_checksum.y);
                // if(tid == 0 && blockIdx.x == 0)printf("%f, %f,%f, %f\\n", temp_0.x, temp_0.y,mem_checksum_t1.x,mem_checksum_t1.y );
                #endif
                #if defined(LOG_ON)
                if(tid == 0 && bx < 128)printf("up2 %f, %f, %f\\n", mem_checksum.x, mem_checksum.y, mem_checksum.y / mem_checksum.x);
                #endif
                '''
                
                
                for i in range(signal_per_thread):
                    ft_fft += f'''
        // sdata[ty + {blockdim_y} * __id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
        '''
                ft_fft += f'''
        // __syncthreads();
        '''
                for i in range(signal_per_thread):
                    ft_fft += f''' 
                    // temp_0 = sdata[((tx + ty * {blockdim_x} + {i * num_thread}) % {blockdim_y}) + {blockdim_y} * ((tx + ty * {blockdim_x} + {i * num_thread}) / {blockdim_y})];
                    outputs[__id[{order[signal_per_thread - offset + i]}] + (ty + bx * blockDim.y) * {N2}] = temp_{order[signal_per_thread - offset + i]};
        '''
                ft_fft += '''
        }
    '''
                break
       
                
    else: 
        exponent = int(log(N, radix))
        N__ = N2
        print(f"########################### TRANSPOSE N = 2 ** {exponent} ###########################################################")
        print(f"N={N2}, radix={radix}, N2 / radix = {N2 / radix}, signal_per_thread={signal_per_thread}")
        log_threadx = 0# thread to log
        log_thready = 0# thread to log
        log_block = 0# thread to log
        plan = []
        twiddle_type = []
        blockdim_y = int((N2 // signal_per_thread))
        blockdim_x = int(num_thread // (N2 // signal_per_thread))
        i = 1
        while i <= N2 / radix:
            if i > N2 / radix:
                break
            elif i >= N2 / signal_per_thread:
                twiddle_type.append(1)
            else:
                twiddle_type.append(0)
            n = 0
            output = f""
            while i < int(N2) and n < int(log(signal_per_thread, radix)):
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
    __global__ void __launch_bounds__({num_thread}) fft_radix{radix}_logN{exponent}_2''' + '''(float2* inputs, float2* outputs) {
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
        int N = {N2};
        int __id[{signal_per_thread}];
        float2 tmp;
        float2 tmp_angle, tmp_angle_rot;
        int j;
        int k;
        int tmp_id;
        int n = 1, n_global = 1;
        float2 tmp_angle_bk;
        '''
        n = 1
        n_global = 1
        ft_fft += '''
        '''
        for i in range(signal_per_thread):
            ft_fft += f'''temp_{i} = inputs[(ty + {i} * {blockdim_y}) + (tx + bx * {blockdim_x}) * {N2}];
        '''
        ft_fft += '''
        '''
        for i in range(signal_per_thread):
            ft_fft += f'''__id[{i}] = {i * blockdim_y} + ty;
        '''
        for stage_id in range(len(plan)):
            if True:
                batch_size = 1 if twiddle_type[stage_id] == 0 else n_global // (N2 // signal_per_thread)
                n = 1
                n_global_ = 1
                for j in range(plan[stage_id]):
                    i = 0 + signal_per_thread // radix
                    ft_fft += f'''
        j = {int(i / ((signal_per_thread) // radix))};
        k = {i // batch_size } % {n_global_};
        MY_ANGLE2COMPLEX((float)(j * k) * {(-2.0 * M_PI / (radix * n_global_))}f, tmp_angle);
        tmp_angle_bk = tmp_angle;
        ''' * (2 if if_abft else 1)
                    for batch in range(batch_size):
                        ft_fft += '''
                    tmp_angle = tmp_angle_bk;
    '''
                        for k in range(max(1, n // 2)):
                            i = k * batch_size + batch + signal_per_thread // radix
                            ft_fft += f'''
            tmp_angle_rot.x = {cos(- M_PI / float(n)) if k != 0 else 1.}f;
            tmp_angle_rot.y = {sin(- M_PI / float(n)) if k != 0 else 0.}f;
            MY_MUL(tmp_angle, tmp_angle_rot, tmp);
            tmp_angle = tmp;
            tmp_angle_rot.x = tmp_angle.y;
            tmp_angle_rot.y = -tmp_angle.x;
            ''' * (2 if if_abft else 1)
                            for kk in range(signal_per_thread // radix // batch_size // n):
                                i = (kk * n + k) * batch_size + batch + signal_per_thread // radix
                                ft_fft += f'''
            MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
            temp_{order[signal_per_thread - offset + i]} = tmp;
            ''' * (2 if if_abft else 1)
                                if n // 2 != 0:
                                    i += (n // 2) * batch_size
                                    ft_fft += f'''
            MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle_rot, tmp);
            temp_{order[signal_per_thread - offset + i]} = tmp;
            ''' * (2 if if_abft else 1)
                    for batch in range(batch_size):        
                        for i in range(signal_per_thread // radix  // batch_size):
                            tmp_id_left = ((i // n) * 2 * n + (i % n)) * batch_size + batch
                            tmp_id_right = ((i // n) * 2 * n + (i % n) + n) * batch_size + batch
                            ft_fft += f'''
            tmp = temp_{order[i * batch_size + batch + signal_per_thread - offset]};
            MY_ADD(tmp, temp_{order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i * batch_size + batch + signal_per_thread - offset]});
            MY_SUB(tmp, temp_{order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]}, temp_{order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]});
            ''' * (2 if if_abft else 1)
                            ft_fft += f'''
            tmp_id = __id[{order[i * batch_size + batch + signal_per_thread - offset]}];
            tmp_id = (tmp_id / n_global) * 2 * n_global + (tmp_id % n_global);
            __id[{order[i * batch_size + batch + signal_per_thread - offset]}] = tmp_id;
            __id[{order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]}] = tmp_id + {n_global};
            '''
                            order[tmp_id_left + offset] = order[i * batch_size + batch + signal_per_thread - offset]
                            order[tmp_id_right + offset] = order[i * batch_size + batch + signal_per_thread + int(signal_per_thread / 2) - offset]
                    ft_fft += f'''
        n_global *= 2;
        '''
                    offset = 0 if  offset > 0 else signal_per_thread
                    n *= radix
                    n_global *= radix
                    n_global_ *= radix
            if twiddle_type[stage_id] == 0:
                ft_fft += f'''
        __syncthreads();
        ''' if stage_id != 0 else '''
        '''
                for i in range(signal_per_thread):    
                    ft_fft += f'''
    MY_ANGLE2COMPLEX((float)(-M_PI * 2 * ((ty) / {int(N2 // N__)}) * {i}) / (float)({N__}), tmp_angle);
    MY_MUL(temp_{order[signal_per_thread - offset + i]}, tmp_angle, tmp);
    temp_{order[signal_per_thread - offset + i]} = tmp;
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
                N__ = N__ / (2 ** plan[stage_id])
            else:
                ft_fft += f'''
        n_global *= 2;
        '''
                offset = 0 if  offset > 0 else signal_per_thread
                
                for i in range(signal_per_thread):
                    ft_fft += f'''
        outputs[(tx + bx * {blockdim_x}) * {N2} +  __id[{order[signal_per_thread - offset + i]}]] = temp_{order[signal_per_thread - offset + i]};
        '''
                ft_fft += '''
        }
    '''
                break
                                
    return ft_fft
