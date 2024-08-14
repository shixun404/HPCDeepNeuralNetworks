import torch as th
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
from random import randint
from utils import load_data, load_data_single

if __name__ == '__main__':
    logN = [i for i in range(1, 26, 1)]
    logBS = [i for i in range(0, 29, 1)]

    surface_z = [4.5, 1.5, 2.5, 1.5, 1, 0.3, 0.2, 0.3]
    zticks = [[0, 2, 4, 5], [0, 0.5, 1, 1.5], [0, 1, 2, 2.5], [0, 0.5, 1, 1.5], [0, 0.5, 1], [0, 0.1, 0.2, 0.3], [0, 0.1, 0.2], [0, 0.1, 0.2, 0.3]]
    zlim_label = [['0', '2', '4', '19.5'], ['0', '0.5', '1', '1.55'], ['0', '1', '2', '9.7'], ['0', '0.5', '1', '1.55'], ['0', '0.5', '8.1'], ['0', '0.1', '0.2', '0.3'],
                ['0', '0.1', '0.2'], ['0', '0.1', '0.2', '0.3']]
                
    # Creating figure
    # fig = plt.figure()
    plt.rcParams['lines.linewidth'] = 0.5
    plt.rcParams["font.family"] = "Times New Roman"
    plt.rc('font', size=30, weight='bold')
    plt.rcParams["font.family"] = "Times New Roman"
    plt.rcParams["hatch.color"] = 'white'
    plt.rcParams['hatch.linewidth'] = 2.0
    # name_list = ['benchmark_A100_fp32.csv', 'benchmark_A100_fp64.csv', 'benchmark_T4_fp32.csv', 'benchmark_T4_fp64.csv',]
    # name_list = ['../data/benchmark_oneside_offline_T4_fp32.csv', '../data/benchmark_twosides_offline_T4_fp32.csv',]

    name_lists = [ ['../data/benchmark_cufft_A100_fp64.csv', '../data/benchmark_turboFFT_A100_fp64.csv',
             '../data/benchmark_offline_A100_fp64.csv', '../data/benchmark_reduction_A100_fp64.csv',
             '../data/benchmark_reduction_turbofft_A100_fp64.csv', '../data/benchmark_twosides_fused_3_A100_fp64.csv',
             '../data/benchmark_twoside_errinject_A100_fp64.csv',
             ], 
             ['../data/benchmark_cufft_A100_fp32.csv', '../data/benchmark_turboFFT_A100_fp32.csv',
              '../data/benchmark_offline_A100_fp32.csv', 
              '../data/benchmark_reduction_A100_fp32.csv',
             '../data/benchmark_reduction_turbofft_A100_fp32.csv', 
            '../data/benchmark_twoside_fused_A100_fp32.csv',
            # '../data/benchmark_twoside_fused_1_A100_fp32.csv',
             '../data/benchmark_twoside_errinject_A100_fp32.csv',
             ], ['../data/benchmark_cufft_T4_fp32.csv', '../data/benchmark_turboFFT_T4_fp32.csv',
              '../data/benchmark_offline_T4_fp32.csv', 
              '../data/benchmark_reduction_T4_fp32.csv',
             '../data/benchmark_reduction_turbofft_T4_fp32.csv', 
            '../data/benchmark_twoside_fused_T4_fp32.csv',
             '../data/benchmark_twoside_errinject_T4_fp32.csv',
             ], 
             ]
    title_list = [
        ' Offline \nA100 FP64\n    (a)  ', ' Optim-1 \nA100 FP64\n    (b)  ', ' Optim-2 \nA100 FP64\n    (c)  ', 'turboFFT w/FT\n A100 FP64  \n    (d)  ',
        ' Offline \nA100 FP32\n    (a)  ', ' Optim-1 \nA100 FP32\n    (b)  ', ' Optim-2 \nA100 FP32\n    (c)  ', 'turboFFT w/FT\n A100 FP32  \n    (d)  ',
        'Offline\nT4 FP32\n    (a)  ', 'Optim-1\nT4 FP32\n    (b)  ', 'Optim-2\nT4 FP32\n    (c)  ', 'turboFFT w/FT\n  T4 FP32  \n    (d)  ',
                  ]
    # title_pos_x = [0.2, 0.6]
    title_pos_x = th.as_tensor([0.175, 0.375, 0.57, 0.80, 
                   0.175, 0.375, 0.58, 0.80,
                   0.175, 0.375, 0.58, 0.80])
    
    
    
    roofline_pos_x = [0.205, 0.405, 0.59, 0.78, 0.205, 0.405, 0.59, 0.78]
    title_pos_y = th.as_tensor([0.7, 0.7, 0.7, 0.7,
                0.45, 0.45, 0.45, 0.45,
                0.15, 0.15, 0.15, 0.15,])
    
    title_pos_y -= 0.1
    title_pos_y[-4:] += 0.05
    title_pos_y[4:8] -= 0.04
    roofline_pos_y = [0.73, 0.73, 0.73, 0.73, 0.35, 0.35, 0.35, 0.35]
    # c_peak = [19.5, ]
    
    fig_name = ['A100_fp64', 'A100_fp32', 'T4_fp32']
    k = 0
    order = [3, 4, 1, 2]
    for name_list in name_lists:
        fig = plt.figure(figsize=(18, 18))
        data_list_cufft, data_tensor_cufft = load_data_single(name_list[0])
        shape = 220
        n_col = 2
        n_row = 2
        dz_min = -0.3
        dz_max = 0.8
        # i = -1
        j = 4
        # i += 1
        # name_list.reverse()
        # for filename in name_list[2:6]:

        for j in order:
            filename = name_list[j + 1]
            data_list, data_tensor = load_data_single(filename)
            
            # First 3D subplot
            ax1 = fig.add_subplot(n_row, n_col, j, projection='3d')
            # Creating plot
            
            # Sample data
            x = [data_list[i][1] for i in range(len(data_list))]
            y = [data_list[i][2] for i in range(len(data_list))]
            # print(x, y)
            z = np.zeros(   len(data_list) )
            dx = dy = np.ones(len(data_list) )
            dz = th.as_tensor([(data_list_cufft[i][5] - data_list[i][5]) / data_list_cufft[i][5] for i in range(len(data_list))])
            
            dz = th.clamp(dz, min=dz_min, max=dz_max)
            dz *= 100
            # Creating figure

            # Creating color map
            # my_cmap = plt.get_cmap('viridis')
            my_cmap = plt.get_cmap('RdBu')
            # color = my_cmap((dz - min(dz)) / (max(dz) - min(dz)))
            color = my_cmap((dz - dz_min * 100) / (dz_max * 100 - (dz_min * 100)))

            # Creating plot
            ax1.bar3d(x, y, z, dx, dy, dz, color=color)
            # ax1.set_zlim(dz.min(), dz.max())
            ax1.set_zlim(dz_min * 100, dz_max * 100)
            # ax1.set_xlim(1, 30)
            # ax1.set_ylim(1, 30)
            # ax.set_ylim(0, 15)

            ax1.view_init(elev=20, azim=20)

            # Adding labels and title
            ax1.set_xlabel('\nlogN',linespacing=2)
            ax1.set_ylabel('\nlogBS',linespacing=2)
            ax1.set_zlabel('\nOverhead\%')
            ax1.text(32, 18, -4,title_list[j - 1 + k * 4])
            # j += 1
            # j -= 1

        # t2.set_position([0.5, 2])

        plt.tight_layout()
        # fig.subplots_adjust(top=0.95)
        plt.subplots_adjust(bottom=0, wspace=-0.1, hspace=-0.15, top=0.8)
        
        # plt.tight_layout()
        # plt.suptitle('Offline Overhead vs. cuFFT')
        # handles, labels = ax1.get_legend_handles_labels()
        # fig.legend(handles, labels, bbox_to_anchor=(0.6, 0.1), ncol=2)

        # Show plot
        # plt.show()

        fig.savefig(f'..\\figures\\twoside_abft_stepwise_optimization_{fig_name[k]}.pdf',bbox_inches='tight')
        k += 1