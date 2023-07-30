#!/bin/bash
#SBATCH -A m4271
#SBATCH -C gpu
#SBATCH -n 1
#SBATCH --gpus-per-task=1
#SBATCH --exclusive

export SLURM_CPU_BIND="cores"
srun ./ft_fft_batch 8 128
