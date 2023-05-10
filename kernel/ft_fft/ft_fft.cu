#include <stdlib.h>
int main(int argc, char** argv){
    int N = 32;
    int random_seed = 10;
    float* input = (float*)calloc(N * 2, sizeof(float));
    float* output = (float*)calloc(N * 2, sizeof(float));
    float* input_d, *output_d;
    cudaMalloc((void**)&input_d, sizeof(float) * N * 2);
    cudaMalloc((void**)&output_d, sizeof(float) * N * 2);

    for(int = 0; i < N * 2; ++i){
        input[i] = (srandom(random_seed) % 100) / 100;
    }

    cudaMemcpy((void*)intput_d, (void*)input, 2 * N * sizeof(float), cudaMemcpyHostToDevice);

    dim3 gridDim(1, 1, 1);
    dim3 blockDim(4, 1, 1);

    

    


}