import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import torch as th
import seaborn as sns
color = sns.color_palette("flare", n_colors=5)
ms = 6
N = th.as_tensor([i for i in range(256, 10240+256, 256)])
# N = th.as_tensor([i for i in range(256, 16384+256, 256)])
N_4 = th.as_tensor([i for i in range(256, 6144+256, 256)])
N_8 = th.as_tensor([i for i in range(256, 6144+256, 256)])
roofline_model = th.ones_like(N) * 7000

cublas = th.as_tensor([  890.96, 2561.72, 3700.86, 4948.52, 5853.06, 6105.49, 6283.51, 6387.91, 6518.79, 5553.21, 4274.96, 3838.08, 4000.84, 4178.87, 4442.41, 4539.08, 4552.04, 4413.85, 4540.95, 4478.05, 4533.59, 4541.68, 4543.56, 4449.70, 4512.24, 3332.50, 4607.49, 4450.57, 4576.79, 4569.49, 4661.42, 4578.87, 3956.61, 4429.99, 4693.99, 4687.07, 4726.95, 4262.54, 4425.00, 4700.04,])
kernel_sgemm =  th.as_tensor([  596.94, 1337.68, 2103.84, 2839.91, 3586.42, 4274.60, 5006.53, 5692.98, 5883.94, 6542.80, 3069.61, 3479.03, 4027.76, 4317.94, 4415.45, 4507.69, 4674.36, 4703.31, 4765.63, 4790.83, 3745.87, 4290.16, 4281.30, 4442.41, 4471.30, 4222.81, 4623.56, 4749.61, 4844.10, 4858.99, 4256.79, 4411.43, 4450.81, 4466.70, 4567.65, 4540.02, 4641.34, 4683.93, 4703.39, 4795.46,])
abft_kernel_huge = th.as_tensor([  229.20,  474.66,  652.53,  893.79, 1147.41, 1214.86, 1364.04, 1499.25, 1678.57, 1794.87, 1731.69, 1862.11, 1940.14, 1994.15, 1982.71, 2039.18, 2066.36, 2146.96, 2148.24, 2190.80, 2116.76, 2230.22, 2269.76, 2332.98, 2340.34, 2195.41, 2310.30, 2407.09, 2391.00, 2398.27, 2365.40, 2466.09, 2429.99, 2448.11, 2502.40, 2379.19, 2339.70, 2521.14, 2529.98, 2532.17,])
abft_baseline = th.as_tensor([  468.69, 1044.62, 1612.50, 2180.40, 2772.22, 3211.35, 3742.00, 4153.16, 4532.47, 4547.64, 2463.10, 2904.70, 3307.33, 3521.31, 3590.33, 3597.27, 3784.93, 3860.90, 3912.30, 4029.99, 3151.06, 3480.05, 3558.06, 3454.42, 3625.53, 3745.38, 3871.41, 3866.26, 3882.45, 3992.63, 3468.88, 3558.08, 3707.62, 3749.28, 3734.88, 3743.06, 3826.94, 3871.34, 3895.56, 3940.39,])


abft_kernel = abft_kernel_huge


kernel_small = th.as_tensor([    0.68,    5.15,   14.69,   35.35,   64.06,  104.75,  140.09,  192.27,  240.99,  291.31,  329.12])
cublas_small = th.as_tensor([    0.50,    3.05,   10.05,   23.05,   42.87,   76.07,  112.83,  133.55,  174.32,  226.50,  304.09,])
abft_baseline_small = th.as_tensor([    0.07,    0.54,    1.86,    4.58,    8.82,   12.63,   19.55,   29.51,   40.93,   56.75,   72.51,])
abft_small =  th.as_tensor([    0.58,    4.36,   13.83,   30.67,   52.42,   85.61,  117.02,  154.22,  177.30,  221.63,  235.26,])
N_small =  th.as_tensor([i for i in range(16, 176, 16)])

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
fig, ax = plt.subplots(ncols=1, figsize=(12, 6))

l = N.shape[0]

ax.plot(N, cublas[:l] / 1000,  label="cublas SGEMM", marker='o', markersize=ms, color = color[0], clip_on=False)
ax.plot(N, abft_baseline[:l] / 1000, label="abft baseline", marker='^',markersize=ms,  color = color[3], clip_on=False)
ax.plot(N, kernel_sgemm[:l] / 1000,  label="SGEMM (Ours)", marker='P',markersize=ms, color = color[1], clip_on=False)
ax.plot(N, abft_kernel[:l] / 1000,  label="ABFT SGEMM (Ours)", marker='s',markersize=ms,  color = color[2], clip_on=False)
ax.plot(N, roofline_model[:l] / 1000,  label="roofline", marker='x', markersize=ms, color = color[4], clip_on=False)

ax.set_xlabel("Matrix Sizes M=K, N=256")
ax.set_ylabel("Performance (TFLOPS)")
# ax.set_xscale("log", base=2)
ax.set_xlim(0, 10240)
xticks = [256, 2000, 4000, 6000, 8000, 10000]#[256, 512, 1024, 2048, 4096, 8192]
ax.set_xticks(xticks)
# ax.set_xticklabels([f'{s}' for s in xticks])
yticks = [1, 2, 3, 4, 5, 7]
ax.set_yticks(yticks)
ylabels = ['1', '2', '3', '4', '5', '8.1']
ax.set_yticklabels(ylabels)

ax.grid()
ax.legend(loc="lower right", prop={'size': 20})

fig.savefig(f"T4_N=256_thread_block_level_abft.pdf", bbox_inches='tight')