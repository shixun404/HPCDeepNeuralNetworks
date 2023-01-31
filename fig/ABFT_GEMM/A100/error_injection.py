import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import torch as th
import seaborn as sns
color = sns.color_palette(n_colors=5)
ms = 6
N = th.as_tensor([i for i in range(256, 10240+256, 256)])
def print_average(tensor, name):
    avg = (tensor.sum() - tensor.max() - tensor.min()) / tensor.shape[0]
    print(name, avg)
    print(tensor.sort())
plt.rc('font', size=24, weight='bold')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(nrows=1, ncols=2, figsize=(16, 5), )
plt.tight_layout()
fig.subplots_adjust(hspace=0.2, wspace = 0.2)


cublas = th.as_tensor([  919.96, 5851.43,11415.95,14468.11,15799.42,16368.84,16274.87,17270.28,18638.37,17917.27,18549.37,18224.07,17676.34,18227.88,18500.76,18668.84,18511.42,18460.13,18627.66,18783.74,18667.15,18700.19,18558.01,18788.45,18704.32,18668.67,19021.89,18729.35,18777.14,18811.54,18905.08,18996.63,18876.12,19009.90,18824.97,19031.90,18845.19,18702.80,18874.12,18882.68,])
kernel_sgemm_huge = th.as_tensor([  495.02, 2336.40, 5534.79,10063.11,15802.47,11977.13,16356.58,14571.78,16372.21,17183.46,16703.06,16690.43,16806.06,17114.84,17480.75,17885.44,18313.37,18781.90,18099.55,18621.22,18219.47,18558.45,18551.75,18357.12,17881.65,18312.80,18858.82,18426.82,18407.41,18670.75,18774.36,18864.83,18747.59,18876.11,18795.49,18644.73,18888.47,18835.72,18845.59,18837.43,])
abft_kernel_huge_err_injec =th.as_tensor([  413.65, 1894.79, 4452.62, 8070.63,12645.88,10101.17,13848.48,10863.26,15686.81,14763.35,14445.62,14445.41,14220.92,14870.65,15200.19,15370.88,15948.21,16361.84,15790.84,16230.82,15921.37,16369.82,16184.57,16107.30,16039.90,16031.75,16431.12,16125.86,16222.47,16337.08,16424.73,16506.51,16413.71,16519.65,16463.23,16558.01,16550.00,16505.31,16510.35,16505.63,])
abft_kernel_huge = th.as_tensor([  434.34, 2025.84, 4766.90, 8644.48,13249.23,10618.69,14378.18,12985.96,16362.68,15345.49,14428.18,14985.60,15123.27,15361.62,15719.70,16073.50,16495.81,16889.35,16303.66,16772.01,16309.46,16814.47,15935.39,16622.23,16558.19,16540.57,16951.33,16637.63,16733.35,16848.01,16951.33,17027.72,16925.27,17051.21,16975.99,17078.35,17079.90,17024.56,17027.39,17017.98,])
l = N.shape[0]
roofline_model = th.ones_like(N) * 19500
print_average((cublas - abft_kernel_huge_err_injec) / cublas, "cublas")
print_average((kernel_sgemm_huge - abft_kernel_huge_err_injec) / kernel_sgemm_huge, "sgemm")
print_average((abft_kernel_huge - abft_kernel_huge_err_injec) / abft_kernel_huge, "no error injection")

ax[0].plot(N, cublas[:l] / 1000,  label="cublas SGEMM", marker='o', markersize=ms, color = color[1], clip_on=False)
ax[0].plot(N, kernel_sgemm_huge[:l] / 1000,  label="SGEMM (Ours)", marker='P',markersize=ms, color = color[2], clip_on=False)
ax[0].plot(N, abft_kernel_huge[:l] / 1000,  label="ABFT SGEMM: Ori", marker='s',markersize=ms,  color = color[3], clip_on=False)
ax[0].plot(N, abft_kernel_huge_err_injec[:l] / 1000, '--', label="ABFT SGEMM: error injected", marker='^',markersize=ms,  color =  'purple', clip_on=False)
ax[0].plot(N, roofline_model[:l] / 1000,  label="roofline", marker='x', markersize=ms, color = 'k', clip_on=False)
ax[0].set_xlabel("(a) Matrix Sizes M=N=K",fontdict=dict(weight='bold',  size=30))
ax[0].set_ylabel("Performance (TFLOPS)", fontdict=dict(weight='bold'))
# ax[0].set_xscale("log", base=2)
ax[0].set_xlim(0, 10240)
xticks = [256, 2000, 4000, 6000, 8000, 10000]#[256, 512, 1024, 2048, 4096, 8192]
ax[0].set_xticks(xticks)
yticks = [1, 2, 3, 4, 5, 5.6]
# ax[0].set_yticks(yticks)
ylabels = ['1', '2', '3', '4', '5', '8.1']
# ax[0].set_yticklabels(ylabels)
# ax[0].set_xticklabels([f'{s}' for s in xticks])

ax[0].grid()
ax[0].legend(loc="lower right", prop={'size': 18, })
cublas = th.as_tensor([ 2854.34, 8028.91,12365.28,14189.12,10505.93,15762.79,15239.12,16401.62,17584.81,17197.66,17722.33,17342.98,17271.19,17516.78,17743.87,18135.08,16318.36,18838.78,18692.39,18653.29,18632.23,18714.08,18488.16,17978.80,18490.22,18516.20,18827.88,18401.34,18782.48,18829.93,18288.10,18835.59,18531.07,18870.08,18815.19,18840.25,18861.86,18846.89,18792.61,18882.37,])
kernel_sgemm_huge = th.as_tensor([  627.44, 2530.96, 5686.42,10067.94,15442.04,11792.06,15932.84,14221.60,17785.13,16624.01,16356.12,16316.72,16472.94,16756.42,15382.43,17536.09,17937.21,18364.65,17710.11,18185.82,17852.48,18085.86,18198.95,18093.84,18029.16,17275.23,18503.21,18136.17,17670.69,18334.60,18422.24,18514.83,18364.30,18497.69,18389.70,18561.40,18531.67,18524.35,18533.44,18521.25,])
abft_kernel_huge = th.as_tensor([  544.04, 2189.55, 4934.73, 8727.22,13468.15,10550.23,14278.63,12738.96,15969.96,15007.96,14710.80,14697.95,14845.13,15107.83,15348.01,15800.73,16199.37,16610.21,16020.92,16480.57,16154.82,16628.79,16442.08,16343.74,16278.84,16275.66,16737.43,16372.91,16456.89,16561.34,16659.64,16642.41,16643.14,16422.45,16657.58,16793.64,16771.36,16714.77,16740.18,16731.57,])
abft_kernel_huge_err_injec = th.as_tensor([  504.11, 2028.98, 4563.44, 8078.40,12445.12,10037.42,13571.11,10587.67,15304.64,14448.77,14178.18,14160.38,14018.40,14568.10,14890.41,15198.13,15681.65,16135.62,15450.19,15920.32,15611.82,16070.23,15891.89,15771.52,15471.49,15728.45,16173.10,15830.98,15921.13,16022.60,16101.78,16197.84,15639.88,16199.81,16148.45,16237.18,16193.34,16093.26,16196.78,16190.54,])
l = N.shape[0]
roofline_model = th.ones_like(N) * 19500

ax[1].plot(N, cublas[:l] / 1000,  label="cublas SGEMM", marker='o', markersize=ms, color = color[1], clip_on=False)
ax[1].plot(N, kernel_sgemm_huge[:l] / 1000,  label="SGEMM (Ours)", marker='P',markersize=ms, color = color[2], clip_on=False)
ax[1].plot(N, abft_kernel_huge[:l] / 1000,  label="ABFT SGEMM: Ori", marker='s',markersize=ms,  color = color[3], clip_on=False)
ax[1].plot(N, abft_kernel_huge_err_injec[:l] / 1000, '--', label="ABFT SGEMM: error injected", marker='^',markersize=ms,  color = 'purple', clip_on=False)
ax[1].plot(N, roofline_model[:l] / 1000,  label="roofline", marker='x', markersize=ms, color = 'k', clip_on=False)

ax[1].set_xlabel("(b) Matrix Sizes M=K, K=1024", fontdict=dict(weight='bold', size=30))
ax[1].set_ylabel("Performance (TFLOPS)", fontdict=dict(weight='bold'))
# ax[1].set_xscale("log", base=2)
ax[1].set_xlim(0, 10240)
xticks = [256, 2000, 4000, 6000, 8000, 10000]#[256, 512, 1024, 2048, 4096, 8192]
ax[1].set_xticks(xticks)
# ax[1].set_xticklabels([f'{s}' for s in xticks])
yticks = [1, 2, 3, 4, 5, 5.6]
# ax[1].set_yticks(yticks)
ylabels = ['1', '2', '3', '4', '5', '8.1']
# ax[1].set_yticklabels(ylabels)

ax[1].grid()
ax[1].legend(loc="lower right", prop={'size': 18})
fig.savefig(f"A100_error_injection.pdf", bbox_inches='tight')
print_average((cublas - abft_kernel_huge_err_injec) / cublas, "cublas")
print_average((kernel_sgemm_huge - abft_kernel_huge_err_injec) / kernel_sgemm_huge, "sgemm")
print_average((abft_kernel_huge - abft_kernel_huge_err_injec) / abft_kernel_huge, "no error injection")
