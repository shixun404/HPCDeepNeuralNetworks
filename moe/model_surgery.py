import torch
import torch.nn as nn
from transformers import AutoModelForCausalLM
from typing import List

class PlaceholderMoETransformerBlock(nn.Module):
    """使用 PyTorch TransformerEncoderLayer 占位的自定义块"""
    def __init__(self, original_layer, d_model=None, nhead=None, dim_feedforward=None):
        super().__init__()
        # 获取原层的维度信息
        self.hidden_size = getattr(original_layer, "hidden_size", d_model or 4096)
        self.intermediate_size = getattr(original_layer, "intermediate_size", dim_feedforward or self.hidden_size * 4)
        self.n_heads = getattr(original_layer, "num_heads", nhead or 32)
        
        # === 1. 用原始的 LayerNorm 和 Attention 保留输入输出语义 ===
        self.input_layernorm = getattr(original_layer, "input_layernorm", nn.LayerNorm(self.hidden_size))
        self.post_attention_layernorm = getattr(original_layer, "post_attention_layernorm", nn.LayerNorm(self.hidden_size))
        self.self_attn = getattr(original_layer, "self_attn", None)

        # === 2. 用 PyTorch 官方 TransformerEncoderLayer 作为占位 MLP ===
        self.placeholder = nn.TransformerEncoderLayer(
            d_model=self.hidden_size,
            nhead=self.n_heads,
            dim_feedforward=self.intermediate_size,
            dropout=0.0,
            activation="gelu",
            batch_first=True,
            norm_first=True
        )

    def forward(self, hidden_states, attention_mask=None, **kwargs):
        """
        兼容 HuggingFace 的 forward 接口。
        注意：这里暂时不处理 attention_mask。
        """
        # 模拟一个标准 transformer block：LN -> Attention -> LN -> FFN
        x = self.input_layernorm(hidden_states)
        if self.self_attn is not None:
            x = hidden_states + self.self_attn(x, attention_mask=attention_mask, **kwargs)
        else:
            # 如果 self_attn 没有保留，就直接占位一个 identity
            x = hidden_states
        # 占位 MLP
        x = self.placeholder(x)
        return x

def replace_transformer_layers(model, layer_indices: List[int]):
    """
    替换指定层为占位TransformerEncoderLayer
    """
    for idx in layer_indices:
        if idx < len(model.model.layers):
            original = model.model.layers[idx]
            model.model.layers[idx] = PlaceholderMoETransformerBlock(original)
            print(f"✅ Replaced layer {idx} with PlaceholderMoETransformerBlock")
        else:
            print(f"⚠️ Layer index {idx} out of range")
    return model
