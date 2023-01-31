import matplotlib.pyplot as plt
import torch as th
import numpy as np
import seaborn as sns
color = sns.color_palette(n_colors=4)
print(color)

import numpy as np
import matplotlib.pyplot as plt
def addlabels(x,y):
    for i in range(len(x)):
        plt.text(x[i], y[i]+0.01, f'{y[i]:.2f}', ha = 'center', fontsize=10, rotation=45) 
# set width of bar
barWidth = 0.2
plt.rc('font', size=24, weight='bold')
plt.rcParams["font.family"] = "Times New Roman"
fig = plt.subplots(figsize =(20, 8))

# set height of bar
bs = th.as_tensor([18.14,   26.84,   34.58,   42.66, 85.41,  121.67,  155.42,  183.12, 387.97,  406.17,  455.93,  511.63,
                  161.40,  593.88,  570.64,  922.93,3143.83, 3615.20, 3206.53, 3233.87,  ])
cublas = th.as_tensor([63.97,   97.73,  120.84,  168.33, 215.98,  305.02,  338.76,  410.21,1028.06,  896.00, 1064.46, 1275.35,
                       514.29, 1465.11, 1747.82, 2005.86, 4078.11, 4099.19, 4427.79, 4377.52])
gemm = th.as_tensor([   75.55,  117.18,  175.94,  210.96, 404.86,  569.16,  557.98,  689.67, 982.96, 1077.14, 1226.84, 1247.60,
                      1023.60, 2687.45, 3651.31, 2736.64, 4829.44, 4837.38, 4831.13, 4813.67, ])
abft = th.as_tensor([67.60,  102.20,  138.24,  168.52, 230.40,  342.90,  371.64,  475.59, 708.28,  667.94,  772.61,  727.92,
                    685.61, 1748.36, 2253.92, 1812.79, 4057.16, 4010.16, 4082.80, 4065.98,])
kernel_name = ['small', 'medium', 'large', 'wide', 'huge']
kernel_size = ['M=N, K=256', 'M=N, K=256', 'M=N, K=256', 'M=K, N=1024', 'M=N=K']
# Set position of bar on X axis
br1 = np.arange(len(bs))
br2 = [x + barWidth for x in br1]
br3 = [x + barWidth for x in br2]
br4 = [x + barWidth for x in br3]
 
# Make the plot
plt.bar(br1, bs / cublas, color = color[0], width = barWidth,
        edgecolor ='k', label ='ABFT baseline', zorder=3)
plt.bar(br2, cublas / cublas, color =color[1], width = barWidth,
        edgecolor ='k', label ='cublasSGEMM',zorder=3)
plt.bar(br3, gemm / cublas, color =color[2], width = barWidth,
        edgecolor ='k', label ='SGEMM (Ours)',zorder=3)
plt.bar(br4, abft / cublas, color =color[3], width = barWidth,
        edgecolor ='k', label ='ABFT SGEMM (Ours)',zorder=3)
for i in range(4):
    x = 3.8 + i * 4
        #     plt.annotate('', xy=((x+0.2)/21.1, -0.03), xycoords='axes fraction', xytext=(x/21.1, 1),
        # arrowprops=dict(linestyle="--", color='k', linewidth=1))
    plt.plot([x, x], [-0.3, 2.15], color='k', linestyle='--', clip_on=False)

# plt.bar([], abft / cublas, color =color[3], width = barWidth,
        # edgecolor ='grey', label ='ABFT SGEMM (Ours)')
# Adding Xticks
# plt.xlabel('Matirx Size', fontsize = 30,y=-10)
plt.ylabel('Scaled Performance', fontsize = 24, fontdict=dict(weight='bold'))
plt.xticks([r + barWidth for r in range(len(bs))], 
           ['64', '80', '96', '112',
            '160', '192', '224', '256',
            '384', '416', '448', '480',
            '128', '256', '384', '512',
            '5k', '6k', '7k', '8k',
            ],
           rotation=45)
fig[1].set_xlim(-0.2,19.9)
fig[1].set_ylim(0,2.15)
# addlabels(br1, bs / cublas )
# # addlabels(br2, cublas/ cublas )
# addlabels(br3, gemm/ cublas )
# addlabels(br4, abft/ cublas )

for i in range(5):
    x = 1.9 + 4 * i
    plt.text(x, 2.05, kernel_name[i], ha = 'center') 
    plt.text(x, -0.3, kernel_size[i], ha = 'center', fontsize=25) 
plt.text( 1.9 + 8, -0.5, 'Matrix Sizes', ha = 'center', fontsize=30) 
plt.title("Performance of generated kernels", fontdict=dict(weight='bold'))
plt.grid(linestyle='--', linewidth=0.7, zorder=0)
plt.legend(loc="lower right", framealpha=0.7)
plt.savefig("sgemm_bar.pdf",bbox_inches='tight')
def print_average(tensor, name):
    avg = tensor.mean() #(tensor.sum() - tensor.max() - tensor.min()) / tensor.shape[0]
    print(f'################### {name} ############################')
    print("overhead:", avg.item()*100, '%')
    print(tensor.sort()[0].numpy(), tensor.sort()[1].numpy())
print("\n\n################# small kernel #####################")
s = 0
print_average((cublas[s:s+4] - gemm[s:s+4]) / cublas[s:s+4], "cublas vs sgemm")
print_average((cublas[s:s+4] - abft[s:s+4]) / cublas[s:s+4], "cublas vs abft")
print_average((bs[s:s+4] - abft[s:s+4]) / bs[s:s+4], "ABFT bs vs abft")

print("\n\n################# medium kernel #####################")
s = 4
print_average((cublas[s:s+4] - gemm[s:s+4]) / cublas[s:s+4], "cublas vs sgemm")
print_average((cublas[s:s+4] - abft[s:s+4]) / cublas[s:s+4], "cublas vs abft")
print_average((bs[s:s+4] - abft[s:s+4]) / bs[s:s+4], "ABFT bs vs abft")

print("\n\n################# large kernel #####################")
s = 8
print_average((cublas[s:s+4] - gemm[s:s+4]) / cublas[s:s+4], "cublas vs sgemm")
print_average((cublas[s:s+4] - abft[s:s+4]) / cublas[s:s+4], "cublas vs abft")
print_average((bs[s:s+4] - abft[s:s+4]) / bs[s:s+4], "ABFT bs vs abft")

print("\n\n################# wide kernel #####################")
s = 12
print_average((cublas[s:s+4] - gemm[s:s+4]) / cublas[s:s+4], "cublas vs sgemm")
print_average((cublas[s:s+4] - abft[s:s+4]) / cublas[s:s+4], "cublas vs abft")
print_average((bs[s:s+4] - abft[s:s+4]) / bs[s:s+4], "ABFT bs vs abft")

print("\n\n################# huge kernel #####################")
s = 16
print_average((cublas[s:s+4] - gemm[s:s+4]) / cublas[s:s+4], "cublas vs sgemm")
print_average((cublas[s:s+4] - abft[s:s+4]) / cublas[s:s+4], "cublas vs abft")
print_average((bs[s:s+4] - abft[s:s+4]) / bs[s:s+4], "ABFT bs vs abft")