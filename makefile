BINARY_NAME = sgemm #sdot saxpy
CUDA_PATH   = /usr/local/cuda-11.4
CC          = $(CUDA_PATH)/bin/nvcc
CFLAGS      = -O3 -std=c++11  
LDFLAGS     = -L$(CUDA_PATH)/lib64 -lcudart -lcublas
INCFLAGS    = -I$(CUDA_PATH)/include -I$(CUDA_PATH)/samples/common/inc




SRC         = $(wildcard *.cu)
build : $(BINARY_NAME)

$(BINARY_NAME): %: %.cu utils.cu ./kernel/kernel_9.cu ./kernel/kernel_10.cu ./kernel/kernel_11.cu ./kernel/kernel_12.cu
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
