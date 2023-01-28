import matplotlib.pyplot as plt
import torch as th
import numpy as np
import seaborn as sns
color = sns.color_palette("Paired_r")
print(color)
def addlabels(x,y):
    for i in range(len(x)):
        print(f'{y[i]:.2f}')
        plt.text(x[i], y[i]+10, f'{y[i]:.0f}', ha = 'center', fontsize=15) 
# set width of bar
barWidth = 0.5
plt.rc('font', size=20)
fig = plt.subplots(figsize =(16, 8))

# set height of bar
cublas = th.as_tensor([4003.20])
kernel = th.as_tensor([611.10, 678.92, 1256.47, 1766.59, 3821.92, 4331.14, 4381.14, 4625.11, 4653.91,])
# kernel_name = ['Naive', 'Shared\nmemory', '4 x 1 tile', 'Vectorized\nload', '4 x 4 tile', '256 threads', 'Ks → 16', '8x8 tile', 'Warp\nparallelisim', 'Prefetching', 'Double\nbuffer']
kernel_name = ['Naive', 'Threadblock\n-level tiling',  '4 x 1', '4 x 4', '8 x 8',  'Warp-level\ntiling', 'Vectorized\nload','Prefetching', 'Double\nbuffer']
error = th.rand(11) * 0.03

br1 = np.arange(len(kernel)) + barWidth
for i in range(2,4):
    br1[i+1] = br1[i] + barWidth

for i in range(5,9):
    br1[i] = br1[i] - 1

br2 = [x + barWidth * 2 for x in br1]


# Make the plot
plt.bar(br1, kernel, color = color[0], width = barWidth,
        edgecolor ='grey', label ='SGEMM (Ours)',)
# plt.plot([0, br1[-1]+10], [1, 1], color='k', linestyle='--', label='cublas SGEMM')
# plt.bar(br2[-1], cublas / cublas, color = color[1], width = barWidth, edgecolor ='grey', label ='cublas')
# plt.bar(br2, cublas / cublas, color =color[1], width = barWidth,
#         edgecolor ='grey', label ='cublasSGEMM')
# plt.bar(br3, gemm / cublas, color =color[2], width = barWidth,
#         edgecolor ='grey', label ='SGEMM (Ours)')
# plt.bar(br4, abft / cublas, color =color[3], width = barWidth,
#         edgecolor ='grey', label ='ABFT SGEMM (Ours)')
addlabels(br1, kernel.numpy())
plt.text(br1[3], -1000, s='Thread-level\ntiling',ha='center')
# Adding Xticks
plt.xlabel('',  fontsize = 20)
plt.ylabel('Performance (TFOPS)',  fontsize = 20)

plt.xticks(br1,
[f'{kernel_name[i]}' for i in range(len(kernel))], rotation = 30)
plt.title("Step-wise SGEMM Kernel Optimization")
fig[1].set_xlim([0, 8])
plt.grid(linestyle='--', linewidth=0.7)
plt.legend(loc="upper left", framealpha=0.7)
plt.savefig("step_wise.pdf",bbox_inches='tight')
