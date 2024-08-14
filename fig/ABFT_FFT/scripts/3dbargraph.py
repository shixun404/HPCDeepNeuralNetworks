import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
from utils import load_data, load_data_single
import torch as th

# Sample data: Create a 10x10 random matrix
data = np.random.rand(10, 10)
# name_list = ['benchmark_A100_fp32.csv', 'benchmark_A100_fp64.csv', 'benchmark_T4_fp32.csv', 'benchmark_T4_fp64.csv',]
# name_list = ['../data/benchmark_cufft_A100_fp64.csv', '../data/benchmark_turboFFT_A100_fp64.csv',
#              '../data/benchmark_offline_A100_fp64.csv', '../data/benchmark_reduction_A100_fp64.csv',
#              '../data/benchmark_reduction_turbofft_A100_fp64.csv', '../data/benchmark_twosides_fused_3_A100_fp64.csv',
#              '../data/benchmark_twoside_errinject_A100_fp64.csv',
#              ]
# name_list = ['../data/benchmark_cufft_A100_fp32.csv', '../data/benchmark_turboFFT_A100_fp32.csv',
#               '../data/benchmark_offline_A100_fp32.csv', 
#               '../data/benchmark_reduction_A100_fp32.csv',
#              '../data/benchmark_reduction_turbofft_A100_fp32.csv', 
#             '../data/benchmark_twoside_fused_A100_fp32.csv',
#             '../data/benchmark_twoside_fused_1_A100_fp32.csv',
#              '../data/benchmark_twoside_errinject_A100_fp32.csv',
#              ]
# name_list = ['../data/benchmark_cufft_T4_fp32.csv', '../data/benchmark_turboFFT_T4_fp32.csv',
#               '../data/benchmark_offline_T4_fp32.csv', 
#               '../data/benchmark_reduction_T4_fp32.csv',
#              '../data/benchmark_reduction_turbofft1_T4_fp32.csv', 
#             '../data/benchmark_twoside_fused_T4_fp32.csv',
#              '../data/benchmark_twoside_errinject_T4_fp32.csv',x
#              ]
# name_list = ['../data/benchmark_cufft_T4_fp64.csv', '../data/benchmark_turbofft_T4_fp64.csv',
#             #   '../data/benchmark_offline_T4_fp32.csv', 
#             #   '../data/benchmark_reduction_T4_fp32.csv',
#             #  '../data/benchmark_reduction_turbofft1_T4_fp32.csv', 
#             '../data/benchmark_twoside_fused_T4_fp64.csv',
#              '../data/benchmark_twoside_errinject_T4_fp64.csv',
#              ]
# name_list = ['../data/benchmark_cufft_A100_fp64.csv', '../data/turboFFT_A100_fp64_threadbs=32.csv',]
# name_list = ['../data/benchmark_cufft_A100_fp64.csv', '../data/param_A100_double2_recompute_1.csv',]
# name_list = ['../data/param_A100_double2_recompute_1.csv', '../data/param_A100_double2_DMR.csv',]
# name_list = ['../data/param_A100_float2_recompute_1.csv', '../data/param_A100_float2_DMR.csv',]
name_list = ['../data/benchmark_cufft_A100_fp32.csv', 
             '../data/benchmark_turbofft_A100_fp32.csv', 
             #'../data/param_A100_float2_threadbs=32.csv', 
             #'../data/param_A100_float2_recompute_1.csv',
              # '../data/param_A100_float2_DMR.csv',
              ]
# name_list = ['../data/turboFFT_A100_fp64_threadbs=32.csv', '../data/param_A100_double2_recompute.csv']
# name_list = ['../data/turboFFT_A100_fp64_threadbs=32.csv', '../data/param_A100_double2_recompute_1.csv']
# name_list = ['../data/turboFFT_A100_fp64_threadbs=32.csv', '../data/turboFFT_A100_fp64_threadbs=16.csv',]
# name_list = ['../data/turboFFT_batch_1.csv', '../data/turboFFT_batch_32.csv',
#              ]
data_list, data_tensor = load_data_single(name_list[-1])
data_list_cufft, data_tensor_cufft = load_data_single(name_list[0])
print((data_tensor - data_tensor_cufft).shape)

# Sample data
x = [data_list[i][1] for i in range(len(data_list))]
y = [data_list[i][2] for i in range(len(data_list))]
z = np.zeros(   len(data_list) )
dx = dy = np.ones(len(data_list) )
dz = th.as_tensor([(data_list_cufft[i][5] - data_list[i][5]) / data_list_cufft[i][5] for i in range(len(data_list))])

print(dz.mean())

dz = th.clamp(dz, min=-0.3)

# Creating figure
fig = plt.figure(figsize=(10, 7))
ax_1 = fig.add_subplot(111, projection='3d')

# Creating color map
# my_cmap = plt.get_cmap('viridis')
my_cmap = plt.get_cmap('RdBu')
color = my_cmap((dz - min(dz)) / (max(dz) - min(dz)))

# Creating plot
ax_1.bar3d(x, y, z, dx, dy, dz, color=color)
# ax_1.set_zlim(dz.min(), dz.max())
# ax.set_ylim(0, 15)

plt.title("3D Bar Graph Example")
ax_1.set_xlabel('X Axis')
ax_1.set_ylabel('Y Axis')
ax_1.set_zlabel('Z Axis')


# data_list, data_tensor = load_data_single(name_list[7])


# ax_2 = fig.add_subplot(122, projection='3d')

# # Creating color map
# # my_cmap = plt.get_cmap('viridis')
# my_cmap = plt.get_cmap('RdBu')
# color = my_cmap((dz - min(dz)) / (max(dz) - min(dz)))

# # Creating plot
# ax_2.bar3d(x, y, z, dx, dy, dz, color=color)
# ax_2.set_zlim(dz.min(), dz.max())
# # ax.set_ylim(0, 15)

# plt.title("3D Bar Graph Example")
# ax_2.set_xlabel('X Axis')
# ax_2.set_ylabel('Y Axis')
# ax_2.set_zlabel('Z Axis')


# show plot
plt.show()