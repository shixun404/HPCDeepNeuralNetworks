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
    i = 3
    while N <= 2 ** 13:
        signal_per_thread = 16 if (N == 2 ** 11 or N == 2 ** 12) else 8
        fft_kernel = ft_fft_code_gen(radix, N, signal_per_thread, if_abft)
        function_name = f'ft_fft_radix{radix}_logN{i}_reg{signal_per_thread}'
        with open(f"../radix_2_codegen/{function_name}.cuh", 'w') as f:
            f.write(fft_kernel)
        i += 1
        N *= 2