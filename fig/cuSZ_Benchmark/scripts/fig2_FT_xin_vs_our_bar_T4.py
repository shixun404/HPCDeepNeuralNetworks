import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import os
import pandas as pd
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
color = sns.color_palette(n_colors=7)
cmp_name = ['cuSZ', 'cuSZ-I', 'cuSZp', 'cuSZx', 'cuZFP', 'FZ-GPU', 'cuSZ-I_bitcomp' ]
dataset_name_excel = ['miranda', 'jhtdb', 'rtm', 'qmcpack', 'S3D', 'nyx']
dataset_name_plot = ['miranda', 'jhtdb', 'rtm', 'qmcpack', 'S3D', 'nyx']

cmp_data = {}
decmp_data = {}
for dataset in dataset_name_excel:
	cmp_tp = {}
	decmp_tp = {}	
	for cmp in cmp_name:
		cmp_tp[cmp] = []
		decmp_tp[cmp] = []
	cmp_data[dataset] = cmp_tp
	decmp_data[dataset] = decmp_tp

for dataset in dataset_name_excel:
	df = pd.read_excel("..\\Data\\theta_a100.xlsx", sheet_name=dataset, header=None)
	for i in range(len(df)):
		cmp = df.iloc[i][0]
		# print(cmp)
		if df.iloc[i][0] in cmp_name:
			if cmp == 'cuZFP':
				cmp_data[dataset][cmp].append(df.iloc[i + 3][7])
				cmp_data[dataset][cmp].append(df.iloc[i + 4][7])
				cmp_data[dataset][cmp].append(df.iloc[i + 5][7])
				decmp_data[dataset][cmp].append(df.iloc[i + 3][8])
				decmp_data[dataset][cmp].append(df.iloc[i + 4][8])
				decmp_data[dataset][cmp].append(df.iloc[i + 5][8])
			else:
				cmp_data[dataset][cmp].append(df.iloc[i + 2][7])
				cmp_data[dataset][cmp].append(df.iloc[i + 4][7])
				cmp_data[dataset][cmp].append(df.iloc[i + 6][7])
				decmp_data[dataset][cmp].append(df.iloc[i + 2][8])
				decmp_data[dataset][cmp].append(df.iloc[i + 4][8])
				decmp_data[dataset][cmp].append(df.iloc[i + 6][8])
			if cmp == 'cuSZ-I':
				cmp_data[dataset][cmp_name[-1]].append(df.iloc[i + 2][17])
				cmp_data[dataset][cmp_name[-1]].append(df.iloc[i + 4][17])
				cmp_data[dataset][cmp_name[-1]].append(df.iloc[i + 6][17])
				decmp_data[dataset][cmp_name[-1]].append(df.iloc[i + 2][18])
				decmp_data[dataset][cmp_name[-1]].append(df.iloc[i + 4][18])
				decmp_data[dataset][cmp_name[-1]].append(df.iloc[i + 6][18])


def addlabels(x,y):
    for i in range(len(x)):
        print(f'{y[i]:.2f}')
        plt.text(x[i], y[i]+10, f'{y[i]:.0f}', ha = 'center', fontsize=26) 
# set width of bar
barWidth = 0.4

plt.rc('font', size=30, weight='bold')
plt.rcParams["font.family"] = "Times New Roman"
fig, ax = plt.subplots(nrows=2, ncols=3, figsize =(32, 14))


plt.rcParams["hatch.color"] = 'white'
plt.rcParams['hatch.linewidth'] = 3.0
# gflops_cufft = th.as_tensor([425.5, 481.0, 488.0, 500, 510,515, 520, 529.9, 552.9,])

br1 = np.arange(3) * 3 - barWidth * 3
# br2 = th.as_tensor(np.arange(9) * 2 + barWidth * 1.6)
# br3 = th.as_tensor(np.arange(9) * 2 + barWidth * 3.1)
# Make the plot
bar_edge_color = color[3]
# print(ax.shape)
cmp_name = deepcopy.copy(cmp_name_)
for i in range(len(dataset_name_plot)):
	BarPlots = []
	for j in range(len(cmp_name)):
		sa = ax[int(i / 3)][i % 3]
		BarPlot = sa.bar(br1 + barWidth * j, cmp_data[dataset_name_plot[i]][cmp_name[j]], color = color[j], width = barWidth,
				edgecolor = 'white', label = cmp_name[j], zorder=3)# , hatch='//')
		BarPlots.append(BarPlot)
		# Adding Xticks
		if int(i / 3) == 1:
			sa.set_xlabel('Error Bound',  fontsize = 30, fontdict=dict(weight='bold'))
		if i % 3 == 0:
			sa.set_ylabel('Throughput (GB/s)',  fontsize = 30, fontdict=dict(weight='bold'))
		sa.set_xticks(br1 + barWidth * 3)
		sa.set_xticklabels(['1e-2', '1e-3', '1e-4', ])
		sa.set_title(dataset_name_plot[i], loc='center')
		sa.grid(linestyle='--', linewidth=0.7, zorder=0)
	label = [l.get_label() for l in BarPlots]
plt.subplots_adjust(bottom=0.2, hspace=0.3, wspace=0.1)
# plt.subplots_adjust(bottom=0.1, hspace=0.5, wspace=0.5)
handles, labels = ax[0, 0].get_legend_handles_labels()
fig.legend(handles, labels, loc='lower center', bbox_to_anchor=(0.5, 0.01), ncol=4)

# plt.legend(BarPlots, label, loc = 'upper center', framealpha=0, ncol=3, fontsize=25,labelspacing = 0.2,columnspacing=0.5)	
# ax.set_yticks([0, 200, 400, 600])
# ax.set_yticklabels([f'{i * 200}' for i in range(4)], rotation=90)
# ax.set_ylim([0, 650])
# ax.set_xlim([-0.4, br3[-1]+0.5])
# ax.grid(linestyle='--', linewidth=0.7, zorder=0)
# lns = [xin_c] + [xin_cm] + [ft_c] + [ft_cm] + [fft]
# label = [l.get_label() for l in lns]
# plt.legend(lns, label, loc = 'upper center', framealpha=0, ncol=3, fontsize=25,labelspacing = 0.2,columnspacing=0.5)
fig.savefig("..\\figures\\theta_a100.pdf",bbox_inches='tight')
