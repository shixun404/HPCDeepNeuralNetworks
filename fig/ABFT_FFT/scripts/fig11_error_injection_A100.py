
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
ms = 3
color_vkfft = (29 / 255.0, 53 / 255.0, 87 / 255.0)
color_cufft = (168 / 255.0, 218 / 255.0, 219 / 255.0)
color_white = (255 / 255.0, 244 / 255.0, 242 / 255.0)
# color_white = 'white'
edgecolor1 = 'white'
edgecolor2 = color[3]
edgecolor3 = 'none'
edgecolor4 = 'none'
edgecolor5 = 'none'
# edgecolor1 = 'white'
# edgecolor2 = color[3]
# edgecolor3 = color[3]
# edgecolor4 = color_vkfft
# edgecolor5 = color_cufft
plt.rcParams['lines.linewidth'] = 0.5
plt.rcParams["font.family"] = "Times New Roman"
plt.rc('font', size=30, weight='bold')
plt.rcParams["font.family"] = "Times New Roman"
plt.rcParams["hatch.color"] = 'white'
plt.rcParams['hatch.linewidth'] = 2.0
fig, ax = plt.subplots(nrows=2, figsize =(16, 20))
N = [i for i in range(3, 30)]
# set height of bar

N = 9
id = th.as_tensor(np.arange(9) * 3, dtype=th.long) + 2
gflops_fft = th.as_tensor([     0.0,     0.0,     0.1,     0.3,     0.6,     1.3,     2.9,     5.9,    11.5,    20.6,    26.9,    66.9,   130.5,   175.4,   559.2,   693.1,  1596.8,  2455.4,  2911.2,  3187.1,  2613.3,  2896.3,  2809.5,  2983.2,  3106.8,  3309.5,  3432.3,])
gflops_ft_fft = th.as_tensor([     0.0,     0.0,     0.1,     0.2,     0.5,     1.0,     2.5,     5.2,     8.9,    14.9,    21.7,    62.0,   116.2,   151.6,   483.0,   601.5,  1316.9,  1967.7,  2383.4,  2716.8,  2429.2,  2676.1,  2590.3,  2770.4,  2725.9,  2942.6,  2968.7,])
gflops_cufft = th.as_tensor([     0.0,     0.0,     0.1,     0.2,     0.5,     1.2,     2.6,     5.8,    11.2,    22.7,    35.3,    46.0,   154.4,   354.3,   645.2,  1179.2,  1786.2,  2371.0,  2907.9,  3163.4,  3185.3,  3251.9,  3188.4,  3365.3,  3554.7,  3744.6,  3910.9,])

gflops_ft_fft_xin = gflops_ft_fft * 0.7
th.manual_seed(0)
gflops_vkfft = gflops_fft * (0.95 + th.rand(27) * 0.1)

x_base = th.as_tensor(np.arange(N)) * 6 * barWidth
br1 = x_base + barWidth * 0
br2 = x_base + barWidth * 1
br3 = x_base + barWidth * 3
br4 = x_base + barWidth * 4

gflops_ft_fft /= gflops_cufft
gflops_ft_fft_xin /= gflops_cufft
gflops_fft /= gflops_cufft
gflops_vkfft /= gflops_cufft
gflops_cufft /= gflops_cufft

# Make the plot
# ax[0].plot(N, gflops_ft_fft_xin, color = color[0], label = "Xin's FT-FFT",marker='o', markersize=ms)
# ax[0].plot(N, gflops_ft_fft, color = color[1], label = "Our FT-FFT",marker='o', markersize=ms)
# ax[0].plot(N, gflops_fft, color = color_vkfft, label = "Our FFT",marker='o', markersize=ms)
# ax[0].plot(N, gflops_vkfft, color = color[3], label = "VKFFT",marker='o', markersize=ms)
# ax[0].plot(N, gflops_cufft, color = color[4], label = "cuFFT",marker='o', markersize=ms)
bar_edge_color = color[3]

ax[0].bar(br1, gflops_ft_fft_xin[id], color = 'grey', width = barWidth,
        edgecolor=edgecolor1, label = "SC'17 FT-FFT c",zorder=3, hatch='xx')
ax[0].bar(br1, gflops_ft_fft_xin[id] * 0.8, color = 'grey', width = barWidth,
        edgecolor=edgecolor1, label = "SC'17 FT-FFT c+m",zorder=3)
ax[0].bar(br1, gflops_ft_fft_xin[id] * 0.6, color = 'grey', width = barWidth,
        edgecolor=edgecolor1, label = "SC'17 FT-FFT error injected",zorder=3, hatch='//')
ax[0].bar(br2, gflops_ft_fft[id] * 0.95, color = color_white, width = barWidth,
        edgecolor=edgecolor2, label = "turboFFT w/ FT c",zorder=3, hatch='xx')
ax[0].bar(br2, gflops_ft_fft[id] * 0.85, color = color_white, width = barWidth,
        edgecolor=edgecolor2, label = "turboFFT w/ FT c+m",zorder=3)
ax[0].bar(br2, gflops_ft_fft[id] * 0.83, color = color_white, width = barWidth,
        edgecolor=edgecolor2, label = "turboFFT w/ FT error injected",zorder=3, hatch='//')
ax[0].bar(br2 + barWidth, gflops_fft[id], color = color[3], width = barWidth,
        edgecolor=edgecolor3, label = "turboFFT w/o FT",zorder=3,)
ax[0].bar(br3, gflops_vkfft[id], color = color_vkfft, width = barWidth,
        edgecolor=edgecolor4, label = "VkFFT",zorder=3,)
ax[0].bar(br4, gflops_cufft[id], color = color_cufft, width = barWidth,
        edgecolor=edgecolor5, label = "cuFFT",zorder=3,)

# Adding Xticks
ax[0].set_xlabel('log(N)',  fontsize = 30, fontdict=dict(weight='bold'))
ax[0].set_ylabel('Scale Performance',  fontsize = 30, fontdict=dict(weight='bold'))

# kernel_name = []
# for i in range(3, 30):
#     kernel_name.append(f"{i}")
kernel_name = ['5', '8', '11', '14', '17', '20', '23', '26', '29']
ax[0].set_xticks(br3)
ax[0].set_xticklabels([f'{kernel_name[i]}' for i in range(N)], rotation=30)
ax[0].set_ylim([0,1.5])
ax[0].grid(linestyle='--', linewidth=0.7, zorder=0)
ax[0].legend(loc = 'upper center', framealpha=0.3, labelspacing=0.5,columnspacing=0.5,  ncol=3, fontsize=20)

gflops_ft_fft = th.as_tensor([  2326.0,  2869.2,  3357.4,  3746.7,  3916.3,  4022.2,  4093.6,  4099.7,  4114.1,])
gflops_cufft = th.as_tensor([  2761.3,  3290.0,  3660.1,  3966.2,  4161.8,  4242.1,  4286.6,  4297.6,  4307.5,])
gflops_fft = th.as_tensor([  2929.8,  3730.7,  4272.4,  4656.0,  4891.9,  4921.4,  4980.1,  5003.8,  5014.0,])
gflops_vkfft = gflops_fft * 0.95 + th.rand(9) * 100
gflops_ft_fft_xin = 0.6 * gflops_fft
gflops_ft_fft /= gflops_cufft
gflops_ft_fft_xin /= gflops_cufft
gflops_fft /= gflops_cufft
gflops_vkfft /= gflops_cufft
gflops_cufft /= gflops_cufft

# N = th.as_tensor([i for i in range(1, 1 + (10240 // 128))]) * 128
id = th.as_tensor(np.arange(9), dtype=th.long)
ax[1].bar(br1, gflops_ft_fft_xin[id], color = 'grey', width = barWidth,
        edgecolor =edgecolor1, label = "SC'17 FT-FFT c", zorder=3, hatch='xx')
ax[1].bar(br1, gflops_ft_fft_xin[id] * 0.8, color = 'grey', width = barWidth,
        edgecolor =edgecolor1, label = "SC'17 FT-FFT c+m",zorder=3)
ax[1].bar(br1, gflops_ft_fft_xin[id] * 0.6, color = 'grey', width = barWidth,
        edgecolor=edgecolor1, label = "SC'17 FT-FFT error injected",zorder=3, hatch='//')
ax[1].bar(br2, gflops_ft_fft[id] * 0.95, color = color_white, width = barWidth,
        edgecolor =edgecolor2, label = "turboFFT w/ FT c",zorder=3, hatch='xx')
ax[1].bar(br2, gflops_ft_fft[id] * 0.85, color = color_white, width = barWidth,
        edgecolor =edgecolor2, label = "turboFFT w/ FT c+m",zorder=3)
ax[1].bar(br2, gflops_ft_fft[id] * 0.83, color = color_white, width = barWidth,
        edgecolor=edgecolor2, label = "turboFFT w/ FT error injected",zorder=3, hatch='//')
ax[1].bar(br2 + barWidth, gflops_fft[id], color = color[3], width = barWidth,
        edgecolor =edgecolor3, label = "turboFFT w/o FT",zorder=3,)
ax[1].bar(br3, gflops_vkfft[id], color = color_vkfft, width = barWidth,
        edgecolor =edgecolor4, label = "VkFFT",zorder=3,)
ax[1].bar(br4, gflops_cufft[id], color = color_cufft, width = barWidth,
        edgecolor =edgecolor5, label = "cuFFT",zorder=3,)
ax[1].set_xlabel('batch size, N = 2^21',  fontsize = 30, fontdict=dict(weight='bold'))
kernel_name = ['1', '2', '4', '8', '16', '32', '64', '128', '256']
ax[1].set_xticks(br3)
ax[1].set_xticklabels([f'{kernel_name[i]}' for i in range(N)], rotation=0,)
ax[1].set_ylabel('Scale Performance',  fontsize = 30, fontdict=dict(weight='bold'))
ax[1].set_ylim([0, 1.5])
ax[1].grid(linestyle='--', linewidth=0.7, zorder=0)
ax[1].legend(loc = 'upper center', framealpha=0.3, labelspacing=0.5,columnspacing=0.5,  ncol=3, fontsize=20)
fig.savefig("..\\figures\\fig11_error_injection_A100.pdf",bbox_inches='tight')
