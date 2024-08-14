import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import torch as th
import seaborn as sns
import numpy as np
import os
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
color = sns.color_palette(n_colors=6)
# print(color[3])

M = th.as_tensor([8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128])

plt.rc('font', size=15, weight='bold')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(ncols=2, figsize=(10, 4), )
plt.tight_layout()
fig.subplots_adjust(hspace=0.1, wspace = 0.2)

with open("fix_MK.csv", "r") as file:
    lines = file.readlines()
t_raft = []
t_codegen_Para1 = []
t_codegen_18 = []
t_codegen_best = []
for i in range(16):
    elements = lines[i].split(", ")
    t_codegen_best.append(float(elements[3]))
    t_codegen_Para1.append(float(elements[4]))
    t_codegen_18.append(float(elements[5]))
    t_raft.append(float(elements[6]))
    
for i in range(16):
    elements = lines[i + 16].split(", ")
    t_codegen_best.append(float(elements[3]))
    t_codegen_Para1.append(float(elements[4]))
    t_codegen_18.append(float(elements[5]))
    t_raft.append(float(elements[6]))

t_raft_K8 = th.as_tensor(t_raft[0:16])
t_codegen_Para1_K8 = th.as_tensor(t_codegen_Para1[0:16])
t_codegen_18_K8 = th.as_tensor(t_codegen_18[0:16])
t_codegen_best_K8 = th.as_tensor(t_codegen_best[0:16])

t_raft_K128 = th.as_tensor(t_raft[16:32])
t_codegen_Para1_K128 = th.as_tensor(t_codegen_Para1[16:32])
t_codegen_18_K128 = th.as_tensor(t_codegen_18[16:32])
t_codegen_best_K128 = th.as_tensor(t_codegen_best[16:32])

ms = 8
ax[0].plot(M[:], t_raft_K8[:], label="Raft", marker='^',markersize=ms,  color = color[0], clip_on=False)
ax[0].plot(M[:], t_codegen_Para1_K8[:], label="Parameter1", marker='*',markersize=ms,  color = color[1], clip_on=False)
ax[0].plot(M[:], t_codegen_18_K8[:], label="Parameter2", marker='s',markersize=ms,  color = color[2], clip_on=False)
ax[0].plot(M[:], t_codegen_best_K8[:], label="Codegen", marker='o',markersize=ms,  color = color[3], clip_on=False)

ax[1].plot(M[:], t_raft_K128[:], label="Raft", marker='^',markersize=ms,  color = color[0], clip_on=False)
ax[1].plot(M[:], t_codegen_Para1_K128[:], label="Parameter1", marker='*',markersize=ms,  color = color[1], clip_on=False)
ax[1].plot(M[:], t_codegen_18_K128[:], label="Parameter2", marker='s',markersize=ms,  color = color[2], clip_on=False)
ax[1].plot(M[:], t_codegen_best_K128[:], label="Codegen", marker='o',markersize=ms,  color = color[3], clip_on=False)

ax[0].set_title("M=131072, K=8",fontdict=dict(weight='bold', fontsize=15))
ax[0].set_xlabel("N",fontdict=dict(weight='bold'))
ax[0].set_xticks([0, 32, 64, 96, 128])
ax[0].set_ylabel("Perf. (GFLOPS)", fontdict=dict(weight='bold', fontsize = 20))
ax[0].grid()
ax[0].legend(loc="upper left", prop={'size': 10, })
speedup_8_Para1 = 0.0
speedup_128_Para1 = 0.0
speedup_8_18 = 0.0
speedup_128_18 = 0.0
for i in range(16):
    speedup_8_Para1 = speedup_8_Para1 + t_codegen_Para1_K8[i] / t_raft_K8[i]
    speedup_128_Para1 = speedup_128_Para1 + t_codegen_Para1_K128[i] / t_raft_K128[i]
    speedup_8_18 = speedup_8_18 + t_codegen_18_K8[i] / t_raft_K8[i]
    speedup_128_18 = speedup_128_18 + t_codegen_18_K128[i] / t_raft_K128[i]
    
print("Para1: Speedup 8: ",speedup_8_Para1 / 16)
print("Para1: Speedup 128: ",speedup_128_Para1 / 16)
print("Para1: Overall speedup: ", (speedup_8_Para1 + speedup_128_Para1) / 32)

print("Para2: Speedup 8: ",speedup_8_18 / 16)
print("Para2: Speedup 128: ",speedup_128_18 / 16)
print("Para2: Overall speedup: ", (speedup_8_18 + speedup_128_18) / 32)
# plt.suptitle("Performance of cuBLAS Assignment Kernel")

ax[1].set_title("M=131072, K=128",fontdict=dict(weight='bold', fontsize=15))
ax[1].set_xlabel("N",fontdict=dict(weight='bold'))
ax[1].set_xticks([0, 32, 64, 96, 128])
ax[1].grid()
ax[1].legend(loc="upper left", prop={'size': 10, })
plt.show()
fig.savefig(f"fixMK_float.pdf", bbox_inches='tight')
fig.savefig(f"fixMK_float.png", bbox_inches='tight')