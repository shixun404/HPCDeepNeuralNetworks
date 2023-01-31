import matplotlib.pyplot as plt
import torch as th
online = 1.15
offline = 1.01

gamma0 = 1/256

N = th.tensor([i for i in range(256, 1500, 32)])
n = 128
constant = th.ones(N.shape) * online
gamma = 1 - (1-gamma0)**(N * N / (n*n))
print(gamma)
offline_time = (1-gamma) / (1-2*gamma + 1e-6) * offline
print(offline_time)
print(constant)
plt.rc('font', size=24, weight='bold')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(ncols=1, figsize=(8, 5))
plt.tight_layout()
fig.subplots_adjust(hspace=0.2, wspace = 0.2)
plt.plot(N, 100 * (offline_time - 1), linewidth=2, label='Offline ABFT')
plt.plot(N, 100*(constant - 1),  linewidth=2, label='Online ABFT')

ax.set_xlabel("Matrix Sizes M=N=K",fontdict=dict(weight='bold',size=30))
ax.set_ylabel("Overhead %", fontdict=dict(weight='bold'))
ax.grid()
ax.legend()

fig.savefig(f"fault.pdf", bbox_inches='tight')