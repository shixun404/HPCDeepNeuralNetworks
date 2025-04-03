import torch as th
device = th.device("cuda")
dtype = th.float32
print(th.__version__)
M = 100
N = 100
K = 100
print("asas")
A = th.randn(M, K, dtype=dtype, device=device)
# B = th.randn(K, N, dtype=dtype, device=device)
# C = th.randn(M, N, dtype=dtype, device=device)
# e1 = th.ones(M, 1, dtype=dtype, device=device)
# e2 = th.ones(N, 1, dtype=dtype, device=device)

# alpha = 2.0
# beta = -1.5

# res = A @ B

# res_checksum = e1.T @ res @ e2
# ref_checksum = (e1.T @ A) @ (B @ e2)

# delta = ref_checksum -  res_checksum
