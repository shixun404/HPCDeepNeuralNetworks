# HPCDeepNeuralNetworks
High-Performance Deep Learning

Meeting at Sep 19 2022:
```
- Please try to download & install the latest version of MAGMA BLAS (2.6.2), and test the performance of three sample problems of it. 1) fp32 ax + y. (saxpy) 2) fp32 dot product (sdot), 3) fp32 gemm (sgemm) and 4) fp16 gemm (hgemm). Please also compare the performance against cuBLAS. cuBLAS comes together with the built-in cudatoolkit-11.3 on turing4 so you don't have to install/configure for it. But you still need to learn how to call these routines.

- Learn what roofline model is. Also learn what STREAM benchmark is. Please find a CUDA stream benchmark online, testing the memory bandwidth of turing4 GPU and tell the difference between the theoretical mem-bw and experimental mem-bw.

- Using the experimental results and vendors spec data to compute the efficiencies of all four routines from both libraries that you benchmarked. 

- Try to implement a prototype saxpy and compare the performance against reference libs. 
```
[Meeting Slides](https://docs.google.com/presentation/d/1c313YcVJXOzObtOIY2anqqYC7Ah4qs0sYNExqSFnilQ/edit#slide=id.p)

Meeting Sep 26 2022:

```
- Write two custom methods: saxpy and sdot.
- Compared implmentation: cublas
```
