
#include <chrono>
class saxpy_timer
{
public:
    saxpy_timer() { reset(); }
    void reset() {
    t0_ = std::chrono::high_resolution_clock::now();
    }
    double elapsed(bool reset_timer=false) {
    std::chrono::high_resolution_clock::time_point t =
            std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> time_span =
            std::chrono::duration_cast<std::chrono::duration<double>>(t - t0_);
    if (reset_timer)
        reset();
    return time_span.count();
    }
    double elapsed_msec(bool reset_timer=false) {
    return elapsed(reset_timer) * 1000;
    }
private:
    std::chrono::high_resolution_clock::time_point t0_;
};

__global__ void fill(float *a , float x, int N)
{
   int index =  blockIdx.x * blockDim.x + threadIdx.x;
   int stride = blockDim.x * gridDim.x;

   for(int i = index; i < N; i += stride)
   {
       a[i] = x;
   }
}


cudaDeviceProp getDetails(int deviceId)
{
        cudaDeviceProp props;
            cudaGetDeviceProperties(&props, deviceId);
                return props;
}

