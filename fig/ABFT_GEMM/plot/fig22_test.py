import matplotlib.pyplot as plt
import torch as th
online = 1.15
offline = 1.01

gamma0 = 1/256
import seaborn as sns
color = sns.color_palette( n_colors=4)
import matplotlib
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42
N = th.tensor([i for i in range(256, 1536+1, 64)])
n = 128
constant = th.ones(N.shape) * online
gamma = 1 - (1-gamma0)**(N * N / (n*n))
print(gamma)
offline_time = (1-gamma) / (1-2*gamma + 1e-6) * offline
print(offline_time)
print(constant)
plt.rc('font', size=40, weight='bold')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(ncols=2, figsize=(18, 7))
plt.tight_layout()
fig.subplots_adjust(hspace=0.2, wspace = 0.2)
ax[0].plot(N, 100 * (offline_time - 1), linewidth=3,marker='^',markersize=12, color='k', label='Offline ABFT')
ax[0].plot(N, 100*(constant - 1),  linewidth=3, marker='s',markersize=12, color=color[3],label='Online ABFT')


ax[0].set_xlabel("(a) Matrix Sizes M=N=K",fontdict=dict(weight='bold',size=40))
ax[0].set_ylabel("Overhead %", fontdict=dict(weight='bold'))
ax[0].grid()
ax[0].legend(fontsize=32,labelspacing = 0,)
# ax[0].set_yscale('log')

online = 1.10
offline = 1.01
constant = th.ones(N.shape) * online
gamma = 1 - (1-gamma0)**(N * N / (n*n))
print(gamma)
offline_time = (1-gamma) / (1-2*gamma + 1e-6) * offline
print(offline_time)
print(constant)

ax[1].plot(N, 100 * (offline_time - 1), linewidth=3,marker='^',markersize=12, color='k', label='Offline ABFT')
ax[1].plot(N, 100*(constant - 1),  linewidth=3, marker='s', markersize=12,color=color[3],label='Online ABFT')


yticks = [1, 4,16, 64, 256]

# ax[0].set_yticks(yticks)
# ax[0].set_yticklabels([f'{s}' for s in yticks])

ax[1].set_xlabel("(b) Matrix Sizes M=N, K=1024",fontdict=dict(weight='bold',size=40))
# ax[1].set_ylabel("Overhead %", fontdict=dict(weight='bold'))
ax[1].grid()
ax[1].legend(fontsize=32,labelspacing = 0,)
# ax[1].set_yscale('log')
# ax[1].set_yticks(yticks)
# ax[1].set_yticklabels([f'{s}' for s in yticks])

fig.savefig(f"fault.pdf", bbox_inches='tight')