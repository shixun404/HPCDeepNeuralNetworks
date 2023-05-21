import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import torch as th
import seaborn as sns
import matplotlib
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42
color = sns.color_palette(n_colors=5)
ms = 9
N = th.as_tensor([i for i in range(256, 10240+256, 256)])

plt.rc('font', size=40, weight='bold')
plt.rcParams['lines.linewidth'] = 3
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(nrows=1, ncols=2, figsize=(18, 7), )
plt.tight_layout()
fig.subplots_adjust(hspace=0.1, wspace = 0.1)
def print_average(tensor, name):
    print(f"############## {name} #################")
    avg = (tensor.sum() - tensor.max() - tensor.min()) / tensor.shape[0]
    print(name, avg)
    print(tensor.sort())
cublas = th.as_tensor([  919.96, 5851.43,11415.95,14468.11,15799.42,16368.84,16274.87,17270.28,18638.37,17917.27,18549.37,18224.07,17676.34,18227.88,18500.76,18668.84,18511.42,18460.13,18627.66,18783.74,18667.15,18700.19,18558.01,18788.45,18704.32,18668.67,19021.89,18729.35,18777.14,18811.54,18905.08,18996.63,18876.12,19009.90,18824.97,19031.90,18845.19,18702.80,18874.12,18882.68,])
kernel_sgemm_huge = th.as_tensor([  495.02, 2336.40, 5534.79,10063.11,15802.47,11977.13,16356.58,14571.78,16372.21,17183.46,16703.06,16690.43,16806.06,17114.84,17480.75,17885.44,18313.37,18781.90,18099.55,18621.22,18219.47,18558.45,18551.75,18357.12,17881.65,18312.80,18858.82,18426.82,18407.41,18670.75,18774.36,18864.83,18747.59,18876.11,18795.49,18644.73,18888.47,18835.72,18845.59,18837.43,])
abft_baseline = th.as_tensor([  181.08,  698.77, 1391.75, 2513.21, 3541.34, 4938.09, 6318.28, 6178.09, 8965.03, 9487.66,10160.29,10660.17,10607.27,11070.22,10781.90,12001.30,12117.66,11781.59,12574.61,12736.41,12421.08,13081.66,13360.65,13287.60,13767.49,13591.24,14061.82,13835.32,13991.88,14108.60,13304.48,14372.90,14397.49,14460.01,14435.18,14592.39,14511.97,14646.73,14701.29,13974.82,])
abft_kernel_huge = th.as_tensor([  434.34, 2025.84, 4766.90, 8644.48,13249.23,10618.69,14378.18,12985.96,16362.68,15345.49,14428.18,14985.60,15123.27,15361.62,15719.70,16073.50,16495.81,16889.35,16303.66,16772.01,16309.46,16814.47,15935.39,16622.23,16558.19,16540.57,16951.33,16637.63,16733.35,16848.01,16951.33,17027.72,16925.27,17051.21,16975.99,17078.35,17079.90,17024.56,17027.39,17017.98,])
l = N.shape[0]
roofline_model = th.ones_like(N) * 19500
print("\n\n #########################   M=N=K  #########################################")
print_average((cublas - kernel_sgemm_huge) / cublas, "cublas vs sgemm")
print_average((kernel_sgemm_huge - abft_kernel_huge) / kernel_sgemm_huge, "sgemm vs abft")
print_average((cublas - abft_kernel_huge) / cublas, "cublas vs abft")
print_average((abft_baseline - abft_kernel_huge) / abft_baseline, "non-fused ABFT SGEMM vs abft")
ax[0].plot(N, roofline_model[:l] / 1000,  label="Roofline", marker='x', markersize=ms, color = 'k', clip_on=False)
ax[0].plot(N, cublas[:l] / 1000,  label="cuBLAS", marker='o', markersize=ms, color = color[1], clip_on=False)
ax[0].plot(N, kernel_sgemm_huge[:l] / 1000,  label="Our fused FT: off", marker='P',markersize=ms, color = color[2], clip_on=False)
ax[0].plot(N, abft_baseline[:l] / 1000, label="Ding et al. 2011: FT on", marker='^',markersize=ms,  color = color[0], clip_on=False)
ax[0].plot(N, abft_kernel_huge[:l] / 1000,  label="Our fused FT: on", marker='s',markersize=ms,  color = color[3], clip_on=False)

ax[0].set_xlabel("(a) Matrix Sizes M=N=K",fontdict=dict(weight='bold',  size=40))
ax[0].set_ylabel("Perf. (TFLOPS)", fontdict=dict(weight='bold'))
# ax[0].set_xscale("log", base=2)
ax[0].set_xlim(0, 10240)
xticks = [0, 2000, 4000, 6000, 8000, 10000]#[256, 512, 1024, 2048, 4096, 8192]
ax[0].set_xticks(xticks)
ax[0].set_xticklabels(['0','2k','4k','6k','8k','10k',])
yticks = [1, 2, 3, 4, 5, 5.6]
# ax[0].set_yticks(yticks)
ylabels = ['1', '2', '3', '4', '5', '8.1']
# ax[0].set_yticklabels(ylabels)
# ax[0].set_xticklabels([f'{s}' for s in xticks])

ax[0].grid()
ax[0].legend(loc="lower right", prop={'size': 30, },labelspacing=0,bbox_to_anchor=(1.02,-0.03))
cublas = th.as_tensor([ 2854.34, 8028.91,12365.28,14189.12,10505.93,15762.79,15239.12,16401.62,17584.81,17197.66,17722.33,17342.98,17271.19,17516.78,17743.87,18135.08,16318.36,18838.78,18692.39,18653.29,18632.23,18714.08,18488.16,17978.80,18490.22,18516.20,18827.88,18401.34,18782.48,18829.93,18288.10,18835.59,18531.07,18870.08,18815.19,18840.25,18861.86,18846.89,18792.61,18882.37,])
kernel_sgemm_huge = th.as_tensor([  627.44, 2530.96, 5686.42,10067.94,15442.04,11792.06,15932.84,14221.60,17785.13,16624.01,16356.12,16316.72,16472.94,16756.42,15382.43,17536.09,17937.21,18364.65,17710.11,18185.82,17852.48,18085.86,18198.95,18093.84,18029.16,17275.23,18503.21,18136.17,17670.69,18334.60,18422.24,18514.83,18364.30,18497.69,18389.70,18561.40,18531.67,18524.35,18533.44,18521.25,])
abft_baseline = th.as_tensor([  175.35,  548.56, 1389.05, 2509.61, 3551.89, 4885.94, 6211.64, 7285.89, 9011.83, 9537.02,10130.44, 9449.00,10579.66,11092.21,11595.87,12026.03,11323.12,12319.91,12635.72,12127.03,12903.26,12572.11,13345.86,13681.17,13395.25,13893.43,13765.94,13900.35,14164.67,12768.07,14359.67,14359.98,14401.19,14430.61,14509.07,14463.12,14651.43,14555.94,13681.91,14755.63,])
abft_kernel_huge = th.as_tensor([  544.04, 2189.55, 4934.73, 8727.22,13468.15,10550.23,14278.63,12738.96,15969.96,15007.96,14710.80,14697.95,14845.13,15107.83,15348.01,15800.73,16199.37,16610.21,16020.92,16480.57,16154.82,16628.79,16442.08,16343.74,16278.84,16275.66,16737.43,16372.91,16456.89,16561.34,16659.64,16642.41,16643.14,16422.45,16657.58,16793.64,16771.36,16714.77,16740.18,16731.57,])
l = N.shape[0]

roofline_model = th.ones_like(N) * 19500
ax[1].plot(N, roofline_model[:l] / 1000,  label="Roofline", marker='x', markersize=ms, color = 'k', clip_on=False)
ax[1].plot(N, cublas[:l] / 1000,  label="cuBLAS", marker='o', markersize=ms, color = color[1], clip_on=False)
ax[1].plot(N, kernel_sgemm_huge[:l] / 1000,  label="Our fused FT: off", marker='P',markersize=ms, color = color[2], clip_on=False)
ax[1].plot(N, abft_baseline[:l] / 1000, label="Ding et al. 2011: FT on", marker='^',markersize=ms,  color = color[0], clip_on=False)
ax[1].plot(N, abft_kernel_huge[:l] / 1000,  label="Our fused FT: on", marker='s',markersize=ms,  color = color[3], clip_on=False)


ax[1].set_xlabel("(b) Matrix Sizes M=N, K=1024", fontdict=dict(weight='bold', size=40))
# ax[1].set_ylabel("Performance (TFLOPS)", fontdict=dict(weight='bold'))
# ax[1].set_xscale("log", base=2)
ax[1].set_xlim(0, 10240)
xticks = [0, 2000, 4000, 6000, 8000, 10000]#[256, 512, 1024, 2048, 4096, 8192]
ax[1].set_xticks(xticks)
ax[1].set_xticklabels(['0','2k','4k','6k','8k','10k',])
# ax[1].set_xticklabels([f'{s}' for s in xticks])
yticks = [1, 2, 3, 4, 5, 5.6]
# ax[1].set_yticks(yticks)
ylabels = ['1', '2', '3', '4', '5', '8.1']
# ax[1].set_yticklabels(ylabels)
print("\n\n #########################   M=N, K = 1024 #########################################")
print_average((cublas - kernel_sgemm_huge) / cublas, "cublas vs sgemm")
print_average((kernel_sgemm_huge - abft_kernel_huge) / kernel_sgemm_huge, "sgemm vs abft")
print_average((cublas - abft_kernel_huge) / cublas, "cublas vs abft")
print_average((abft_baseline - abft_kernel_huge) / abft_baseline, "non-fused ABFT SGEMM vs abft")

ax[1].grid()
ax[1].legend(loc="lower right", prop={'size': 30},labelspacing=0,bbox_to_anchor=(1.02,-0.03))
fig.savefig(f"A100_thread_block_level_abft.pdf", bbox_inches='tight')