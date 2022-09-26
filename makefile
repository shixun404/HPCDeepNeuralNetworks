run:
	nvcc -o saxpy saxpy.cu  -std=c++11 -lcublas
	nvcc -o sdot sdot.cu  -std=c++11 -lcublas

profile:
	nsys profile --stats=true ./saxpy

clean:
	bash -c "rm ./report*"
