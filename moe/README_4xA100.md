# Qwen2-MoE-A2.7B on 4xA100 80GB Setup

## 概述
这个配置用于在4张A100 80GB GPU上运行Qwen2-MoE-A2.7B模型。

## 主要修改

### 1. 模型配置
- 默认模型改为 `Qwen/Qwen2-MoE-A2.7B`
- 添加了针对MoE模型的特殊处理
- 支持Flash Attention 2优化

### 2. 多GPU配置
- 自动设备映射 (`device_map="auto"`)
- 每个GPU限制75GB内存使用
- 低CPU内存使用模式
- GPU内存使用监控

### 3. 新增参数
- `--low_cpu_mem_usage`: 启用低CPU内存使用
- `--max_memory`: 设置每个GPU的最大内存限制（默认80GB，建议75GB）

## 使用方法

### 方法1: 使用脚本（推荐）
```bash
# 使用默认prompt
./run_qwen2_moe_4gpu.sh

# 使用自定义prompt
./run_qwen2_moe_4gpu.sh "你的自定义问题"
```

### 方法2: 直接运行Python脚本
```bash
python run_llm.py \
    --model "Qwen/Qwen2-MoE-A2.7B" \
    --prompt "你的问题" \
    --max_new_tokens 256 \
    --dtype bfloat16 \
    --use_4gpu \
    --low_cpu_mem_usage \
    --max_memory 75GB
```

## 环境要求

### 硬件
- 4张A100 80GB GPU
- 足够的系统内存（推荐64GB+）

### 软件
- PyTorch 2.0+
- Transformers 4.35+
- Flash Attention 2 (推荐)
- CUDA 11.8+

### 环境变量
```bash
export CUDA_VISIBLE_DEVICES=0,1,2,3
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128
export TOKENIZERS_PARALLELISM=false
```

## 性能优化建议

1. **内存管理**: 每个GPU使用75GB而不是80GB，留出缓冲空间
2. **数据类型**: 使用bfloat16以获得最佳性能
3. **注意力机制**: 自动启用Flash Attention 2
4. **并行化**: 自动跨4个GPU分布模型

## 监控功能

脚本会自动显示：
- GPU信息和数量
- 模型加载进度
- MoE专家分布信息
- 推理前后的GPU内存使用情况
- 每层hidden states的形状

## 故障排除

### 内存不足
- 减少 `max_new_tokens`
- 降低 `max_memory` 到 70GB
- 使用 `float16` 而不是 `bfloat16`

### 模型加载失败
- 确保有足够的磁盘空间
- 检查网络连接（首次下载模型）
- 验证CUDA和PyTorch版本兼容性

### MoE专家分布问题
- 检查模型架构是否支持
- 确认transformers版本足够新
- 查看错误日志中的具体信息
