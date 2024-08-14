import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import sys
import os
import seaborn as sns
sys.path.append(os.path.abspath('../scripts'))
# import utils
from utils import load_data, load_data_single
import torch as th
plt.rc('font', size=20, weight='bold')
plt.rcParams['lines.linewidth'] = 3
plt.rcParams["font.family"] = "Times New Roman"
plt.tight_layout()
thread_bs = [1,2, 4, 8, 16, 32]
d = '32'
dsize = 26
device = 'T4'
datatype = 'fp'+d
datatype_capital = 'FP'+d
xin = f'../ft_data/ft_scheme_threadblock_bs=1_{device}_{datatype}.csv'
thread = f'../ft_data/ft_scheme_thread_bs=1_{device}_{datatype}.csv'
file_name = [xin, thread,thread ]
thread_bs_list = [[], [], thread_bs]
label = [
    '(a) TurboFFT w/\n1-sided ABFT',
    '(b) TurboFFT w/\n2-sided ABFT\nthread-level',
    '(c) TurboFFT w/\n2-sided ABFT\nthreadblock-level',
]
def get_heatmap(file_name, thread_bs=[], datatype='fp64'):
    best_data, data_tensor = load_data_single(file_name)
    for i in thread_bs:
        data_list , data_tensor = load_data_single(f'../ft_data/ft_scheme_threadblock_bs={i}_{device}_{datatype}.csv')
        for j in range(len(best_data)):
            best_data[j][5] = max(best_data[j][5], data_list[j][5])
    data_list = best_data
    data_list_cufft, data_tensor_cufft = load_data_single(f'../data/benchmark_cufft_{device}_{datatype}.csv')
    x = [data_list[i][1] for i in range(len(data_list))]
    y = [data_list[i][2] for i in range(len(data_list))]
    z = np.zeros(   len(data_list) )
    dx = dy = np.ones(len(data_list) )
    dz = th.as_tensor([(data_list_cufft[i][5] - data_list[i][5]) / data_list_cufft[i][5] for i in range(len(data_list))])
    
    neg_indexes = th.where(dz < 0)
    print(device, datatype, thread_bs, neg_indexes, dz[neg_indexes])
    # assert 0
    dz = th.clamp(dz, min=-0.0)
    heatmap = th.zeros(dsize, dsize)
    cnt = 0
    mask = np.zeros_like(heatmap, dtype=np.bool)
    avg = 0
    for i in range(0,dsize):
        j = 0
        while j < dsize:
            if j + i > dsize or  i > 25 or i == 0:
                mask[i, j] = True
            else:
                heatmap[i, j] = dz[cnt]
                mask[i, j] = False
                avg += dz[cnt]
                cnt += 1
            j += 1
    rel_mean = avg / cnt
    rel_max = heatmap.max()
    
    rel_min = heatmap.min()
    name = f'{device}_{datatype}_'
    # print(avg / cnt)
    print(f"{name:<20} {rel_mean:<15.4f} {rel_max:<15.4f} {rel_min:<15.4f}")
    heatmap *= 100
    return heatmap, mask

def get_lower_tri_heatmap(df, mask, ax, output="cooc_matrix.png",if_cbar=False):
    cmap = sns.diverging_palette(220, 10, as_cmap=True)
    sns_plot = sns.heatmap(df, mask=mask, cmap=cmap, vmax=30, center=5,
            square=True, linewidths=.5, cbar_kws={"shrink": .5}, ax=ax,
             cbar=if_cbar)

fig, ax = plt.subplots(1, 3, figsize=(15, 4))

loc = [
    [.35, .3],
    [.4, .4],
    [.4, .4],
]
for i in range(3):
    if_cbar = True if i == 2 else False
    heatmap, mask = get_heatmap(file_name[i], thread_bs_list[i],datatype=datatype)
    
    # get_lower_tri_heatmap(heatmap, mask, ax[i],if_cbar=if_cbar)
#     ax[i].set_xlabel('log(Batch size)')
#     ax[i].text(.4, .3, label[i], ha='left', va='top', transform=ax[i].transAxes, fontsize=16)
#     ax[i].set_ylabel('log(N)')
# fig.suptitle('Overhead % versus cuFFT')
# fig.subplots_adjust(hspace=0.1, wspace = 0)
# fig.savefig(f"..//sc_figures//ft_optimizations_heatmap_{device}_{datatype_capital}.pdf", bbox_inches='tight')
