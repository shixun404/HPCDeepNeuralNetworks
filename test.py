#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import roc_curve, auc
import math

def bit_flip_no_nan(val, max_retries=5):
    """
    对 float32 的 val 进行随机单比特翻转，若产生 NaN 则重试。
    最多尝试 max_retries 次，若都失败则返回原值 (可改为其他处理逻辑)。
    """
    original_val = val
    for _ in range(max_retries):
        # 把 float32 转为 uint32
        bits = np.frombuffer(val.tobytes(), dtype=np.uint32)[0]
        # 随机选择一个 bit 位置 [0..31]
        bit_pos = np.random.randint(32)
        # 翻转该 bit
        flipped_bits = bits ^ (1 << bit_pos)
        # 转回 float32
        faulty_val = np.frombuffer(np.uint32(flipped_bits).tobytes(), dtype=np.float32)[0]

        # 检查是否 NaN
        if not math.isnan(faulty_val):
            return faulty_val
    
    # 如果多次重试仍然产生 NaN，则返回原值 (或按需处理)
    return original_val

def inject_fault_in_AB_no_nan(AB, fault_prob=0.05, max_retries=5):
    """
    在矩阵 AB (float32) 中，按给定概率 fault_prob 注入一个 bit flip。
    如若翻转后出现 NaN，则进行重试，直到不产生 NaN 或超出重试上限。
    """
    if np.random.rand() < fault_prob:
        n = AB.shape[0]
        # 随机选一个元素 [i, j]
        i = np.random.randint(n)
        j = np.random.randint(n)
        val = AB[i, j]
        
        # 进行 bit flip，但要避免 NaN
        faulty_val = bit_flip_no_nan(val, max_retries=max_retries)
        AB[i, j] = faulty_val

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


def compute_delta(A, B, AB=None, dtype=np.float32, error_mode='relative', eps=1e-12):
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
    e = np.ones((n, 1), dtype=dtype)
    
    # If AB not provided, compute it here
    if AB is None:
        AB = A @ B
    
    # e'(AB)e => shape: (1,1)
    val1 = (e.T @ AB @ e).item()
    
    # (e' A)(B e) => shape: (1,1)
    val2 = ((e.T @ A) @ (B @ e)).item()
    
    diff = val1 - val2
    
    if error_mode == 'relative':
        # Avoid division by zero by taking max(eps, abs(val2)) or another denominator
        denom = max(eps, abs(val2))
        return abs(diff) / denom
    else:
        # Default: absolute error
        return abs(diff)

def run_experiment(
    matrix_sizes=(8, 16, 32, 64, 128, 1024),
    k=8,
    n_runs=1000,
    fault_prob=0.5,
    fault_scale=1e6,
    dtype=np.float32
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
    
    for n in matrix_sizes:
        y_true = []
        y_score = []

        for _ in range(n_runs):
            # Generate random A, B
            A = np.random.randn(n, k).astype(dtype)
            B = np.random.randn(k, n).astype(dtype)

            # Compute AB in FP32
            AB = A @ B

            # Decide if we inject a fault
            faulty = (np.random.rand() < fault_prob)
            if faulty:
                AB = inject_fault_in_AB_no_nan(AB, fault_prob=1.0)
                label = 1
            else:
                label = 0

            # Compute delta (with the possibly corrupted AB)
            delta = compute_delta(A, B, AB=AB, dtype=dtype, eps=1e-12 if dtype is np.float32 else 1e-30)

            y_true.append(label)
            y_score.append(abs(delta))

        results[n] = (np.array(y_true), np.array(y_score))

    return results
def plot_roc_curves_log_scale(results_dict, fpr_min=1e-6, num_thresholds=50):
    """
    Given a dict {size: (y_true, y_score)}, plot an ROC curve for each size
    on a log-scaled x-axis (FPR).
    
    :param results_dict: Dictionary where key = matrix size, 
                         value = (array of labels, array of detection scores).
    :param fpr_min: A small positive number to replace any FPR == 0 for log scaling.
    """
    plt.figure(figsize=(8, 6))
    for n, (y_true, y_score) in results_dict.items():
        # fpr, tpr, _ = roc_curve(y_true, y_score, drop_intermediate=False)
        thresholds = np.logspace(np.log10(fpr_min), np.log10(1.0), num=num_thresholds)
        tpr, fpr = compute_tpr_fpr_for_thresholds(y_true, y_score, thresholds)
        # print(len(y_true), len(y_score))
        print(thresholds)
        print(fpr)
        print(tpr)
        # assert 0
        # Avoid log(0) issues by clipping any FPR == 0 to a small positive value
        # fpr = np.clip(fpr, fpr_min, 1.0)
        
        roc_auc = auc(fpr, tpr)

        plt.plot(fpr, tpr, label=f"n={n}, AUC={roc_auc:.3f}")

    # Plot a reference line (though it's no longer strictly "diagonal" in log scale)
    # We'll just show the range [fpr_min, 1] for a visual reference.
    plt.plot([fpr_min, 1], [0, 1], 'k--', linewidth=0.8, label="Reference line")

    plt.xscale("log")
    plt.xlim([0, 1.0])
    plt.ylim([0.0, 1.05])
    plt.xlabel('False Positive Rate (log scale)')
    plt.ylabel('True Positive Rate')
    plt.title('ROC Curves for ABFT Error Detection (|delta| Threshold) - Log Scale')
    plt.legend(loc="lower right")
    plt.tight_layout()
    plt.show()
    plt.savefig('error_analysis/ROC.png')

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

def plot_tpr_fpr_vs_thresholds(results_dict, num_thresholds=50, min_score=1e-14):
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
        thresholds = np.logspace(np.log10(min_score), np.log10(1.0), num=num_thresholds)
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
    plt.savefig('error_analysis/tpr_fpr_vs_thresholds.png')


matrix_sizes = [8, 16, 32, 64, 128]
k = 128
# Run experiments to gather data
results = run_experiment(
	matrix_sizes=matrix_sizes,
	k=k,
	n_runs=1000,      # number of runs per size
	fault_prob=0.5,   # 50% chance to inject a fault each run
	fault_scale=1e6,  # large factor to simulate corruption
	dtype=np.float64
)

# Plot the ROC curves
plot_roc_curves_log_scale(results, fpr_min=1e-30)
plot_tpr_fpr_vs_thresholds(results, num_thresholds=100, min_score=1e-20)