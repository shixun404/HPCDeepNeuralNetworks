import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import torch as th
import seaborn as sns
import numpy as np
import os
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
color = sns.color_palette(n_colors=4)
color1 = sns.color_palette("rocket", n_colors=6)
print(color[3])

ms = 12
N = th.as_tensor([i for i in range(3, 20)])

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

# naive = th.as_tensor([0.056125, 0.063702, 0.078861, 0.099072, 0.082838, 0.111050, 0.117997, 0.114426, 0.151485, 0.256698, 0.169098, 0.191856, 0.231997, 0.306314, 0.488992, 0.821341, 1.657386, 3.241248, 6.555161, 13.729983, 28.424778, 59.347252, 122.738297, 255.389893, 533.874390])
# cufft = th.as_tensor([0.004,0.005,0.005,0.005,0.006,0.007,0.007,0.009,0.014,0.025,0.028,0.021,0.022,0.037,0.044,0.090,0.196,0.390,0.824,2.034,4.406,8.697,17.244,34.181,69])
# vkFFT = th.as_tensor([0.004,0.004,0.004,0.004,0.005,0.005,0.005,0.006,0.008,0.013,0.027,0.012,0.024,0.020,0.022,0.048,0.085,0.203,0.430,0.814,1.971,3.979,8.039,16.148,33.074])
t_fft = th.as_tensor([0.012061,0.009981,0.010178,0.010269,0.010829,0.010860,0.010989,0.012271,0.015668,0.020952,0.037823,0.080734,0.128778,0.126299,0.355640,0.390307,0.876479,])
t_cufft = th.as_tensor([0.010262,0.010318,0.011182,0.011127,0.011532,0.011864,0.013001,0.013342,0.014828,0.020254,0.030830,0.033940,0.027559,0.028283,0.043083,0.080998,0.152974,])
t_vkfft = th.as_tensor([0.011444,0.009925,0.010317,0.010591,0.011094,0.010943,0.010887,0.012145,0.014127,0.018686,0.034755,0.026461,0.055109,0.058862,0.063823,0.110648,0.166978,])
gflops_fft = th.as_tensor([0.009949,0.032060,0.078599,0.186968,0.413699,0.942924,2.096619,4.172534,7.189395,11.729489,14.078191,14.205594,19.084066,41.511585,31.326933,60.447155,56.826626,])
gflops_cufft = th.as_tensor([0.011694,0.031014,0.071541,0.172553,0.388479,0.863092,1.772177,3.837483,7.596193,12.133659,17.271622,33.791241,89.176857,185.370819,258.599274,291.276855,325.592804,])
gflops_vkfft = th.as_tensor([0.010486,0.032242,0.077539,0.181285,0.403819,0.935727,2.116215,4.215852,7.973542,13.152261,15.321014,43.342083,44.595158,89.071068,174.562653,213.225983,298.287689,])


ax[0].plot(N[:11], t_cufft[:11], label="cuFFT", marker='^',markersize=ms,  color = color[0], clip_on=False)
ax[0].plot(N[:11], t_vkfft[:11], label="VkFFT", marker='+',markersize=ms,  color = color[2], clip_on=False)
ax[0].plot(N[:11], t_fft[:11], label="Ours", marker='*',markersize=ms,  color = color[1], clip_on=False)

ax[1].plot(N[:11], gflops_cufft[:11], label="cuFFT", marker='^',markersize=ms,  color = color[0], clip_on=False)
ax[1].plot(N[:11], gflops_vkfft[:11], label="VkFFT", marker='+',markersize=ms,  color = color[2], clip_on=False)
ax[1].plot(N[:11], gflops_fft[:11], label="Ours", marker='*',markersize=ms,  color = color[1], clip_on=False)

ax[0].set_xlabel("log2(N)",fontdict=dict(weight='bold',size=30))
ax[0].set_ylabel("Execution Time (ms)", fontdict=dict(weight='bold'))

ax[0].set_xticks(range(3,14))

plt.suptitle("Performance of C2C-FFT (radix-2 single precision)")

ax[1].set_xlabel("log2(N)",fontdict=dict(weight='bold',size=30))
ax[1].set_ylabel("GFLOPS", fontdict=dict(weight='bold'))
ax[1].set_xticks(range(3,14))
ax[0].grid()
ax[1].grid()
ax[0].legend(loc="upper left", prop={'size': 20, })
ax[1].legend(loc="upper left", prop={'size': 20, })
fig.savefig(f"cuFFT.pdf", bbox_inches='tight')