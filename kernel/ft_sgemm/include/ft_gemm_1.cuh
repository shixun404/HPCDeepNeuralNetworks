
void ft_sgemm_1(int num_tests, int max_size, cublasHandle_t handle, float* dA, float* dB, float* dC, float* dE, float* dRes, float* dcheck_C_row, float* dcheck_C_col, float* dcheck_A_col_mul_B, float* dcheck_B_row_mul_A, float* dcheck_A_col, float* dcheck_B_row,  float alpha, float beta, float negative_1){
    
    for(int ii = 0; ii < num_tests; ++ii){
        for (int i = 0; i < max_size; i += int(max_size / 8)){
        cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, max_size, max_size,  int(max_size / 8), &alpha, dA + i * max_size, max_size, dB  + i * max_size, max_size, &beta, dC, max_size);
        cudaDeviceSynchronize();
        // row sum of C
        cublasSgemv(handle, CUBLAS_OP_N, max_size, max_size, &alpha, dC, max_size, dE, 1, &beta, dcheck_C_row, 1);
        
        // col sum of C
        cublasSgemv(handle, CUBLAS_OP_T, max_size, max_size, &alpha, dC, max_size, dE, 1, &beta, dcheck_C_col, 1);

        // col sum of A
        cublasSgemv(handle, CUBLAS_OP_T, max_size, int(max_size / 8), &alpha, dA  + i * max_size, max_size, dE, 1, &beta, dcheck_A_col, 1);

        // row sum of B
        cublasSgemv(handle, CUBLAS_OP_N, int(max_size / 8), max_size, &alpha, dB + i * max_size, max_size, dE, 1, &beta, dcheck_B_row, 1);
        cudaDeviceSynchronize();
        // col sum of A x B
        cublasSgemv(handle, CUBLAS_OP_T, int(max_size / 8), max_size, &alpha, dB + i * max_size, max_size, dcheck_A_col, 1, &beta, dcheck_A_col_mul_B, 1);

        // row sum of B x A
        cublasSgemv(handle, CUBLAS_OP_N, max_size, int(max_size / 8), &alpha, dA + i * max_size, max_size, dcheck_B_row, 1, &beta, dcheck_B_row_mul_A, 1);
        cudaDeviceSynchronize();
        // verify
        cublasSaxpy(handle, max_size, &negative_1, dcheck_A_col_mul_B, 1, dcheck_C_col, 1);
        cublasSdot(handle, max_size, dcheck_C_col, 1, dE, 1, dRes);
        cudaDeviceSynchronize();
        cublasSaxpy(handle, max_size, &negative_1, dcheck_B_row_mul_A, 1, dcheck_C_row, 1);
        cublasSdot(handle, max_size, dcheck_C_row, 1, dE, 1, dRes);
        }
    }
}