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
roofline_model = th.ones_like(N) * 19500

cublas = th.as_tensor([  870.40, 5003.94,10717.58,11808.29,15651.51,16192.83,15858.09,17151.99,18671.88,17884.51,18538.73,18252.86,18187.66,18245.82,18540.77,18930.83,18576.25,18951.30,18826.36,18887.82,18545.32,18840.80,18655.36,18832.54,18697.97,18655.85,19126.16,18727.62,18785.77,18822.53,18881.87,19111.63,18882.94,19088.94,18845.21,19117.71,19063.04,18902.44,18865.81,18860.63,])
kernel_sgemm =  th.as_tensor([  500.32, 2290.47, 5269.42, 9908.59,15369.61,11808.29,16378.03,14655.79,18469.05,17288.17,16842.06,16841.09,16895.99,17174.83,17527.58,17975.27,18426.14,18917.72,18142.80,18739.09,18269.71,18886.74,18625.72,18445.58,18349.32,18293.55,18938.70,18440.71,18541.38,18556.78,18821.31,18972.63,18752.08,18961.38,18806.68,19025.31,18939.95,18886.04,18845.78,18834.40,])
abft_kernel_huge = th.as_tensor([  426.77, 1959.22, 4559.32, 8261.38,13013.50,10363.70,14137.64,12678.80,14480.57,15040.51,14325.57,14667.87,14789.44,15079.26,15362.77,15621.43,16230.30,16655.45,15994.23,16530.03,16134.43,16674.81,16440.65,16202.45,16233.82,16229.86,16783.75,16324.60,16418.38,16541.59,16668.68,16800.11,16610.30,16790.29,16663.76,16847.96,16782.05,16737.26,16707.93,16699.94,])
abft_baseline = th.as_tensor([  150.65,  674.50, 1391.75, 2495.12, 3647.54, 4806.06, 6391.67, 7118.19, 8785.70, 9368.31, 9994.66,10583.56,10534.28,11106.90,11471.19,11945.06,12092.04,12313.57,12595.24,12650.76,12874.18,13013.39,13227.73,13499.81,13432.71,13875.82,14106.67,14075.47,14157.90,14303.20,14064.86,14386.23,14396.57,14469.10,14477.47,14482.22,14622.01,14681.63,13985.00,14671.25,])


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

ax.set_xlabel("Matrix Sizes M=N=K")
ax.set_ylabel("Performance (TFLOPS)")
# ax.set_xscale("log", base=2)
ax.set_xlim(0, 10240)
xticks = [256, 2000, 4000, 6000, 8000, 10000]#[256, 512, 1024, 2048, 4096, 8192]
ax.set_xticks(xticks)
# ax.set_xticklabels([f'{s}' for s in xticks])


ax.grid()
ax.legend(loc="lower right", prop={'size': 20})

fig.savefig(f"A100_thread_block_level_abft.pdf", bbox_inches='tight')