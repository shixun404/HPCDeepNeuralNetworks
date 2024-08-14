import matplotlib.pyplot as plt
import os
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
import torch as th
import numpy as np
import seaborn as sns
import matplotlib
# matplotlib.rcParams['pdf.fonttype'] = 42
# matplotlib.rcParams['ps.fonttype'] = 42
# plt.rcParams.update(plt.rcParamsDefault)
# plt.rcParams['text.usetex'] = True

color = sns.color_palette(n_colors=4)
print(color)
def addlabels(x,y):
    for i in range(len(x)):
        print(f'{y[i]:.2f}')
        plt.text(x[i], y[i]+10, f'{y[i]:.0f}', ha = 'center', fontsize=26) 
# set width of bar
barWidth = 0.3
plt.rc('font', size=30, weight='bold')
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(nrows=1, figsize =(16, 5))
plt.grid(linestyle='--', linewidth=0.7, zorder=0)
# set height of bar
cublas = th.as_tensor([19000])
simt_kernel = th.as_tensor([4000.10, 6000.92,7000, 8000, 8500, 8700, 9100 ])
tensor_core_kernel = th.as_tensor([9100, 15000, 17200, 17800, 18200, 18700])
# kernel_name = ['Naive', 'Shared\nmemory', '4 x 1 tile', 'Vectorized\nload', '4 x 4 tile', '256 threads', 'Ks → 16', '8x8 tile', 'Warp\nparallelisim', 'Prefetching', 'Double\nbuffer']
simt_kernel_name = ['Naive', 'Threadblock\nlevel tiling',  'Warp level\ntiling',  'Thread level\ntiling',  'Double Buffer', 'Vectorized\nload','Prefetching']
tensor_core_kernel_name = ['SIMT', 'wmma',  'mma.sync', 'Shared Memory\nBank Conflict',  'Triple Buffer', 'Async Copy']
error = th.rand(11) * 0.03

br1 = np.arange(len(tensor_core_kernel_name)) + barWidth
# for i in range(len(simt_kernel_name) - 1):
#     br1[i+1] = br1[i] + barWidth

br2 = [x + barWidth * 2 for x in br1]


# Make the plot
ax.bar(br1, tensor_core_kernel / 1000, color = color[2], width = barWidth,
        edgecolor ='k', label='ZGEMM (Ours)', zorder=3)
# plt.plot([0, br1[-1]+10], [1, 1], color='k', linestyle='--', label='cublas SGEMM')
# plt.bar(br2[-1], cublas / cublas, color = color[1], width = barWidth, edgecolor ='grey', label ='cublas')
# plt.bar(br2, cublas / cublas, color =color[1], width = barWidth,
#         edgecolor ='grey', label ='cuBLAS SGEMM')
# plt.bar(br3, gemm / cublas, color =color[2], width = barWidth,
#         edgecolor ='grey', label ='SGEMM (Ours)')
# plt.bar(br4, abft / cublas, color =color[3], width = barWidth,
#         edgecolor ='grey', label ='fused ABFT SGEMM (Ours)')
# addlabels(br1, kernel.numpy())
# plt.text(br1[3], y=-3.0, s='Thread-level\ntiling',ha='center')
# Adding Xticks
plt.plot([0, 6.3], [19.5, 19.5], linestyle='--', color='k', linewidth='3', label='FP64 Tensor Core Roofline')
ax.set_xlabel('',  fontsize = 30, fontdict=dict(weight='bold'))
ax.set_ylabel('Performance\n(TFLOPS)',  fontsize = 30, fontdict=dict(weight='bold'))
ax.set_xticks(br1) 
ax.set_xticklabels([f'{tensor_core_kernel_name[i]}' for i in range(len(tensor_core_kernel))], rotation = 30)
plt.title("ZGEMM Stepwise Optimization (Tensor Core)", fontdict=dict(weight='bold'))
ax.set_xlim([0, 6.3])
# ax.set_yticks([0, 2, 4])

ax.legend(loc="lower right", framealpha=0.7)
fig.savefig("../figures/fig1_stepwise_tensor_core.pdf",bbox_inches='tight')
