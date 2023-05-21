import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import torch as th
import seaborn as sns
import numpy as np
color = sns.color_palette(n_colors=4)
color1 = sns.color_palette("rocket", n_colors=6)
print(color[3])

ms = 12
N = th.as_tensor([i for i in range(4, 29)])

plt.rc('font', size=24, weight='bold')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(ncols=2, figsize=(12, 6), )
plt.tight_layout()
fig.subplots_adjust(hspace=0.2, wspace = 0.2)
def print_average(tensor, name):
    print(f"############## {name} #################")
    avg = (tensor.sum() - tensor.max() - tensor.min()) / tensor.shape[0]
    print(name, avg)
    print(tensor.sort())
roofline = th.ones_like(N) * 8100
for i in range(roofline.shape[0]):
    roofline[i] = min(np.log2(N[i]) * 625, 8100)

naive = th.as_tensor([0.056125, 0.063702, 0.078861, 0.099072, 0.082838, 0.111050, 0.117997, 0.114426, 0.151485, 0.256698, 0.169098, 0.191856, 0.231997, 0.306314, 0.488992, 0.821341, 1.657386, 3.241248, 6.555161, 13.729983, 28.424778, 59.347252, 122.738297, 255.389893, 533.874390])
cufft = th.as_tensor([0.004,0.005,0.005,0.005,0.006,0.007,0.007,0.009,0.014,0.025,0.028,0.021,0.022,0.037,0.044,0.090,0.196,0.390,0.824,2.034,4.406,8.697,17.244,34.181,69])
vkFFT = th.as_tensor([0.004,0.004,0.004,0.004,0.005,0.005,0.005,0.006,0.008,0.013,0.027,0.012,0.024,0.020,0.022,0.048,0.085,0.203,0.430,0.814,1.971,3.979,8.039,16.148,33.074])
# cufft = th.as_tensor([0.015385, 0.047610, 0.109709, 0.261780, 0.674963, 1.431127, 2.658249, 5.459904, 9.465122, 15.464684, 30.311232, 76.425512, 139.819078, 198.370471, 244.845907, 314.199192, 323.557877, 391.431077, 418.505137, 491.834592, 485.917895, 468.761672, 522.807357, 526.686973, 541.703822, 550.155578])
# l = N.shape[0]
print(vkFFT.shape)
print(cufft.shape)
print(N[1:-1].shape)
# roofline_model = th.ones_like(N) * 5600
print("\n\n #########################   M=N=K  #########################################")

ax[0].plot(N[:18], cufft[:18], label="cuFFT", marker='^',markersize=ms,  color = color[0], clip_on=False)
ax[0].plot(N[:18], vkFFT[1:19], label="VkFFT", marker='+',markersize=ms,  color = color[2], clip_on=False)
ax[0].plot(N[:18], naive[:18], label="Ours", marker='*',markersize=ms,  color = color[1], clip_on=False)
ax[1].plot(N[18:-1], cufft[18:-1], label="cuFFT", marker='^',markersize=ms,  color = color[0], clip_on=False)
ax[1].plot(N[18:-1], vkFFT[19:], label="VkFFT", marker='+',markersize=ms,  color = color[2], clip_on=False)
ax[1].plot(N[18:-1], naive[18:-1], label="Ours", marker='*',markersize=ms,  color = color[1], clip_on=False)
# ax.plot(N[:16], cufft[:16], label="cuFFT c2c", marker='^',markersize=ms,  color = color[0], clip_on=False)
# ax.plot(N[:16], naive[:16], label="ours c2c", marker='*',markersize=ms,  color = color[1], clip_on=False)
# ax.plot(N, roofline, label="roofline", marker='^',markersize=ms,  color = color[1], clip_on=False)
ax[0].set_xlabel("log(N)",fontdict=dict(weight='bold',size=30))
ax[0].set_ylabel("Execution Time (ms)", fontdict=dict(weight='bold'))
plt.suptitle("Performance of C2C-FFT (single precision)")

ax[1].set_xlabel("log(N)",fontdict=dict(weight='bold',size=30))
ax[1].set_ylabel("Execution Time (ms)", fontdict=dict(weight='bold'))
# ax[1].set_title("single precision C2C")
# ax.set_xscale("log", base=2)
# ax.set_xlim(0, 10240)
# xticks = [256, 2000, 4000, 6000, 8000, 10000]#[256, 512, 1024, 2048, 4096, 8192]
# ax.set_xticks(xticks)
# yticks = [1, 2, 3, 4]
# ax.set_yticks(yticks)
# ylabels = ['1', '2', '3', '4']
# ax.set_yticklabels(ylabels)
# ax.set_xticklabels([f'{s}' for s in xticks])
# ax.set_yscale('log', base=10)
ax[0].grid()
ax[1].grid()
ax[0].legend(loc="upper left", prop={'size': 20, })
ax[1].legend(loc="upper left", prop={'size': 20, })
fig.savefig(f"cuFFT.pdf", bbox_inches='tight')