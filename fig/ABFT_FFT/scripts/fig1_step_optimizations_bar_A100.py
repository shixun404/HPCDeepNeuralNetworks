import matplotlib.pyplot as plt
import torch as th
import numpy as np
import seaborn as sns
import os
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
color = sns.color_palette(n_colors=5)
print(color)
def addlabels(x,y):
    for i in range(len(x)):
        print(f'{y[i]:.2f}')
        plt.text(x[i], y[i]+10, f'{y[i]:.0f}', ha = 'center', fontsize=26) 
# set width of bar
barWidth = 0.4
fsz=32
plt.rc('font', size=fsz, weight='bold')
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(figsize =(20, 4))
plt.grid(linestyle='--', linewidth=0.7, zorder=0)
# set height of bar

gflops_fft = th.as_tensor([300.0, 375, 454.7, 460, 505.8, 520, 524.7, 537, 550.9])
th.manual_seed(0)
gflops_naive = []
gflops_optim1 = []
gflops_optim2 = []


gflops_cufft = th.as_tensor([425.5, 450, 481.0, 484,  488.0, 500, 529.9, 535, 552.9,])

kernel_name = ['5', '8', '11', '14','17',  '20','23', '26', '29']
# error = th.rand(11) * 0.03

br1 = th.as_tensor(np.arange(9) * 2.0 + barWidth * 0)
br2 = th.as_tensor(np.arange(9) * 2.0 + barWidth * 1)
br3 = th.as_tensor(np.arange(9) * 2.0 + barWidth * 2)
br4 = th.as_tensor(np.arange(9) * 2.0 + barWidth * 3)



plt.rcParams["hatch.color"] = 'white'
plt.rcParams['hatch.linewidth'] = 2.0
# plt.rcParams["marker.edgecolor"] = 'white'

bar_edge_color = 'white'
# Make the plot
bar1 = ax.bar(br1, gflops_naive, color = color[3], width = barWidth,
        edgecolor =bar_edge_color, label ='TurboFFT-v0',zorder=3,hatch = 'O')
bar2 = ax.bar(br2, gflops_optim1, color = color[3], width = barWidth,
        edgecolor =bar_edge_color, label ='TurboFFT-v1',zorder=3, hatch = '//')
bar3 = ax.bar(br3, gflops_optim2, color = color[3], width = barWidth,
        edgecolor =bar_edge_color, label ='TurboFFT-v2',zorder=3, hatch = 'xx')
bar4 = ax.bar(br4, gflops_fft, color = color[3], width = barWidth,
        edgecolor =bar_edge_color, label ='TurboFFT',zorder=3)


ax_0 = ax.twinx()
ms = 20
line_color = 'k'
# markercolor = color[3]
markercolor = 'white'
linewidth = 3
mew=3
l1 = ax_0.plot((br2 + br3) / 2, gflops_naive / gflops_cufft, color = line_color, linestyle='dashdot', marker='o', linewidth=linewidth, markersize = ms, label ='TurboFFT-v0', markeredgecolor='k', markerfacecolor = markercolor,mew=mew)
l2 = ax_0.plot((br2 + br3) / 2, gflops_optim1 / gflops_cufft, color = line_color, linestyle='dotted', marker='*', linewidth=linewidth, markersize = ms, label ='TurboFFT-v1', markeredgecolor='k', markerfacecolor = markercolor,mew=mew)
l3 = ax_0.plot((br2 + br3) / 2, gflops_optim2 / gflops_cufft, color = line_color, linestyle='dashed',marker='P', linewidth=linewidth, markersize = ms, label ='TurboFFT-v2', markeredgecolor='k', markerfacecolor = markercolor,mew=mew)
l4 = ax_0.plot((br2 + br3) / 2, gflops_fft / gflops_cufft, color = line_color, marker='^', linewidth=linewidth, markersize = ms, label ='TurboFFT', markeredgecolor='k', markerfacecolor = markercolor,mew=mew)

ax_0.set_ylabel('Performance Ratio', fontsize=fsz, fontdict=dict(weight='bold'))
# Adding Xticks
ax.set_xlabel('log(N)',  fontsize=fsz, fontdict=dict(weight='bold'))
ax.set_ylabel('Performance (GFLOPS)',  fontsize=fsz, fontdict=dict(weight='bold'))

ax.set_xticks(br3)
ax.set_xticklabels([f'{kernel_name[i]}' for i in range(9)])

ax.set_yticks([0, 200, 400, 600])
ax.set_yticklabels(['0', '200', '400', '600'] ,rotation=90)
ax.set_ylim([0, 550])
ax_0.set_ylim([0, 1.3])
ax.set_xlim([br1[0]-0.5, br4[-1] + 0.7])

lns = [bar1] + l1 + [bar2] + l2 + [bar3] + l3 + [bar4] + l4
label = [l.get_label() for l in lns]
# plt.legend(lns, label, loc = 'upper center', framealpha=0, ncol=4, fontsize=fsz,labelspacing = 0.2,columnspacing=0.5)
plt.legend(lns, label,bbox_to_anchor=(0.5, -0.15), loc = 'upper center', framealpha=0, ncol=4, fontsize=fsz,labelspacing = 0.2,columnspacing=0.5)
plt.savefig("..\\figures\\fig1_step_optimizations_bar_A100.pdf",bbox_inches='tight')
# plt.savefig("..\\figures\\fig1_step_optimizations_bar_T4.png",bbox_inches='tight')
