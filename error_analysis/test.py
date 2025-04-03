#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import roc_curve, auc
import math
import torch as th

# def bit_flip_no_nan(val, max_retries=5, dtype=th.float32):
#     """
#     对 float32 的 val 进行随机单比特翻转，若产生 NaN 则重试。
#     最多尝试 max_retries 次，若都失败则返回原值 (可改为其他处理逻辑)。
#     """
#     original_val = val
#     for _ in range(max_retries):
#         # 把 float32 转为 uint32
#         # 翻转该 bit
#         # print(type(bits))

#         # 转回 float32
#         if dtype is th.float32:
#             bits = np.frombuffer(np.array(val, dtype=np.float32).tobytes(), dtype=np.uint32)[0]
#             bit_pos = np.random.randint(32)
#             flipped_bits = bits ^ (1 << bit_pos)
#             faulty_val = np.frombuffer(np.uint32(flipped_bits).tobytes(), dtype=np.float32)[0]
#         else:
#             bits = np.frombuffer(np.array(val, dtype=np.float64).tobytes(), dtype=np.uint64)[0]
#             bit_pos = np.random.randint(64)
#             mask = np.uint64(1) << np.uint64(bit_pos)
#             flipped_bits = bits ^ mask
#             faulty_val = np.frombuffer(np.uint64(flipped_bits).tobytes(), dtype=np.float64)[0]

#         # 检查是否 NaN
#         if not math.isnan(faulty_val):
#             return faulty_val
    
#     # 如果多次重试仍然产生 NaN，则返回原值 (或按需处理)
#     return original_val


def bit_flip_no_nan(val, max_retries=5, dtype=th.float32):
    """
    Flip exactly one random bit in 'val' (interpreted as having PyTorch dtype='dtype').
    - If the dtype is a floating type (float16, bfloat16, float32, float64),
      we attempt to avoid returning NaN by retrying up to 'max_retries'.
    - If the dtype is int8 or any non-floating type, we just flip once and return.

    Returns the flipped value (Python float or int, depending on dtype).
    """
    # A mapping from PyTorch dtype -> (NumPy storage dtype, NumPy unsigned dtype, bit_width)
    # NOTE: bfloat16 is not natively supported by NumPy, so we treat it similarly to float16
    #       for the demonstration. Real bfloat16 might need special packing/unpacking logic.
    dtype_map = {
        th.float16:   (np.float16,  np.uint16, 16),
        th.bfloat16:  (np.float16,  np.uint16, 16),  # Fake handle as float16 bits
        th.float32:   (np.float32,  np.uint32, 32),
        th.float64:   (np.float64,  np.uint64, 64),
        th.int8:      (np.int8,     np.uint8,   8),
    }

    if dtype not in dtype_map:
        raise NotImplementedError(f"dtype {dtype} not in dtype_map.")

    np_storage, np_unsigned, bit_width = dtype_map[dtype]

    # Convert 'val' to the chosen NumPy storage type (e.g. float16, int8, etc.)
    # If 'val' is a tensor, convert to Python scalar or NumPy first.
    # If 'val' is a Python float/int, just np.array([val], dtype=np_storage) or np_storage(val).
    val_arr = np.array(val, dtype=np_storage)  # shape (), a 0D array

    # We'll handle only 1 flip. If it's a floating type, we allow up to 'max_retries' to avoid NaN.
    def do_one_flip(x):
        # Interpret as unsigned integer
        bits_view = np.frombuffer(x.tobytes(), dtype=np_unsigned)[0]
        # Random bit position
        bit_pos = np.random.randint(bit_width)
        # Flip
        flipped_bits = bits_view ^ (np_unsigned(1) << np_unsigned(bit_pos))
        # Convert back to storage dtype
        return np.frombuffer(np_unsigned(flipped_bits).tobytes(), dtype=np_storage)[0]

    # If not a floating type, just flip once and return
    if not dtype.is_floating_point:
        return do_one_flip(val_arr)

    # Otherwise, it's float16/bfloat16/float32/float64
    # We do repeated attempts to avoid returning a NaN
    original_val = val_arr
    for _ in range(max_retries):
        flipped_val = do_one_flip(val_arr)
        # Convert to Python float for checking NaN
        float_check = float(flipped_val)
        if not math.isnan(float_check) and not math.isinf(float_check):
            return flipped_val

    # If we still get NaN after max_retries, just return original
    return original_val

def inject_fault_in_AB_no_nan(AB, fault_prob=0.05, max_retries=5, dtype=th.float32):
    """
    在矩阵 AB (float32) 中，按给定概率 fault_prob 注入一个 bit flip。
    如若翻转后出现 NaN，则进行重试，直到不产生 NaN 或超出重试上限。
    """
    if np.random.rand() < fault_prob:
        n = AB.shape[0]
        # 随机选一个元素 [i, j]
        i = np.random.randint(n)
        j = np.random.randint(n)
        val = AB[i, j].item()
        
        # 进行 bit flip，但要避免 NaN
        faulty_val = bit_flip_no_nan(val, max_retries=max_retries, dtype=dtype)
        AB[i, j] = th.as_tensor(faulty_val, dtype=dtype, device='cuda:0')

    return AB

# def compute_delta(A, B, AB=None, dtype=np.float32):
#     """
#     Compute delta = e'(AB)e - (e' A)(B e).
#     If AB is precomputed (and possibly corrupted), pass it in;
#     otherwise we'll compute it here (uncorrupted).
#     """
#     n = A.shape[0]
#     e = np.ones((n, 1), dtype=dtype)
    
#     # If not provided, compute AB
#     if AB is None:
#         AB = A @ B
    
#     # e'(AB)e => shape: (1,1)
#     val1 = e.T @ AB @ e
#     val1 = val1.item()
    
#     # (e' A)(B e) => shape: (1,1)
#     val2 = (e.T @ A) @ (B @ e)
#     val2 = val2.item()
    
#     return val1 - val2


def compute_delta(A, B, AB=None, dtype=th.float32, error_mode='relative', eps=1e-12):
    """
    Compute the error = e'(AB)e - (e' A)(B e) in either absolute or relative sense.
    
    Parameters:
    -----------
    A, B : np.ndarray
        Input matrices of shape (n, n).
    AB : np.ndarray or None
        If provided, use this matrix as the product AB (possibly corrupted).
        If None, compute it fresh as A @ B.
    dtype : numpy dtype
        Floating-point precision (default np.float32).
    error_mode : str, optional
        "absolute" => return |val1 - val2|
        "relative" => return |val1 - val2| / max(eps, |val2|)
    eps : float, optional
        Small number to avoid division by zero in relative error.

    Returns:
    --------
    error_val : float
        The computed error (absolute or relative).
    """
    n = A.shape[0]
    e = th.ones((n, 1), dtype=dtype, device='cuda:0')
    
    # If AB not provided, compute it here
    if AB is None:
        AB = A @ B
    
    # e'(AB)e => shape: (1,1)
    val1 = (e.T @ AB @ e).item()
    
    # (e' A)(B e) => shape: (1,1)
    val2 = ((e.T @ A) @ (B @ e)).item()

    # Convert results back to float16 if needed
    result_val1 = th.tensor(val1, dtype=th.float16)
    result_val2 = th.tensor(val2, dtype=th.float16)
    
    diff = val1 - val2
    
    if error_mode == 'relative':
        # Avoid division by zero by taking max(eps, abs(val2)) or another denominator
        denom = max(eps, abs(val2))
        if math.isnan(abs(diff) / denom) or math.isinf(abs(diff) / denom):
            # print('A.shape: ', A.shape)
            # print('B.shape: ', B.shape)
            # print('AB: ', AB)
            # has_nan = th.isnan(AB).any()
            # print(has_nan)  # True
            # print('(e.T @ A):', (e.T @ A) )
            # print('(B @ e):', (B @ e) )
            # print('val1: ', val1)
            # print('val2: ', val2)
            # print(diff, denom)
            # assert 0
            e_fp32 = e.to(dtype=th.float32)
            AB_fp32 = AB.to(dtype=th.float32)
            A_fp32 = A.to(dtype=th.float32)
            B_fp32 = B.to(dtype=th.float32)

            # Compute values in float32
            val1 = (e_fp32.T @ AB_fp32 @ e_fp32).item()
            val2 = ((e_fp32.T @ A_fp32) @ (B_fp32 @ e_fp32)).item()
            diff = val1 - val2
            denom = max(eps, abs(val2))
            if math.isnan(abs(diff) / denom) or math.isinf(abs(diff) / denom):
                print('A.shape: ', A_fp32.shape)
                print('B`.shape: ', B_fp32.shape)
                print('AB: ', AB_fp32)
                has_nan = th.isnan(AB_fp32).any()
                print('has_nan:', has_nan)  # True
                has_inf = th.isinf(AB_fp32).any()
                print('has_inf:', has_inf)  # True
                print('(e.T @ A):', (e_fp32.T @ A_fp32) )
                print('(B @ e):', (B_fp32 @ e_fp32) )
                print('val1: ', val1)
                print('val2: ', val2)
                print(diff, denom)
                assert 0
        return abs(diff) / denom
    else:
        # Default: absolute error
        return abs(diff)

def plot_histogram(matrix, dtype):
    # 将矩阵展开为一维数组
    elements = matrix.flatten().cpu()

    # 绘制直方图
    plt.figure(figsize=(8, 6))
    plt.hist(elements.numpy(), bins=30, alpha=0.7, color='blue', edgecolor='black')
    plt.xlabel('Element Value', fontsize=14)
    plt.ylabel('Frequency', fontsize=14)
    plt.title(f'Histogram of Tensor Elements ({matrix.shape[0]}x{matrix.shape[1]})', fontsize=16)
    plt.grid(alpha=0.3)
    plt.xscale("log")
    plt.savefig(f'histogram__{str(dtype)}.png')

def run_experiment(
    matrix_sizes=(8, 16, 32, 64, 128, 1024),
    k=8,
    n_runs=1000,
    fault_prob=0.5,
    fault_scale=1e6,
    dtype=th.float32
):
    """
    For each matrix size in `matrix_sizes`, run multiple experiments:
      1) Generate random A, B ~ N(0,1) in FP32
      2) Compute AB
      3) With probability `fault_prob`, inject a fault into one random element of AB
      4) Compute delta
      5) Collect |delta| and the label (0=clean, 1=faulty)
    Return a dict of {size: (labels, scores)} for ROC analysis.
    """
    results = {}
    dtype_eps_map = {
        th.float32: 1e-10,
        th.float64: 1e-20,
        th.float16: 1e-7,
        th.bfloat16: 1e-7,
        th.int8: 1e-3,  # 整数类型的 eps
    }
    AB = []
    for i in range(len(matrix_sizes)):
        n = matrix_sizes[i]
        y_true = []
        y_score = []

        for _ in range(n_runs):
            # Generate random A, B
            if dtype is not th.int8:
                A = th.randn((n, k[i]), dtype=dtype, device='cuda:0')
                B = th.randn((k[i], n), dtype=dtype, device='cuda:0')
            else:
                A = th.randint(low=-128, high=127, size=(n, k[i]), dtype=dtype, device='cuda:0')
                B = th.randint(low=-128, high=127, size=(k[i], n), dtype=dtype, device='cuda:0')

            # Compute AB in FP32
            AB = A @ B

            # Decide if we inject a fault
            faulty = (np.random.rand() < fault_prob)
            if faulty:
                AB = inject_fault_in_AB_no_nan(AB, fault_prob=1.0, dtype=dtype)
                label = 1
            else:
                label = 0

            # Compute delta (with the possibly corrupted AB)
            delta = compute_delta(A, B, AB=AB, dtype=dtype, eps=dtype_eps_map.get(dtype, 1e-12))

            y_true.append(label)
            y_score.append(abs(delta))
            if math.isnan(abs(delta)):
                print(y_score)
                assert 0
        results[n] = (np.array(y_true), np.array(y_score))
    # plot_histogram(AB, dtype=dtype)
    return results
def plot_roc_curves_log_scale(results_dict, num_thresholds=50, dtype=th.float32):
    """
    Given a dict {size: (y_true, y_score)}, plot an ROC curve for each size
    on a log-scaled x-axis (FPR).
    
    :param results_dict: Dictionary where key = matrix size, 
                         value = (array of labels, array of detection scores).
    :param fpr_min: A small positive number to replace any FPR == 0 for log scaling.
    """
    plt.figure(figsize=(8, 6))
    for n, (y_true, y_score) in results_dict.items():
        fpr, tpr, _ = roc_curve(y_true, y_score, drop_intermediate=False)
        
        roc_auc = auc(fpr, tpr)

        plt.plot(fpr, tpr, label=f"n={n}, AUC={roc_auc:.3f}")

    # Plot a reference line (though it's no longer strictly "diagonal" in log scale)
    # We'll just show the range [fpr_min, 1] for a visual reference.
    plt.plot([0, 1], [0, 1], 'k--', linewidth=0.8, label="Reference line")

    # plt.xscale("log")
    # plt.xlim([0, 1.0])
    # plt.ylim([0.0, 1.05])
    plt.xlabel('False Positive Rate (log scale)')
    plt.ylabel('True Positive Rate')
    plt.title('ROC Curves for ABFT Error Detection (|delta| Threshold) - Log Scale')
    plt.legend(loc="lower right")
    plt.tight_layout()
    plt.show()
    plt.savefig(f'ROC_{str(dtype)}.png')

def compute_tpr_fpr_for_thresholds(labels, scores, thresholds):
    """
    给定:
      - labels: 一维数组, 元素 ∈ {0,1}, 表示真实负/正
      - scores: 一维数组, 与 labels 对应, 表示模型或检测器输出的分数
      - thresholds: 一维数组, 想要考察的一系列阈值

    返回:
      - tpr_list: 与 thresholds 同长度的 TPR 数组
      - fpr_list: 与 thresholds 同长度的 FPR 数组
    """
    labels = np.asarray(labels)
    scores = np.asarray(scores)

    # 统计真实正类与真实负类的总数
    total_pos = np.sum(labels == 1)
    total_neg = np.sum(labels == 0)

    tpr_list = []
    fpr_list = []

    for thr in thresholds:
        # 大于等于 thr 即预测为正
        pred = (scores >= thr).astype(int)

        # 计算 TP 和 FP
        TP = np.sum((pred == 1) & (labels == 1))
        FP = np.sum((pred == 1) & (labels == 0))

        # 计算 TPR 和 FPR
        TPR = TP / total_pos if total_pos > 0 else 0.0
        FPR = FP / total_neg if total_neg > 0 else 0.0

        tpr_list.append(TPR)
        fpr_list.append(FPR)

    return np.array(tpr_list), np.array(fpr_list)

def plot_tpr_fpr_vs_thresholds(results_dict, num_thresholds=50, min_score=1e-14, dtype=th.float32):
    """
    绘制:
      TPR vs. Threshold 以及 FPR vs. Threshold 曲线 (同一子图中两条线)
      针对 results_dict 中每个 size 画一个子图.

    参数:
      - results_dict: dict, 形如 {size: (labels, scores)}
      - num_thresholds: 在 [min_score, max_score] 间取多少个阈值点
    """
    # 如果只有一两个 size，可以根据需要改成单图或多图布局
    n_sizes = len(results_dict)
    min_score_map = {
        th.float32: 1e-14,
        th.float64: 1e-20,
        th.float16: 1e-9,
        th.bfloat16: 1e-9,
        th.int8: 1e-3,  # 整数类型的 eps
    }
    # 创建若干子图
    fig, axes = plt.subplots(2, 3, figsize=(6 * 3, 6*2), sharey=True)
    if n_sizes == 1:
        # 若只有一个 size，就让 axes 变成列表方便后续处理
        axes = [axes]
    axs = axes
    axes = []
    for i in range(2):
      	for j in range(3):
            axes.append(axs[i, j])
            
    # 针对 dict 中每个 size 的 (labels, scores) 分别处理
    for ax, (size, (labels, scores)) in zip(axes, results_dict.items()):
        # min_score = np.min(scores)
        # max_score = np.max(scores)

        # 在 [min_score, max_score] 均匀取 num_thresholds 个点作为阈值
        thresholds = np.logspace(np.log10(min_score_map[dtype]), np.log10(1000), num=num_thresholds)
        tpr_list, fpr_list = compute_tpr_fpr_for_thresholds(labels, scores, thresholds)

        # 画图: TPR & FPR vs. threshold
        ax.plot(thresholds, tpr_list, label='TPR', color='blue', marker='o')
        ax.plot(thresholds, fpr_list, label='FPR', color='red', marker='x')

        ax.set_title(f'Size = {size}')
        ax.set_xlabel('Threshold')
        ax.set_ylabel('Rate')
        ax.legend()
        ax.grid(True)
        ax.set_xscale("log")
    plt.tight_layout()
    plt.show()
    plt.savefig(f'tpr_fpr_vs_thresholds_{str(dtype)}.png')



matrix_sizes = [4, 8, 16, 128, 1024, 4096]
k = [128, 128, 128, 128, 1024, 4096]
# Run experiments to gather data
dtype_list = [
            th.float64,
               th.float32,
                 th.float16,
                   th.bfloat16
            #   , th.int8
              ]
for dtype in dtype_list:
    print(dtype)
    results = run_experiment(
        matrix_sizes=matrix_sizes,
        k=k,
        n_runs=2000,      # number of runs per size
        fault_prob=0.5,   # 50% chance to inject a fault each run
        fault_scale=1e6,  # large factor to simulate corruption
        dtype=dtype
    )

    # Plot the ROC curves
    plot_roc_curves_log_scale(results, num_thresholds=100, dtype=dtype)
    plot_tpr_fpr_vs_thresholds(results, num_thresholds=100, dtype=dtype)