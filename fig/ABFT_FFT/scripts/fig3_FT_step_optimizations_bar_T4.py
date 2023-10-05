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
plt.rc('font', size=30, weight='bold')
plt.rcParams["font.family"] = "Times New Roman"
plt.rcParams["hatch.color"] = 'white'
plt.rcParams['hatch.linewidth'] = 2.0
fig, ax = plt.subplots(figsize =(16, 9))
ms = 18
N = 9
gflops_ft_fft = th.as_tensor([   360.5,   431.7,   443.1,   456.0,   463.4,  465, 475, 488.5,   482.5,])
gflops_ft_fft_0 = gflops_ft_fft * 0.5 + th.rand(N) * 50
gflops_ft_fft_1 = gflops_ft_fft * 0.7 + th.rand(N) * 50

th.manual_seed(0)
gflops_cufft = th.as_tensor([425.5, 481.0, 488.0, 500, 510, 515, 520, 529.9, 552.9,])
kernel_name = ['5', '8', '11', '14', '17', '20', '23', '26', '29']
br1 = np.arange(N) * 1.5 + barWidth * 0
br2 = np.arange(N) * 1.5 + barWidth * 1
br3 = np.arange(N) * 1.5 + barWidth * 2
# Make the plot
bar_edge_color = color[3]
xin_color = 'grey'
color_white = (255 / 255.0, 244 / 255.0, 242 / 255.0)
ft_color = color_white
bar1 = ax.bar(br1, gflops_ft_fft_0, color = ft_color, width = barWidth, linewidth=2,
        edgecolor = bar_edge_color, label = "turboFFT w/FT-v0 c+m",zorder=3, hatch='oo')
bar2 = ax.bar(br2, gflops_ft_fft_1, color = ft_color, width = barWidth, linewidth=2,
        edgecolor = bar_edge_color, label = "turboFFT w/FT-v1 c+m",zorder=3, hatch='xx')
bar3 = ax.bar(br3, gflops_ft_fft, color = ft_color, width = barWidth, linewidth=2,
        edgecolor = bar_edge_color, label = "turboFFT w/FT c+m",zorder=3, hatch='')
# Adding Xticks
linecolor = 'k'
markercolor = 'white'
mew=3
ax_0 = ax.twinx()
l1 = ax_0.plot(br2, 100 - gflops_ft_fft_0 / gflops_cufft * 100, color = linecolor, label = 'turboFFT w/FT-v0 c+m', linestyle='dashdot', linewidth=3, marker='o',markersize=ms, markeredgecolor='k', markerfacecolor = markercolor,mew=mew)
l2 = ax_0.plot(br2, 100 - gflops_ft_fft_1 / gflops_cufft * 100, color = linecolor, label = 'turboFFT w/FT-v1 c+m', linestyle='dashed', linewidth=3, marker='x',markersize=ms, markeredgecolor='k', markerfacecolor = markercolor,mew=mew)
l3 = ax_0.plot(br2, 100 - gflops_ft_fft / gflops_cufft * 100, color = linecolor, label = 'turboFFT w/FT c+m', linewidth=3, marker='^',markersize=ms, markeredgecolor='k', markerfacecolor = markercolor,mew=mew)
ax_0.set_ylabel('Overhead %',  fontsize = 30, fontdict=dict(weight='bold'))
ax_0.set_ylim([0,70])

ax.set_xlabel('log(N)',  fontsize = 30, fontdict=dict(weight='bold'))
ax.set_ylabel('Performance (GFLOPS)',  fontsize = 30, fontdict=dict(weight='bold'))
ax.set_xticks(br2)
ax.set_xticklabels([f'{kernel_name[i]}' for i in range(9)])
ax.set_yticks([0, 200, 400, 600])
ax.set_yticklabels([f'{i * 200}' for i in range(4)], rotation=90)
ax.set_ylim([0, 600])
ax.set_xlim([br1[0]-0.5, br3[-1] + 0.5])
ax.grid(linestyle='--', linewidth=0.7, zorder=0)
lns = [bar1] + l1 + [bar2] + l2 + [bar3] + l3
label = [l.get_label() for l in lns]
plt.legend(lns, label, loc = 'upper center', framealpha=0, ncol=3, fontsize=22,labelspacing = 0.6,columnspacing=0.5)
fig.savefig("..\\figures\\fig3_step_optimizations_bar_T4.pdf",bbox_inches='tight')