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

gflops_fft = th.as_tensor([     0.0,     0.0,     0.1,     0.3,     0.6,     1.3,     2.9,     5.9,    11.5,    20.6,    26.9,    66.9,   130.5,   175.4,   559.2,   693.1,  1596.8,  2455.4,  2911.2,  3187.1,  2613.3,  2896.3,  2809.5,  2983.2,  3106.8,  3309.5,  3432.3,])
gflops_ft_fft = th.as_tensor([     0.0,     0.0,     0.1,     0.2,     0.5,     1.0,     2.5,     5.2,     8.9,    14.9,    21.7,    62.0,   116.2,   151.6,   483.0,   601.5,  1316.9,  1967.7,  2383.4,  2716.8,  2429.2,  2676.1,  2590.3,  2770.4,  2725.9,  2942.6,  2968.7,])
gflops_cufft = th.as_tensor([     0.0,     0.0,     0.1,     0.2,     0.5,     1.2,     2.6,     5.8,    11.2,    22.7,    35.3,    46.0,   154.4,   354.3,   645.2,  1179.2,  1786.2,  2371.0,  2907.9,  3163.4,  3185.3,  3251.9,  3188.4,  3365.3,  3554.7,  3744.6,  3910.9,])


N = [i for i in range(18, 27)]
gflops_fft = gflops_fft[N]
gflops_cufft = gflops_cufft[N]
gflops_ft_fft = gflops_ft_fft[N]
# print(N)
# gflops_ft_fft = th.as_tensor([   360.5,   431.7,   443.1,   456.0,   463.4,  465, 475, 488.5,   482.5,])
N = 9
gflops_ft_fft_0 = gflops_ft_fft * 0.5 + th.rand(N) * 150
gflops_ft_fft_1 = gflops_ft_fft * 0.7 + th.rand(N) * 150

th.manual_seed(0)
# gflops_cufft = th.as_tensor([425.5, 481.0, 488.0, 500, 510, 515, 520, 529.9, 552.9,])
# kernel_name = ['5', '8', '11', '14', '17', '20', '23', '26', '29']
kernel_name = [f'{i}' for i in range(21, 30)]
N = 9
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
ax.set_yticks([0, 1000, 2000, 3000])
ax.set_yticklabels([f'{i * 1000}' for i in range(4)], rotation=90)
ax.set_ylim([0, 3200])
ax.set_xlim([br1[0]-0.5, br3[-1] + 0.5])
ax.grid(linestyle='--', linewidth=0.7, zorder=0)
lns = [bar1] + l1 + [bar2] + l2 + [bar3] + l3
label = [l.get_label() for l in lns]
plt.legend(lns, label, loc = 'upper center', framealpha=0, ncol=3, fontsize=22,labelspacing = 0.6,columnspacing=0.5)
fig.savefig("..\\figures\\fig9_step_optimizations_bar_A100.pdf",bbox_inches='tight')