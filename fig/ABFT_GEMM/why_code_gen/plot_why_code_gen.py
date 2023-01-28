import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable, Size, Divider
import torch as th
import seaborn as sns
color = sns.color_palette("flare", n_colors=4)
ms = 6
N = th.as_tensor([i for i in range(512, 10240+256, 256)])
# N = th.as_tensor([i for i in range(256, 16384+256, 256)])
N_4 = th.as_tensor([i for i in range(256, 6144+256, 256)])
N_8 = th.as_tensor([i for i in range(256, 6144+256, 256)])
kernel_name = ["", "row&col", "2 row checksum", "offline_abft_sgemm", "online_abft_1", "online_abft_2", "online_abft_3"]

abft_baseline = th.as_tensor([ 959.62, 1841.99, 2202.17, 2823.02, 2889.81, 3111.80, 3154.83, 3205.98, 3317.29, 3165.32, 3272.93, 3332.64, 3215.64, 3455.40, 3280.94, 3235.12, 3224.79, 3198.11, 3177.45, 3192.96, 3218.55, 3175.69, 3570.59, 3533.17, 3565.54, 3573.56, 3507.66, 3545.39, 3546.27, 3537.29, 3509.69, 3500.70, 3545.49, 3538.42, 3504.38, 3504.35, 3517.17, 3515.51, 3520.64,])
abft_kernel_huge = th.as_tensor([ 2002.27, 4368.73, 4389.24, 4749.40, 4275.54, 4158.65, 4040.66, 4043.24, 4206.92, 3985.80, 3918.80, 4108.95, 4024.96, 3996.32, 4047.62, 4029.24, 4025.08, 3999.30, 4018.15, 4008.31, 4004.01, 3988.19, 3981.11, 3968.03, 3957.93, 3962.18, 3931.24, 3942.08, 3910.40, 3905.81, 3890.04, 3876.59, 3874.56, 3858.04, 3842.47, 3860.15, 3828.56, 3826.31, 3817.52,])

# cublas_16384 = th.as_tensor([650.52, 2984.95, 4301.10, 4664.26, 5497.94, 5389.51, 5103.12, 4530.11, 4474.13, 4558.96, 4557.86, 4531.65, 4531.41, 4534.36, 4095.93, 4586.89, 4544.47, 4195.69, 4522.45, 4066.08, 4451.25, 4464.35, 4453.80, 4068.02, 4403.85, 4396.97, 4454.24, 4374.23, 4385.21, 4386.33, 4395.24, 4296.50, 4336.14, 4339.77, 4405.04, 4344.19, 4314.03, 4263.68, 4151.08, 4106.55,])
cublas = th.as_tensor([2850.22, 4504.82, 4622.96, 4489.48, 4591.98, 4731.48, 4228.35, 4485.04, 4282.02, 4511.37, 4284.57, 4296.68, 4351.45, 4411.01, 4466.17, 4331.06, 4300.80, 4290.18, 3929.37, 4216.73, 4165.86, 4164.11, 3847.94, 4178.97, 4146.90, 4194.62, 4106.82, 4134.28, 4131.57, 4154.89, 4065.60, 4144.52, 3958.89, 4187.66, 3970.73, 4015.54, 4119.32, 3940.17, 4060.69,])
# cublas_16384 = th.as_tensor([  213.26, 2984.21, 5610.69, 5043.13, 7044.23, 6964.93, 7289.90, 7286.82, 7354.07, 7472.27, 7463.11, 7137.08, 5441.40, 3652.63, 3571.65, 4124.15, 4520.38, 4491.29, 4422.57, 4313.85, 4263.87, 4488.63, 4432.17, 4167.45, 4382.91, 3451.29, 4477.09, 4476.04, 4393.66, 4465.69, 3968.95, 4279.32, 4394.86, 4302.11, 4170.43, 3967.08, 4146.43, 4271.25, 4266.57, 4222.32, 4000.47, 4292.92, 3988.15, 4231.43, 3971.86, 4215.40, 4214.59, 3708.19, 4192.49, 3885.76, 4157.53, 3870.42, 3898.53, 4118.40, 4094.46, 3797.77, 3858.35, 3877.61, 3858.68, 4190.85, 3867.86, 3793.21, 3867.69, 3769.26,])
abft_kernel_11_verf_16384 = th.as_tensor([  318.62, 1879.17, 4173.90, 4257.10, 4621.72, 5062.98, 5512.98, 5233.58, 5252.72, 5677.00, 4781.64, 4921.14, 5039.07, 4992.27, 5050.86, 5013.72, 3815.36, 3718.95, 3832.44, 3913.06, 3870.09, 3889.62, 3889.95, 3931.50, 3511.98, 3199.37, 3901.20, 3865.70, 3882.87, 3758.62, 3694.15, 3849.16, 3842.36, 3718.64, 3805.45, 3762.94, 3744.17, 3730.26, 3725.36, 3720.50, 3701.28, 3668.61, 3689.63, 3657.95, 3606.85, 3695.47, 3626.29, 3572.73, 3535.17, 3541.86, 3534.60, 3481.16, 3475.76, 3538.74, 3530.11, 3480.92, 3516.27, 3433.47, 3419.13, 3346.11, 3377.51, 3394.89, 3373.42, 3371.75,])
# kernel_13_16384 = th.as_tensor([  455.25, 2010.97, 4435.19, 4325.41, 4804.76, 5017.70, 5206.55, 5067.08, 4796.65, 5087.31, 4891.53, 4919.76, 4909.25, 4917.65, 4863.45, 4937.53, 4847.93, 4850.38, 4805.34, 4809.65, 4781.42, 4756.17, 4718.05, 4696.78, 4677.13, 4661.70, 4675.83, 4646.40, 4635.72, 4618.14, 4628.72, 4577.31, 4628.44, 4604.31, 4627.41, 4596.48, 4628.21, 4603.16, 4606.65, 4588.00])
kernel_sgemm = th.as_tensor([ 2653.09, 5013.23, 4840.83, 4766.77, 5013.24, 5206.89, 5053.87, 4796.65, 5087.31, 4891.53, 4919.76, 4909.25, 4917.65, 4863.45, 4937.53, 4847.93, 4850.38, 4805.34, 4809.65, 4781.42, 4756.17, 4718.05, 4696.78, 4677.13, 4661.70, 4675.83, 4646.40, 4635.72, 4618.14, 4628.72, 4577.31, 4628.44, 4604.31, 4627.41, 4596.48, 4628.21, 4603.16, 4606.65, 4588.00])


abft_kernel = abft_kernel_huge


# kernel_small = th.as_tensor([ th.as_tensor([    0.68,    5.15,   14.69,   35.35,   64.06,  104.75,  140.09,  192.27,  240.99,  291.31,  329.12])])
# cublas_small = th.as_tensor([ th.as_tensor([    0.50,    3.05,   10.05,   23.05,   42.87,   76.07,  112.83,  133.55,  174.32,  226.50,  304.09,])])
# N_small =  th.as_tensor([i for i in range(192, 176, 32)])

# N = th.cat((N_small, N))
# cublas = th.cat((cublas_small, cublas))
# kernel_sgemm = th.cat((kernel_small, kernel_sgemm))
# abft_baseline = th.cat((abft_baseline_small, abft_baseline))
# abft_kernel = th.cat((abft_baseline_small, abft_kernel_huge))

plt.rc('font', size=20)
plt.rcParams['lines.linewidth'] = 2
horiz = [Size.Fixed(6), Size.Fixed(6)]
vert = [Size.Fixed(3), Size.Fixed(3)]
fig, axLin = plt.subplots(ncols=1, figsize=(12, 6))

performance_scale = 1
l = N.shape[0]
axLin.set_xscale('linear')
axLin.set_yscale('log', base=2)

axLin.set_xlim(16, 512)
axLin.set_ylim(1, 2048)
axLin.set_xlabel("Matrix Sizes M=N=K")
axLin.set_ylabel("Performance (GFLOPS)")
# l = N_small.shape[0]
# axLin.plot(N_small, cublas_small[:l] / performance_scale,  label="cublas SGEMM", marker='o', markersize=ms, color = color[0], clip_on=False)
# axLin.plot(N_small, abft_baseline_small[:l] / performance_scale, label="abft baseline", marker='^',markersize=ms,  color = color[3], clip_on=False)
# axLin.plot(N_small, kernel_small[:l] / performance_scale,  label="SGEMM (Ours)", marker='P',markersize=ms, color = color[1], clip_on=False)
# axLin.plot(N_small, abft_small[:l] / performance_scale,  label="ABFT SGEMM (Ours)", marker='s',markersize=ms,  color = color[2], clip_on=False)
# l = N_medium.shape[0]
# axLin.plot(N_medium, cublas_medium[:l] / performance_scale,   marker='o', markersize=ms, color = color[0], clip_on=False)
# axLin.plot(N_medium, abft_baseline_medium[:l] / performance_scale,  marker='^',markersize=ms,  color = color[3], clip_on=False)
# axLin.plot(N_medium, kernel_medium[:l] / performance_scale,   marker='P',markersize=ms, color = color[1], clip_on=False)
# axLin.plot(N_medium, abft_medium[:l] / performance_scale,   marker='s',markersize=ms,  color = color[2], clip_on=False)

kernel_small = th.as_tensor([   5.15,   14.69,   35.35,   64.06,  104.75,  140.09,  192.27,  240.99,  291.31,  329.12])
cublas_small = th.as_tensor([   3.05,   10.05,   23.05,   42.87,   76.07,  112.83,  133.55,  174.32,  226.50,  304.09,])
abft_baseline_small = th.as_tensor([  1,    1.86,    4.58,    8.82,   12.63,   19.55,   29.51,   40.93,   56.75,   72.51,])
abft_small =  th.as_tensor([     4.36,   13.83,   30.67,   52.42,   85.61,  117.02,  154.22,  177.30,  221.63,  235.26,])
N_small =  th.as_tensor([i for i in range(32, 176, 16)])

kernel_medium = th.as_tensor([   505.71,  669.84,  803.94,  786.94,  987.32, 1013.21, 1115.21,])
cublas_medium = th.as_tensor([  355.89,  492.92,  486.60,  658.81,  831.64, 1043.56, 1213.82])
abft_baseline_medium = th.as_tensor([ 92.63,  141.99,  189.91,  125.00,  179.26,  228.91,  298.83,])
abft_medium =  th.as_tensor([     314.51,  366.65,  475.16,  550.05,  683.25,  670.12,  744.98,])
N_medium =  th.as_tensor([i for i in range(192, 384, 32)])

kernel_large = th.as_tensor([    1185.16, 1377.82, 1383.85, 1592.40,])
cublas_large = th.as_tensor([  976.20, 1137.69, 1547.95, 1770.16,])
abft_baseline_large = th.as_tensor([ 324.81,  399.56,  482.88,  607.94,])
abft_large =  th.as_tensor([     730.45,  858.64,  811.59,  932.15,])
N_large =  th.as_tensor([i for i in range(416, 512, 32)])

kernel = th.cat((kernel_small, kernel_medium))
cublas = th.cat((cublas_small, cublas_medium))
abft_baseline = th.cat((abft_baseline_small, abft_baseline_medium))
abft = th.cat((abft_small, abft_medium))
N = th.cat((N_small, N_medium))

kernel = th.cat((kernel, kernel_large))
cublas = th.cat((cublas, cublas_large))
abft_baseline = th.cat((abft_baseline, abft_baseline_large))
abft = th.cat((abft, abft_large))
abft_ = th.as_tensor([ 1.29,    3.63,    7.63,   12.95,   19.76,   28.78,   39.82,   51.44,   65.93,   81.24,  80.92,  117.56,  162.51,  202.56,  259.79,  324.23,  394.07,513.20,  604.05,  698.75,  805.80,])
kernel_ = th.as_tensor([ 1.84,    5.07,   10.73,   17.21,   26.95,   37.64,   52.19,   66.35,   85.18,  104.71, 102.98,  148.92,  205.38,  268.96,  342.44,  423.92,  515.76, 674.38,  785.38,  911.42, 1050.26,])
N = th.cat((N, N_large))


l = N.shape[0]
axLin.plot(N, cublas[:l] / performance_scale,   marker='o', markersize=ms, color = color[0], label="cublas SGEMM", clip_on=False)
# axLin.plot(N, abft_baseline[:l] / performance_scale,  marker='^',markersize=ms,  color = color[3], clip_on=False)
axLin.plot(N, kernel[:l] / performance_scale, '--' ,  marker='P',markersize=ms, color = color[1],label="SGEMM (Ours), with codegen", clip_on=False)
axLin.plot(N, kernel_[:l] / performance_scale,  marker='P',markersize=ms, color = color[1], label="SGEMM (Ours), no codegen",clip_on=False)
axLin.plot(N, abft[:l] / performance_scale, '--',  marker='s',markersize=ms,  color = color[2],label="ABFT SGEMM (Ours), with codegen", clip_on=False)
axLin.plot(N, abft_[:l] / performance_scale,   marker='s',markersize=ms,  color = color[2], label="ABFT SGEMM (Ours), no codegen",clip_on=False)


xticks = [100, 200, 300, 400, 512]
yticks = [1, 4,16, 64, 256, 1024]
axLin.set_xticks(xticks)
axLin.set_xticklabels([f'{s}' for s in xticks])

axLin.set_yticks(yticks)
axLin.set_yticklabels([f'{s}' for s in yticks])

axLin.grid(True)

xticks = [1024, 2048, 4096, 8192]

yticks = [2000, 3000, 4000, 5000]
axLin.legend()

fig.savefig(f"why_code_gen.pdf", bbox_inches='tight')