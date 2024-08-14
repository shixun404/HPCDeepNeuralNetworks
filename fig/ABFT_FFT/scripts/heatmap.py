import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from fig.ABFT_FFT.scripts.turbofft_bench import load_data
import torch as th

# Sample data: Create a 10x10 random matrix
data = np.random.rand(10, 10)
# name_list = ['benchmark_A100_fp32.csv', 'benchmark_A100_fp64.csv', 'benchmark_T4_fp32.csv', 'benchmark_T4_fp64.csv',]
name_list = ['../data/benchmark_DMR_A100_fp64.csv']
data_list, data_tensor = load_data(name_list[0])
delta_data = (data_tensor[1] - data_tensor[0]) / data_tensor[0]

# print(delta_data.max(), delta_data.mean())
# assert 0
# Create a heatmap
plt.figure(figsize=(8, 6))
sns.heatmap(delta_data[:, :, 1], annot=False, cmap='viridis')

# Adding title and labels
plt.title('Heatmap Example')
plt.xlabel('X Axis Label')
plt.ylabel('Y Axis Label')

# Show the plot
plt.show()