import matplotlib.pyplot as plt
import torch as th
N = th.as_tensor([i for i in range(256, 6144+256, 256)])

cublas = th.as_tensor([ 478.30, 1762.72, 3064.22, 3535.43, 4501.64, 4487.19, 4686.38, 4645.69, 4536.79, 4510.14, 4523.27, 4461.58, 4452.83, 4383.76, 4069.96, 4509.07, 4419.94, 4126.46, 4378.89, 3926.02, 4221.64, 4246.50, 4255.68, 3873.09,])
abft_kernel_1 = th.as_tensor([  175.88,  943.84, 1492.44, 1893.66, 2329.72, 2548.41, 4117.57, 4177.57, 4288.31, 4278.63, 4373.74, 4201.10, 4280.47, 4294.27, 3949.02, 4385.34, 4258.65, 4059.59, 4246.70, 3893.22, 4153.44, 4166.75, 4192.75, 3835.52,])
abft_kernel_2 = th.as_tensor([204.44, 1173.13, 2192.94, 2752.28, 3518.67, 3698.43, 3956.46, 3914.00, 4041.84, 4214.75, 4296.18, 4136.99, 4193.81, 4044.02, 3930.65, 4319.38, 4201.47, 4090.54, 4265.22, 3893.61, 4175.73, 4195.22, 4208.89, 3861.00,])
roofline = N * 31.25
for i in range(N.shape[0]):
    if roofline[i] > 8100:
        roofline[i] = 8100
plt.rc('font', size=12)
plt.rcParams['lines.linewidth'] = 2
fig, ax = plt.subplots(ncols=2, figsize=(12, 5))
k1 = abft_kernel_1
k2 = abft_kernel_2
k1_id = 1
k2_id = 2
ax[0].plot(N, cublas / 1000,  label="cublas", color = 'k')
# ax[0].plot(N, yujia_kernel_8 / 1000,  label="kernel 8 from Yujia ", color = 'b')
ax[0].plot(N, k1 / 1000,  label=f"kernel {k1_id}", color = 'g')
ax[0].plot(N, k2 / 1000,  label=f"kernel {k2_id}", color = 'r')
ax[0].plot(N, roofline / 1000, '--', label="roofline model", color='b')
# ax[0].set_xscale('log')
ax[0].set_xlabel("Matrix Sizes (m=n=k)")
ax[0].set_ylabel("Performance (TFLOPS)")
ax[0].set_title("ABFT_SGEMM")
ax[0].grid()
ax[0].legend(loc="upper left")

ax[1].plot(N, cublas / roofline,  label="cublas", color = 'k')
# ax[1].plot(N, yujia_kernel_8 / roofline,  label="kernel 8 from Yujia", color = 'b')# ax[1].set_xscale('log')
ax[1].plot(N, k1 / roofline,  label=f"kernel {k1_id}", color = 'g')
ax[1].plot(N, k2 / roofline,  label=f"kernel {k2_id}", color = 'r')# ax[1].set_xscale('log')
ax[1].set_ylim([0,1])
ax[1].set_xlabel("Matrix Sizes (m=n=k)")
ax[1].set_ylabel("Efficiency")
ax[1].set_title("ABFT_SGEMM")
ax[1].grid()
ax[1].legend(loc="upper left")

fig.savefig(f"abft_sgemm_{k1_id}vs{k2_id}.png", dpi=300, bbox_inches='tight')