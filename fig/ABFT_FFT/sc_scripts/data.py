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
dsize = [28, 28, 26, 26]
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
def get_heatmap(file_name, cufft_name, info, dsize):
    best_data, data_tensor = load_data_single(file_name)
    data_list = best_data
    data_list_cufft, data_tensor_cufft = load_data_single(cufft_name)
    dz = th.as_tensor([(data_list_cufft[i][5] - data_list[i][5]) / data_list_cufft[i][5] for i in range(len(data_list))])
    # dz = th.clamp(dz, min=-0.0)
    
    cnt = 0
    
    avg = 0
    rel_mean = dz.mean()
    rel_max = dz.max()
    
    rel_min = dz.min()
    name = info
    # print(avg / cnt)
    print(f"{name:<20} {rel_mean:<15.4f} {rel_max:<15.4f} {rel_min:<15.4f}")
    # heatmap *= 100
    return 

name_lists = [['benchmark_cufft_A100_fp32.csv','benchmark_turbofft_A100_fp32.csv'], 
                ['benchmark_cufft_A100_fp64.csv', 'benchmark_turbofft_A100_fp64.csv'],
                    ['benchmark_cufft_T4_fp32.csv', 'benchmark_turbofft_T4_fp32.csv'],
                    ['benchmark_cufft_T4_fp64.csv', 'benchmark_turbofft_T4_fp64.csv'],
                    ]
info_list = [
    'A100_fp32',
    'A100_fp64',
    'T4_fp32',
    'T4_fp64',
             ]
path = '../data/'
i = 0
for i in range(4):
    get_heatmap(path+name_lists[i][1], path+name_lists[i][0], info_list[i],dsize[i])
