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
bs = th.as_tensor([85.41,  121.67,  155.42,  183.12,])
cublas = th.as_tensor([215.98,  305.02,  338.76,  410.21])
gemm = th.as_tensor([    404.86,  569.16,  557.98,  689.67,])
abft = th.as_tensor([230.40,  342.90,  371.64,  475.59,])
 
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
plt.xlabel('(M, N, K)',  fontsize = 15)
plt.ylabel('Scale Performance', fontsize = 15)
plt.xticks([r + barWidth for r in range(len(bs))],
['(160, 160, 256)', '(192, 192, 256)', '(224, 224, 256)', '(256, 256, 256)'])
 
plt.title("Medium Kernel")
plt.grid(linestyle='--', linewidth=0.7)
plt.legend(loc="lower right", framealpha=0.7)
plt.savefig("sgemm_medium.pdf",bbox_inches='tight')