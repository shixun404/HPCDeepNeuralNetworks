# HPCDeepNerualNetworks
Cuda implementation of SAXPY, SDOT and SGEMM.
## 1. SAXPY and SDOT
Custom kernels outperform cublasSaxpy and cublasSdot on Turing4.
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
![alt text](fig/sgemm_1.png)
### 2.1 Kernel 1: basline GPU SGEMM
* Naive implmentation, each thread calculates a different index C<sub>ij</sub> for matrix C.

* How to transfer from column major to row major
```
B(col major) = B'(row major)
```

| Column Major  | Row Major |
| ----------- | ----------- |
|      AxB = C      |      B'xA'=C'       |
|   cublasSgemm(...A(col major), B(col major)...)  | cublasSgemm(...B(row major), A(row major)...)        |

### 2.2 Kernel 2: block matrix multiplication
* Each thread block calculates a different block C_block<sub>ij</sub> for matrix C.
* $Cblock_{ij} = \sum_{k} Ablock_{ik} * Bblock_{kj}$ 
* Load $Ablock_{ik}, Bblock_{kj}$ into shared memory to accelerate. 

#### 2.2 Kernel 2': Obey spatial locality within a warp (actually I am not sure about this) in kernel 1 and kernel 2: 
* Possible reasons: threads in same warp should load data from a same memory block to avoid serialization and satisfy **spatial locality**.
![alt text](fig/sgemm_2.png)
### 2.3 Kernel 3: Calculate 4 index $C_{ij}, C_{ij+1}, C_{ij+2},C_{ij+3}$ within a thread: 
![alt text](fig/sgemm_3.png)

### 2.4 Kernel 4: A modification of access order for kernel 3: 
![alt text](fig/sgemm_3vs4.png)

### 2.5 Kernel 5: Vectorized load/store with float4 for kernel 4: 
![alt text](fig/sgemm_4vs5.png)