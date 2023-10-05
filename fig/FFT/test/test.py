import torch as th
import math
vec = th.ones(10, dtype=th.cfloat)
w = -0.5 + (math.sqrt(3) / 2) * 1.j
for i in range(9):
    vec[i+1] = vec[i] * w
print(vec)
print(w)