BINARY_NAME = sgemm ft_sgemm #sdot saxpy
CUDA_PATH   = /usr/local/cuda
CC          = $(CUDA_PATH)/bin/nvcc -arch=sm_80 #--ptxas-options=-v
CFLAGS      = -O3 -std=c++11 
LDFLAGS     = -L$(CUDA_PATH)/lib64 -lcudart -lcublas
INCFLAGS    = -I$(CUDA_PATH)/include -I$(CUDA_PATH)/samples/common/inc -I. -I./cuda-samples/Common




SRC         = $(wildcard *.cu)
build : $(BINARY_NAME)

$(BINARY_NAME): %: kernel/%/sgemm.cu  utils/utils.cu 
	$(CC) $(CFLAGS) $(LDFLAGS) $(INCFLAGS)  $^ -o $@

clean:
	rm $(BINARY_NAME)

#run:
#	nvcc -o saxpy saxpy.cu  -std=c++11 -lcublas -O3
#	nvcc -o sdot sdot.cu  -std=c++11 -lcublas -O3

#profile:
#	nsys profile --stats=true ./saxpy

#clean:
#	bash -c "rm ./report*"
