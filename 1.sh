cd kernel/ft_fft/
rm kernels.cuh
rm ft_fft.cu
cd -
cd kernel/ft_fft/include/code_gen/
python main.py
cd -
cd kernel/ft_fft_batch/include/code_gen/
python main.py
cd -
make clean; make V_FFT=0 P_FFT=1 FT=2 LOG=LOG_OFF GLOBAL=GLOBAL_OFF -j
./ft_fft 14 20
# ./ft_fft_batch 9
# make clean; make V_FFT=0 P_FFT=1 FT=0 LOG=LOG_OFF GLOBAL=GLOBAL_OFF -j
# ./ft_fft 23 29 