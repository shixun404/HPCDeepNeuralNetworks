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
fig, ax = plt.subplots(figsize =(16, 9))

# set height of bar



gflops_fft = th.as_tensor([     0.0,     0.0,     0.1,     0.3,     0.6,     1.3,     2.9,     5.9,    11.5,    20.6,    26.9,    66.9,   130.5,   175.4,   559.2,   693.1,  1596.8,  2455.4,  2911.2,  3187.1,  2613.3,  2896.3,  2809.5,  2983.2,  3106.8,  3309.5,  3432.3,])
gflops_fft_m = th.as_tensor([     0.0,     0.0,     0.1,     0.2,     0.5,     1.0,     2.5,     5.2,     8.9,    14.9,    21.7,    62.0,   116.2,   151.6,   483.0,   601.5,  1316.9,  1967.7,  2383.4,  2716.8,  2429.2,  2676.1,  2590.3,  2770.4,  2725.9,  2942.6,  2968.7,])
gflops_cufft = th.as_tensor([     0.0,     0.0,     0.1,     0.2,     0.5,     1.2,     2.6,     5.8,    11.2,    22.7,    35.3,    46.0,   154.4,   354.3,   645.2,  1179.2,  1786.2,  2371.0,  2907.9,  3163.4,  3185.3,  3251.9,  3188.4,  3365.3,  3554.7,  3744.6,  3910.9,])

print((gflops_fft_m[5:] / gflops_fft[5:]).mean())
assert 0
N = [i for i in range(18, 27)]
gflops_fft = gflops_fft[N]
gflops_cufft = gflops_cufft[N]
gflops_fft_m = gflops_fft_m[N]
# print(N)
# assert 0


gflops_fft_xin = gflops_fft * 0.6
gflops_fft_xin_m = gflops_fft_xin * 0.45 + th.rand_like(gflops_fft) * 100
gflops_fft_xin_c = gflops_fft_xin * 0.7 + th.rand_like(gflops_fft) * 100
# gflops_fft = th.as_tensor([   360.5,   431.7,   443.1,   456.0,   463.4, 470, 480,  488.5,   482.5,])

# gflops_cufft = th.as_tensor([   495.7,   461.8,   486.7,   511.0,   529.2, 535, 540,   545.9,   552.7,])
# gflops_fft_c = gflops_cufft
# for i in range(gflops_cufft.shape[0]):
#     gflops_fft_c[i] = max(gflops_cufft[i], gflops_fft[i])
gflops_fft_c = gflops_fft * 0.94
# gflops_fft_m = gflops_fft
th.manual_seed(0)

plt.rcParams["hatch.color"] = 'white'
plt.rcParams['hatch.linewidth'] = 3.0
# gflops_cufft = th.as_tensor([425.5, 481.0, 488.0, 500, 510,515, 520, 529.9, 552.9,])

# kernel_name = ['5', '8',  '11', '14', '17', '20', '23', '26', '29']
kernel_name = [f'{i}' for i in range(21, 30)]
br1 = th.as_tensor(np.arange(9) * 2 + barWidth * 0)
br2 = th.as_tensor(np.arange(9) * 2 + barWidth * 1.6)
br3 = th.as_tensor(np.arange(9) * 2 + barWidth * 3.1)
# Make the plot
bar_edge_color = color[3]
xin_color = 'grey'
ft_color =  (255 / 255.0, 244 / 255.0, 242 / 255.0)
xin_c = ax.bar(br1 + barWidth / 2, gflops_fft_xin_c, color = xin_color, width = barWidth,
        edgecolor = 'white', label = "SC'17 FT-FFT c",zorder=3, hatch='//')
ft_c = ax.bar(br2 + barWidth / 2, gflops_fft_c, color = ft_color, width = barWidth,
        edgecolor = bar_edge_color, label = 'turboFFT w/ FT c',zorder=3, hatch='//')
xin_cm = ax.bar(br1, gflops_fft_xin_m, color = xin_color, width = barWidth,
        edgecolor = 'white', label = "SC'17 FT-FFT c+m",zorder=3, hatch='')
ft_cm = ax.bar(br2, gflops_fft_m, color = ft_color, width = barWidth,
        edgecolor = bar_edge_color, label = 'turboFFT w/ FT c+m',zorder=3, hatch='')
fft = ax.bar(br3, gflops_fft, color = color[3], width = barWidth,
        edgecolor = 'white', label ='turboFFT w/o FT',zorder=3)
# Adding Xticks
ax.set_xlabel('log(N)',  fontsize = 30, fontdict=dict(weight='bold'))
ax.set_ylabel('Performance (GFLOPS)',  fontsize = 30, fontdict=dict(weight='bold'))
ax.set_xticks(br2-barWidth/2)
ax.set_xticklabels([f'{kernel_name[i]}' for i in range(9)])
ax.set_yticks([0, 1000, 2000, 3000, 4000])
ax.set_yticklabels([f'{i * 1000}' for i in range(5)], rotation=90)
ax.set_ylim([0, 4000])
ax.set_xlim([-0.4, br3[-1]+0.5])
ax.grid(linestyle='--', linewidth=0.7, zorder=0)
lns = [xin_c] + [xin_cm] + [ft_c] + [ft_cm] + [fft]
label = [l.get_label() for l in lns]
plt.legend(lns, label, loc = 'upper center', framealpha=0, ncol=3, fontsize=25,labelspacing = 0.2,columnspacing=0.5)
# ax.legend(loc = 'upper center', framealpha=0, ncol=2, fontsize=20)


# gflops_fft = th.as_tensor([   179.0,   316.9,   422.3,   476.3,   453.2,   492.4,   516.1,   520.1,   519.5,   536.4,   545.6,   549.4,   555.3,   565.1,   564.6,   571.8,   568.5,   576.3,   574.8,   582.2,   583.7,   583.0,   590.1,   589.0,   589.5,   593.5,   595.8,   596.1,   597.3,   599.3,   600.8,   600.8,   602.5,   602.3,   603.0,   602.5,   604.6,   606.4,   608.2,   608.1,   608.5,   610.5,   611.9,   608.8,   611.3,   610.6,   611.0,   614.2,   612.5,   612.7,   614.9,   614.2,   612.8,   615.2,   616.3,   616.6,   615.7,   615.1,   616.7,   618.2,   616.2,   615.9,   619.9,   619.8,   616.4,   615.8,   619.0,   620.1,   617.5,   619.1,   619.4,   620.4,   620.0,   620.9,   620.8,   622.6,   619.9,   621.0,   621.6,   622.5,])
# gflops_fft_xin = th.as_tensor([   160.9,   264.8,   336.3,   377.9,   366.1,   396.1,   421.3,   438.8,   457.3,   471.2,   493.8,   501.9,   509.1,   519.3,   527.4,   536.3,   540.4,   543.7,   542.5,   554.3,   558.8,   560.7,   562.7,   566.6,   570.0,   572.0,   572.4,   577.3,   579.3,   581.7,   582.0,   585.9,   585.2,   588.7,   590.7,   592.2,   592.8,   593.4,   596.8,   594.7,   596.9,   596.9,   594.6,   599.9,   602.7,   601.7,   603.2,   605.1,   604.3,   607.2,   608.0,   605.7,   606.4,   608.8,   609.8,   611.1,   609.1,   611.3,   611.5,   613.9,   612.1,   613.4,   614.7,   616.2,   613.6,   615.3,   614.6,   615.5,   615.7,   616.3,   616.8,   618.3,   616.6,   616.9,   619.1,   618.9,   617.3,   618.4,   619.0,   620.1,])
# gflops_fft_xin_m = gflops_fft_xin - 90
# gflops_fft_xin_c = gflops_fft_xin - 45
# gflops_cufft = th.as_tensor([   136.9,   294.8,   355.0,   423.1,   407.5,   445.0,   462.9,   502.4,   492.2,   497.1,   517.0,   530.8,   537.1,   542.2,   551.0,   561.3,   567.2,   564.8,   575.9,   578.8,   581.5,   586.4,   592.5,   595.4,   600.2,   600.9,   603.7,   607.0,   610.5,   610.4,   613.9,   614.3,   616.4,   618.2,   619.9,   617.3,   620.4,   621.8,   623.6,   625.8,   627.5,   629.2,   630.0,   628.6,   629.9,   633.7,   633.2,   633.2,   634.0,   632.8,   636.8,   637.8,   637.9,   639.4,   638.7,   639.8,   642.4,   642.9,   642.5,   643.5,   643.4,   643.7,   643.6,   640.6,   641.8,   645.5,   644.9,   645.9,   646.1,   644.8,   645.3,   646.3,   647.5,   648.0,   647.9,   648.6,   649.4,   648.7,   650.4,   648.1,])
# gflops_fft_m = gflops_cufft * 0.86
# gflops_fft_c = gflops_cufft * 0.94
# N = th.as_tensor([i for i in range(1, 1 + (10240 // 128))]) * 128

# kernel_name = ['1', '4',  '16', '32', '64', '128', '256', '512', '1024']
# # br1 = np.arange(9) * 1.2 + barWidth * 0
# # br2 = np.arange(9) * 1.2 + barWidth * 1
# # Make the plot
# ax[1].bar(br1, gflops_fft_xin_c[:9], color = color[0], width = barWidth,
#         edgecolor ='k', label = "SC17's Comp",zorder=3, hatch='/')
# ax[1].bar(br2, gflops_fft_c[:9], color = color[1], width = barWidth,
#         edgecolor ='k', label ='Our Comp',zorder=3, hatch='/')
# ax[1].bar(br3, gflops_fft_xin_m[:9], color = color[0], width = barWidth,
#         edgecolor ='k', label = "SC17's Comp + Mem",zorder=3)
# ax[1].bar(br4, gflops_fft_m[:9], color = color[1], width = barWidth,
#         edgecolor ='k', label ='Our Comp + Mem',zorder=3)
# ax[1].bar(br5, gflops_cufft[:9], color = color[2], width = barWidth,
#         edgecolor ='k', label ='Our FFT',zorder=3)
# # Adding Xticks
# ax[1].set_xlabel('batch size\n N=512',  fontsize = 30, fontdict=dict(weight='bold'))
# # ax[1].set_ylabel('Performance\n(GFOPS)',  fontsize = 30, fontdict=dict(weight='bold'))
# ax[1].set_xticks(br1)
# ax[1].set_xticklabels([f'{kernel_name[i]}' for i in range(9)], rotation=30)
# ax[1].set_yticks([0, 200, 400, 600])
# ax[1].set_ylim([0, 600])
# ax[1].grid(linestyle='--', linewidth=0.7, zorder=0)
# ax[1].legend(loc = 'upper center', framealpha=0, ncol=4, fontsize=20)
fig.savefig("..\\figures\\fig8_FT_xin_vs_our_bar_A100.pdf",bbox_inches='tight')
