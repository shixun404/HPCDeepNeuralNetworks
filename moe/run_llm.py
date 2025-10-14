
import argparse
import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, set_seed

# Default model: Qwen2-MoE-A2.7B for 4xA100 configuration
DEFAULT_MODEL = "Qwen/Qwen2-MoE-A2.7B"


def shape_hook(module, input, output):
    # input/output 可能是 tuple，这里只取第一个张量
    in_shape = input[0].shape if isinstance(input, (tuple, list)) else input.shape
    out_shape = output[0].shape if isinstance(output, (tuple, list)) else output.shape
    print(f"{module.__class__.__name__}: input {in_shape} -> output {out_shape}")

def proj_hook(module, inputs, output):
    print(f"{module.__class__.__name__}: in {inputs[0].shape} -> out {output.shape}")

def qkv_hook(module, input, output):
    """
    module: usually Qwen2Attention (inside each decoder layer)
    input:  tuple, contains hidden_states
    output: the attention output
    """
    # HuggingFace attention forward 通常会自己在里面投影出 q,k,v
    # 所以这里要用 forward hook 拿不到 q,k,v，得用 forward_pre_hook
    print(f"[Hooked Attention] input hidden: {input[0].shape} -> output: {output.shape}")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model", type=str, default=DEFAULT_MODEL)
    parser.add_argument("--prompt", type=str, default="Explain Fourier transform in one sentence.")
    parser.add_argument("--max_new_tokens", type=int, default=128)
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--dtype", type=str, default="bfloat16", choices=["float16", "bfloat16", "float32"])
    parser.add_argument("--use_4gpu", action="store_true", help="Use accelerate device_map='auto' to shard across 4xA100 GPUs")
    parser.add_argument("--low_cpu_mem_usage", action="store_true", default=True, help="Enable low CPU memory usage for large models")
    parser.add_argument("--max_memory", type=str, default="80GB", help="Maximum memory per GPU")
    args = parser.parse_args()

    set_seed(args.seed)

    if args.dtype == "float16":
        dtype = torch.float16
    elif args.dtype == "bfloat16":
        dtype = torch.bfloat16
    else:
        dtype = torch.float32

    print(f"Loading model: {args.model}")
    print(f"GPU count: {torch.cuda.device_count()}")
    print(f"Available GPUs: {[torch.cuda.get_device_name(i) for i in range(torch.cuda.device_count())]}")
    
    tokenizer = AutoTokenizer.from_pretrained(args.model, use_fast=True)
    
    # Configure device mapping for 4xA100 setup
    if args.use_4gpu:
        # For 4xA100 setup, use auto device mapping with memory constraints
        max_memory = {i: args.max_memory for i in range(4)}  # 4 GPUs
        device_map = "auto"
        print(f"Using auto device mapping across 4 GPUs with {args.max_memory} per GPU")
    else:
        device_map = 0 if torch.cuda.is_available() else "cpu"
        max_memory = None

    # Load model with optimized settings for MoE on 4xA100
    model = AutoModelForCausalLM.from_pretrained(
        args.model,
        torch_dtype=dtype,
        device_map=device_map,
        max_memory=max_memory,
        low_cpu_mem_usage=args.low_cpu_mem_usage,
        trust_remote_code=True,
        attn_implementation="flash_attention_2" if torch.cuda.is_available() else "eager"
    )
    model.eval()
    
    # Register hooks for MoE model layers (Qwen2-MoE may have different architecture)
    # print("Registering hooks for model layers...")
    # try:
    #     for i, layer in enumerate(model.model.layers):
    #         layer.register_forward_hook(shape_hook)
    #         # Handle attention projections (may vary in MoE models)
    #         if hasattr(layer, 'self_attn'):
    #             if hasattr(layer.self_attn, 'q_proj'):
    #                 layer.self_attn.q_proj.register_forward_hook(proj_hook)
    #             if hasattr(layer.self_attn, 'k_proj'):
    #                 layer.self_attn.k_proj.register_forward_hook(proj_hook)
    #             if hasattr(layer.self_attn, 'v_proj'):
    #                 layer.self_attn.v_proj.register_forward_hook(proj_hook)
    #         # Handle MoE-specific components
    #         if hasattr(layer, 'mlp') and hasattr(layer.mlp, 'experts'):
    #             print(f"Found MoE layer {i} with {len(layer.mlp.experts)} experts")
    #     print(f"Successfully registered hooks for {len(model.model.layers)} layers")
    # except Exception as e:
    #     print(f"Warning: Could not register all hooks: {e}")
    #     print("Model architecture may differ from expected structure")

    
    # Simple prompt formatting for instruction models
    if "mistral" in args.model.lower():
        messages = [
            {"role": "user", "content": args.prompt}
        ]
        inputs = tokenizer.apply_chat_template(messages, return_tensors="pt", add_generation_prompt=True)
    else:
        inputs = tokenizer(args.prompt, return_tensors="pt")["input_ids"]

    if device_map == 0:
        inputs = inputs.to(model.device)

    print("=== Prompt ===")
    print(args.prompt)
    print("Input IDs:", inputs)
    print("Shape:", inputs.shape)
    print("Decoded back:", tokenizer.decode(inputs[0]))
    
    # Print GPU memory usage before inference
    if torch.cuda.is_available():
        print("\n=== GPU Memory Usage ===")
        for i in range(torch.cuda.device_count()):
            allocated = torch.cuda.memory_allocated(i) / 1024**3
            cached = torch.cuda.memory_reserved(i) / 1024**3
            print(f"GPU {i}: {allocated:.2f}GB allocated, {cached:.2f}GB cached")
    
    # assert 0
    # with torch.no_grad():
    #     print("\n=== Running Inference ===")
    #     # For MoE models, we can either do forward pass or generation
    #     if args.max_new_tokens > 0:
    #         print("Generating new tokens...")
    #         output_ids = model.generate(
    #             inputs,
    #             max_new_tokens=args.max_new_tokens,
    #             do_sample=False,
    #             temperature=None,
    #             top_p=None,
    #             pad_token_id=tokenizer.eos_token_id
    #         )
    #         text = tokenizer.decode(output_ids[0], skip_special_tokens=True)
    #         print("\n=== Model Output ===")
    #         print(text)
    #     else:
    #         print("Running forward pass only...")
    #         out = model(input_ids=inputs, output_hidden_states=True)
    #         hidden_states = out.hidden_states  # list, 包含 embedding + 每层的输出
    #         print("\n=== Hidden States ===")
    #         for i, h in enumerate(hidden_states):
    #             print(f"Layer {i}: {h.shape}")

    # Print GPU memory usage after inference
    if torch.cuda.is_available():
        print("\n=== GPU Memory Usage After Inference ===")
        for i in range(torch.cuda.device_count()):
            allocated = torch.cuda.memory_allocated(i) / 1024**3
            cached = torch.cuda.memory_reserved(i) / 1024**3
            print(f"GPU {i}: {allocated:.2f}GB allocated, {cached:.2f}GB cached")
    
    print("\nDone.")

if __name__ == "__main__":
    main()
