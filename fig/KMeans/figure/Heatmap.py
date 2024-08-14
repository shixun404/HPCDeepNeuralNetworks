import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import torch as th
import seaborn as sns
import numpy as np
import os
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
color = sns.color_palette(n_colors=6)
# print(color[3])

plt.rc('font', size=15, weight='bold')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(ncols=2, figsize=(4, 4), )
plt.tight_layout()
fig.subplots_adjust(hspace=0.1, wspace = 0.1)

with open("fixM_double.csv", "r") as file:
    lines = file.readlines()

array_double = np.zeros((16, 16))
for i in range(256):
    elements = lines[i].split(", ")
    row = int(int(elements[1]) / 8 - 1)
    col = int(int(elements[2]) / 32 - 1)
    array_double[row][col] = float(elements[11])

with open("fixM.csv", "r") as file:
    lines = file.readlines()

array_float = np.zeros((16, 16))
for i in range(256):
    elements = lines[i].split(", ")
    row = int(int(elements[1]) / 8 - 1)
    col = int(int(elements[2]) / 32 - 1)
    array_float[row][col] = float(elements[11])
# min_val = np.min(array)
# max_val = np.max(array)
# normalized_array = (array - min_val) / (max_val - min_val) * 0.5 + 0.25

ms = 8
heatmap = ax[0].imshow(array_float, cmap="OrRd", interpolation="nearest")
cbar = plt.colorbar(heatmap, ax = ax[0], shrink = 0.7) 
cbar.set_label("Speedup",fontdict=dict(weight='bold'))

ax[0].set_title("M=131072, FP32",fontdict=dict(weight='bold', fontsize=15))
labelx = []
tickx = []
for i in range(int(512/32)):
    labelx.append(int((i+1)*32))
    tickx.append(i)
labely = []
ticky = []
for i in range(int(128/8)):
    labely.append(int((i+1)*8))
    ticky.append(i)
ax[0].set_xlabel("K",fontdict=dict(weight='bold'))
ax[0].set_xticks(tickx)
ax[0].set_xticklabels(labelx)
ax[0].set_ylabel("N",fontdict=dict(weight='bold'))
ax[0].set_yticks(ticky)
ax[0].set_yticklabels(labely)


heatmap1 = ax[1].imshow(array_double, cmap="OrRd", interpolation="nearest")
cbar1 = plt.colorbar(heatmap1, ax = ax[1], shrink = 0.7) 
cbar1.set_label("Speedup",fontdict=dict(weight='bold'))

ax[1].set_title("M=131072, FP64",fontdict=dict(weight='bold', fontsize=15))
ax[1].set_xlabel("K",fontdict=dict(weight='bold'))
ax[1].set_xticks(tickx)
ax[1].set_xticklabels(labelx)
ax[1].set_ylabel("N",fontdict=dict(weight='bold'))
ax[1].set_yticks(ticky)
ax[1].set_yticklabels(labely)

plt.show()
fig.savefig(f"fixM_heatmap.pdf", bbox_inches='tight')
fig.savefig(f"fixM_heatmap.png", bbox_inches='tight')