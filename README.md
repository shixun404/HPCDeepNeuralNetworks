# HPCDeepNerualNetworks
Cuda implementation of SAXPY, SDOT and SGEMM.
## 1. SAXPY and SDOT
Custom kernel outperforms cublasSaxpy and cublasSdot on Turing4.
![alt text](fig/saxpy.png)
![alt text](fig/sdot.png)
## 2. SGEMM
- [x] Learn the definition of leading dimension, and tell the difference between row-major storage and column-major storage.
- [x] Theoretical peak perf of FP32 on Turing4: min(8100 GFLOPS, N * 31.25GFLOPS).
- [x] Row major GEMM on CPU
- [x] Call cublasSgemm under row major: AB=C -> B'A'=C'
- [x] Validation of CPU GEMM and cublasSgemm 
- [x] Implement GPU version SGEMM, validate the correctness, and benchmarking the performance for square matrices ranging 256 to 6144.
- [ ] Optimize the baseline GPU SGEMM
![alt text](fig/sgemm.png)
### 2.1 Kernel 1: basline GPU SGEMM
naive implmentation, each thread calculates a different index C<sub>ij</sub> for matrix C.

Note 1: how to transfer from column major to row major
```
for cublas, B in row major, is equivalent to B' in col major.
col major: AB=C  --> row major: B'A'=C'
modify cublasSgemm(...A(col major), B(col major)...) to cublasSgemm(...B(row major), A(row major)...).
```
### 2.2 Kernel 2: block matrix multiplication
Each thread calculates a different block C_block<sub>ij</sub> for matrix C.
