

__global__ void __launch_bounds__(256) my_hadamard_kernel(float* X, int N){
    int bx = blockIdx.x;
    int tx = threadIdx.x;
    int x = (tx + bx * blockDim.x);
    float data[4], res[4];
    if(2 * x >= N * N) return;
    *(float4*)data = *(float4*)(X + x * 4);
    // #define MY_MUL(a, b, c) c.x = a.x * b.x - a.y * b.y; c.y = a.y * b.x + a.x * b.y;
    float angle = -2 * M_PI * ((x * 2) / N) * ((x * 2) % N) / (N * N);
    float2 tmp;
    tmp.x = __cosf(angle);
    tmp.y = __sinf(angle);
    
    MY_MUL((*((float2*)data)), tmp, (*((float2*)res)));
    // printf("tx: %d, x: %d, k: %d, s: %d\n", tx, x, ((x * 2 + 1) / N), ((x * 2 + 1) % N));
    angle = -2 * M_PI * ((x * 2 + 1) / N) * ((x * 2 + 1) % N) / (N * N);
    tmp.x = __cosf(angle);
    tmp.y = __sinf(angle);
    MY_MUL((*((float2*)data + 1)), tmp, (*((float2*)res + 1)));

    *(float4*)(X + x * 4) = *(float4*)res;
}