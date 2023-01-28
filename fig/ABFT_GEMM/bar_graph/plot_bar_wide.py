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
bs = th.as_tensor([161.40,  593.88,  570.64,  922.93, ])
cublas = th.as_tensor([514.29, 1465.11, 1747.82, 2005.86,])
gemm = th.as_tensor([ 1023.60, 2687.45, 3651.31, 2736.64])
abft = th.as_tensor([ 685.61, 1748.36, 2253.92, 1812.79])
 
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
plt.ylabel('Scale Performance',  fontsize = 15)
plt.xticks([r + barWidth for r in range(len(bs))],
['(128, 1024, 128)', '(256, 1024, 256)', '(384, 1024, 384)', '(512, 1024, 512)'])
 
plt.title("Wide Kernel")
plt.grid(linestyle='--', linewidth=0.7)
plt.legend(loc="lower right", framealpha=0.7)
plt.savefig("sgemm_wide.pdf",bbox_inches='tight')