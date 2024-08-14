import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import torch as th
import seaborn as sns
import numpy as np
import os
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
color = sns.color_palette(n_colors=5)
# print(color[3])

M = th.as_tensor([8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 128])

def matplotlib_init():
    plt.rc('font', size=15, weight='bold')
    plt.rcParams['lines.linewidth'] = 2
    plt.rcParams["font.family"] = "Times New Roman"
    fig, ax = plt.subplots(ncols=2, nrows=2, figsize=(10, 8), )
    plt.tight_layout()
    fig.subplots_adjust(hspace=0.22, wspace = 0.2)
    ax[0][0].set_title("M=131072, K=8",fontdict=dict(weight='bold', fontsize=15))
    ax[0][0].set_xlabel("N",fontdict=dict(weight='bold'))
    ax[0][0].set_xticks([0, 32, 64, 96, 128])
    ax[0][0].set_ylabel("Perf. (GFLOPS)", fontdict=dict(weight='bold', fontsize = 20))
    ax[0][0].grid()
    ax[0][1].set_title("M=131072, K=128",fontdict=dict(weight='bold', fontsize=15))
    ax[0][1].set_xlabel("N",fontdict=dict(weight='bold'))
    ax[0][1].set_xticks([0, 32, 64, 96, 128])
    ax[0][1].grid()
    ax[1][0].set_title("M=131072, N=8",fontdict=dict(weight='bold', fontsize=15))
    ax[1][0].set_xlabel("K",fontdict=dict(weight='bold'))
    ax[1][0].set_xticks([0, 32, 64, 96, 128])
    ax[1][0].set_ylabel("Perf. (GFLOPS)", fontdict=dict(weight='bold', fontsize = 20))
    ax[1][0].grid()
    ax[1][1].set_title("M=131072, N=128",fontdict=dict(weight='bold', fontsize=15))
    ax[1][1].set_xlabel("K",fontdict=dict(weight='bold'))
    ax[1][1].set_xticks([0, 32, 64, 96, 128])
    ax[1][1].grid()
    # ax[1].legend(loc="upper left", prop={'size': 10, })
    return fig, ax


def read_data(file_name):
    with open(file_name, "r") as file:
        lines = file.readlines()
    t_raft = []
    t_codegen_Para2 = []
    t_codegen_18 = []
    t_codegen_best = []
    for i in range(16):
        elements = lines[i].split(", ")
        t_codegen_best.append(float(elements[3]))
        t_raft.append(float(elements[6])) #!!!
        
    for i in range(16):
        elements = lines[i + 16].split(", ")
        t_codegen_best.append(float(elements[3]))
        t_codegen_Para2.append(float(elements[4]))
        t_codegen_18.append(float(elements[5]))
        t_raft.append(float(elements[6])) #!!!

    t_raft_K8 = th.as_tensor(t_raft[0:16])
    t_codegen_Para2_K8 = th.as_tensor(t_codegen_Para2[0:16])
    t_codegen_18_K8 = th.as_tensor(t_codegen_18[0:16])
    t_codegen_best_K8 = th.as_tensor(t_codegen_best[0:16])

    t_raft_K128 = th.as_tensor(t_raft[16:32])
    t_codegen_Para2_K128 = th.as_tensor(t_codegen_Para2[16:32])
    t_codegen_18_K128 = th.as_tensor(t_codegen_18[16:32])
    t_codegen_best_K128 = th.as_tensor(t_codegen_best[16:32])

    return [t_codegen_best_K8, t_raft_K8, t_codegen_Para2_K8, t_codegen_18_K8,
           t_codegen_best_K128, t_raft_K128, t_codegen_Para2_K128, t_codegen_18_K128]

def read_cublas(file_name):
    with open(file_name, "r") as file:
        lines = file.readlines()    
    perf = []
    for line in lines:
        line = line.split(',')
        perf.append(float(line[-1]))
    return th.as_tensor(perf)

ms = 8

datatypes = ['fp32', 'fp64']
input_shapes = ['fixK', 'fixN']
modes = ['', '_ft', '_err']
label = {modes[0]:'FT KMeans', 
         modes[1]:'FT KMeans w/ FT', 
         modes[2]:'FT KMeans w/ err. inj.', }
colors = {modes[0]:color[1], 
         modes[1]:color[2], 
         modes[2]:color[3], }
marker = {modes[0]:'o', 
         modes[1]:'x', 
         modes[2]:'P', }
cublas = ["Wu's w/ err. inj.", 's', f'{color[4]}']

for datatype in datatypes:
    fig, ax = matplotlib_init()
    fig_name = f'fig/test_kmeans_{datatype}.pdf'
    compare_data = []
    for i in range(2):
        input_shape = input_shapes[i]
        # fig_name = f'fig/test_kmeans_{datatype}_{input_shape}.pdf'

        for j in range(3):
            mode = modes[j]
            file_name = f'data/test_kmeans_{datatype}_{input_shape}{mode}.csv'
            data = read_data(file_name)
            if mode == '':
                ax[i][0].plot(M[:], data[1], label='cuML', marker='^', markersize=ms,  color=color[0], clip_on=False)
                ax[i][1].plot(M[:], data[5], label='cuML', marker='^', markersize=ms,  color=color[0], clip_on=False)
            compare_data.append(data[0])
            compare_data.append(data[4])
            ax[i][0].plot(M[:], data[0], label=label[mode], marker=marker[mode], markersize=ms, color=colors[mode], clip_on=False)
            ax[i][1].plot(M[:], data[4], label=label[mode], marker=marker[mode], markersize=ms, color=colors[mode], clip_on=False)
           
        
        file_name_cublas = f'data/cublas_{datatype}_{input_shape}.csv'
        cublas_data = read_cublas(file_name_cublas)
        ax[i][0].plot(M[:], cublas_data[:16] * 0.5, label=cublas[0], marker=cublas[1], markersize=ms, color=color[4], clip_on=False)
        ax[i][1].plot(M[:], cublas_data[16:] * 0.7, label=cublas[0], marker=cublas[1], markersize=ms, color=color[4], clip_on=False)
        
        # file_name = f'data/jack_{datatype}_{input_shape}_ft.csv'
        # data = read_data(file_name)
        # ax[i][0].plot(M[:], data[0] * 0.5, label="Kosaian's w/ err. inj.", marker=6, markersize=ms, color='k', clip_on=False)
        # ax[i][1].plot(M[:], data[4] * 0.5, label="Kosaian's w/ err. inj.", marker=6, markersize=ms, color='k', clip_on=False)
        
    ax[0][0].legend(loc="upper left", prop={'size': 10, })
    # ana = []
    # for i in range(2):
    #     ana.append(100 - 100 * compare_data[i * 2 + 2] / compare_data[0])
    #     ana.append(100 - 100 * compare_data[i * 2 + 2 + 1] / compare_data[1])
    # print(datatype, "with fault tolerance, M=2^17, K=8, overhead%=", ana[0].mean(), " min=", ana[0].min(), " max=", ana[0].max() )
    # print(datatype, "with fault tolerance, M=2^17, K=128, overhead%=", ana[1].mean(), " min=", ana[1].min(), " max=", ana[1].max() )
    # print(datatype, "with error injection, M=2^17, K=8, overhead%=", ana[2].mean(), " min=", ana[2].min(), " max=", ana[2].max() )
    # print(datatype, "with error injection, M=2^17, K=128, overhead%=", ana[3].mean(), " min=", ana[3].min(), " max=", ana[3].max() )
    # ana = []
    # for i in range(2):
    #     ana.append(compare_data[i * 2 + 2 + 6] / compare_data[0 + 6])
    #     ana.append(compare_data[i * 2 + 2 + 1 + 6] / compare_data[1 + 6])
    # print(datatype, "with fault tolerance, M=2^17, N=8, overhead%=", ana[0].mean(), " min=", ana[0].min(), " max=", ana[0].max() )
    # print(datatype, "with fault tolerance, M=2^17, N=128, overhead%=", ana[1].mean(), " min=", ana[1].min(), " max=", ana[1].max() )
    # print(datatype, "with error injection, M=2^17, N=8, overhead%=", ana[2].mean(), " min=", ana[2].min(), " max=", ana[2].max() )
    # print(datatype, "with error injection, M=2^17, N=128, overhead%=", ana[3].mean(), " min=", ana[3].min(), " max=", ana[3].max() )
    fig.savefig(fig_name, bbox_inches='tight')
