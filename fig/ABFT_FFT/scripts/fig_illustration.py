import matplotlib.pyplot as plt
import torch as th
x = th.as_tensor([i for i in range(200)]) / 100
y = 1 / th.sqrt(th.sqrt(x))
fig, ax = plt.subplots()

ax.plot(x, y)
# plt.show()    
fig.savefig("..\\figures\\fig_illustration.pdf")
