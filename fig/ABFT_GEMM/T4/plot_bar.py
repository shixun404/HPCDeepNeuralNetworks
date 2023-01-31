import matplotlib.pyplot as plt
import torch as th
import numpy as np
import seaborn as sns
color = sns.color_palette("Paired_r")
print(color)

import numpy as np
import matplotlib.pyplot as plt
def addlabels(x,y):
    for i in range(len(x)):
        plt.text(x[i], y[i]+0.01, f'{y[i]:.2f}', ha = 'center', fontsize=10, rotation=45) 
# set width of bar
barWidth = 0.2
plt.rc('font', size=20)
fig = plt.subplots(figsize =(20, 10))
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
    
# set height of bar
cublas = th.as_tensor([78.64,  126.98,  152.33,  206.32,  
                       376.97,  554.35,  724.04,  803.14,
                        2004.58, 2590.66, 2977.80, 2923.86,
                        832.17, 2785.80, 5507.23, 7246.55,
                       18887.82, 18832.53, 18727.61, 19111.63])
######################################################################################
bs = th.as_tensor([  10.47,   19.46,   25.74,   17.60, 
                   71.18,   97.91,  136.38,  163.35, 
                   387.97,  406.17,  455.93,  511.63,
                     150.36,  521.78,  637.23, 1060.56,
                   12650.75, 13499.80, 14075.46, 14386.23  ])
######################################################################################
gemm = th.as_tensor([ 92.51,  118.74,  210.89,  290.37, 
                     325.79,  103.99,  822.56, 1099.60,
                     982.96, 1077.14, 1226.84, 1247.60,
                     1076.57, 3177.50, 5067.22, 7819.36, 
                     18739.08, 18445.58, 18440.71, 18972.63, ])
######################################################################################
abft = th.as_tensor([ 79.44,  127.74,  181.42,  248.40, 
                      323.09,  477.51,  640.82,  753.29,
                      708.28,  667.94,  772.61,  727.92, 
                      947.14, 2409.41, 3947.95, 5774.10,
                      16530.02, 16202.45, 16324.59, 16800.10,])
kernel_name = ['small', 'medium', 'large', 'wide', 'huge']
kernel_size = ['M=N, K=256', 'M=N, K=256', 'M=N, K=256', 'M=K, N=1024', 'M=N=K']
# Set position of bar on X axis
br1 = np.arange(len(bs))
br2 = [x + barWidth for x in br1]
br3 = [x + barWidth for x in br2]
br4 = [x + barWidth for x in br3]

# Make the plot
plt.bar(br1, bs / cublas, color = color[0], width = barWidth,
        edgecolor ='grey', label ='ABFT baseline',)
plt.bar(br2, cublas / cublas, color =color[1], width = barWidth,
        edgecolor ='grey', label ='cublasSGEMM')
plt.bar(br3, gemm / cublas, color =color[2], width = barWidth,
        edgecolor ='grey', label ='SGEMM (Ours)')
plt.bar(br4, abft / cublas, color =color[3], width = barWidth,
        edgecolor ='grey', label ='ABFT SGEMM (Ours)')
for i in range(4):
    x = 3.8 + i * 4
        #     plt.annotate('', xy=((x+0.2)/21.1, -0.03), xycoords='axes fraction', xytext=(x/21.1, 1),
        # arrowprops=dict(linestyle="--", color='k', linewidth=1))
    plt.plot([x, x], [-0.2, 1.5], color='k', linestyle='--', clip_on=False)

# plt.bar([], abft / cublas, color =color[3], width = barWidth,
        # edgecolor ='grey', label ='ABFT SGEMM (Ours)')
# Adding Xticks
# plt.xlabel('Matirx Size', fontsize = 15)
plt.ylabel('Scaled Performance', fontsize = 20)
plt.xticks([r + barWidth for r in range(len(bs))], 
           ['64', '80', '96', '112',
            '160', '192', '224', '256',
            '384', '416', '448', '480',
            '128', '256', '384', '512',
            '5k', '6k', '7k', '8k',
            ],
           rotation=45)
fig[1].set_xlim(-0.2,19.9)
fig[1].set_ylim(0,1.5)
addlabels(br1, bs / cublas )
# addlabels(br2, cublas/ cublas )
addlabels(br3, gemm/ cublas )
addlabels(br4, abft/ cublas )

for i in range(5):
    x = 1.9 + 4 * i
    plt.text(x, 1.45, kernel_name[i], ha = 'center') 
    plt.text(x, -0.2, kernel_size[i], ha = 'center') 
plt.title("Performance of Generated Kernels on A100")
plt.grid(linestyle='--', linewidth=0.7)
plt.legend(loc="lower right", framealpha=0.7)
plt.savefig("A100_sgemm_bar.pdf",bbox_inches='tight')