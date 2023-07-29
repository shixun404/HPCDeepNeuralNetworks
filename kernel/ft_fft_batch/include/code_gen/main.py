import pandas as pd
import numpy as np
from code_gen_1D_batch import ft_1D_fft_code_gen
from code_gen_2D_upload1_batch import ft_2D_fft_code_gen_upload1
from code_gen_2D_upload2_batch import ft_2D_fft_code_gen_upload2
from code_gen_3D_upload1_batch import ft_3D_fft_code_gen_upload1
from code_gen_3D_upload2_batch import ft_3D_fft_code_gen_upload2
from code_gen_3D_upload3_batch import ft_3D_fft_code_gen_upload3
# from code_gen_script import code_gen_script
from code_gen_script_batch import code_gen_script
if __name__ =="__main__":
    radix = 2
    
    df = pd.read_csv(f'parameter_radix{radix}.csv')
    if_abft = False

    N = 2 **     int(df['logN'][0])
    include_list = '''
        #include "./include/fft.cuh"
    '''
    signal_per_thread = int(df['signal_per_thread_1'][0])
    bx = int(df['blockdim_x_1'][0])
    by = int(df['blockdim_y_1'][0])
    num_thread = bx * by
    fft_kernel = ft_1D_fft_code_gen(N=N, num_thread=num_thread,
                                radix=2, signal_per_thread=signal_per_thread, transpose=True, if_abft=False)
    function_name = f'''ft_fft_radix{radix}_logN{int(df['logN'][0])}_reg{signal_per_thread}'''
    with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
        f.write(fft_kernel)
    include_list += f'''
        #include "./include/radix_2_codegen/ft_fft_radix2_logN{int(df['logN'][0])}_reg{signal_per_thread}.cuh"
    '''

    
    N = int(radix ** df['logN'][1])
    N1 = int(radix ** df['logN1'][1])
    N2 = int(radix ** df['logN2'][1])
    num_block = int(df['num_block_1'][1])
    num_thread = int(df['num_thread_1'][1])
    signal_per_thread = int(df['signal_per_thread_1'][1])
    fft_kernel = ft_2D_fft_code_gen_upload1(N=N, N1=N1, N2=N2, num_block=num_block, num_thread=num_thread,
                            radix=2, signal_per_thread=signal_per_thread, if_abft=False)
    function_name = f'''ft_fft_radix{radix}_logN{int(df['logN'][1])}_reg{signal_per_thread}_upload=1'''
    with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
        f.write(fft_kernel)
    include_list += f'''
        #include "./include/radix_2_codegen/ft_fft_radix2_logN{int(df['logN'][1])}_reg{signal_per_thread}_upload=1.cuh"
    '''
    num_block = int(df['num_block_2'][1])
    num_thread = int(df['num_thread_2'][1])
    signal_per_thread = int(df['signal_per_thread_2'][1])
    blockdim_x = int(df['blockdim_x_2'][1])
    blockdim_y = int(df['blockdim_y_2'][1])
    fft_kernel = ft_2D_fft_code_gen_upload2(N=N, N1=N1, N2=N2, num_block=num_block, num_thread=num_thread,
                            radix=2, signal_per_thread=signal_per_thread, transpose=blockdim_x<blockdim_y, if_abft=False)
    function_name = f'''ft_fft_radix{radix}_logN{int(df['logN'][1])}_reg{signal_per_thread}_upload=2'''
    with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
        f.write(fft_kernel)
    include_list += f'''
        #include "./include/radix_2_codegen/ft_fft_radix2_logN{int(df['logN'][1])}_reg{signal_per_thread}_upload=2.cuh"
    '''
    # include_list = ''
    # if_abft = False
    # while N <= 2 ** 29:
    #     N = int(radix ** df['logN'][i-1])
    #     N1 = int(radix ** df['logN1'][i-1])
    #     N2 = int(radix ** df['logN2'][i-1])
    #     N3 = int(radix ** df['logN3'][i-1])
        
    #     num_block = int(df['num_block_1'][i-1])
    #     num_thread = int(df['num_thread_1'][i-1])
    #     signal_per_thread = int(df['signal_per_thread_1'][i-1])
    #     fft_kernel = ft_3D_fft_code_gen_upload1(N=N, N1=N1, N2=N2, N3=N3, num_block=num_block, num_thread=num_thread,
    #                             radix=2, signal_per_thread=signal_per_thread, if_abft=if_abft)
    #     function_name = f'ft_fft_radix{radix}_logN{i}_upload=1'
    #     # function_name = f'ft_fft_radix{radix}_logN{i}_upload=1'
    #     with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
    #         f.write(fft_kernel)
    #     include_list += f'#include "./include/radix_2_codegen/{function_name}.cuh"\n'
        
    #     num_block = int(df['num_block_2'][i-1])
    #     num_thread = int(df['num_thread_2'][i-1])
    #     signal_per_thread = int(df['signal_per_thread_2'][i-1])
    #     blockdim_x = int(df['blockdim_x_2'][i-1])
    #     blockdim_y = int(df['blockdim_y_2'][i-1])
    #     fft_kernel = ft_3D_fft_code_gen_upload2(N=N, N1=N1, N2=N2, N3=N3, num_block=num_block, num_thread=num_thread,
    #                             radix=2, signal_per_thread=signal_per_thread, if_abft=if_abft)
    #     function_name = f'ft_fft_radix{radix}_logN{i}_upload=2'
    #     # function_name = f'ft_fft_radix{radix}_logN{i}_upload=2'
    #     with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
    #         f.write(fft_kernel)
    #     include_list += f'#include "./include/radix_2_codegen/{function_name}.cuh"\n'
        
    #     num_block = int(df['num_block_3'][i-1])
    #     num_thread = int(df['num_thread_3'][i-1])
    #     signal_per_thread = int(df['signal_per_thread_3'][i-1])
    #     blockdim_x = int(df['blockdim_x_3'][i-1])
    #     blockdim_y = int(df['blockdim_y_3'][i-1])
    #     fft_kernel = ft_3D_fft_code_gen_upload3(N=N, N1=N1, N2=N2, N3=N3, num_block=num_block, num_thread=num_thread,
    #                             radix=2, signal_per_thread=signal_per_thread, if_abft=if_abft)
    #     # function_name = f'ft_fft_radix{radix}_logN{i}_reg{signal_per_thread}_upload=3'
    #     function_name = f'ft_fft_radix{radix}_logN{i}_upload=3'
    #     with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
    #         f.write(fft_kernel)
    #     include_list += f'#include "./include/radix_2_codegen/{function_name}.cuh"\n'
    #     i += 1
    #     N *= radix
    fft_script = code_gen_script()
    with open(f"../../ft_fft.cu", 'w') as f:
        f.write(fft_script)
    with open(f"../../kernels.cuh", 'w') as f:
        f.write(include_list)