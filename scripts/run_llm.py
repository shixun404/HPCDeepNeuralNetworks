
import argparse
import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, set_seed

# Default model: open, widely available, 7B class
DEFAULT_MODEL = "Qwen/Qwen2.5-7B-Instruct"


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
    parser.add_argument("--use_4gpu", action="store_true", help="Use accelerate device_map='auto' to shard across multiple GPUs")
    args = parser.parse_args()

    set_seed(args.seed)

    if args.dtype == "float16":
        dtype = torch.float16
    elif args.dtype == "bfloat16":
        dtype = torch.bfloat16
    else:
        dtype = torch.float32

    print(f"Loading model: {args.model}")
    tokenizer = AutoTokenizer.from_pretrained(args.model, use_fast=True)
    if args.use_4gpu:
        device_map = "auto"
    else:
        device_map = 0 if torch.cuda.is_available() else "cpu"

    model = AutoModelForCausalLM.from_pretrained(
        args.model,
        torch_dtype=dtype,
        device_map=device_map,
        trust_remote_code=True
    )
    model.eval()
    # 给每一层 transformer block 注册
    for i, layer in enumerate(model.model.layers):  # Qwen/Mistral 类模型一般是 model.model.layers
        layer.register_forward_hook(shape_hook)
        layer.self_attn.q_proj.register_forward_hook(proj_hook)
        layer.self_attn.k_proj.register_forward_hook(proj_hook)
        layer.self_attn.v_proj.register_forward_hook(proj_hook)

    
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
    # assert 0
    with torch.no_grad():
        output_ids = model.generate(
            inputs,
            max_new_tokens=args.max_new_tokens,
            do_sample=False,
            temperature=None,
            top_p=None,
        )
        # with torch.no_grad():
        #     out = model(input_ids=inputs, output_hidden_states=True)
        # hidden_states = out.hidden_states  # list, 包含 embedding + 每层的输出
        # for i, h in enumerate(hidden_states):
        #     print(f"Layer {i}: {h.shape}")

    text = tokenizer.decode(output_ids[0], skip_special_tokens=True)
    print("\n=== Model Output ===")
    print(text)
    print("\nDone.")

if __name__ == "__main__":
    main()
