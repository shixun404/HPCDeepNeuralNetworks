import matplotlib.pyplot as plt
import torch as th
N = th.as_tensor([i for i in range(256, 6144+256, 256)])
kernel_name = ["", "row&col", "2 row checksum", "offline_abft_sgemm", "online_abft_1", "online_abft_2", "online_abft_3"]
cublas = th.as_tensor([ 478.30, 1762.72, 3064.22, 3535.43, 4501.64, 4487.19, 4686.38, 4645.69, 4536.79, 4510.14, 4523.27, 4461.58, 4452.83, 4383.76, 4069.96, 4509.07, 4419.94, 4126.46, 4378.89, 3926.02, 4221.64, 4246.50, 4255.68, 3873.09,])
abft_kernel_1 = th.as_tensor([  175.88,  943.84, 1492.44, 1893.66, 2329.72, 2548.41, 4117.57, 4177.57, 4288.31, 4278.63, 4373.74, 4201.10, 4280.47, 4294.27, 3949.02, 4385.34, 4258.65, 4059.59, 4246.70, 3893.22, 4153.44, 4166.75, 4192.75, 3835.52,])
abft_kernel_2 = th.as_tensor([204.44, 1173.13, 2192.94, 2752.28, 3518.67, 3698.43, 3956.46, 3914.00, 4041.84, 4214.75, 4296.18, 4136.99, 4193.81, 4044.02, 3930.65, 4319.38, 4201.47, 4090.54, 4265.22, 3893.61, 4175.73, 4195.22, 4208.89, 3861.00,])
abft_kernel_3 = th.as_tensor([ 38.42,  239.59,  735.39, 1356.40, 1979.86, 2400.72, 2893.12, 3241.47, 3339.99, 3549.73, 3533.06, 3595.90, 3675.84, 3367.94, 3947.03, 4155.24, 4016.75, 3602.29, 4095.26, 4024.05, 3600.12, 3622.77, 3611.05, 3617.36,])
abft_kernel_4 = th.as_tensor([ 190.43,  817.71, 1754.99, 1832.30, 1954.97, 2156.74, 3089.12, 4446.77, 4599.85, 4651.34, 4382.39, 4555.10, 4427.11, 4396.73, 4353.82, 4387.99, 4442.24, 4325.43, 4294.74, 4486.19, 4314.04, 4227.40, 4190.52, 4284.07])
abft_kernel_5 = th.as_tensor([ 210.24,  907.13, 1956.16, 1925.27, 2306.99, 2773.36, 3049.01, 2878.10, 2989.05, 3322.68, 3159.52, 3233.03, 3196.62, 3126.56, 3139.15, 3178.78, 3126.35, 3131.04, 3098.87, 3097.85, 3105.65, 3088.09, 3088.30, 3101.62,])
abft_kernel_6 = th.as_tensor([ 141.93,  614.58, 1337.82, 1218.56, 1262.93, 1721.16, 3295.51, 3136.62, 3088.84, 3295.39, 3146.11, 3183.92, 3215.51, 3086.80, 3118.16, 3149.30, 3123.99, 3106.27, 3089.58, 3089.73, 3095.54, 3077.70, 3082.21, 3084.07,])
abft_kernel_7 = th.as_tensor([   189.92,  815.61, 1742.79, 1828.65, 2550.16, 4064.22, 4618.96, 4425.49, 4493.72, 4476.96, 4381.22, 4465.47, 4387.82, 4339.78, 4319.44, 4350.51, 4427.00, 4299.13, 4287.28, 4437.14, 4358.80, 4164.32, 4146.07, 4328.85])
abft_kernel_81 = th.as_tensor([ 241.99, 1087.89, 2297.38, 2203.14, 2374.15, 2600.19, 2835.36, 4001.52, 4722.58, 4832.94, 4577.79, 4733.99, 4766.04, 4722.48, 4524.47, 4652.08, 4748.91, 4598.88, 4651.75, 4634.43, 4650.07, 4593.64, 4607.28, 4597.73,])
abft_kernel_8256 = th.as_tensor([  333.29, 1489.53, 3163.02, 3270.21, 3754.72, 4354.93, 4985.07, 4675.69, 4659.46, 4791.40, 4584.83, 4729.93, 4788.32, 4738.84, 4535.13, 4669.53, 4777.33, 4599.23, 4631.40, 4602.58, 4607.68, 4565.39, 4561.84, 4572.16])

kernel_13 = th.as_tensor([ 312.80, 1485.84, 3158.96, 3055.08, 3442.83, 4362.74, 4831.99, 4669.91, 4644.56, 4865.52, 4575.50, 4719.79, 4791.39, 4744.30, 4528.25, 4696.22, 4793.21, 4580.39, 4631.97, 4596.97, 4616.41, 4586.27, 4573.06, 4568.65,])
roofline = N * 31.25
for i in range(N.shape[0]):
    if roofline[i] > 8100:
        roofline[i] = 8100
plt.rc('font', size=12)
plt.rcParams['lines.linewidth'] = 2
fig, ax = plt.subplots(ncols=2, figsize=(12, 5))
k1 = abft_kernel_3
k2 = abft_kernel_6
k1_id = 3
k2_id = 6
ax[0].plot(N, cublas / 1000,  label="cublasSgemm", color = 'k')
# ax[0].plot(N, abft_cublas / 1000,  label="offline_abft_sgemm", color = 'r')
ax[0].plot(N, kernel_13 / 1000,  label="Sgemm", color = 'brown')
ax[0].plot(N, abft_kernel_5 / 1000,  label="threadblock-level reduction", color = 'g')
# ax[0].plot(N, abft_kernel_7 / 1000,  label="warp-level reduction using primitives", color = 'g')
# ax[0].plot(N, abft_kernel_81 / 1000,  label="abft Sgemm (verify k % 1 == 0)", color = 'g')
# ax[0].plot(N, abft_kernel_8256 / 1000,  label="abft Sgemm (verify k % 256 == 0)", color = 'r')
ax[0].plot(N, roofline / 1000, '--', label="roofline model", color='b')
# ax[0].set_xscale('log')
ax[0].set_xlabel("Matrix Sizes (m=n=k)")
ax[0].set_ylabel("Performance (TFLOPS)")
ax[0].set_title("ABFT_SGEMM")
ax[0].grid()
ax[0].legend(loc="lower right", prop={'size': 10})

ax[1].plot(N, cublas / roofline,  label="cublasSgemm", color = 'k')
#ax[1].plot(N, abft_cublas / roofline,  label="offline_abft", color = 'r')
# ax[1].plot(N, yujia_kernel_8 / roofline,  label="kernel 8 from Yujia", color = 'b')# ax[1].set_xscale('log')
ax[1].plot(N, kernel_13 / roofline,  label="Sgemm", color = 'brown')

ax[1].plot(N, abft_kernel_5 / roofline,  label="threadblock-level reduction", color = 'g')
# ax[1].plot(N, abft_kernel_7 / roofline,  label="warp-level reduction using primitives", color = 'g')
# ax[1].plot(N, abft_kernel_81 / roofline,  label="abft Sgemm (verify k % 1 == 0)", color = 'g')
# ax[1].plot(N, abft_kernel_8256 / roofline,  label="abft Sgemm (verify k % 256 == 0)", color = 'r')# ax[1].set_xscale('log')
ax[1].set_ylim([0,1])
ax[1].set_xlabel("Matrix Sizes (m=n=k)")
ax[1].set_ylabel("Efficiency")
ax[1].set_title("ABFT_SGEMM")
ax[1].grid()
ax[1].legend(loc="lower right", prop={'size': 10})

fig.savefig(f"abft_sgemm_threadblock_level.png", dpi=300, bbox_inches='tight')