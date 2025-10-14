
"""
A minimal attention playground to A/B test your own FlashAttention variants.

This file gives you:
  - Reference (baseline) attention using torch.nn.functional.scaled_dot_product_attention (SDPA).
  - Hook points (functions) for FA v1/v2/v3 to be implemented by you.
  - A quick numerical check to compare outputs/gradients vs baseline.

Recommended workflow:
  1) Get baseline to run and pass the checks.
  2) Implement FA v1 forward in pure PyTorch first, then Triton/CUDA.
  3) Add causal / padding masks and dropout if needed.
  4) Optimize memory (tiling, recompute for backward) for v2/v3.
  5) When the playground matches the baseline, wire it into a HF model.

Note: This playground is not wired into Transformers yet—on purpose.
      It keeps the problem isolated so you can iterate faster.

Run:
  python attn_playground.py --seq 2048 --d 128 --heads 32 --batch 1 --causal
"""
import math
import argparse
import torch
import torch.nn.functional as F

def baseline_sdpa(q, k, v, attn_mask=None, causal=False):
    """
    q,k,v: [B, H, S, D]
    attn_mask: None or tensor broadcastable to [B, H, S, S] with True for positions to mask.
    """
    if causal:
        S = q.size(-2)
        causal_mask = torch.triu(torch.ones(S, S, dtype=torch.bool, device=q.device), diagonal=1)
    else:
        causal_mask = None

    if attn_mask is not None and causal_mask is not None:
        full_mask = attn_mask | causal_mask
    else:
        full_mask = attn_mask if attn_mask is not None else causal_mask

    B, H, S, D = q.shape
    q_ = q.reshape(B*H, S, D)
    k_ = k.reshape(B*H, S, D)
    v_ = v.reshape(B*H, S, D)

    if full_mask is not None:
        if full_mask.dim() == 2:
            mask_ = full_mask[None, :, :].expand(B*H, -1, -1)
        elif full_mask.dim() == 3:
            mask_ = full_mask.expand(B*H, -1, -1)
        else:
            mask_ = full_mask
    else:
        mask_ = None

    out = F.scaled_dot_product_attention(
        q_, k_, v_,
        attn_mask=mask_,
        dropout_p=0.0,
        is_causal=False
    )
    return out.reshape(B, H, S, D)

# -----------------------------
# FlashAttention v1 (stub)
# -----------------------------
def flashattention_v1_forward(q, k, v, attn_mask=None, causal=False, eps=1e-6):
    """
    Implement the forward pass of FlashAttention v1 here using tiled softmax accumulation.
    """
    raise NotImplementedError("flashattention_v1_forward is a stub. Implement me.")

def flashattention_v1_backward(grad_out, q, k, v, out, saved_ctx):
    """
    Optional: custom backward for memory savings (recompute).
    """
    raise NotImplementedError("flashattention_v1_backward is a stub. Implement me.")

# -----------------------------
# FlashAttention v2/v3 (stubs)
# -----------------------------
def flashattention_v2_forward(q, k, v, attn_mask=None, causal=False, eps=1e-6):
    raise NotImplementedError("flashattention_v2_forward is a stub. Implement me.")

def flashattention_v3_forward(q, k, v, attn_mask=None, causal=False, eps=1e-6):
    raise NotImplementedError("flashattention_v3_forward is a stub. Implement me.")

def numerical_check(fn, q, k, v, attn_mask, causal):
    with torch.no_grad():
        ref = baseline_sdpa(q, k, v, attn_mask, causal)
    out = fn(q, k, v, attn_mask, causal)
    max_abs = (out - ref).abs().max().item()
    max_rel = ((out - ref).abs() / (ref.abs() + 1e-6)).max().item()
    print(f"[check] max_abs={max_abs:.3e} max_rel={max_rel:.3e}")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--seq", type=int, default=2048)
    parser.add_argument("--d", type=int, default=128)
    parser.add_argument("--heads", type=int, default=32)
    parser.add_argument("--batch", type=int, default=1)
    parser.add_argument("--dtype", type=str, default="bfloat16", choices=["float16", "bfloat16", "float32"])
    parser.add_argument("--causal", action="store_true")
    parser.add_argument("--impl", type=str, default="sdpa", choices=["sdpa", "fa_v1", "fa_v2", "fa_v3"])
    args = parser.parse_args()

    if args.dtype == "float16":
        dtype = torch.float16
    elif args.dtype == "bfloat16":
        dtype = torch.bfloat16
    else:
        dtype = torch.float32

    device = "cuda" if torch.cuda.is_available() else "cpu"
    torch.manual_seed(0)

    B, H, S, D = args.batch, args.heads, args.seq, args.d
    q = torch.randn(B, H, S, D, device=device, dtype=dtype) / math.sqrt(D)
    k = torch.randn(B, H, S, D, device=device, dtype=dtype) / math.sqrt(D)
    v = torch.randn(B, H, S, D, device=device, dtype=dtype)

    attn_mask = None

    if args.impl == "sdpa":
        fn = baseline_sdpa
        out = fn(q, k, v, attn_mask, args.causal)
        print("Baseline SDPA ran. Output stats:", out.mean().item(), out.std().item())
    elif args.impl == "fa_v1":
        fn = flashattention_v1_forward
        print("Comparing FA v1 vs SDPA...")
        numerical_check(fn, q, k, v, attn_mask, args.causal)
    elif args.impl == "fa_v2":
        fn = flashattention_v2_forward
        print("Comparing FA v2 vs SDPA...")
        numerical_check(fn, q, k, v, attn_mask, args.causal)
    else:
        fn = flashattention_v3_forward
        print("Comparing FA v3 vs SDPA...")
        numerical_check(fn, q, k, v, attn_mask, args.causal)

if __name__ == "__main__":
    main()
