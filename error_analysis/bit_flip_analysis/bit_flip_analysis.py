import numpy as np
import matplotlib.pyplot as plt
import torch as th

def test_all_bit_flips(val, dtype=th.float32):
    """
    Test all possible bit flips for a given value and visualize the impact.
    
    Parameters:
    -----------
    val : float or int
        The value to test for all bit flips.
    dtype : torch.dtype
        The data type of the value (e.g., th.float32, th.float16, th.int8).
    
    Returns:
    --------
    bit_positions : List of bit positions (0, 1, ..., bit_width - 1)
    abs_changes : List of absolute changes for each bit flip
    rel_changes : List of relative changes for each bit flip
    """
    # Map PyTorch dtype to NumPy dtype and bit width
    dtype_map = {
        th.float32: (np.float32, np.uint32, 32),
        th.float64: (np.float64, np.uint64, 64),
        th.float16: (np.float16, np.uint16, 16),
        th.int8:    (np.int8, np.uint8, 8),
        th.int16:   (np.int16, np.uint16, 16),
        th.int32:   (np.int32, np.uint32, 32),
        th.int64:   (np.int64, np.uint64, 64),
    }
    
    if dtype not in dtype_map:
        raise ValueError(f"Unsupported dtype: {dtype}")
    
    np_dtype, np_unsigned, bit_width = dtype_map[dtype]
    
    # Convert the value to NumPy dtype
    val_np = np.array(val, dtype=np_dtype)
    
    # View the bits as an unsigned integer
    val_bits = np.frombuffer(val_np.tobytes(), dtype=np_unsigned)[0]
    
    # Initialize results
    bit_positions = list(range(bit_width))
    abs_changes = []
    rel_changes = []
    
    # Test each bit flip
    for bit_position in bit_positions:
        # Flip the bit
        flipped_bits = val_bits ^ (np_unsigned(1) << np_unsigned(bit_position))
        
        # Convert back to the original type
        flipped_val = np.frombuffer(np.array(flipped_bits, dtype=np_unsigned).tobytes(), dtype=np_dtype)[0]
        
        # Compute the changes
        original = val_np.item()
        flipped = flipped_val.item()
        abs_change = abs(flipped - original)
        rel_change = abs_change / abs(original) if original != 0 else float('inf')
        print(flipped, rel_change)
        abs_changes.append(abs_change)
        rel_changes.append(rel_change)
    
    return bit_positions, abs_changes, rel_changes

def visualize_bit_flips(val, dtype=th.float32):
    """
    Visualize the impact of flipping each bit on the given value.
    """
    # Test all bit flips
    bit_positions, abs_changes, rel_changes = test_all_bit_flips(val, dtype)
    
    # Plot absolute changes
    plt.figure(figsize=(10, 6))
    plt.bar(bit_positions, abs_changes, color='blue', alpha=0.7)
    plt.xlabel("Bit Position")
    plt.ylabel("Absolute Change")
    plt.title(f"Impact of Bit Flips on Value {val} (dtype={dtype})")
    plt.grid(True)
    plt.show()
    
    # Plot relative changes
    plt.figure(figsize=(10, 6))
    plt.bar(bit_positions, rel_changes, color='orange', alpha=0.7)
    plt.xlabel("Bit Position")
    plt.ylabel("Relative Change")
    plt.title(f"Relative Impact of Bit Flips on Value {val} (dtype={dtype})")
    plt.grid(True)
    plt.yscale("log")  # Log scale for better visualization of large changes
    # plt.show()
    plt.savefig('bit_flip_analysis.png')

# Example usage
visualize_bit_flips(1e-5, dtype=th.float16)
