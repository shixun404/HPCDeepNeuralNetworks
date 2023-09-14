# BINARY_NAME = ft_fft_batch # ft_fft_batch #ft_fft #ft_sgemm #sdot saxpy
BINARY_NAME = ft_fft
CUDA_PATH   = /opt/nvidia/hpc_sdk/Linux_x86_64/22.7/cuda
MATH_LIB = /opt/nvidia/hpc_sdk/Linux_x86_64/22.7/math_libs/11.7
CC          = nvcc -arch=sm_80 #--ptxas-options=-v

CFLAGS      = -O3 -std=c++11 
LDFLAGS     = -L$(MATH_LIB)/lib64 -lcudart -lcublas -lcufft
INCFLAGS    = -I$(CUDA_PATH)/include -Icuda-samples/Common -I. 
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

