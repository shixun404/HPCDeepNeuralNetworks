import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable, Size, Divider
import torch as th
import seaborn as sns
def print_average(tensor, name):
    avg = (tensor.sum() - tensor.max() - tensor.min()) / tensor.shape[0]
    print(f'################### {name} ############################')
    print("overhead:", avg.item()*100, '%')
    print(tensor.sort()[0].numpy(), tensor.sort()[1].numpy())
color = sns.color_palette( n_colors=4)
ms = 6
N = th.as_tensor([i for i in range(512, 10240+256, 256)])
# N = th.as_tensor([i for i in range(256, 16384+256, 256)])
N_4 = th.as_tensor([i for i in range(256, 6144+256, 256)])
N_8 = th.as_tensor([i for i in range(256, 6144+256, 256)])
kernel_name = ["", "row&col", "2 row checksum", "offline_abft_sgemm", "online_abft_1", "online_abft_2", "online_abft_3"]

plt.rc('font', size=24, weight='bold')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.family"] = "Times New Roman"
horiz = [Size.Fixed(6), Size.Fixed(6)]
vert = [Size.Fixed(3), Size.Fixed(3)]
fig, ax = plt.subplots(ncols=2, figsize=(16, 5))
plt.tight_layout()
fig.subplots_adjust(hspace=0.2, wspace = 0.2)
performance_scale = 1
l = N.shape[0]
ax[0].set_xscale('linear')
# ax[0].set_yscale('log', base=2)

ax[0].set_xlim(16, 512)
ax[0].set_ylim(1, 5120)
ax[0].set_xlabel("Matrix Sizes M=N=K")
ax[0].set_ylabel("Performance (GFLOPS)")

cublas_small = th.as_tensor([   3.25,    9.84,   23.33,   45.05,   77.84,  118.28,  152.55,  212.85,  287.25,  363.41,])
kernel_small = th.as_tensor([    3.76,   13.25,   30.75,   58.48,   96.81,  145.57,  212.78,  300.62,  390.24,  484.00])
abft_small =  th.as_tensor([      3.79,   12.67,   29.09,   36.43,   90.95,  139.64,  200.29,  276.40,  366.13,  464.98,])
N_small =  th.as_tensor([i for i in range(32, 176+1, 16)])

kernel_medium = th.as_tensor([   633.81,  977.82, 1295.18, 1818.95, 2261.48, 2605.02, 3013.41])
cublas_medium = th.as_tensor([ 394.51,  728.09,  934.89, 1426.79, 1990.67, 2437.31, 3001.14,])
abft_medium =  th.as_tensor([ 536.89,  847.57, 1155.84, 1557.80, 1919.04, 2137.62, 2365.60,])
N_medium =  th.as_tensor([i for i in range(192, 384+1, 32)])

kernel_large = th.as_tensor([ 3367.73, 4069.90, 4247.79, 4872.56,])
cublas_large = th.as_tensor([ 3462.32, 4429.16, 4243.62, 4983.73,])
abft_large =  th.as_tensor([    2481.23, 2839.39, 2979.31, 3402.26,])
N_large =  th.as_tensor([i for i in range(416, 512, 32)])

kernel = th.cat((kernel_small, kernel_medium))
cublas = th.cat((cublas_small, cublas_medium))
abft = th.cat((abft_small, abft_medium))
N = th.cat((N_small, N_medium))

kernel = th.cat((kernel, kernel_large))
cublas = th.cat((cublas, cublas_large))
abft = th.cat((abft, abft_large))
abft_ = th.as_tensor([ 2.20,    6.37,   13.56,   23.36,   37.04,   53.44,   74.14,   95.29,  122.23,  152.01, 183.22,  263.37,  353.48,  457.41,  576.32,  709.87,  860.64, 1016.80, 1196.70, 1382.84, 1591.65,])
kernel_ = th.as_tensor([  2.32,    6.78,   14.67,   25.54,   40.66,   59.01,   82.50,  105.84,  136.87,  169.69, 209.54,  298.67,  403.80,  524.22,  662.53,  817.11,  990.08, 1166.42, 1377.92, 1592.33, 1838.32,])
N = th.cat((N, N_large))

def print_average(tensor, name):
    avg = (tensor.sum() - tensor.max() - tensor.min()) / tensor.shape[0]
    
    print(name, avg)
    print(tensor.sort())

l = N.shape[0]
print(cublas.shape, N)
ax[0].plot(N, cublas[:l] / performance_scale,   marker='o', markersize=ms, color = color[1], label="cublas SGEMM", clip_on=False)
# ax[0].plot(N, abft_baseline[:l] / performance_scale,  marker='^',markersize=ms,  color = color[3], clip_on=False)
ax[0].plot(N, kernel[:l] / performance_scale, '--' ,  marker='P',markersize=ms, color = color[2],label="SGEMM (Ours), with codegen", clip_on=False)
ax[0].plot(N, kernel_[:l] / performance_scale,  marker='P',markersize=ms, color = color[2], label="SGEMM (Ours), no codegen",clip_on=False)
ax[0].plot(N, abft[:l] / performance_scale, '--',  marker='s',markersize=ms,  color = color[3],label="ABFT SGEMM (Ours), with codegen", clip_on=False)
ax[0].plot(N, abft_[:l] / performance_scale,   marker='s',markersize=ms,  color = color[3], label="ABFT SGEMM (Ours), no codegen",clip_on=False)
print("\n\n################# M=N=K #####################")
print_average((cublas - kernel) / cublas, "cublas vs sgemm")
print_average((cublas - abft_) / cublas, "cublas vs abft no code gen")
print_average((cublas - abft) / cublas, "cublas vs abft")
print_average((kernel_ - kernel) / kernel_, "SGEMM: no codegen vs codegen")
print_average((abft_ - abft) / abft_, "ABFT: no codegen vs codegen")


xticks = [100, 200, 300, 400, 512]
yticks = [1, 4,16, 64, 256, 1024, 4096]
ax[0].set_xticks(xticks)
ax[0].set_xticklabels([f'{s}' for s in xticks])

ax[0].set_yticks(yticks)
ax[0].set_yticklabels([f'{s}' for s in yticks])

ax[0].grid(True)

ax[0].legend(fontsize=18)
ax[0].set_xlabel("(a) Matrix Sizes M=N=K",fontdict=dict(weight='bold', size=30))
ax[0].set_ylabel("Performance (GFLOPS)", fontdict=dict(weight='bold'))



kernel_small = th.as_tensor([  22.96,   52.48,   92.46,  145.45,  207.57,  283.80,  368.18,  455.74,  551.72,  667.59,])
cublas_small = th.as_tensor([     20.45,   43.72,   78.92,  124.27,  137.35,  196.31,  257.21,  322.49,  404.42,  462.33,])
abft_small =  th.as_tensor([       19.59,   45.71,   80.63,  125.49,  179.65,  245.48,  320.00,  398.00,  488.55,  583.35,])
N_small =  th.as_tensor([i for i in range(32, 176+1, 16)])

kernel_medium = th.as_tensor([  768.10, 1056.34, 1222.69, 1435.02, 1726.81, 1857.63, 2529.26,])
cublas_medium = th.as_tensor([ 534.75,  725.09,  979.61, 1401.08, 1646.30, 1897.46, 2251.24,])

abft_medium =  th.as_tensor([   644.23,  922.35, 1166.12, 1465.44, 1718.12, 1487.44, 2017.18,])
N_medium =  th.as_tensor([i for i in range(192, 384+1, 32)])

kernel_large = th.as_tensor([2639.43, 3106.87, 3191.14, 3591.01,])
cublas_large = th.as_tensor([ 2335.24, 2760.72, 2701.06, 3051.73,])
abft_large =  th.as_tensor([  2121.68, 2350.16, 2488.12, 2800.68])
N_large =  th.as_tensor([i for i in range(416, 512, 32)])

kernel = th.cat((kernel_small, kernel_medium))
cublas = th.cat((cublas_small, cublas_medium))

abft = th.cat((abft_small, abft_medium))
N = th.cat((N_small, N_medium))

kernel = th.cat((kernel, kernel_large))
cublas = th.cat((cublas, cublas_large))
abft = th.cat((abft, abft_large))
abft_ = th.as_tensor([  5.54,   12.47,   22.33,   30.17,   50.31,   68.29,   89.73,  111.66,  138.38,  166.99, 197.30,  256.79,  336.77,  451.52,  555.01,  671.57,  802.26, 924.31, 1090.78, 1249.46, 1427.02,])
kernel_ = th.as_tensor([ 6.36,   14.20,   25.55,   39.51,   57.28,   77.72,  101.95,  126.44,  156.86,  189.11,224.11,  307.07,  402.80,  507.92,  627.07,  758.75,  906.31,1032.19, 1230.56, 1398.06, 1609.23,])
N = th.cat((N, N_large))
print("\n\n################# M=N, K=1024 #####################")
print_average((cublas - kernel) / cublas, "cublas vs sgemm")
print_average((cublas - abft_) / cublas, "cublas vs abft no code gen")
print_average((cublas - abft) / cublas, "cublas vs abft")
print_average((kernel_ - kernel) / kernel_, "SGEMM: no codegen vs codegen")
print_average((abft_ - abft) / abft_, "ABFT: no codegen vs codegen")

l = N.shape[0]
ax[1].plot(N, cublas[:l] / performance_scale,   marker='o', markersize=ms, color = color[1], label="cublas SGEMM", clip_on=False)
# ax[0].plot(N, abft_baseline[:l] / performance_scale,  marker='^',markersize=ms,  color = color[3], clip_on=False)
ax[1].plot(N, kernel[:l] / performance_scale, '--' ,  marker='P',markersize=ms, color = color[2],label="SGEMM (Ours), with codegen", clip_on=False)
ax[1].plot(N, kernel_[:l] / performance_scale,  marker='P',markersize=ms, color = color[2], label="SGEMM (Ours), no codegen",clip_on=False)
ax[1].plot(N, abft[:l] / performance_scale, '--',  marker='s',markersize=ms,  color = color[3],label="ABFT SGEMM (Ours), with codegen", clip_on=False)
ax[1].plot(N, abft_[:l] / performance_scale,   marker='s',markersize=ms,  color = color[3], label="ABFT SGEMM (Ours), no codegen",clip_on=False)

ax[1].set_xscale('linear')
# ax[1].set_yscale('log', base=2)

xticks = [100, 200, 300, 400, 512]
yticks = [1, 4,16, 64, 256, 1024, 4096]
ax[1].set_xticks(xticks)
ax[1].set_xticklabels([f'{s}' for s in xticks])

ax[1].set_yticks(yticks)
ax[1].set_yticklabels([f'{s}' for s in yticks])

ax[1].grid(True)

ax[1].legend(fontsize=18)
ax[1].set_xlabel("(b) Matrix Sizes M=N, K = 256",fontdict=dict(weight='bold',size=30))
ax[1].set_ylabel("Performance (GFLOPS)", fontdict=dict(weight='bold'))



fig.savefig(f"A100_why_code_gen.pdf", bbox_inches='tight')