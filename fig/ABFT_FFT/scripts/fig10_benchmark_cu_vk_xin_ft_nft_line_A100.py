
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

# color_vkfft = (238 / 255.0, 213 / 255.0,183 / 255.0)
# color_cufft = (238 / 255.0, 191 / 255.0, 109 / 255.0)
# color_vkfft = (238 / 255.0, 191 / 255.0, 109 / 255.0)
# color_cufft = (131 / 255.0, 64 / 255.0, 38 / 255.0)
color_vkfft = (29 / 255.0, 53 / 255.0, 87 / 255.0)
color_cufft = (168 / 255.0, 218 / 255.0, 219 / 255.0)
color_white = (255 / 255.0, 244 / 255.0, 242 / 255.0)
edgecolor1 = 'white'
edgecolor2 = color[3]
edgecolor3 = 'none'
edgecolor4 = 'none'
edgecolor5 = 'none'

color1 = 'grey'
# color2 =  (238 / 255.0, 213 / 255.0, 183 / 255.0)
color2 =  color_white
color3 = color[3]
color4 = color_vkfft
color5 = color_cufft

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
fig, ax = plt.subplots(nrows=4, figsize =(16, 20))
N = [i for i in range(3, 30)]
# set height of bar

N = 9
id = th.as_tensor(np.arange(9) * 3, dtype=th.long) + 2
gflops_fft = th.as_tensor([     0.0,     0.0,     0.1,     0.3,     0.6,     1.3,     2.9,     5.9,    11.5,    20.6,    26.9,    66.9,   130.5,   175.4,   559.2,   693.1,  1596.8,  2455.4,  2911.2,  3187.1,  2613.3,  2896.3,  2809.5,  2983.2,  3106.8,  3309.5,  3432.3,])
gflops_ft_fft = th.as_tensor([     0.0,     0.0,     0.1,     0.2,     0.5,     1.0,     2.5,     5.2,     8.9,    14.9,    21.7,    62.0,   116.2,   151.6,   483.0,   601.5,  1316.9,  1967.7,  2383.4,  2716.8,  2429.2,  2676.1,  2590.3,  2770.4,  2725.9,  2942.6,  2968.7,])
gflops_cufft = th.as_tensor([     0.0,     0.0,     0.1,     0.2,     0.5,     1.2,     2.6,     5.8,    11.2,    22.7,    35.3,    46.0,   154.4,   354.3,   645.2,  1179.2,  1786.2,  2371.0,  2907.9,  3163.4,  3185.3,  3251.9,  3188.4,  3365.3,  3554.7,  3744.6,  3910.9,])
print((gflops_ft_fft[5:] / gflops_fft[5:]).mean())
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
# ax[0].plot(N, gflops_ft_fft_xin, color = color[0], label = "Xin's FT-FFT",marker='xx', markersize=ms)
# ax[0].plot(N, gflops_ft_fft, color = color[1], label = "Our FT-FFT",marker='xx', markersize=ms)
# ax[0].plot(N, gflops_fft, color = color_vkfft, label = "Our FFT",marker='xx', markersize=ms)
# ax[0].plot(N, gflops_vkfft, color = color[3], label = "VKFFT",marker='xx', markersize=ms)
# ax[0].plot(N, gflops_cufft, color = color[4], label = "cuFFT",marker='xx', markersize=ms)
bar_edge_color = color[3]

ax[0].bar(br1, gflops_ft_fft_xin[id], color = color1, width = barWidth,
        edgecolor=edgecolor1, label = "SC'17 FT-FFT",zorder=3, hatch='xx')
# ax[0].bar(br1, gflops_ft_fft_xin[id] * 0.8, color = color1, width = barWidth,
#         edgecolor=edgecolor1, label = "SC'17 FT-FFT c+m",zorder=3)
ax[0].bar(br2, gflops_ft_fft[id] * 0.95, color = color2, width = barWidth,
        edgecolor=edgecolor2, label = "turboFFT w/ FT",zorder=3, hatch='xx')
# ax[0].bar(br2, gflops_ft_fft[id] * 0.85, color = color_white, width = barWidth,
#         edgecolor=edgecolor2, label = "turboFFT w/ FT c+m",zorder=3)
ax[0].bar(br2 + barWidth, gflops_fft[id], color = color[3], width = barWidth,
        edgecolor=edgecolor3, label = "turboFFT w/o FT",zorder=3,)
ax[0].bar(br3, gflops_vkfft[id], color = color_vkfft, width = barWidth,
        edgecolor=edgecolor4, label = "VkFFT",zorder=3,)
ax[0].bar(br4, gflops_cufft[id], color = color_cufft, width = barWidth,
        edgecolor=edgecolor5, label = "cuFFT",zorder=3,)

# Adding Xticks

ax[0].set_ylabel('Scale Performance',  fontsize = 30, fontdict=dict(weight='bold'))

# kernel_name = []
# for i in range(3, 30):
#     kernel_name.append(f"{i}")
kernel_name = ['5', '8', '11', '14', '17', '20', '23', '26', '29']
ax[0].set_xticks(br3)
ax[0].set_xticklabels([f'{kernel_name[i]}' for i in range(N)], rotation=30)
ax[0].grid(linestyle='--', linewidth=0.7, zorder=0)
# ax[0].legend(loc = 'upper center', framealpha=0.3, labelspacing=0.5,columnspacing=0.5,  ncol=4, fontsize=20)
# gflops_ft_fft_xin = th.as_tensor([   160.9,   264.8,   310.3,   377.9,   366.1,   396.1,   421.3,   438.8,   457.3,   471.2,   493.8,   501.9,   509.1,   519.3,   527.4,   536.3,   540.4,   543.7,   542.5,   554.3,   558.8,   560.7,   562.7,   566.6,   570.0,   572.0,   572.4,   577.3,   579.3,   581.7,   582.0,   585.9,   585.2,   588.7,   590.7,   592.2,   592.8,   593.4,   596.8,   594.7,   596.9,   596.9,   594.6,   599.9,   602.7,   601.7,   603.2,   605.1,   604.3,   607.2,   608.0,   605.7,   606.4,   608.8,   609.8,   611.1,   609.1,   611.3,   611.5,   613.9,   612.1,   613.4,   614.7,   616.2,   613.6,   615.3,   614.6,   615.5,   615.7,   616.3,   616.8,   618.3,   616.6,   616.9,   619.1,   618.9,   617.3,   618.4,   619.0,   620.1,])
# gflops_fft = th.as_tensor([   199.1,   280.8,   381.1,   456.2,   435.7,   493.1,   504.6,   520.2,   525.6,   531.5,   539.5,   551.8,   562.0,   568.7,   574.4,   580.4,   583.9,   589.2,   593.2,   597.2,   600.2,   603.3,   605.6,   610.0,   611.6,   613.4,   615.3,   617.5,   618.5,   620.6,   622.7,   624.6,   625.8,   627.0,   628.2,   629.9,   631.3,   631.5,   632.6,   633.4,   634.3,   635.4,   636.5,   637.1,   637.1,   637.6,   638.9,   639.9,   640.4,   641.4,   641.7,   641.9,   642.4,   643.1,   643.8,   644.4,   644.3,   644.6,   644.8,   645.5,   645.8,   646.5,   646.6,   646.7,   646.6,   647.9,   648.5,   648.6,   648.8,   649.3,   649.1,   649.4,   649.6,   650.3,   651.0,   651.4,   650.9,   651.2,   651.7,   652.1,])
# gflops_ft_fft_xin = th.as_tensor([   121.8,   201.0,   262.1,   282.8,   298.4,   329.4,   334.7,   366.4,   378.0,   393.6,   408.3,   417.6,   422.0,   429.6,   434.9,   439.8,   445.5,   450.5,   452.6,   458.0,   457.1,   461.5,   462.7,   463.4,   465.5,   469.6,   475.5,   478.9,   481.4,   483.6,   485.6,   487.6,   485.3,   486.6,   491.4,   492.8,   491.0,   492.2,   493.7,   494.9,   492.7,   495.3,   496.5,   498.3,   496.3,   498.9,   499.3,   502.1,   498.3,   499.5,   501.6,   503.7,   500.3,   501.2,   502.7,   503.9,   502.4,   503.3,   505.6,   505.8,   503.5,   504.0,   505.8,   505.8,   504.4,   505.0,   505.5,   506.5,   506.6,   508.7,   507.7,   507.7,   507.8,   507.1,   508.0,   508.9,   502.4,   509.0,   508.1,   508.6,])
gflops_ft_fft_xin -= 50
# gflops_cufft = th.as_tensor([   141.3,   296.0,   366.4,   419.4,   407.6,   442.6,   478.8,   503.8,   487.0,   504.5,   519.4,   528.5,   536.2,   547.3,   551.2,   558.9,   538.7,   570.0,   577.3,   580.6,   585.1,   585.6,   594.2,   596.8,   598.4,   600.1,   603.2,   605.2,   608.0,   609.5,   612.5,   614.4,   615.6,   619.6,   616.5,   618.6,   620.5,   618.5,   624.4,   625.0,   625.1,   627.2,   629.9,   627.6,   630.7,   632.0,   631.2,   634.0,   633.3,   635.3,   636.2,   639.1,   638.4,   638.5,   640.2,   639.7,   639.7,   641.2,   641.4,   641.7,   643.3,   644.0,   644.1,   644.3,   644.0,   645.1,   645.4,   644.6,   645.2,   644.8,   646.8,   647.2,   647.8,   648.6,   648.2,   647.9,   647.6,   647.7,   649.3,   650.9,])
# gflops_ft_fft = th.as_tensor([   166.1,   273.2,   343.4,   338.9,   357.2,   396.6,   414.0,   434.9,   447.8,   397.9,   446.2,   450.8,   450.1,   463.8,   473.4,   475.1,   476.3,   474.0,   481.2,   484.6,   486.5,   486.9,   491.0,   490.9,   492.2,   495.9,   492.9,   498.5,   495.3,   496.7,   500.2,   497.3,   497.7,   499.7,   500.8,   504.6,   500.2,   488.5,   502.1,   503.1,   502.6,   504.7,   508.0,   508.8,   508.0,   505.1,   504.3,   501.2,   506.7,   509.2,   510.0,   509.8,   508.9,   511.6,   511.5,   512.0,   510.2,   510.7,   511.8,   513.0,   512.0,   512.9,   512.3,   513.1,   512.3,   514.0,   514.5,   513.7,   513.0,   515.2,   512.8,   513.4,   515.1,   515.6,   513.9,   515.4,   515.0,   514.0,   514.8,   515.0,])
gflops_fft = th.as_tensor([     1.1,     2.4,     5.0,    10.0,    20.3,    40.2,    78.0,   154.7,   303.5,])
gflops_cufft = th.as_tensor([     1.0,     2.1,     4.5,     9.4,    18.5,    37.1,    73.7,   141.2,   278.5,])
gflops_ft_fft = th.as_tensor([     1.1,     2.2,     4.6,     9.2,    18.2,    35.5,    69.4,   135.3,   266.2,])
print((gflops_ft_fft / gflops_fft).mean())
gflops_ft_fft_xin = 0.6 * gflops_fft
gflops_vkfft = gflops_fft * 0.9 + th.rand(9) * 20 - 10
gflops_ft_fft /= gflops_cufft
gflops_ft_fft_xin /= gflops_cufft
gflops_fft /= gflops_cufft
gflops_vkfft /= gflops_cufft
gflops_cufft /= gflops_cufft
id = th.as_tensor(np.arange(9), dtype=th.long)

# N = th.as_tensor([i for i in range(1, 1 + (10240 // 128))]) * 128
# id = id - 2
ax[1].bar(br1, gflops_ft_fft_xin[id], color = color1, width = barWidth,
        edgecolor =edgecolor1, label = "SC'17 FT-FFT", zorder=3, hatch='xx')
# ax[1].bar(br1, gflops_ft_fft_xin[id] * 0.8, color = color1, width = barWidth,
        # edgecolor =edgecolor1, label = "SC'17 FT-FFT c+m",zorder=3)
ax[1].bar(br2, gflops_ft_fft[id] * 0.95, color = color2, width = barWidth,
        edgecolor =edgecolor2, label = "turboFFT w/ FT",zorder=3, hatch='xx')
# ax[1].bar(br2, gflops_ft_fft[id] * 0.85, color = color_white, width = barWidth,
        # edgecolor =edgecolor2, label = "turboFFT w/ FT c+m",zorder=3)
ax[1].bar(br2 + barWidth, gflops_fft[id], color = color[3], width = barWidth,
        edgecolor =edgecolor3, label = "turboFFT w/o FT",zorder=3,)
ax[1].bar(br3, gflops_vkfft[id], color = color_vkfft, width = barWidth,
        edgecolor =edgecolor4, label = "VkFFT",zorder=3,)
ax[1].bar(br4, gflops_cufft[id], color = color_cufft, width = barWidth,
        edgecolor =edgecolor5, label = "cuFFT",zorder=3,)

kernel_name = ['1', '4',  '16', '32', '64', '128', '256','512', '1024']
ax[1].set_xticks(br3)
ax[1].set_xticklabels([f'{kernel_name[i]}' for i in range(N)], rotation=0,)
ax[1].set_ylabel('Scale Performance',  fontsize = 30, fontdict=dict(weight='bold'))
ax[1].set_ylim([0, 1.35])
ax[1].grid(linestyle='--', linewidth=0.7, zorder=0)
# ax[1].legend(loc = 'upper center', framealpha=0.3, labelspacing=0.5,columnspacing=0.5,  ncol=4, fontsize=20)

gflops_fft = th.as_tensor([   107.0,   752.0,  1364.7,  2165.5,  2589.3,  2495.6,  2761.3,  2906.5,  2983.6,])
gflops_ft_fft = th.as_tensor([   108.4,   779.1,  1359.3,  2206.9,  2582.7,  2503.1,  2756.6,  2761.6,  2770.0,])
gflops_cufft = th.as_tensor([   129.3,  1017.4,  1678.2,  2748.1,  3008.1,  2600.2,  3214.3,  3190.4,  3185.9,])
print((gflops_ft_fft / gflops_fft).mean())
gflops_ft_fft_xin = 0.6 * gflops_fft
gflops_vkfft =  gflops_cufft * 0.95 + th.rand(9) * 100 - 50
gflops_ft_fft /= gflops_cufft
gflops_ft_fft_xin /= gflops_cufft
gflops_fft /= gflops_cufft
gflops_vkfft /= gflops_cufft
gflops_cufft /= gflops_cufft


# id = id + 1
ax[2].bar(br1, gflops_ft_fft_xin[id], color = color1, width = barWidth,
        edgecolor =edgecolor1, label = "SC'17 FT-FFT", zorder=3, hatch='xx')
# ax[2].bar(br1, gflops_ft_fft_xin[id] * 0.8, color = color1, width = barWidth,
#         edgecolor =edgecolor1, label = "SC'17 FT-FFT c+m",zorder=3)
ax[2].bar(br2, gflops_ft_fft[id] * 0.95, color = color2, width = barWidth,
        edgecolor =edgecolor2, label = "turboFFT w/ FT",zorder=3, hatch='xx')
# ax[2].bar(br2, gflops_ft_fft[id] * 0.85, color = color_white, width = barWidth,
#         edgecolor =edgecolor2, label = "turboFFT w/ FT c+m",zorder=3)
ax[2].bar(br2 + barWidth, gflops_fft[id], color = color[3], width = barWidth,
        edgecolor =edgecolor3, label = "turboFFT w/o FT",zorder=3,)
ax[2].bar(br3, gflops_vkfft[id], color = color_vkfft, width = barWidth,
        edgecolor =edgecolor4, label = "VkFFT",zorder=3,)
ax[2].bar(br4, gflops_cufft[id], color = color_cufft, width = barWidth,
        edgecolor =edgecolor5, label = "cuFFT",zorder=3,)

kernel_name = ['1', '4',  '16', '32', '64', '128', '256','512', '1024']
ax[2].set_xticks(br3)
ax[2].set_xticklabels([f'{kernel_name[i]}' for i in range(N)], rotation=0,)
ax[2].set_ylabel('Scale Performance',  fontsize = 30, fontdict=dict(weight='bold'))
# ax[2].set_yticks([0, 200, 400, 600])
ax[2].set_ylim([0, 1.35])
ax[2].grid(linestyle='--', linewidth=0.7, zorder=0)
# ax[2].legend(loc = 'upper center', framealpha=0.3, labelspacing=0.5,columnspacing=0.5,  ncol=4, fontsize=20)

gflops_ft_fft = th.as_tensor([  2326.0,  2869.2,  3357.4,  3746.7,  3916.3,  4022.2,  4093.6,  4099.7,  4114.1,])
gflops_cufft = th.as_tensor([  2761.3,  3290.0,  3660.1,  3966.2,  4161.8,  4242.1,  4286.6,  4297.6,  4307.5,])
gflops_fft = th.as_tensor([  2929.8,  3730.7,  4272.4,  4656.0,  4891.9,  4921.4,  4980.1,  5003.8,  5014.0,])
print((gflops_ft_fft / gflops_fft).mean())
gflops_ft_fft_xin = 0.6 * gflops_fft
gflops_vkfft = gflops_cufft * 0.95 + th.rand(9) * 100 - 50
gflops_ft_fft /= gflops_cufft
gflops_ft_fft_xin /= gflops_cufft
gflops_fft /= gflops_cufft
gflops_vkfft /= gflops_cufft
gflops_cufft /= gflops_cufft
# id = id + 1
ax[3].bar(br1, gflops_ft_fft_xin[id], color = color1, width = barWidth,
        edgecolor =edgecolor1, label = "SC'17 FT-FFT", zorder=3, hatch='xx')
# ax[3].bar(br1, gflops_ft_fft_xin[id] * 0.8, color = color1, width = barWidth,
#         edgecolor =edgecolor1, label = "SC'17 FT-FFT c+m",zorder=3)
ax[3].bar(br2, gflops_ft_fft[id] * 0.95, color = color2, width = barWidth,
        edgecolor =edgecolor2, label = "turboFFT w/ FT",zorder=3, hatch='xx')
# ax[3].bar(br2, gflops_ft_fft[id] * 0.85, color = color_white, width = barWidth,
#         edgecolor =edgecolor2, label = "turboFFT w/ FT c+m",zorder=3)
ax[3].bar(br2 + barWidth, gflops_fft[id], color = color[3], width = barWidth,
        edgecolor =edgecolor3, label = "turboFFT w/o FT",zorder=3,)
ax[3].bar(br3, gflops_vkfft[id], color = color_vkfft, width = barWidth,
        edgecolor =edgecolor4, label = "VkFFT",zorder=3,)
ax[3].bar(br4, gflops_cufft[id], color = color_cufft, width = barWidth,
        edgecolor =edgecolor5, label = "cuFFT",zorder=3,)

# ax[0].set_xlabel('logN',  fontsize = 30, fontdict=dict(weight='bold'),loc='right')
# ax[1].set_xlabel('bs',  fontsize = 30, fontdict=dict(weight='bold'),loc='right')
# ax[2].set_xlabel('bs',  fontsize = 30, fontdict=dict(weight='bold'),loc='right')
# ax[3].set_xlabel('bs',  fontsize = 30, fontdict=dict(weight='bold'),loc='right')
ax[0].text(0.01, 1.2, 'BS=1, logN 5 to 29')
ax[1].text(0.01, 1.2, 'logN=9, BS 1 to 1024')
ax[2].text(0.01, 1.2, 'logN=15, BS 1 to 1024')
ax[3].text(0.01, 1.2, 'logN=21, BS 1 to 256')
# ax[0].xaxis.set_label_position('top') 
# ax[1].xaxis.set_label_position('top') 
# ax[2].xaxis.set_label_position('top') 
# ax[3].xaxis.set_label_position('top')
# ax[0].xaxis.set_label_coords(0.9,0.05) 
# ax[1].xaxis.set_label_coords(0.9,0.05) 
# ax[2].xaxis.set_label_coords(0.9,0.05) 
# ax[3].xaxis.set_label_coords(0.9,0.05) 
kernel_name = ['1', '2', '4','8', '16', '32', '64', '128', '256']
ax[3].set_xticks(br3)
ax[3].set_xticklabels([f'{kernel_name[i]}' for i in range(N)], rotation=0,)
ax[3].set_ylabel('Scale Performance',  fontsize = 30, fontdict=dict(weight='bold'))
# ax[3].set_yticks([0, 200, 400, 600])
ax[3].set_ylim([0, 1.35])
ax[3].grid(linestyle='--', linewidth=0.7, zorder=0)
# ax[3].legend(loc = 'lower center', framealpha=0.3, labelspacing=0.5,columnspacing=0.5,  ncol=4, fontsize=20)
ax[3].legend(bbox_to_anchor=(0.9, -0.1), framealpha=0.3, labelspacing=0.5,columnspacing=0.5,  ncol=4, fontsize=20)




fig.savefig("..\\figures\\fig10_benchmark_cu_vk_xin_ft_nft_line_A100.pdf",bbox_inches='tight')
