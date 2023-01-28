import matplotlib.pyplot as plt
import torch as th
import numpy as np
import seaborn as sns
color = sns.color_palette("Paired_r")
print(color)

import numpy as np
import matplotlib.pyplot as plt
 
# set width of bar
barWidth = 0.2
plt.rc('font', size=15)
fig = plt.subplots(figsize =(12, 8))

# set height of bar
bs = th.as_tensor([18.14,   26.84,   34.58,   42.66])
cublas = th.as_tensor([63.97,   97.73,  120.84,  168.33,])
gemm = th.as_tensor([   75.55,  117.18,  175.94,  210.96])
abft = th.as_tensor([67.60,  102.20,  138.24,  168.52])
 
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
 
# Adding Xticks
plt.xlabel('(M, N, K)', fontsize = 15)
plt.ylabel('Scale Performance', fontsize = 15)
plt.xticks([r + barWidth for r in range(len(bs))],
        ['(64, 64, 256)', '(80, 80, 256)', '(96, 96, 256)', '(112, 112, 256)'])
plt.title("Small Kernel")
plt.grid(linestyle='--', linewidth=0.7)
plt.legend(loc="lower right", framealpha=0.7)
plt.savefig("sgemm_small.pdf",bbox_inches='tight')