# HPCDeepNerualNetworks
Cuda implementation of SAXPY and SDOT

Fine tuning: blockDim.x = 256, gridDim.x = (N + blockDim.x - 1) / blockDim.x
![alt text](fig/saxpy.png)
![alt text](fig/sdot.png)
![alt text](fig/sgemm.png)

