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
abft_kernel = abft_kernel_huge


kernel_small = th.as_tensor([   5.15,   14.69,   35.35,   64.06,  104.75,  140.09,  192.27,  240.99,  291.31,  329.12])
cublas_small = th.as_tensor([   3.05,   10.05,   23.05,   42.87,   76.07,  112.83,  133.55,  174.32,  226.50,  304.09,])
abft_baseline_small = th.as_tensor([  1,    1.86,    4.58,    8.82,   12.63,   19.55,   29.51,   40.93,   56.75,   72.51,])
abft_small =  th.as_tensor([     4.36,   13.83,   30.67,   52.42,   85.61,  117.02,  154.22,  177.30,  221.63,  235.26,])
N_small =  th.as_tensor([i for i in range(32, 176, 16)])

plt.rc('font', size=20)
plt.rcParams['lines.linewidth'] = 2
horiz = [Size.Fixed(6), Size.Fixed(6)]
vert = [Size.Fixed(3), Size.Fixed(3)]
fig, ax = plt.subplots(ncols=2, figsize=(16, 5))

performance_scale = 1
l = N.shape[0]
ax[0].set_xscale('linear')
ax[0].set_yscale('log', base=2)

ax[0].set_xlim(16, 512)
ax[0].set_ylim(1, 2048)
ax[0].set_xlabel("Matrix Sizes M=N=K")
ax[0].set_ylabel("Performance (GFLOPS)")

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
ax[0].plot(N, cublas[:l] / performance_scale,   marker='o', markersize=ms, color = color[0], label="cublas SGEMM", clip_on=False)
# ax[0].plot(N, abft_baseline[:l] / performance_scale,  marker='^',markersize=ms,  color = color[3], clip_on=False)
ax[0].plot(N, kernel[:l] / performance_scale, '--' ,  marker='P',markersize=ms, color = color[1],label="SGEMM (Ours), with codegen", clip_on=False)
ax[0].plot(N, kernel_[:l] / performance_scale,  marker='P',markersize=ms, color = color[1], label="SGEMM (Ours), no codegen",clip_on=False)
ax[0].plot(N, abft[:l] / performance_scale, '--',  marker='s',markersize=ms,  color = color[2],label="ABFT SGEMM (Ours), with codegen", clip_on=False)
ax[0].plot(N, abft_[:l] / performance_scale,   marker='s',markersize=ms,  color = color[2], label="ABFT SGEMM (Ours), no codegen",clip_on=False)


xticks = [100, 200, 300, 400, 512]
yticks = [1, 4,16, 64, 256, 1024]
ax[0].set_xticks(xticks)
ax[0].set_xticklabels([f'{s}' for s in xticks])

ax[0].set_yticks(yticks)
ax[0].set_yticklabels([f'{s}' for s in yticks])

ax[0].grid(True)

xticks = [1024, 2048, 4096, 8192]

yticks = [2000, 4000, 6000, 8000]
ax[0].legend()





performance_scale = 1
l = N.shape[0]
ax[0].set_xscale('linear')
ax[0].set_yscale('log', base=2)

ax[0].set_xlim(16, 512)
ax[0].set_ylim(1, 2048)
ax[0].set_xlabel("Matrix Sizes M=N=K")
ax[0].set_ylabel("Performance (GFLOPS)")

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
ax[0].plot(N, cublas[:l] / performance_scale,   marker='o', markersize=ms, color = color[0], label="cublas SGEMM", clip_on=False)
# ax[0].plot(N, abft_baseline[:l] / performance_scale,  marker='^',markersize=ms,  color = color[3], clip_on=False)
ax[0].plot(N, kernel[:l] / performance_scale, '--' ,  marker='P',markersize=ms, color = color[1],label="SGEMM (Ours), with codegen", clip_on=False)
ax[0].plot(N, kernel_[:l] / performance_scale,  marker='P',markersize=ms, color = color[1], label="SGEMM (Ours), no codegen",clip_on=False)
ax[0].plot(N, abft[:l] / performance_scale, '--',  marker='s',markersize=ms,  color = color[2],label="ABFT SGEMM (Ours), with codegen", clip_on=False)
ax[0].plot(N, abft_[:l] / performance_scale,   marker='s',markersize=ms,  color = color[2], label="ABFT SGEMM (Ours), no codegen",clip_on=False)


xticks = [100, 200, 300, 400, 512]
yticks = [1, 4,16, 64, 256, 1024]
ax[0].set_xticks(xticks)
ax[0].set_xticklabels([f'{s}' for s in xticks])

ax[0].set_yticks(yticks)
ax[0].set_yticklabels([f'{s}' for s in yticks])

ax[0].grid(True)

xticks = [1024, 2048, 4096, 8192]

yticks = [2000, 4000, 6000, 8000]
ax[0].legend()









fig.savefig(f"A100_why_code_gen.pdf", bbox_inches='tight')