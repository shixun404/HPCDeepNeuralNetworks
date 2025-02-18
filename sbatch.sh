#!/bin/bash
#SBATCH -A m4271
#SBATCH -C gpu
#SBATCH -n 1
#SBATCH --gpus-per-task=1
#SBATCH --exclusive

export SLURM_CPU_BIND="cores"
# srun ./ft_fft_batch 8 128
# ./ft_sgemm 0 4096 4096  128 0 0
./ft_sgemm 6 4096 4096  128 0 6
./ft_sgemm 6 4096 4096  128 6 6
./ft_sgemm 6 4096 4096  128 0 0
./ft_sgemm 6 4096 4096  128 6 6
./ft_sgemm 6 4096 4096  128 0 0
# srun ./ft_fft 29    
# srun ./zgemm 20 256 10240  1  
