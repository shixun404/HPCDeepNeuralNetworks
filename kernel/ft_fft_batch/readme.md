# High-Performance Fast Fourier Transform on GPU

## Run the following command to verify correctness

```
make V=VERIFY -j
./ft_fft #length_of_FFT
```



## Run the following command for profiling

```
make P=PROFILING -j
./ft_fft 16
```

You will get the following output.

```
| SIZE |  Execution Time (us) |   Shared   | #threads |
|------|----------------------|------------|----------|
|log(N)|   Ours   |   cuFFT   | Memory (KB)|          |
|     3|   11.264 |   11.360  |   0.062    |         1|
|     4|   13.382 |   11.654  |   0.125    |         2|
|     5|   15.578 |   12.611  |   0.250    |         4|
|     6|   17.795 |   12.230  |   0.500    |         8|
|     7|   15.974 |   13.424  |   1.000    |        16|
|     8|   18.410 |   12.813  |   2.000    |        32|
|     9|   20.890 |   13.075  |   4.000    |        64|
|    10|   19.046 |   14.365  |   8.000    |       128|
|    11|   46.694 |   15.773  |  16.000    |       256|
|    12|   73.741 |   21.043  |  32.000    |       512|
|    13|   64.502 |   36.710  |  64.000    |      1024|
|    14|   90.320 |   36.531  | 128.000    |      2048|
|    15|  138.301 |   65.334  | 256.000    |      4096|
|    16|  135.843 |   68.813  | 512.000    |      8192|
```