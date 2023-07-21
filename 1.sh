cd kernel/ft_fft/include/code_gen/
python main.py
cd -
make clean; make V_FFT=1 P_FFT=1 FT=0 LOG=LOG_OFF -j
./ft_fft 18
# make clean; make V_FFT=0 P_FFT=1 FT=0 LOG=LOG_OFF GLOBAL=GLOBAL_OFF -j
# ./ft_fft 23 29