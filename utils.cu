#include "utils.cuh"


__global__ void fill(float *a , float x, int N)
{
   int index =  blockIdx.x * blockDim.x + threadIdx.x;
   int stride = blockDim.x * gridDim.x;

   for(int i = index; i < N; i += stride)
   {
       a[i] = x;
   }
}


void fill_vector(float *target, int size, float val){
    for(int i = 0; i < size; ++i){
        target[i] = val;
    }
}

cudaDeviceProp getDetails(int deviceId)
{
        cudaDeviceProp props;
            cudaGetDeviceProperties(&props, deviceId);
                return props;
}

void generate_random_vector(float* target, int n){
    for(int i = 0; i < n; ++i){
        float tmp = (float)(rand() % 5) + rand() % 5 * 0.01;
        tmp = (rand() % 2 == 0) ? tmp : tmp * (-1.);
        target[i] = tmp;
    }
}

void copy_vector(float *src, float *dest, int n){
    int i;
    for (i = 0; src + i && dest + i && i < n; i++) *(dest + i) = *(src + i);
    if (i != n) printf("copy failed at %d while there are %d elements in total.\n", i, n);
}

bool verify_vector(float *vec1, float *vec2, int n){
    double diff = 0.0;
    int i;
    for (i = 0; vec1 + i && vec2 + i && i < n; i++){
        diff = fabs( (double)vec1[i] - (double)vec2[i] );
        if (diff / double(vec1[i]) > 5e-5) {
            printf("error. %5.2f,%5.2f,%d\n", vec1[i], vec2[i],i);
            // return false;
            // printf("asdadsad");
            return false;
        }
    }
    return true;
}

