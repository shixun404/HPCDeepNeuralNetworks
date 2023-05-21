import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable, Size, Divider
import torch as th
import seaborn as sns
color = sns.color_palette( n_colors=4)
ms = 9
ls=3
N = th.as_tensor([i for i in range(512, 10240+256, 256)])
# N = th.as_tensor([i for i in range(256, 16384+256, 256)])
N_4 = th.as_tensor([i for i in range(256, 6144+256, 256)])
N_8 = th.as_tensor([i for i in range(256, 6144+256, 256)])
kernel_name = ["", "row&col", "2 row checksum", "offline_abft_sgemm", "online_abft_1", "online_abft_2", "online_abft_3"]
def print_average(tensor, name):
    avg = (tensor.sum() - tensor.max() - tensor.min()) / tensor.shape[0]
    print(f'################### {name} ############################')
    print("overhead:", avg.item()*100, '%')
    print(tensor.sort()[0].numpy(), tensor.sort()[1].numpy())
    
plt.rc('font', size=40, weight='bold')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.family"] = "Times New Roman"
horiz = [Size.Fixed(6), Size.Fixed(6)]
vert = [Size.Fixed(3), Size.Fixed(3)]
fig, ax = plt.subplots(ncols=2, figsize=(18, 7))
plt.tight_layout()
fig.subplots_adjust(hspace=0.1, wspace = 0.15)
performance_scale = 1
l = N.shape[0]
ax[0].set_xscale('linear')
ax[0].set_yscale('log', base=2)

ax[0].set_xlim(16, 512)
ax[0].set_ylim(1, 2048)
ax[0].set_xlabel("Matrix Sizes M=N=K")
ax[0].set_ylabel("Performance (GFLOPS)")

cublas_small = th.as_tensor([   2.98,    9.97,   24.48,   38.39,   75.43,  116.68,  137.25,  178.36,  233.11,  310.10,])
kernel_small = th.as_tensor([    4.76,   15.78,   35.21,   63.71,  103.41,  146.01,  193.76,   254.22,  334.97,  414.82])
abft_small =  th.as_tensor([      4.16,   13.50,   28.68,   50.76,   85.02,  114.33,  150.13,  178.11,  221.33,   262.41,])
N_small =  th.as_tensor([i for i in range(32, 176+1, 16)])

kernel_medium = th.as_tensor([    494.32,  540.23,  724.08,  824.06,  983.41, 1139.70, 1371.71,])
cublas_medium = th.as_tensor([ 360.65,  514.08,  507.21,  682.23,  880.92, 1073.12, 1236.72])
abft_medium =  th.as_tensor([  322.86,  371.32,  477.33,  547.89,  670.91,724.84,  879.46,])
N_medium =  th.as_tensor([i for i in range(192, 384+1, 32)])

kernel_large = th.as_tensor([    1047.58, 1214.43,1386.24, 1377.20,])
cublas_large = th.as_tensor([  583.04, 1116.65, 1548.51, 1783.6])
abft_large =  th.as_tensor([      731.58,  862.40,   921.90,  908.54,])
N_large =  th.as_tensor([i for i in range(416, 512, 32)])

kernel = th.cat((kernel_small, kernel_medium))
cublas = th.cat((cublas_small, cublas_medium))
abft = th.cat((abft_small, abft_medium))
N = th.cat((N_small, N_medium))

kernel = th.cat((kernel, kernel_large))
cublas = th.cat((cublas, cublas_large))
abft = th.cat((abft, abft_large))
abft_ = th.as_tensor([  1.28,    3.65,    7.66,   13.00,   20.36,   28.92,   39.83,   51.68,   65.64,   81.12, 99.07,  140.54,  188.62,  231.43,  291.07,  360.38,  434.99,  514.85,  604.86,  699.83,  804.19,])
kernel_ = th.as_tensor([  1.66,    4.87,   10.29,   16.75,   26.45,   37.10,   50.99,   65.62,   84.25,  103.95,124.45,  178.95,  238.86,  307.48,  384.67,  473.24,  569.02,  673.12,  785.34,  908.66, 1046.92,])
N = th.cat((N, N_large))
print("\n\n################# M=N=K #####################")
# print_average((cublas - kernel) / cublas, "cublas vs sgemm")
print_average((cublas - kernel_) / cublas, "cublas vs sgemm no code gen")
# print_average((cublas - abft_) / cublas, "cublas vs abft no code gen")
# print_average((cublas - abft) / cublas, "cublas vs abft")
# print_average((kernel_ - kernel) / kernel_, "SGEMM: no codegen vs codegen")
# print_average((abft_ - abft) / abft_, "ABFT: no codegen vs codegen")
l = N.shape[0]
print(cublas.shape, N)
ax[0].plot(N, cublas[:l] / performance_scale,  linewidth=ls,  marker='o', markersize=ms, color = color[1], label="cuBLAS", clip_on=False)
# ax[0].plot(N, abft_baseline[:l] / performance_scale,  marker='^',markersize=ms,  color = color[3], clip_on=False)
ax[0].plot(N, kernel_[:l] / performance_scale,  marker='P',  linewidth=ls,markersize=ms, color = color[2], label="Fused FT: off",clip_on=False)
ax[0].plot(N, kernel[:l] / performance_scale, '--' ,    linewidth=ls,marker='P',markersize=ms, color = color[2],label="Codegen FT: off", clip_on=False)

ax[0].plot(N, abft_[:l] / performance_scale, linewidth=ls,  marker='s',markersize=ms,  color = color[3], label="Fused FT: on",clip_on=False)
ax[0].plot(N, abft[:l] / performance_scale, '--', linewidth=ls, marker='s',markersize=ms,  color = color[3],label="Codegen FT: on", clip_on=False)



xticks = [100, 200, 300, 400, 512]
yticks = [1, 4,16, 64, 256, 1024]
ax[0].set_xticks(xticks)
ax[0].set_xticklabels([f'{s}' for s in xticks],fontdict=dict(weight='bold',size=40))

ax[0].set_yticks(yticks)
ax[0].set_yticklabels([f'{s}' for s in yticks], fontdict=dict(weight='bold',size=40))

ax[0].grid(True)

xticks = [1024, 2048, 4096, 8192]

yticks = [2000, 3000, 4000, 5000]
ax[0].legend(loc="lower right",fontsize=32,labelspacing = 0,bbox_to_anchor=(1.02,-0.03))
ax[0].set_xlabel("(a) Matrix Sizes M=N=K",fontdict=dict(weight='bold', size=40))
ax[0].set_ylabel("Perf. (GFLOPS)", fontdict=dict(weight='bold',size=40))



kernel_small = th.as_tensor([   19.60,   45.61,   79.74,  121.96,  176.69,  226.43, 264.16,  323.57,  401.41,  485.56,])
cublas_small = th.as_tensor([    17.02,   38.79,   69.55,  109.38,  126.39,  173.94,  230.30,  280.30,  302.43,  352.16,])

abft_small =  th.as_tensor([      16.51,   34.92,   65.56,  100.07,  140.66,  165.45,  202.77,  223.76,  262.14,268.89,])
N_small =  th.as_tensor([i for i in range(32, 176+1, 16)])

kernel_medium = th.as_tensor([   556.94,  554.47,  716.00,  786.74,  930.17,  949.07, 1031.45,])
cublas_medium = th.as_tensor([ 395.68,  424.36,  507.28,  520.84,  787.75,  881.31, 1035.69,])

abft_medium =  th.as_tensor([     352.05, 358.05,   481.12,  534.16,  643.17,  637.10,   716.09,])
N_medium =  th.as_tensor([i for i in range(192, 384+1, 32)])

kernel_large = th.as_tensor([    987.15, 1126.25, 1276.56, 1262.11])
cublas_large = th.as_tensor([ 899.78, 1066.28, 1281.00, 1454.08,])
abft_large =  th.as_tensor([   670.05,  739.97, 844.88,  829.68,])
N_large =  th.as_tensor([i for i in range(416, 512, 32)])

kernel = th.cat((kernel_small, kernel_medium))
cublas = th.cat((cublas_small, cublas_medium))

abft = th.cat((abft_small, abft_medium))
N = th.cat((N_small, N_medium))

kernel = th.cat((kernel, kernel_large))
cublas = th.cat((cublas, cublas_large))
abft = th.cat((abft, abft_large))
abft_ = th.as_tensor([ 2.94,    6.61,   11.84,   18.23,   26.56,   36.00,   47.40,   59.24,   73.39,   88.76,105.54,  143.96,  187.35,  237.15,  291.46,  354.45,  423.42, 491.23,  573.38,  654.73,  752.89,])
kernel_ = th.as_tensor([ 3.80,    8.40,   15.16,   23.25,   33.73,   45.41,   59.87,   74.14,   92.84,  111.70, 132.15,  181.59,  239.18,  299.56,  369.00,  447.71,  533.35,   612.55,  722.70,  832.36,  957.20])
N = th.cat((N, N_large))
print("\n\n################# M=N, K=1024 #####################")
# print_average((cublas - kernel) / cublas, "cublas vs sgemm")
# print_average((cublas - abft_) / cublas, "cublas vs abft no code gen")
# print_average((cublas - abft) / cublas, "cublas vs abft")
# print_average((kernel_ - kernel) / kernel_, "SGEMM: no codegen vs codegen")
# print_average((abft_ - abft) / abft_, "ABFT: no codegen vs codegen")
print_average((cublas - kernel_) / cublas, "cublas vs sgemm no code gen")
l = N.shape[0]
ax[1].plot(N, cublas[:l] / performance_scale,   marker='o',  linewidth=ls, markersize=ms, color = color[1], label="cuBLAS", clip_on=False)
# ax[0].plot(N, abft_baseline[:l] / performance_scale,  marker='^',markersize=ms,  color = color[3], clip_on=False)

ax[1].plot(N, kernel_[:l] / performance_scale,  marker='P',  linewidth=ls,markersize=ms, color = color[2], label="Fused FT: off",clip_on=False)
ax[1].plot(N, kernel[:l] / performance_scale, '--' ,   linewidth=ls, marker='P',markersize=ms, color = color[2],label="Codegen FT: off", clip_on=False)
ax[1].plot(N, abft_[:l] / performance_scale,   marker='s',linewidth=ls,markersize=ms,  color = color[3], label="Fused FT: on",clip_on=False)
ax[1].plot(N, abft[:l] / performance_scale, '--',  marker='s',linewidth=ls,markersize=ms,  color = color[3],label="Codegen FT: on", clip_on=False)


ax[1].set_xscale('linear')
ax[1].set_yscale('log', base=2)

xticks = [100, 200, 300, 400, 512]
yticks = [1, 4,16, 64, 256, 1024]
ax[1].set_xticks(xticks)
ax[1].set_xticklabels([f'{s}' for s in xticks], fontdict=dict(weight='bold',size=40))

ax[1].set_yticks(yticks)
ax[1].set_yticklabels([f'{s}' for s in yticks], fontdict=dict(weight='bold',size=40))

ax[1].grid(True)

xticks = [1024, 2048, 4096, 8192]

yticks = [2000, 3000, 4000, 5000]
ax[1].legend(loc="lower right",fontsize=32,labelspacing = 0,bbox_to_anchor=(1.02,-0.03))
ax[1].set_xlabel("(b) Matrix Sizes M=N, K = 256",fontdict=dict(weight='bold',size=40))
# ax[1].set_ylabel("Performance (GFLOPS)", fontdict=dict(weight='bold',size=35))



fig.savefig(f"why_code_gen.pdf", bbox_inches='tight')