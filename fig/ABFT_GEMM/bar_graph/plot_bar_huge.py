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
bs = th.as_tensor([3143.83, 3615.20, 3206.53, 3233.87, ])
cublas = th.as_tensor([ 4078.11, 4099.19, 4427.79, 4377.52])
gemm = th.as_tensor([ 4829.44, 4837.38, 4831.13, 4813.67, ])
abft = th.as_tensor([ 4057.16, 4010.16, 4082.80, 4065.98,])
 
# Set position of bar on X axis
br1 = np.arange(len(bs))
br2 = [x + barWidth for x in br1]
br3 = [x + barWidth for x in br2]
br4 = [x + barWidth for x in br3]
 
# Make the plot
plt.bar(br1, bs / cublas, color = color[0], width = barWidth,
        edgecolor ='grey', label ='non-fused ABFT SGEMM',)
plt.bar(br2, cublas / cublas, color =color[1], width = barWidth,
        edgecolor ='grey', label ='cuBLAS SGEMM')
plt.bar(br3, gemm / cublas, color =color[2], width = barWidth,
        edgecolor ='grey', label ='SGEMM (Ours)')
plt.bar(br4, abft / cublas, color =color[3], width = barWidth,
        edgecolor ='grey', label ='fused ABFT SGEMM (Ours)')
 
# Adding Xticks``
plt.xlabel('(M, N, K)',  fontsize = 15)
plt.ylabel('Scale Performance',  fontsize = 15)
plt.xticks([r + barWidth for r in range(len(bs))],
['(5120, 5120, 5120)', '(6144, 6144, 6144)', '(7168, 7168, 7168)', '(8192, 8192, 8192)'])
 
plt.title("Huge Kernel")
plt.grid(linestyle='--', linewidth=0.7)
plt.legend(loc="lower right", framealpha=0.7)
plt.savefig("sgemm_huge.pdf",bbox_inches='tight')