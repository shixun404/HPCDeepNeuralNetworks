import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np
import matplotlib.pyplot as plt

# === 你的纯 Python 实现 ===
class MultiHeadAttentionCustom(nn.Module):
    def __init__(self, embed_dim, num_heads, dropout=0.0):
        super().__init__()
        assert embed_dim % num_heads == 0, "embed_dim must be divisible by num_heads"
        self.embed_dim = embed_dim
        self.num_heads = num_heads
        self.head_dim = embed_dim // num_heads
        
        self.q_proj = nn.Linear(embed_dim, embed_dim, bias=False)
        self.k_proj = nn.Linear(embed_dim, embed_dim, bias=False)
        self.v_proj = nn.Linear(embed_dim, embed_dim, bias=False)
        self.out_proj = nn.Linear(embed_dim, embed_dim, bias=False)

    def forward(self, x):
        B, T, C = x.shape
        q = self.q_proj(x)
        k = self.k_proj(x)
        v = self.v_proj(x)
        q = q.view(B, T, self.num_heads, self.head_dim).transpose(1, 2)
        k = k.view(B, T, self.num_heads, self.head_dim).transpose(1, 2)
        v = v.view(B, T, self.num_heads, self.head_dim).transpose(1, 2)
        attn = (q @ k.transpose(-2, -1)) / (self.head_dim ** 0.5)
        attn = F.softmax(attn, dim=-1)
        out = attn @ v
        out = out.transpose(1, 2).contiguous().view(B, T, C)
        return self.out_proj(out)


# === PyTorch 官方实现 ===
def compare_with_torch(embed_dim=64, num_heads=8, seq_len=4, batch_size=2, seed=42):
    torch.manual_seed(seed)

    # 初始化两种 attention
    custom_attn = MultiHeadAttentionCustom(embed_dim, num_heads)
    torch_attn = nn.MultiheadAttention(embed_dim, num_heads, bias=False, batch_first=True)

    # 同步权重
    with torch.no_grad():
        custom_attn.q_proj.weight.copy_(torch_attn.in_proj_weight[:embed_dim])
        custom_attn.k_proj.weight.copy_(torch_attn.in_proj_weight[embed_dim:2*embed_dim])
        custom_attn.v_proj.weight.copy_(torch_attn.in_proj_weight[2*embed_dim:])
        custom_attn.out_proj.weight.copy_(torch_attn.out_proj.weight)

    # 随机输入
    x = torch.randn(batch_size, seq_len, embed_dim)

    # 计算输出
    y_custom = custom_attn(x)
    y_torch, _ = torch_attn(x, x, x)

    # 计算误差统计
    abs_diff = (y_custom - y_torch).abs()
    rel_diff = abs_diff / (y_torch.abs() + 1e-8)  # 避免除零
    
    print("=== Compare ===")
    print("Mean abs diff:", abs_diff.mean().item())
    print("Max abs diff :", abs_diff.max().item())
    print("Mean rel diff:", rel_diff.mean().item())
    print("Max rel diff :", rel_diff.max().item())
    
    # 计算CDF
    abs_diff_flat = abs_diff.flatten().detach().cpu().numpy()
    rel_diff_flat = rel_diff.flatten().detach().cpu().numpy()
    
    # 排序用于CDF计算
    abs_diff_sorted = np.sort(abs_diff_flat)
    rel_diff_sorted = np.sort(rel_diff_flat)
    
    # 计算CDF值
    n = len(abs_diff_sorted)
    cdf_abs = np.arange(1, n + 1) / n
    cdf_rel = np.arange(1, n + 1) / n
    
    # 打印CDF统计
    print("\n=== CDF Statistics ===")
    print("Absolute Error CDF:")
    for p in [0.5, 0.9, 0.95, 0.99, 0.999]:
        idx = int(p * n)
        if idx >= n:
            idx = n - 1
        print(f"  {p*100:5.1f}%: {abs_diff_sorted[idx]:.2e}")
    
    print("Relative Error CDF:")
    for p in [0.5, 0.9, 0.95, 0.99, 0.999]:
        idx = int(p * n)
        if idx >= n:
            idx = n - 1
        print(f"  {p*100:5.1f}%: {rel_diff_sorted[idx]:.2e}")
    
    return y_custom, y_torch, abs_diff_sorted, rel_diff_sorted, cdf_abs, cdf_rel


def plot_error_cdf(abs_diff_sorted, rel_diff_sorted, cdf_abs, cdf_rel):
    """绘制误差CDF图"""
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
    
    # 绝对误差CDF
    ax1.semilogx(abs_diff_sorted, cdf_abs, 'b-', linewidth=2)
    ax1.set_xlabel('Absolute Error')
    ax1.set_ylabel('Cumulative Probability')
    ax1.set_title('Absolute Error CDF')
    ax1.grid(True, alpha=0.3)
    ax1.set_ylim(0, 1)
    
    # 相对误差CDF
    ax2.semilogx(rel_diff_sorted, cdf_rel, 'r-', linewidth=2)
    ax2.set_xlabel('Relative Error')
    ax2.set_ylabel('Cumulative Probability')
    ax2.set_title('Relative Error CDF')
    ax2.grid(True, alpha=0.3)
    ax2.set_ylim(0, 1)
    
    plt.tight_layout()
    plt.savefig('error_cdf.png', dpi=150, bbox_inches='tight')
    plt.show()


if __name__ == "__main__":
    y1, y2, abs_diff_sorted, rel_diff_sorted, cdf_abs, cdf_rel = compare_with_torch()
    
    # 绘制CDF图
    plot_error_cdf(abs_diff_sorted, rel_diff_sorted, cdf_abs, cdf_rel)
