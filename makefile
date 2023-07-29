BINARY_NAME = ft_fft_batch # ft_fft_batch #ft_fft #ft_sgemm #sdot saxpy
CUDA_PATH   = /usr/local/cuda
CC          = $(CUDA_PATH)/bin/nvcc -arch=sm_75 #--ptxas-options=-v 
CFLAGS      = -O3 -std=c++11 
LDFLAGS     = -L$(CUDA_PATH)/lib64 -lcudart -lcublas -lcufft
INCFLAGS    = -I$(CUDA_PATH)/include -I$(CUDA_PATH)/samples/common/inc -I. 
LOG = LOG_OFF
GLOBAL = GLOBAL_ON
V_FFT = 0
P_FFT = 0
K_FFT = 2
CFLAGS += -D$(LOG)
CFLAGS += -D$(GLOBAL)
CFLAGS += -DV_FFT=$(V_FFT)
CFLAGS += -DP_FFT=$(P_FFT)
CFLAGS += -DK_FFT=$(K_FFT)
CFLAGS += -DFT=$(FT)

SRC         = $(wildcard *.cu)
build : $(BINARY_NAME)

$(BINARY_NAME): %: kernel/%/ft_fft.cu  utils/utils.cu 
	$(CC) $(CFLAGS) $(LDFLAGS) $(INCFLAGS)  $^   -o $@ 

clean:
	rm $(BINARY_NAME)

