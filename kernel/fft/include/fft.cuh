#include <stdio.h>
#include <math_constants.h>
#include <cuda_runtime.h>
#include <cufftXt.h>
#define M_PI 3.14159265358979312f
#define MY_SUB(a, b, c) c.x = a.x - b.x; c.y = a.y - b.y;
#define MY_ADD(a, b, c) c.x = a.x + b.x; c.y = a.y + b.y;
#define MY_SUB_ft(a, b, c) c.x += a.x - b.x; c.y += a.y - b.y;
#define MY_ADD_ft(a, b, c) c.x += a.x + b.x; c.y += a.y + b.y;
// #define MY_SUB(a, b, c) c.x = a.x - b.x; c.y = a.y - b.y; c.x += a.x * b.x; c.y += a.y * b.y;
// #define MY_ADD(a, b, c) c.x += a.x + b.x; c.y += a.y + b.y; c.x += a.x - b.y; c.y += b.x - a.y;
#define MY_MUL(a, b, c) c.x = a.x * b.x - a.y * b.y; c.y = a.y * b.x + a.x * b.y;
// #define MY_MUL(a, b, c) c.x = a.x * b.x - a.y * b.y; c.y = a.y * b.x + a.x * b.y; c.x += a.x * a.x - b.y * b.y; c.y += b.y * b.x + a.x * a.y;
#define MY_MUL_REPLACE(a, b, c, d) d.x = a.x * b.x - a.y * b.y; d.y = a.y * b.x + a.x * b.y; c = d;
// #define MY_MUL_REPLACE(a, b, c, d) d.x += a.x * b.x - a.y * b.y; d.y += a.y * b.x + a.x * b.y; c.x += d.x;c.y += d.y;
#define MY_ANGLE2COMPLEX(angle, a) a.x = __cosf(angle); a.y =  __sinf(angle); 

// #define MY_ANGLE2COMPLEX(angle, a)  a.x = __cosf(angle); a.y =  __sinf(angle); a.x += __cosf(angle * 0.9f); a.y +=  __sinf(angle * 0.9f);

// #define radix3_a00_x 1.0f;
// #define radix3_a00_y -0.0f;

// #define radix3_a01_x 1.0f;
// #define radix3_a01_y -0.0f;

// #define radix3_a02_x 1.0f;
// #define radix3_a02_y -0.0f;

// #define radix3_a10_x 1.0f;
// #define radix3_a10_y -0.0f;

// #define radix3_a11_x -0.4999999999999998f;
// #define radix3_a11_y -0.8660254037844387f;

// #define radix3_a12_x -0.5000000000000004f;
// #define radix3_a12_y 0.8660254037844384f;

// #define radix3_a20_x 1.0f;
// #define radix3_a20_y -0.0f;

// #define radix3_a21_x -0.5000000000000004f;
// #define radix3_a21_y 0.8660254037844384f;

// #define radix3_a22_x -0.4999999999999992f;
// #define radix3_a22_y -0.8660254037844392f;

// #define A_radix2_0_x 0.5f
// #define A_radix2_0_y -0.8660253882408142f
// #define A_radix2_1_x 1.5f
// #define A_radix2_1_y 0.8660253882408142f

// #define A_radix4_0_x 1.0f
// #define A_radix4_0_y 0.0f
// #define A_radix4_1_x 0.6339746117591858f
// #define A_radix4_1_y 0.6339746117591858f
// #define A_radix4_2_x 0.0f
// #define A_radix4_2_y 1.7320507764816284f
// #define A_radix4_3_x 2.366025447845459f
// #define A_radix4_3_y -2.366025447845459f

// #define A_radix8_0_x 0.5f
// #define A_radix8_0_y -0.8660253882408142f
// #define A_radix8_1_x 0.6929928064346313f
// #define A_radix8_1_y -0.5317519903182983f
// #define A_radix8_2_x 0.8660253882408142f
// #define A_radix8_2_y -0.23205077648162842f
// #define A_radix8_3_x 1.082262396812439f
// #define A_radix8_3_y 0.1424824297428131f
// #define A_radix8_4_x 1.5f
// #define A_radix8_4_y 0.8660253882408142f
// #define A_radix8_5_x 4.039057731628418f
// #define A_radix8_5_y 5.263802528381348f
// #define A_radix8_6_x -0.8660253882408142f
// #define A_radix8_6_y -3.232050895690918f
// #define A_radix8_7_x 0.18568682670593262f
// #define A_radix8_7_y -1.4104316234588623f

// #define A_radix16_0_x 1.0f
// #define A_radix16_0_y 0.0f
// #define A_radix16_1_x 0.8969879746437073f
// #define A_radix16_1_y 0.1784219741821289f
// #define A_radix16_2_x 0.8070071935653687f
// #define A_radix16_2_y 0.33427339792251587f
// #define A_radix16_3_x 0.7216188907623291f
// #define A_radix16_3_y 0.4821702241897583f
// #define A_radix16_4_x 0.6339746117591858f
// #define A_radix16_4_y 0.6339746117591858f
// #define A_radix16_5_x 0.5364618301391602f
// #define A_radix16_5_y 0.802871823310852f
// #define A_radix16_6_x 0.4177376627922058f
// #define A_radix16_6_y 1.0085078477859497f
// #define A_radix16_7_x 0.25624358654022217f
// #define A_radix16_7_y 1.2882237434387207f
// #define A_radix16_8_x 0.0f
// #define A_radix16_8_y 1.7320507764816284f
// #define A_radix16_9_x -0.5256141424179077f
// #define A_radix16_9_y 2.6424412727355957f
// #define A_radix16_10_x -2.5390584468841553f
// #define A_radix16_10_y 6.129827976226807f
// #define A_radix16_11_x 7.356497287750244f
// #define A_radix16_11_y -11.00977611541748f
// #define A_radix16_12_x 2.366025447845459f
// #define A_radix16_12_y -2.366025447845459f
// #define A_radix16_13_x 1.6280629634857178f
// #define A_radix16_13_y -1.087836742401123f
// #define A_radix16_14_x 1.3143131732940674f
// #define A_radix16_14_y -0.5444062352180481f
// #define A_radix16_15_x 1.129741907119751f
// #define A_radix16_15_y -0.22471967339515686f

// #define A_radix32_0_x 0.5f
// #define A_radix32_0_y -0.8660253882408142f
// #define A_radix32_1_x 0.553804337978363f
// #define A_radix32_1_y -0.7728331089019775f
// #define A_radix32_2_x 0.6030120253562927f
// #define A_radix32_2_y -0.6876034140586853f
// #define A_radix32_3_x 0.6490356922149658f
// #define A_radix32_3_y -0.6078881621360779f
// #define A_radix32_4_x 0.6929928064346313f
// #define A_radix32_4_y -0.5317519903182983f
// #define A_radix32_5_x 0.735824704170227f
// #define A_radix32_5_y -0.4575650095939636f
// #define A_radix32_6_x 0.7783811092376709f
// #define A_radix32_6_y -0.3838551640510559f
// #define A_radix32_7_x 0.8214906454086304f
// #define A_radix32_7_y -0.30918726325035095f
// #define A_radix32_8_x 0.8660253882408142f
// #define A_radix32_8_y -0.23205077648162842f
// #define A_radix32_9_x 0.9129745960235596f
// #define A_radix32_9_y -0.15073224902153015f
// #define A_radix32_10_x 0.9635381698608398f
// #define A_radix32_10_y -0.06315356492996216f
// #define A_radix32_11_x 1.019264817237854f
// #define A_radix32_11_y 0.03336694836616516f
// #define A_radix32_12_x 1.082262396812439f
// #define A_radix32_12_y 0.1424824297428131f
// #define A_radix32_13_x 1.1555607318878174f
// #define A_radix32_13_y 0.2694389224052429f
// #define A_radix32_14_x 1.2437561750411987f
// #define A_radix32_14_y 0.4221983551979065f
// #define A_radix32_15_x 1.3542685508728027f
// #define A_radix32_15_y 0.6136113405227661f
// #define A_radix32_16_x 1.5f
// #define A_radix32_16_y 0.8660253882408142f
// #define A_radix32_17_x 1.7056796550750732f
// #define A_radix32_17_y 1.222272276878357f
// #define A_radix32_18_x 2.0256142616271973f
// #define A_radix32_18_y 1.7764158248901367f
// #define A_radix32_19_x 2.6070899963378906f
// #define A_radix32_19_y 2.7835617065429688f
// #define A_radix32_20_x 4.039057731628418f
// #define A_radix32_20_y 5.263802528381348f
// #define A_radix32_21_x 13.977169036865234f
// #define A_radix32_21_y 22.477115631103516f
// #define A_radix32_22_x -5.856496334075928f
// #define A_radix32_22_y -11.875801086425781f
// #define A_radix32_23_x -1.8727192878723145f
// #define A_radix32_23_y -4.975696086883545f
// #define A_radix32_24_x -0.8660253882408142f
// #define A_radix32_24_y -3.232050895690918f
// #define A_radix32_25_x -0.4004870653152466f
// #define A_radix32_25_y -2.4257149696350098f
// #define A_radix32_26_x -0.12806302309036255f
// #define A_radix32_26_y -1.9538620710372925f
// #define A_radix32_27_x 0.05365872383117676f
// #define A_radix32_27_y -1.6391106843948364f
// #define A_radix32_28_x 0.18568682670593262f
// #define A_radix32_28_y -1.4104315042495728f
// #define A_radix32_29_x 0.2876772880554199f
// #define A_radix32_29_y -1.2337794303894043f
// #define A_radix32_30_x 0.3702579736709595f
// #define A_radix32_30_y -1.090744972229004f
// #define A_radix32_31_x 0.4397074580192566f
// #define A_radix32_31_y -0.9704551696777344f

// #define GEMM_radix3 (b0, b1, b2, c0, c1, c2) \
// c0.x += radix3_a00_x * b0.x - radix3_a00_y * b0.y; c0.y = radix3_a00_y * b0.x + radix3_a00_x * b0.y;\    
// c0.x += radix3_a01_x * b1.x - radix3_a01_y * b1.y; c0.y = radix3_a01_y * b1.x + radix3_a01_x * b1.y;\    
// c0.x += radix3_a02_x * b2.x - radix3_a02_y * b2.y; c0.y = radix3_a02_y * b2.x + radix3_a02_x * b2.y;\    
// c1.x += radix3_a10_x * b0.x - radix3_a10_y * b0.y; c1.y = radix3_a10_y * b0.x + radix3_a10_x * b0.y;\    
// c1.x += radix3_a11_x * b1.x - radix3_a11_y * b1.y; c1.y = radix3_a11_y * b1.x + radix3_a11_x * b1.y;\    
// c1.x += radix3_a12_x * b2.x - radix3_a12_y * b2.y; c1.y = radix3_a12_y * b2.x + radix3_a12_x * b2.y;\    
// c2.x += radix3_a20_x * b0.x - radix3_a20_y * b0.y; c2.y = radix3_a20_y * b0.x + radix3_a20_x * b0.y;\    
// c2.x += radix3_a21_x * b1.x - radix3_a21_y * b1.y; c2.y = radix3_a21_y * b1.x + radix3_a21_x * b1.y;\    
// c2.x += radix3_a22_x * b2.x - radix3_a22_y * b2.y; c2.y = radix3_a22_y * b2.x + radix3_a22_x * b2.y;\





// __global__ void ft_fft(int N, float2 * data, int ns, int k ){
//     int tx = threadIdx.x;
//     int bx = blockIdx.x;
//     int block_dim = blockDim.x;
//     int R = 2;
//     int j = tx + bx * block_dim; 
//     __shared__ float sa[256 * 2 * 2];
//     cufftComplex * data0;
//     cufftComplex * data1;
//     if(j >= N / R) return;
//     data0 = data + N * (k % 2);
//     data1 = data + N * ((k + 1) % 2);
//     cufftComplex v[2];
//     float angle = -2 * CUDART_PI_F * (j % ns) / (ns * R);
//     for(int r = 0; r < R; ++r){
//         v[r] =  data0[j+r*N/R];
//         v[r] = cuCmulf(v[r], make_cuComplex(cosf(r*angle), sinf(r*angle)));
//     }
//     cufftComplex tmp = v[0];
//     v[0] = cuCaddf(tmp, v[1]);
//     v[1] = cuCsubf(tmp, v[1]);
//     if (false){
//         int idxD = (tx / ns)*R + (tx % ns), stride = 1;
//         float* sr = sa, *si = sa + blockDim.x * R;
//         for(int r = 0; r < R; r++) {
//             int i = (idxD + r * ns) * stride;
//             sr[i] = v[r].x;
//             si[i] = v[r].y; 
//         }
//         __syncthreads();
//         for(int r = 0; r < R; r++) {
//             int i = (tx + r * blockDim.x) * stride;
//             v[r].x = sr[i];
//             v[r].y = si[i];
//         }
//         idxD = bx * R * blockDim.x + tx;
//         for(int r = 0; r < R; r++) 
//             data1[idxD + r * blockDim.x] = v[r];
//     }
//     else{
//         int idxD = (j / ns) * ns * R + (j % ns);
//         for(int r = 0; r < R; ++r){
//             data1[idxD + r * ns] = v[r];
//         }
//     }
// }

// __global__ void fft_small(int N, float2* input, int ns, int k){




// }

// __global__ void __launch_bounds__(1) radix2_exp2 (int N, float2* input, int ns){
//     float2 x[4], tmp[4], tmp1, tmp2;
//     *(float4*)x = *(float4*)input;
//     *(float4*)(x + 2) = *(float4*)(input + 2);
//     MY_ADD(x[0], x[2], tmp[0]);
//     MY_SUB(x[0], x[2], tmp[1]);

//     MY_ADD(x[1], x[3], tmp[2]);
//     MY_SUB(x[1], x[3], tmp[3]);
    
//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[2], tmp2, tmp[2], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[3], tmp2, tmp[3], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];

//     MY_ADD(x[0], x[2], tmp[0]);
//     MY_SUB(x[0], x[2], tmp[2]);

//     MY_ADD(x[1], x[3], tmp[1]);
//     MY_SUB(x[1], x[3], tmp[3]);

//     *(float4*)input = *(float4*)tmp;
//     *(float4*)(input + 2) = *(float4*)(tmp + 2);
        
// }

// __global__ void __launch_bounds__(1) radix2_exp3 (int N, float2* input, int ns){
//     float2 x[8], tmp[8], tmp1, tmp2;
//     *(float4*)x = *(float4*)input;
//     *(float4*)(x + 2) = *(float4*)(input + 2);
//     *(float4*)(x + 4) = *(float4*)(input + 4);
//     *(float4*)(x + 6) = *(float4*)(input + 6);
    
    
//     MY_ADD(x[0], x[4], tmp[0]);
//     MY_SUB(x[0], x[4], tmp[1]);

//     MY_ADD(x[1], x[5], tmp[2]);
//     MY_SUB(x[1], x[5], tmp[3]);

//     MY_ADD(x[2], x[6], tmp[4]);
//     MY_SUB(x[2], x[6], tmp[5]);

//     MY_ADD(x[3], x[7], tmp[6]);
//     MY_SUB(x[3], x[7], tmp[7]);
    
//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[4], tmp2, tmp[4], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[5], tmp2, tmp[5], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[6], tmp2, tmp[6], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[7], tmp2, tmp[7], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];

//     MY_ADD(x[0], x[4], tmp[0]);
//     MY_SUB(x[0], x[4], tmp[2]);

//     MY_ADD(x[1], x[5], tmp[1]);
//     MY_SUB(x[1], x[5], tmp[3]);

//     MY_ADD(x[2], x[6], tmp[4]);
//     MY_SUB(x[2], x[6], tmp[6]);

//     MY_ADD(x[3], x[7], tmp[5]);
//     MY_SUB(x[3], x[7], tmp[7]);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[4], tmp2, tmp[4], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[5], tmp2, tmp[5], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[6], tmp2, tmp[6], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[7], tmp2, tmp[7], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];

//     MY_ADD(x[0], x[4], tmp[0]);
//     MY_SUB(x[0], x[4], tmp[4]);

//     MY_ADD(x[1], x[5], tmp[1]);
//     MY_SUB(x[1], x[5], tmp[5]);

//     MY_ADD(x[2], x[6], tmp[2]);
//     MY_SUB(x[2], x[6], tmp[6]);

//     MY_ADD(x[3], x[7], tmp[3]);
//     MY_SUB(x[3], x[7], tmp[7]);

//     *(float4*)input = *(float4*)tmp;
//     *(float4*)(input + 2) = *(float4*)(tmp + 2);
//     *(float4*)(input + 4) = *(float4*)(tmp + 4);
//     *(float4*)(input + 6) = *(float4*)(tmp + 6);
        
// }

// __global__ void __launch_bounds__(1) radix2_exp4 (int N, float2* input, int ns){
//     float2 x[16], tmp[16], tmp1, tmp2;
//     *(float4*)x = *(float4*)input;
//     *(float4*)(x + 2) = *(float4*)(input + 2);
//     *(float4*)(x + 4) = *(float4*)(input + 4);
//     *(float4*)(x + 6) = *(float4*)(input + 6);
//     *(float4*)(x + 8) = *(float4*)(input + 8);
//     *(float4*)(x + 10) = *(float4*)(input + 10);
//     *(float4*)(x + 12) = *(float4*)(input + 12);
//     *(float4*)(x + 14) = *(float4*)(input + 14);
    
    
//     MY_ADD(x[0], x[8], tmp[0]);
//     MY_SUB(x[0], x[8], tmp[1]);

//     MY_ADD(x[1], x[9], tmp[2]);
//     MY_SUB(x[1], x[9], tmp[3]);

//     MY_ADD(x[2], x[10], tmp[4]);
//     MY_SUB(x[2], x[10], tmp[5]);

//     MY_ADD(x[3], x[11], tmp[6]);
//     MY_SUB(x[3], x[11], tmp[7]);

//     MY_ADD(x[4], x[12], tmp[8]);
//     MY_SUB(x[4], x[12], tmp[9]);

//     MY_ADD(x[5], x[13], tmp[10]);
//     MY_SUB(x[5], x[13], tmp[11]);

//     MY_ADD(x[6], x[14], tmp[12]);
//     MY_SUB(x[6], x[14], tmp[13]);

//     MY_ADD(x[7], x[15], tmp[14]);
//     MY_SUB(x[7], x[15], tmp[15]);
    
//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[8], tmp2, tmp[8], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[9], tmp2, tmp[9], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[10], tmp2, tmp[10], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[11], tmp2, tmp[11], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[12], tmp2, tmp[12], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[13], tmp2, tmp[13], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[14], tmp2, tmp[14], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[15], tmp2, tmp[15], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];
//     x[8] = tmp[8];
//     x[9] = tmp[9];
//     x[10] = tmp[10];
//     x[11] = tmp[11];
//     x[12] = tmp[12];
//     x[13] = tmp[13];
//     x[14] = tmp[14];
//     x[15] = tmp[15];

//     MY_ADD(x[0], x[8], tmp[0]);
//     MY_SUB(x[0], x[8], tmp[2]);

//     MY_ADD(x[1], x[9], tmp[1]);
//     MY_SUB(x[1], x[9], tmp[3]);

//     MY_ADD(x[2], x[10], tmp[4]);
//     MY_SUB(x[2], x[10], tmp[6]);

//     MY_ADD(x[3], x[11], tmp[5]);
//     MY_SUB(x[3], x[11], tmp[7]);

//     MY_ADD(x[4], x[12], tmp[8]);
//     MY_SUB(x[4], x[12], tmp[10]);

//     MY_ADD(x[5], x[13], tmp[9]);
//     MY_SUB(x[5], x[13], tmp[11]);

//     MY_ADD(x[6], x[14], tmp[12]);
//     MY_SUB(x[6], x[14], tmp[14]);

//     MY_ADD(x[7], x[15], tmp[13]);
//     MY_SUB(x[7], x[15], tmp[15]);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[8], tmp2, tmp[8], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[9], tmp2, tmp[9], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[10], tmp2, tmp[10], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[11], tmp2, tmp[11], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[12], tmp2, tmp[12], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[13], tmp2, tmp[13], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[14], tmp2, tmp[14], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[15], tmp2, tmp[15], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];
//     x[8] = tmp[8];
//     x[9] = tmp[9];
//     x[10] = tmp[10];
//     x[11] = tmp[11];
//     x[12] = tmp[12];
//     x[13] = tmp[13];
//     x[14] = tmp[14];
//     x[15] = tmp[15];

//     MY_ADD(x[0], x[8], tmp[0]);
//     MY_SUB(x[0], x[8], tmp[4]);

//     MY_ADD(x[1], x[9], tmp[1]);
//     MY_SUB(x[1], x[9], tmp[5]);

//     MY_ADD(x[2], x[10], tmp[2]);
//     MY_SUB(x[2], x[10], tmp[6]);

//     MY_ADD(x[3], x[11], tmp[3]);
//     MY_SUB(x[3], x[11], tmp[7]);

//     MY_ADD(x[4], x[12], tmp[8]);
//     MY_SUB(x[4], x[12], tmp[12]);

//     MY_ADD(x[5], x[13], tmp[9]);
//     MY_SUB(x[5], x[13], tmp[13]);

//     MY_ADD(x[6], x[14], tmp[10]);
//     MY_SUB(x[6], x[14], tmp[14]);

//     MY_ADD(x[7], x[15], tmp[11]);
//     MY_SUB(x[7], x[15], tmp[15]);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[8], tmp2, tmp[8], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[9], tmp2, tmp[9], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[10], tmp2, tmp[10], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[11], tmp2, tmp[11], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 4.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[12], tmp2, tmp[12], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 5.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[13], tmp2, tmp[13], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 6.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[14], tmp2, tmp[14], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 7.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[15], tmp2, tmp[15], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];
//     x[8] = tmp[8];
//     x[9] = tmp[9];
//     x[10] = tmp[10];
//     x[11] = tmp[11];
//     x[12] = tmp[12];
//     x[13] = tmp[13];
//     x[14] = tmp[14];
//     x[15] = tmp[15];

//     MY_ADD(x[0], x[8], tmp[0]);
//     MY_SUB(x[0], x[8], tmp[8]);

//     MY_ADD(x[1], x[9], tmp[1]);
//     MY_SUB(x[1], x[9], tmp[9]);

//     MY_ADD(x[2], x[10], tmp[2]);
//     MY_SUB(x[2], x[10], tmp[10]);

//     MY_ADD(x[3], x[11], tmp[3]);
//     MY_SUB(x[3], x[11], tmp[11]);

//     MY_ADD(x[4], x[12], tmp[4]);
//     MY_SUB(x[4], x[12], tmp[12]);

//     MY_ADD(x[5], x[13], tmp[5]);
//     MY_SUB(x[5], x[13], tmp[13]);

//     MY_ADD(x[6], x[14], tmp[6]);
//     MY_SUB(x[6], x[14], tmp[14]);

//     MY_ADD(x[7], x[15], tmp[7]);
//     MY_SUB(x[7], x[15], tmp[15]);

//     *(float4*)input = *(float4*)tmp;
//     *(float4*)(input + 2) = *(float4*)(tmp + 2);
//     *(float4*)(input + 4) = *(float4*)(tmp + 4);
//     *(float4*)(input + 6) = *(float4*)(tmp + 6);
//     *(float4*)(input + 8) = *(float4*)(tmp + 8);
//     *(float4*)(input + 10) = *(float4*)(tmp + 10);
//     *(float4*)(input + 12) = *(float4*)(tmp + 12);
//     *(float4*)(input + 14) = *(float4*)(tmp + 14);
        
// }
// // __global__ void __launch_bounds__(1) radix2_exp5_for (int N, float2* input, int ns){
// //     float2 x[32], tmp[32], tmp1, tmp2;
    
// //     #pragma unroll
// //     for(int i = 0; i < 32; i += 2){
// //         *(float4*)(x + i) = *(float4*)(input + i);    
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 16; i+=1){
// //         MY_ADD(x[i], x[i + 16], tmp[i * 2]);
// //         MY_SUB(x[i], x[i + 16], tmp[i * 2 + 1]);
// //     }

// //     #pragma unroll
// //     for(int i = 16; i < 32; i+=1){
// //         MY_ANGLE2COMPLEX(-M_PI * (float)(i % 2) / 2.f, tmp2);
// //         MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 32; i+=1){
// //         x[i] = tmp[i];
// //     }
    
// //     #pragma unroll
// //     for(int i = 0; i < 16; i+=1){
// //         MY_ADD(x[i], x[i + 16], tmp[(i % 2) + (i / 2) * 4]);
// //         MY_SUB(x[i], x[i + 16], tmp[(i % 2) + (i / 2) * 4 + 2]);
// //     }

// //     #pragma unroll
// //     for(int i = 16; i < 32; i+=1){
// //         MY_ANGLE2COMPLEX(-M_PI * (float)(i % 4) / 4.f, tmp2);
// //         MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 32; i+=1){
// //         x[i] = tmp[i];
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 16; i+=1){
// //         MY_ADD(x[i], x[i + 16], tmp[(i % 4) + (i / 4) * 8]);
// //         MY_SUB(x[i], x[i + 16], tmp[(i % 4) + (i / 4) * 8 + 4]);
// //     }

// //     #pragma unroll
// //     for(int i = 16; i < 32; i+=1){
// //         MY_ANGLE2COMPLEX(-M_PI * (float)(i % 8) / 8.f, tmp2);
// //         MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 32; i+=1){
// //         x[i] = tmp[i];
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 16; i+=1){
// //         MY_ADD(x[i], x[i + 16], tmp[(i % 8) + (i / 8) * 16]);
// //         MY_SUB(x[i], x[i + 16], tmp[(i % 8) + (i / 8) * 16 + 8]);
// //     }

// //     #pragma unroll
// //     for(int i = 16; i < 32; i+=1){
// //         MY_ANGLE2COMPLEX(-M_PI * (float)(i % 16) / 16.f, tmp2);
// //         MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 32; i+=1){
// //         x[i] = tmp[i];
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 16; i+=1){
// //         MY_ADD(x[i], x[i + 16], tmp[(i % 16) + (i / 16) * 32]);
// //         MY_SUB(x[i], x[i + 16], tmp[(i % 16) + (i / 16) * 32 + 16]);
// //     }

// //     #pragma unroll
// //     for(int i = 0; i < 32; i += 2){
// //         *(float4*)(input + i) = *(float4*)(tmp + i);    
// //     }


// // }

// __global__ void __launch_bounds__(1) radix2_exp5_for_ (int N, float2* input, int ns){
//     float2 x[32], tmp[32], tmp1, tmp2;
    
//     #pragma unroll
//     for(int i = 0; i < 32; i += 2){
//         *(float4*)(x + i) = *(float4*)(input + i);    
//     }

//     #pragma unroll
//     for(int j = 1; j < 16; j *= 2){
//         #pragma unroll
//         for(int i = 0; i < 16; i+=1){
//             MY_ADD(x[i], x[i + 16], tmp[(i % j) + (i / j) * j * 2]);
//             MY_SUB(x[i], x[i + 16], tmp[(i % j) + (i / j) * j * 2 + j]);
//         }

//         #pragma unroll
//         for(int i = 16; i < 32; i+=1){
//             MY_ANGLE2COMPLEX(-M_PI * (float)(i % (j * 2)) / (float)(j * 2), tmp2);
//             MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
//         }

//         #pragma unroll
//         for(int i = 0; i < 32; i+=1){
//             x[i] = tmp[i];
//         }
//     }

//     #pragma unroll
//     for(int i = 0; i < 16; i+=1){
//         MY_ADD(x[i], x[i + 16], tmp[(i % 16) + (i / 16) * 32]);
//         MY_SUB(x[i], x[i + 16], tmp[(i % 16) + (i / 16) * 32 + 16]);
//     }

//     #pragma unroll
//     for(int i = 0; i < 32; i += 2){
//         *(float4*)(input + i) = *(float4*)(tmp + i);    
//     }
// }


// __global__ void __launch_bounds__(1) radix2_exp6 (int N, float2* input, int ns){
//     float2 x[64], tmp[64], tmp1, tmp2;
    
//     #pragma unroll
//     for(int i = 0; i < N; i += 2){
//         *(float4*)(x + i) = *(float4*)(input + i);    
//     }

//     #pragma unroll
//     for(int j = 1; j < N / 2; j *= 2){
//         #pragma unroll
//         for(int i = 0; i < N / 2; i+=1){
//             MY_ADD(x[i], x[i + (N / 2)], tmp[(i % j) + (i / j) * j * 2]);
//             MY_SUB(x[i], x[i + (N / 2)], tmp[(i % j) + (i / j) * j * 2 + j]);
//         }

//         #pragma unroll
//         for(int i = (N / 2); i < N; i+=1){
//             MY_ANGLE2COMPLEX(-M_PI * (float)(i % (j * 2)) / (float)(j * 2), tmp2);
//             MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
//         }

//         #pragma unroll
//         for(int i = 0; i < N; i+=1){
//             x[i] = tmp[i];
//         }
//     }

//     #pragma unroll
//     for(int i = 0; i < (N / 2); i+=1){
//         MY_ADD(x[i], x[i + (N / 2)], tmp[(i % (N / 2)) + (i / (N / 2)) * N]);
//         MY_SUB(x[i], x[i + (N / 2)], tmp[(i % (N / 2)) + (i / (N / 2)) * N + (N / 2)]);
//     }

//     #pragma unroll
//     for(int i = 0; i < N; i += 2){
//         *(float4*)(input + i) = *(float4*)(tmp + i);    
//     }
// }

// __global__ void __launch_bounds__(1) radix2_exp5_for (int N, float2* input, int ns){
//     float2 x[32], tmp[32], tmp1, tmp2;
    
//     #pragma unroll
//     for(int i = 0; i < 32; i += 2){
//         *(float4*)(x + i) = *(float4*)(input + i);    
//     }

//     #pragma unroll
//     for(int i = 0; i < 16; i+=1){
//         MY_ADD(x[i], x[i + 16], tmp[i * 2]);
//         MY_SUB(x[i], x[i + 16], tmp[i * 2 + 1]);
//     }

//     #pragma unroll
//     for(int i = 16; i < 32; i+=1){
//         MY_ANGLE2COMPLEX(-M_PI * (float)(i % 2) / 2.f, tmp2);
//         MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
//     }

//     #pragma unroll
//     for(int i = 0; i < 32; i+=1){
//         x[i] = tmp[i];
//     }
    
//     #pragma unroll
//     for(int i = 0; i < 16; i+=1){
//         MY_ADD(x[i], x[i + 16], tmp[(i % 2) + (i / 2) * 4]);
//         MY_SUB(x[i], x[i + 16], tmp[(i % 2) + (i / 2) * 4 + 2]);
//     }

//     #pragma unroll
//     for(int i = 16; i < 32; i+=1){
//         MY_ANGLE2COMPLEX(-M_PI * (float)(i % 4) / 4.f, tmp2);
//         MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
//     }

//     #pragma unroll
//     for(int i = 0; i < 32; i+=1){
//         x[i] = tmp[i];
//     }

//     #pragma unroll
//     for(int i = 0; i < 16; i+=1){
//         MY_ADD(x[i], x[i + 16], tmp[(i % 4) + (i / 4) * 8]);
//         MY_SUB(x[i], x[i + 16], tmp[(i % 4) + (i / 4) * 8 + 4]);
//     }

//     #pragma unroll
//     for(int i = 16; i < 32; i+=1){
//         MY_ANGLE2COMPLEX(-M_PI * (float)(i % 8) / 8.f, tmp2);
//         MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
//     }

//     #pragma unroll
//     for(int i = 0; i < 32; i+=1){
//         x[i] = tmp[i];
//     }

//     #pragma unroll
//     for(int i = 0; i < 16; i+=1){
//         MY_ADD(x[i], x[i + 16], tmp[(i % 8) + (i / 8) * 16]);
//         MY_SUB(x[i], x[i + 16], tmp[(i % 8) + (i / 8) * 16 + 8]);
//     }

//     #pragma unroll
//     for(int i = 16; i < 32; i+=1){
//         MY_ANGLE2COMPLEX(-M_PI * (float)(i % 16) / 16.f, tmp2);
//         MY_MUL_REPLACE(tmp[i], tmp2, tmp[i], tmp1);
//     }

//     #pragma unroll
//     for(int i = 0; i < 32; i+=1){
//         x[i] = tmp[i];
//     }

//     #pragma unroll
//     for(int i = 0; i < 16; i+=1){
//         MY_ADD(x[i], x[i + 16], tmp[(i % 16) + (i / 16) * 32]);
//         MY_SUB(x[i], x[i + 16], tmp[(i % 16) + (i / 16) * 32 + 16]);
//     }

//     #pragma unroll
//     for(int i = 0; i < 32; i += 2){
//         *(float4*)(input + i) = *(float4*)(tmp + i);    
//     }


// }

// __global__ void __launch_bounds__(1) radix2_exp5 (int N, float2* input, int ns){
//     float2 x[32], tmp[32], tmp1, tmp2;
//     *(float4*)x = *(float4*)input;
//     *(float4*)(x + 2) = *(float4*)(input + 2);
//     *(float4*)(x + 4) = *(float4*)(input + 4);
//     *(float4*)(x + 6) = *(float4*)(input + 6);
//     *(float4*)(x + 8) = *(float4*)(input + 8);
//     *(float4*)(x + 10) = *(float4*)(input + 10);
//     *(float4*)(x + 12) = *(float4*)(input + 12);
//     *(float4*)(x + 14) = *(float4*)(input + 14);
//     *(float4*)(x + 16) = *(float4*)(input + 16);
//     *(float4*)(x + 18) = *(float4*)(input + 18);
//     *(float4*)(x + 20) = *(float4*)(input + 20);
//     *(float4*)(x + 22) = *(float4*)(input + 22);
//     *(float4*)(x + 24) = *(float4*)(input + 24);
//     *(float4*)(x + 26) = *(float4*)(input + 26);
//     *(float4*)(x + 28) = *(float4*)(input + 28);
//     *(float4*)(x + 30) = *(float4*)(input + 30);
    
    
//     MY_ADD(x[0], x[16], tmp[0]);
//     MY_SUB(x[0], x[16], tmp[1]);

//     MY_ADD(x[1], x[17], tmp[2]);
//     MY_SUB(x[1], x[17], tmp[3]);

//     MY_ADD(x[2], x[18], tmp[4]);
//     MY_SUB(x[2], x[18], tmp[5]);

//     MY_ADD(x[3], x[19], tmp[6]);
//     MY_SUB(x[3], x[19], tmp[7]);

//     MY_ADD(x[4], x[20], tmp[8]);
//     MY_SUB(x[4], x[20], tmp[9]);

//     MY_ADD(x[5], x[21], tmp[10]);
//     MY_SUB(x[5], x[21], tmp[11]);

//     MY_ADD(x[6], x[22], tmp[12]);
//     MY_SUB(x[6], x[22], tmp[13]);

//     MY_ADD(x[7], x[23], tmp[14]);
//     MY_SUB(x[7], x[23], tmp[15]);

//     MY_ADD(x[8], x[24], tmp[16]);
//     MY_SUB(x[8], x[24], tmp[17]);

//     MY_ADD(x[9], x[25], tmp[18]);
//     MY_SUB(x[9], x[25], tmp[19]);

//     MY_ADD(x[10], x[26], tmp[20]);
//     MY_SUB(x[10], x[26], tmp[21]);

//     MY_ADD(x[11], x[27], tmp[22]);
//     MY_SUB(x[11], x[27], tmp[23]);

//     MY_ADD(x[12], x[28], tmp[24]);
//     MY_SUB(x[12], x[28], tmp[25]);

//     MY_ADD(x[13], x[29], tmp[26]);
//     MY_SUB(x[13], x[29], tmp[27]);

//     MY_ADD(x[14], x[30], tmp[28]);
//     MY_SUB(x[14], x[30], tmp[29]);

//     MY_ADD(x[15], x[31], tmp[30]);
//     MY_SUB(x[15], x[31], tmp[31]);
    
//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[16], tmp2, tmp[16], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[17], tmp2, tmp[17], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[18], tmp2, tmp[18], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[19], tmp2, tmp[19], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[20], tmp2, tmp[20], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[21], tmp2, tmp[21], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[22], tmp2, tmp[22], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[23], tmp2, tmp[23], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[24], tmp2, tmp[24], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[25], tmp2, tmp[25], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[26], tmp2, tmp[26], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[27], tmp2, tmp[27], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[28], tmp2, tmp[28], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[29], tmp2, tmp[29], tmp1);

//     MY_ANGLE2COMPLEX(0, tmp2);
//     MY_MUL_REPLACE(tmp[30], tmp2, tmp[30], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI/2.f, tmp2);
//     MY_MUL_REPLACE(tmp[31], tmp2, tmp[31], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];
//     x[8] = tmp[8];
//     x[9] = tmp[9];
//     x[10] = tmp[10];
//     x[11] = tmp[11];
//     x[12] = tmp[12];
//     x[13] = tmp[13];
//     x[14] = tmp[14];
//     x[15] = tmp[15];
//     x[16] = tmp[16];
//     x[17] = tmp[17];
//     x[18] = tmp[18];
//     x[19] = tmp[19];
//     x[20] = tmp[20];
//     x[21] = tmp[21];
//     x[22] = tmp[22];
//     x[23] = tmp[23];
//     x[24] = tmp[24];
//     x[25] = tmp[25];
//     x[26] = tmp[26];
//     x[27] = tmp[27];
//     x[28] = tmp[28];
//     x[29] = tmp[29];
//     x[30] = tmp[30];
//     x[31] = tmp[31];

//     MY_ADD(x[0], x[16], tmp[0]);
//     MY_SUB(x[0], x[16], tmp[2]);

//     MY_ADD(x[1], x[17], tmp[1]);
//     MY_SUB(x[1], x[17], tmp[3]);

//     MY_ADD(x[2], x[18], tmp[4]);
//     MY_SUB(x[2], x[18], tmp[6]);

//     MY_ADD(x[3], x[19], tmp[5]);
//     MY_SUB(x[3], x[19], tmp[7]);

//     MY_ADD(x[4], x[20], tmp[8]);
//     MY_SUB(x[4], x[20], tmp[10]);

//     MY_ADD(x[5], x[21], tmp[9]);
//     MY_SUB(x[5], x[21], tmp[11]);

//     MY_ADD(x[6], x[22], tmp[12]);
//     MY_SUB(x[6], x[22], tmp[14]);

//     MY_ADD(x[7], x[23], tmp[13]);
//     MY_SUB(x[7], x[23], tmp[15]);

//     MY_ADD(x[8], x[24], tmp[16]);
//     MY_SUB(x[8], x[24], tmp[18]);

//     MY_ADD(x[9], x[25], tmp[17]);
//     MY_SUB(x[9], x[25], tmp[19]);

//     MY_ADD(x[10], x[26], tmp[20]);
//     MY_SUB(x[10], x[26], tmp[22]);

//     MY_ADD(x[11], x[27], tmp[21]);
//     MY_SUB(x[11], x[27], tmp[23]);

//     MY_ADD(x[12], x[28], tmp[24]);
//     MY_SUB(x[12], x[28], tmp[26]);

//     MY_ADD(x[13], x[29], tmp[25]);
//     MY_SUB(x[13], x[29], tmp[27]);

//     MY_ADD(x[14], x[30], tmp[28]);
//     MY_SUB(x[14], x[30], tmp[30]);

//     MY_ADD(x[15], x[31], tmp[29]);
//     MY_SUB(x[15], x[31], tmp[31]);

//     MY_ANGLE2COMPLEX(-M_PI * 0.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[16], tmp2, tmp[16], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 1.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[17], tmp2, tmp[17], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[18], tmp2, tmp[18], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[19], tmp2, tmp[19], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 0.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[20], tmp2, tmp[20], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 1.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[21], tmp2, tmp[21], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[22], tmp2, tmp[22], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[23], tmp2, tmp[23], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 0.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[24], tmp2, tmp[24], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 1.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[25], tmp2, tmp[25], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[26], tmp2, tmp[26], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[27], tmp2, tmp[27], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 0.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[28], tmp2, tmp[28], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 1.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[29], tmp2, tmp[29], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[30], tmp2, tmp[30], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 4.f, tmp2);
//     MY_MUL_REPLACE(tmp[31], tmp2, tmp[31], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];
//     x[8] = tmp[8];
//     x[9] = tmp[9];
//     x[10] = tmp[10];
//     x[11] = tmp[11];
//     x[12] = tmp[12];
//     x[13] = tmp[13];
//     x[14] = tmp[14];
//     x[15] = tmp[15];
//     x[16] = tmp[16];
//     x[17] = tmp[17];
//     x[18] = tmp[18];
//     x[19] = tmp[19];
//     x[20] = tmp[20];
//     x[21] = tmp[21];
//     x[22] = tmp[22];
//     x[23] = tmp[23];
//     x[24] = tmp[24];
//     x[25] = tmp[25];
//     x[26] = tmp[26];
//     x[27] = tmp[27];
//     x[28] = tmp[28];
//     x[29] = tmp[29];
//     x[30] = tmp[30];
//     x[31] = tmp[31];

//     MY_ADD(x[0], x[16], tmp[0]);
//     MY_SUB(x[0], x[16], tmp[4]);

//     MY_ADD(x[1], x[17], tmp[1]);
//     MY_SUB(x[1], x[17], tmp[5]);

//     MY_ADD(x[2], x[18], tmp[2]);
//     MY_SUB(x[2], x[18], tmp[6]);

//     MY_ADD(x[3], x[19], tmp[3]);
//     MY_SUB(x[3], x[19], tmp[7]);

//     MY_ADD(x[4], x[20], tmp[8]);
//     MY_SUB(x[4], x[20], tmp[12]);

//     MY_ADD(x[5], x[21], tmp[9]);
//     MY_SUB(x[5], x[21], tmp[13]);

//     MY_ADD(x[6], x[22], tmp[10]);
//     MY_SUB(x[6], x[22], tmp[14]);

//     MY_ADD(x[7], x[23], tmp[11]);
//     MY_SUB(x[7], x[23], tmp[15]);

//     MY_ADD(x[8], x[24], tmp[16]);
//     MY_SUB(x[8], x[24], tmp[20]);

//     MY_ADD(x[9], x[25], tmp[17]);
//     MY_SUB(x[9], x[25], tmp[21]);

//     MY_ADD(x[10], x[26], tmp[18]);
//     MY_SUB(x[10], x[26], tmp[22]);

//     MY_ADD(x[11], x[27], tmp[19]);
//     MY_SUB(x[11], x[27], tmp[23]);

//     MY_ADD(x[12], x[28], tmp[24]);
//     MY_SUB(x[12], x[28], tmp[28]);

//     MY_ADD(x[13], x[29], tmp[25]);
//     MY_SUB(x[13], x[29], tmp[29]);

//     MY_ADD(x[14], x[30], tmp[26]);
//     MY_SUB(x[14], x[30], tmp[30]);

//     MY_ADD(x[15], x[31], tmp[27]);
//     MY_SUB(x[15], x[31], tmp[31]);

//     MY_ANGLE2COMPLEX(-M_PI * 0.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[16], tmp2, tmp[16], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 1.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[17], tmp2, tmp[17], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[18], tmp2, tmp[18], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[19], tmp2, tmp[19], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 4.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[20], tmp2, tmp[20], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 5.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[21], tmp2, tmp[21], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 6.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[22], tmp2, tmp[22], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 7.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[23], tmp2, tmp[23], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 0.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[24], tmp2, tmp[24], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 1.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[25], tmp2, tmp[25], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[26], tmp2, tmp[26], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[27], tmp2, tmp[27], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 4.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[28], tmp2, tmp[28], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 5.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[29], tmp2, tmp[29], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 6.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[30], tmp2, tmp[30], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 7.f / 8.f, tmp2);
//     MY_MUL_REPLACE(tmp[31], tmp2, tmp[31], tmp1);

//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];
//     x[8] = tmp[8];
//     x[9] = tmp[9];
//     x[10] = tmp[10];
//     x[11] = tmp[11];
//     x[12] = tmp[12];
//     x[13] = tmp[13];
//     x[14] = tmp[14];
//     x[15] = tmp[15];
//     x[16] = tmp[16];
//     x[17] = tmp[17];
//     x[18] = tmp[18];
//     x[19] = tmp[19];
//     x[20] = tmp[20];
//     x[21] = tmp[21];
//     x[22] = tmp[22];
//     x[23] = tmp[23];
//     x[24] = tmp[24];
//     x[25] = tmp[25];
//     x[26] = tmp[26];
//     x[27] = tmp[27];
//     x[28] = tmp[28];
//     x[29] = tmp[29];
//     x[30] = tmp[30];
//     x[31] = tmp[31];

//     MY_ADD(x[0], x[16], tmp[0]);
//     MY_SUB(x[0], x[16], tmp[8]);

//     MY_ADD(x[1], x[17], tmp[1]);
//     MY_SUB(x[1], x[17], tmp[9]);

//     MY_ADD(x[2], x[18], tmp[2]);
//     MY_SUB(x[2], x[18], tmp[10]);

//     MY_ADD(x[3], x[19], tmp[3]);
//     MY_SUB(x[3], x[19], tmp[11]);

//     MY_ADD(x[4], x[20], tmp[4]);
//     MY_SUB(x[4], x[20], tmp[12]);

//     MY_ADD(x[5], x[21], tmp[5]);
//     MY_SUB(x[5], x[21], tmp[13]);

//     MY_ADD(x[6], x[22], tmp[6]);
//     MY_SUB(x[6], x[22], tmp[14]);

//     MY_ADD(x[7], x[23], tmp[7]);
//     MY_SUB(x[7], x[23], tmp[15]);

//     MY_ADD(x[8], x[24], tmp[16]);
//     MY_SUB(x[8], x[24], tmp[24]);

//     MY_ADD(x[9], x[25], tmp[17]);
//     MY_SUB(x[9], x[25], tmp[25]);

//     MY_ADD(x[10], x[26], tmp[18]);
//     MY_SUB(x[10], x[26], tmp[26]);

//     MY_ADD(x[11], x[27], tmp[19]);
//     MY_SUB(x[11], x[27], tmp[27]);

//     MY_ADD(x[12], x[28], tmp[20]);
//     MY_SUB(x[12], x[28], tmp[28]);

//     MY_ADD(x[13], x[29], tmp[21]);
//     MY_SUB(x[13], x[29], tmp[29]);

//     MY_ADD(x[14], x[30], tmp[22]);
//     MY_SUB(x[14], x[30], tmp[30]);

//     MY_ADD(x[15], x[31], tmp[23]);
//     MY_SUB(x[15], x[31], tmp[31]);

//     MY_ANGLE2COMPLEX(-M_PI * 0.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[16], tmp2, tmp[16], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 1.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[17], tmp2, tmp[17], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 2.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[18], tmp2, tmp[18], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 3.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[19], tmp2, tmp[19], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 4.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[20], tmp2, tmp[20], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 5.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[21], tmp2, tmp[21], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 6.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[22], tmp2, tmp[22], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 7.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[23], tmp2, tmp[23], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 8.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[24], tmp2, tmp[24], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 9.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[25], tmp2, tmp[25], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 10.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[26], tmp2, tmp[26], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 11.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[27], tmp2, tmp[27], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 12.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[28], tmp2, tmp[28], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 13.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[29], tmp2, tmp[29], tmp1);

//     MY_ANGLE2COMPLEX(-M_PI * 14.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[30], tmp2, tmp[30], tmp1);
//     MY_ANGLE2COMPLEX(-M_PI * 15.f / 16.f, tmp2);
//     MY_MUL_REPLACE(tmp[31], tmp2, tmp[31], tmp1);


//     x[0] = tmp[0];
//     x[1] = tmp[1];
//     x[2] = tmp[2];
//     x[3] = tmp[3];
//     x[4] = tmp[4];
//     x[5] = tmp[5];
//     x[6] = tmp[6];
//     x[7] = tmp[7];
//     x[8] = tmp[8];
//     x[9] = tmp[9];
//     x[10] = tmp[10];
//     x[11] = tmp[11];
//     x[12] = tmp[12];
//     x[13] = tmp[13];
//     x[14] = tmp[14];
//     x[15] = tmp[15];
//     x[16] = tmp[16];
//     x[17] = tmp[17];
//     x[18] = tmp[18];
//     x[19] = tmp[19];
//     x[20] = tmp[20];
//     x[21] = tmp[21];
//     x[22] = tmp[22];
//     x[23] = tmp[23];
//     x[24] = tmp[24];
//     x[25] = tmp[25];
//     x[26] = tmp[26];
//     x[27] = tmp[27];
//     x[28] = tmp[28];
//     x[29] = tmp[29];
//     x[30] = tmp[30];
//     x[31] = tmp[31];

//     MY_ADD(x[0], x[16], tmp[0]);
//     MY_SUB(x[0], x[16], tmp[16]);

//     MY_ADD(x[1], x[17], tmp[1]);
//     MY_SUB(x[1], x[17], tmp[17]);

//     MY_ADD(x[2], x[18], tmp[2]);
//     MY_SUB(x[2], x[18], tmp[18]);

//     MY_ADD(x[3], x[19], tmp[3]);
//     MY_SUB(x[3], x[19], tmp[19]);

//     MY_ADD(x[4], x[20], tmp[4]);
//     MY_SUB(x[4], x[20], tmp[20]);

//     MY_ADD(x[5], x[21], tmp[5]);
//     MY_SUB(x[5], x[21], tmp[21]);

//     MY_ADD(x[6], x[22], tmp[6]);
//     MY_SUB(x[6], x[22], tmp[22]);

//     MY_ADD(x[7], x[23], tmp[7]);
//     MY_SUB(x[7], x[23], tmp[23]);

//     MY_ADD(x[8], x[24], tmp[8]);
//     MY_SUB(x[8], x[24], tmp[24]);

//     MY_ADD(x[9], x[25], tmp[9]);
//     MY_SUB(x[9], x[25], tmp[25]);

//     MY_ADD(x[10], x[26], tmp[10]);
//     MY_SUB(x[10], x[26], tmp[26]);

//     MY_ADD(x[11], x[27], tmp[11]);
//     MY_SUB(x[11], x[27], tmp[27]);

//     MY_ADD(x[12], x[28], tmp[12]);
//     MY_SUB(x[12], x[28], tmp[28]);

//     MY_ADD(x[13], x[29], tmp[13]);
//     MY_SUB(x[13], x[29], tmp[29]);

//     MY_ADD(x[14], x[30], tmp[14]);
//     MY_SUB(x[14], x[30], tmp[30]);

//     MY_ADD(x[15], x[31], tmp[15]);
//     MY_SUB(x[15], x[31], tmp[31]);

//     *(float4*)input = *(float4*)tmp;
//     *(float4*)(input + 2) = *(float4*)(tmp + 2);
//     *(float4*)(input + 4) = *(float4*)(tmp + 4);
//     *(float4*)(input + 6) = *(float4*)(tmp + 6);
//     *(float4*)(input + 8) = *(float4*)(tmp + 8);
//     *(float4*)(input + 10) = *(float4*)(tmp + 10);
//     *(float4*)(input + 12) = *(float4*)(tmp + 12);
//     *(float4*)(input + 14) = *(float4*)(tmp + 14);
//     *(float4*)(input + 16) = *(float4*)(tmp + 16);
//     *(float4*)(input + 18) = *(float4*)(tmp + 18);
//     *(float4*)(input + 20) = *(float4*)(tmp + 20);
//     *(float4*)(input + 22) = *(float4*)(tmp + 22);
//     *(float4*)(input + 24) = *(float4*)(tmp + 24);
//     *(float4*)(input + 26) = *(float4*)(tmp + 26);
//     *(float4*)(input + 28) = *(float4*)(tmp + 28);
//     *(float4*)(input + 30) = *(float4*)(tmp + 30);
// }