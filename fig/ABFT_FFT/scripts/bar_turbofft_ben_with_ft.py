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

              ['../data/benchmark_cufft_T4_fp64.csv', '../data/benchmark_turboFFT_T4_fp64.csv',
              '../data/benchmark_cufft_T4_fp64.csv', 
              '../data/benchmark_cufft_T4_fp64.csv', 
              '../data/benchmark_cufft_T4_fp64.csv', 
            '../data/benchmark_twoside_fused_T4_fp64.csv',
             '../data/benchmark_twoside_errinject_T4_fp64.csv',
             ],
             ]
    title_list = [
        # '(a) turboFFT w/o FT', '(b) turboFFT w/ FT', '(c) turboFFT err. injection',
        # '(a) turboFFT w/o FT', '(b) turboFFT w/ FT', '(c) turboFFT err. Injection',
        # '(a) turboFFT w/o FT', '(b) turboFFT w/ FT', '(c) turboFFT err. Injection',
        # '(a) turboFFT w/o FT', '(b) turboFFT w/ FT', '(c) turboFFT err. Injection',
        '(a) turboFFT w/o FT', '(a) turboFFT w/ FT', '(b) turboFFT err. injection',
        '(a) turboFFT w/o FT', '(a) turboFFT w/ FT', '(b) turboFFT err. Injection',
        '(a) turboFFT w/o FT', '(a) turboFFT w/ FT', '(b) turboFFT err. Injection',
        '(a) turboFFT w/o FT', '(a) turboFFT w/ FT', '(b) turboFFT err. Injection',
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
    
    fig_name = ['A100_fp64', 'A100_fp32', 'T4_fp32', 'T4_fp64' ]
    k = 0
    order = [1, 5, 6]
    # fig = plt.figure(figsize=(15, 20))
    for name_list in name_lists:
        fig = plt.figure(figsize=(18, 25))
        data_list_cufft, data_tensor_cufft = load_data_single(name_list[0])
        n_col = 3
        n_row = 4
        dz_min = 0
        dz_max = 1.5
        # i = -1
        # i += 1
        # name_list.reverse()
        # for filename in name_list[2:6]:

        # for j in range(1, 1 + len(order)):
        for j in range(2, 1 + len(order)):
            filename = name_list[order[j - 1]]
            
            data_list, data_tensor = load_data_single(filename)
            sum = 0
            n = 0
            cnt = 0
            for i in range(len(data_list)):
                if data_list_cufft[i][3] != 0:
                    sum += (data_list[i][3] - data_list_cufft[i][3]) / data_list_cufft[i][3]
                    n += 1
                    if sum < 0:
                        cnt += 1
            print(filename, sum / n, cnt, cnt / n, n)
            
            # First 3D subplot
            ax1 = fig.add_subplot(n_row, n_col, j + k * 3, projection='3d')
            # Creating plot
            
            # Sample data
            x = [data_list[i][1] for i in range(len(data_list))]
            y = [data_list[i][2] for i in range(len(data_list))]
            # print(x, y)
            z = np.zeros(   len(data_list) )
            dx = dy = np.ones(len(data_list) )
            # if j == 3:
            #     dz = th.as_tensor([(data_list_cufft[i][5] - data_list[i][5]) / data_list_cufft[i][5] + 0.05 for i in range(len(data_list))])
            # else:
            #     dz = th.as_tensor([(data_list_cufft[i][5] - data_list[i][5]) / data_list_cufft[i][5] for i in range(len(data_list))])

            dz = th.as_tensor([(data_list[i][5]) / data_list_cufft[i][5] for i in range(len(data_list))])
            
            dz = th.clamp(dz, min=dz_min, max=dz_max)
            dz *= 100

            dz -= 90
            # Creating figure

            # Creating color map
            # my_cmap = plt.get_cmap('viridis')
            my_cmap = plt.get_cmap('RdBu')
            # color = my_cmap((dz - min(dz)) / (max(dz) - min(dz)))
            # color = my_cmap((dz - 90) / 100)
            color = my_cmap((dz - 90) / 20)

            # Creating plot
            ax1.bar3d(x, y, z, dx, dy, dz, color=color)
            ax1.set_zlim(dz_min * 100, dz_max * 100)

            elev = 20
            
            ax1.view_init(elev=elev, azim=20)

            # Adding labels and title
            ax1.set_xlabel('\nlogN',linespacing=2)
            ax1.set_ylabel('\nlogBS',linespacing=2)
            if j == 1:
                ax1.set_zlabel('Overhead\%\n')
            if j == 1:
                ax1.text(30, 0, 50, title_list[j - 1])
            else:
                ax1.text(25, 0, 50, title_list[j - 1])

        plt.tight_layout()
        plt.subplots_adjust(bottom=0, wspace=0, hspace=-0.15, top=0.8)
        

        fig.savefig(f'..\\figures\\revision_FT_turbofft_bench_{fig_name[k]}.pdf',bbox_inches='tight')
        k += 1
    # plt.tight_layout()
    # plt.subplots_adjust(bottom=0, wspace=0, hspace=-0.15, top=0.8)
    # fig.savefig(f'..\\figures\\FT_turbofft_bench.pdf',bbox_inches='tight')