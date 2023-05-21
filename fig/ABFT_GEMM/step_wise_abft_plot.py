import matplotlib.pyplot as plt
import torch as th
import seaborn as sns
color = sns.color_palette("flare", n_colors=4)
ms = 8
# N = th.as_tensor([i for i in range(256, 6144+256, 256)])
N = th.as_tensor([i for i in range(256, 10240+256, 256)])
# N = th.as_tensor([i for i in range(256, 16384+256, 256)])
N_4 = th.as_tensor([i for i in range(256, 6144+256, 256)])
N_8 = th.as_tensor([i for i in range(256, 6144+256, 256)])
kernel_name = ["", "row&col", "2 row checksum", "offline_abft_sgemm", "online_abft_1", "online_abft_2", "online_abft_3"]
cublas = th.as_tensor([  771.24, 3685.36, 4493.55, 4736.14, 4801.66, 4358.91, 4647.11, 4101.19, 4261.44, 4461.81, 4411.62, 4345.48, 4358.91, 4280.92, 3925.50, 4456.07, 4244.33, 4075.64, 4227.55, 3876.73, 4125.18, 4138.51, 4154.92, 3807.30,])
abft_kernel_1 = th.as_tensor([    93.90,  680.40, 1290.29, 1568.04, 2145.34, 2257.25, 2597.70, 2849.10, 2910.12, 3255.49, 3302.04, 3389.22, 3456.87, 3497.73, 3440.38, 3375.99, 3355.49, 3364.17, 3356.83, 3210.91, 3299.14, 3246.63, 3051.23, 2899.62, 3483.08, 3711.87, 3741.23, 3759.40, 3748.43, 3632.27, 3742.34, 3757.65, 3690.35, 3718.58, 3771.02, 3656.90, 3712.60, 3689.28, 3726.11, 3716.87, 3736.08, 3734.92, 3724.72, 3737.47, 3740.45, 3731.49, 3690.00, 3769.84, 3747.24, 3731.39, 3735.19, 3732.49, 3719.49, 3727.86, 3718.25, 3722.41, 3712.58, 3704.65, 3706.80, 3708.08, 3693.74, 3688.94, 3695.32, 3797.35])


kernel_13 = th.as_tensor([ 312.80, 1485.84, 3158.96, 3055.08, 3442.83, 4362.74, 4831.99, 4669.91, 4644.56, 4865.52, 4575.50, 4719.79, 4791.39, 4744.30, 4528.25, 4696.22, 4793.21, 4580.39, 4631.97, 4596.97, 4616.41, 4586.27, 4573.06, 4568.65,])

abft_kernel_thread = th.as_tensor([  232.59, 1016.20, 2232.19, 2029.86, 2113.35, 2334.28, 2563.59, 2549.20, 3362.27, 3491.54, 3290.15, 3380.54, 3420.76, 3214.76, 3315.42, 3402.98, 3233.86, 3265.38, 3222.60, 3233.05, 3231.54, 3226.90, 3208.96, 3205.12, 3209.21, 3204.07, 3217.30, 3203.44, 3195.79, 3186.20, 3180.62, 3168.67, 3152.05, 3159.86, 3166.69, 3140.87, 3139.41, 3129.38, 3123.06, 3097.40])
abft_kernel_warp = th.as_tensor([ 390.18, 1747.15, 3479.15, 3291.07, 3515.37, 3840.10, 4043.43, 3756.69, 3785.35, 3993.53, 3765.55, 3825.55, 3817.14, 3696.27, 3757.40, 3810.95, 3730.90, 3757.58, 3726.19, 3753.33, 3740.59, 3746.76, 3727.01, 3724.96, 3709.51, 3722.55, 3736.45, 3716.93, 3709.32, 3698.80, 3682.13, 3654.94, 3661.37, 3628.57, 3647.83, 3623.01, 3605.97, 3583.08, 3575.44, 3543.11,])  
abft_kernel_threadblock = th.as_tensor([   206.09, 1110.19, 2434.77, 2399.92, 2541.09, 2799.80, 3074.11, 3033.51, 3255.80, 3584.43, 3633.32, 3816.07, 4021.38, 3976.43, 3908.83, 3860.68, 3940.42, 3985.73, 3901.45, 3964.31, 3973.96, 3960.32, 3935.64, 3949.86, 3947.25, 3768.61, 3895.49, 3917.04, 3940.23, 3929.43, 3825.75, 3885.43, 3868.86, 3879.25, 3885.81, 3894.61, 3836.78, 3883.09, 3742.15, 3790.27, 3839.04, 3798.48, 3829.05, 3724.72, 3741.32, 3653.62, 3706.61, 3727.66, 3753.71, 3678.97, 3703.42, 3623.77, 3701.72, 3644.07, 3626.84, 3600.51, 3603.36, 3728.43, 3570.28, 3586.31, 3482.34, 3450.02, 3489.65, 3466.88])
cublas_16384 = th.as_tensor([  213.26, 2984.21, 5610.69, 5043.13, 7044.23, 6964.93, 7289.90, 7286.82, 7354.07, 7472.27, 7463.11, 7137.08, 5441.40, 3652.63, 3571.65, 4124.15, 4520.38, 4491.29, 4422.57, 4313.85, 4263.87, 4488.63, 4432.17, 4167.45, 4382.91, 3451.29, 4477.09, 4476.04, 4393.66, 4465.69, 3968.95, 4279.32, 4394.86, 4302.11, 4170.43, 3967.08, 4146.43, 4271.25, 4266.57, 4222.32, 4000.47, 4292.92, 3988.15, 4231.43, 3971.86, 4215.40, 4214.59, 3708.19, 4192.49, 3885.76, 4157.53, 3870.42, 3898.53, 4118.40, 4094.46, 3797.77, 3858.35, 3877.61, 3858.68, 4190.85, 3867.86, 3793.21, 3867.69, 3769.26,])
kernel_13_16384 = th.as_tensor([558.73, 2613.27, 5546.17, 5361.20, 5799.39, 6383.47, 5735.74, 4403.65, 4559.28, 4770.27, 4559.84, 4693.43, 4728.11, 4728.78, 4305.30, 4677.68, 4738.38, 4457.53, 4636.01, 4538.75, 4567.17, 4603.87, 4608.96, 4597.37, 4596.99, 4592.30, 4636.48, 4560.55, 4558.08, 4579.26, 4535.38, 4368.25, 4542.83, 4492.50, 4503.08, 4468.59, 4507.09, 4435.04, 4398.33, 4415.85, 4345.94, 4344.33, 4333.57, 4282.52, 4311.11, 4253.77, 4316.26, 4290.67, 4238.32, 4283.96, 4155.34, 4141.92, 4204.89, 4228.60, 4214.93, 4089.33, 4179.70, 4111.91, 4067.31, 4228.25, 4016.56, 4054.22, 4219.58, 3903.30,])




plt.rc('font', size=20)
plt.rcParams['lines.linewidth'] = 2
fig, ax = plt.subplots(ncols=2,nrows=2, figsize=(12, 6))
# ax[0,0].plot(N, cublas / 1000,  label="cublasSgemm", color = 'k')
# ax[0].plot(N, abft_cublas / 1000,  label="offline_abft_sgemm", color = 'r')
# ax[0,0].plot(N, kernel_13 / 1000,  label="Sgemm", color = 'g')
ax[0,0].plot(N, abft_kernel_thread[:40] / 1000,  label="thread-level ABFT", marker='o', markersize=ms, color = color[0])
ax[0,0].plot(N, abft_kernel_warp[:40] / 1000,  label="warp-level ABFT", marker='P', markersize=ms,color=color[1])
ax[0,0].plot(N, abft_kernel_threadblock[:40] / 1000,  label="threadblock-level ABFT",marker='s', markersize=ms, color =  color[2])
ax[0,0].plot(N, abft_kernel_1[:40] / 1000,  label="abft baseline", marker='^', markersize=ms,color =  color[3])
# ax[0].plot(N, abft_kernel_verify_branch / 1000, label = "thread-level (k % 256 == 0), branch verification", color='pink')
# ax[0].plot(N, abft_kernel_7 / 1000,  label="warp-level reduction using primitives", color = 'g')
# ax[0].plot(N, abft_kernel_81 / 1000,  label="abft Sgemm (verify k % 1 == 0)", color = 'g')
# ax[0].plot(N, abft_kernel_8256 / 1000,  label="abft Sgemm (verify k % 256 == 0)", color = 'r')
# ax[0].plot(N, roofline / 1000, '--', label="roofline model", color='b')
# ax[0].set_xscale('log')
ax[0,0].set_xlabel("Matrix Sizes M=N=K")
ax[0,0].set_ylabel("Performance (TFLOPS)")
# ax[0,0].set_title("Performance")
ax[0,0].grid()
ax[0,0].legend(loc="lower right", prop={'size': 20})

# ax[1].plot(N, cublas / roofline,  label="cublasSgemm", color = 'k')
#ax[1].plot(N, abft_cublas / roofline,  label="offline_abft", color = 'r')
# ax[1].plot(N, yujia_kernel_8 / roofline,  label="kernel 8 from Yujia", color = 'b')# ax[1].set_xscale('log')
# ax[1].plot(N, kernel_13 / roofline,  label="Sgemm", color = 'brown')

# ax[1].plot(N, 100 * (kernel_13_16384 - abft_kernel_12) / kernel_13_16384,  label="overhead (SGEMM)", color = 'g')
# ax[1].plot(N, 100 * (cublas_16384 - abft_kernel_12) / cublas_16384   ,  label="overhead (cublas)", color = 'k')

# ax[1].plot(N, abft_kernel_7 / roofline,  label="warp-level reduction using primitives", color = 'g')
# ax[1].plot(N, abft_kernel_81 / roofline,  label="abft Sgemm (verify k % 1 == 0)", color = 'g')
# ax[1].plot(N, abft_kernel_8256 / roofline,  label="abft Sgemm (verify k % 256 == 0)", color = 'r')# ax[1].set_xscale('log')
# ax[1].set_ylim([0,1])

# fig.suptitle("T4")
fig.savefig(f"step_wise_abft.pdf", bbox_inches='tight')