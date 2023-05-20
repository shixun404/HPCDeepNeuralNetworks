from code_gen import ft_fft_code_gen
if __name__ =="__main__":
    import os
    # kernel = os.sys.argv[1]
    # if_abft = int(os.sys.argv[2])
    radix = 2
    N = 8
    signal_per_thread = 8
    if_abft = False
    # abft = "ft_" if if_abft else ""
    while N <= 2 ** 9:
        fft_kernel = ft_fft_code_gen(radix, N, signal_per_thread, if_abft)
        N *= 2
    # with open(f"../include_code_gen/{function_name}.cuh", 'w') as f:
    #     f.write(sgemm_kernel)