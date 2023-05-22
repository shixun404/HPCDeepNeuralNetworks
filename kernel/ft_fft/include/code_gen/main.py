import numpy as np
from code_gen_1D import ft_1D_fft_code_gen
from code_gen_2D import ft_2D_fft_code_gen
if __name__ =="__main__":
    import os
    # kernel = os.sys.argv[1]
    # if_abft = int(os.sys.argv[2])
    radix = 2
    N = 8
    signal_per_thread = 8
    if_abft = False
    # abft = "ft_" if if_abft else ""
    i = 3


    params = np.genfromtxt("parameter.csv", dtype=None, delimiter=",", names=True)
    print(params['logN'])
    assert 0
    
    while N <= 2 ** 13:
        signal_per_thread = 16 if (N == 2 ** 11 or N == 2 ** 12) else 8
        fft_kernel = ft_1D_fft_code_gen(radix, N, signal_per_thread, if_abft)
        function_name = f'ft_fft_radix{radix}_logN{i}_reg{signal_per_thread}'
        with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
            f.write(fft_kernel)
        i += 1
        N *= 2
    while N <= 2 ** 19:
        # def ft_2D_fft_code_gen(N, N1, N2, num_block, num_thread,
        #                radix=2, signal_per_thread=8, if_abft=False):
        signal_per_thread = 16 if (N == 2 ** 11 or N == 2 ** 12) else 8
        fft_kernel = ft_1D_fft_code_gen(radix, N, signal_per_thread, if_abft)
        function_name = f'ft_fft_radix{radix}_logN{i}_reg{signal_per_thread}'
        with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
            f.write(fft_kernel)
        i += 1
        N *= 2