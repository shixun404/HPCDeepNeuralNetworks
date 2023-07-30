#!/bin/bash
#SBATCH -A swu264
#SBATCH -C gpu
#SBATCH -q shared
#SBATCH -t 1:00:00
#SBATCH -n 1
#SBATCH --gpus-per-task=1

export SLURM_CPU_BIND="cores"
srun ./ft_fft_batch 21 128
