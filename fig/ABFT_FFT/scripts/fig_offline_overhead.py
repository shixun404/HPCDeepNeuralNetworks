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
    fig = plt.figure(figsize=(20, 10))
    # name_list = ['benchmark_A100_fp32.csv', 'benchmark_A100_fp64.csv', 'benchmark_T4_fp32.csv', 'benchmark_T4_fp64.csv',]
    name_list = ['../data/benchmark_oneside_offline_T4_fp32.csv', '../data/benchmark_twosides_offline_T4_fp32.csv',]
    title_list = ['1-side ABFT vs. cuFFT', '2-sides ABFT vs. cuFFT']
    title_pos_x = [0.2, 0.6]
    roofline_pos_x = [0.205, 0.405, 0.59, 0.78, 0.205, 0.405, 0.59, 0.78]
    title_pos_y = [0.65, 0.65, 0.78, 0.78, 0.4, 0.4, 0.4, 0.4]
    roofline_pos_y = [0.73, 0.73, 0.73, 0.73, 0.35, 0.35, 0.35, 0.35]
    # c_peak = [19.5, ]
    j = 0
    data_list_cufft, data_tensor_cufft = load_data_single('../data/benchmark_cufft_T4_fp32.csv')
    shape = 120
    n_col = 2
    n_row = 1
    for filename in name_list:
        data_list, data_tensor = load_data_single(filename)
        
        # First 3D subplot
        ax1 = fig.add_subplot(shape + j + 1, projection='3d')
        # Creating plot
        
        # Sample data
        x = [data_list[i][1] for i in range(len(data_list))]
        y = [data_list[i][2] for i in range(len(data_list))]
        # print(x, y)
        z = np.zeros(   len(data_list) )
        dx = dy = np.ones(len(data_list) )
        dz = th.as_tensor([(data_list_cufft[i][5] - data_list[i][5]) / data_list_cufft[i][5] for i in range(len(data_list))])

        # dz = th.clamp(dz, min=-0.05, max=2)

        # Creating figure

        # Creating color map
        # my_cmap = plt.get_cmap('viridis')
        my_cmap = plt.get_cmap('RdBu')
        color = my_cmap((dz - min(dz)) / (max(dz) - min(dz)))

        # Creating plot
        ax1.bar3d(x, y, z, dx, dy, dz, color=color)
        # ax1.set_zlim(dz.min(), dz.max())
        # ax1.set_xlim(1, 30)
        # ax1.set_ylim(1, 30)
        # ax.set_ylim(0, 15)

        ax1.view_init(elev=20, azim=20)

        # Adding labels and title
        ax1.set_xlabel('\nlogN',linespacing=2)
        ax1.set_ylabel('\nlogBS',linespacing=2)
        ax1.set_zlabel('\nOverhead')
        # ax1.set_zticks(zticks[j * 2])
        # ax1.set_zticklabels(zlim_label[j * 2])
        # plt.title('3D Scatter plot')
        # t1 = ax1.set_title('Computation')
        plt.figtext(title_pos_x[j], title_pos_y[j], title_list[j])
        # plt.figtext(roofline_pos_x[j * 2], roofline_pos_y[j * 2], 'Roofline Model', fontsize=15)
        # plt.annotate('Computation', (0.25, 0.85))
        # t1.set_position([0.5, 2])
        # t2 = ax2.set_title('Memory Bandwidth')
        # plt.figtext(title_pos_x[j * 2 + 1], title_pos_y[j * 2 + 1], title_list[j * 2 + 1])
        # plt.figtext(roofline_pos_x[j * 2 + 1], roofline_pos_y[j * 2 + 1], 'Roofline Model', fontsize=15)
        # plt.annotate('Mem Bandwidth', (0.75, 0.85))
        j += 1

    # t2.set_position([0.5, 2])

    fig.tight_layout()
    # fig.subplots_adjust(top=0.95)
    plt.subplots_adjust(bottom=0, wspace=-0.15, hspace=0, top=0.8)
    # plt.suptitle('Offline Overhead vs. cuFFT')
    # handles, labels = ax1.get_legend_handles_labels()
    # fig.legend(handles, labels, bbox_to_anchor=(0.6, 0.1), ncol=2)

    # Show plot
    # plt.show()

    fig.savefig('..\\figures\\offline_overhead.pdf',bbox_inches='tight')