#!/bin/bash

# Script to run Qwen2-MoE-A2.7B on 4xA100 80GB GPUs
# Usage: ./run_qwen2_moe_4gpu.sh [prompt]

# Set environment variables for optimal performance
export CUDA_VISIBLE_DEVICES=0,1,2,3
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128
export TOKENIZERS_PARALLELISM=false

# Default prompt if none provided
PROMPT=${1:-"Explain the concept of mixture of experts in neural networks in detail."}

echo "Running Qwen2-MoE-A2.7B on 4xA100 80GB GPUs"
echo "Prompt: $PROMPT"
echo "================================================"

# Run the model with 4 GPU configuration
python run_llm.py \
    --model "Qwen/Qwen2-MoE-A2.7B" \
    --prompt "$PROMPT" \
    --max_new_tokens 256 \
    --dtype bfloat16 \
    --use_4gpu \
    --low_cpu_mem_usage \
    --max_memory 75GB \
    --seed 42

echo "================================================"
echo "Inference completed!"
