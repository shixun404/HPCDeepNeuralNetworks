import torch

def two_side_abft(A, B, AB, epsilon=1e-6):
    """
    Two-Side ABFT for error detection and localization.

    Parameters:
    -----------
    A : torch.Tensor
        An n x n matrix.
    B : torch.Tensor
        An n x n matrix.
    epsilon : float
        Numerical threshold to consider a value "close enough" to 0.

    Returns:
    --------
    R : torch.Tensor
        The resulting n x n matrix from two-side ABFT.
    error_detected : bool
        Whether an error was detected.
    """
    n = A.shape[0]
    e = torch.ones((n, 1), device=A.device, dtype=A.dtype)

    # Compute vectors
    v1 = (e.T @ A) @ B - (e.T @ (AB))  # Shape: (1, n)
    v2 = A @ (B @ e) - (AB) @ e        # Shape: (n, 1)

    # Compute R
    print(v1.shape, v2.T.shape)
    print(v1, v2)
    R = v1 - v2  # Shape: (n, n)

    # Detect error (values close to 0 are considered no error)
    error_detected = torch.any(R.abs() < epsilon)
    
    return R, error_detected

# Example matrices
A = torch.rand((5, 128), dtype=torch.float16)
B = torch.rand((128, 5), dtype=torch.float16)

AB = A @ B
AB[0, 0] = 0
# Inject an error
# A[2, 3] += 0.1  # Inject an error in A

# Perform Two-Side ABFT
R, error_detected = two_side_abft(A, B, AB, epsilon=1e-6)

print("Resulting R Matrix:\n", R)
print("Error Detected:", error_detected)