cd kernel/ft_fft/include/code_gen/
python main.py
cd -
make clean; make V_FFT=0 P_FFT=0 FT=2 LOG=LOG_OFF -j
./ft_fft 29
# make clean; make V_FFT=0 P_FFT=1 FT=2 LOG=LOG_OFF -j
# ./ft_fft 23 28