#!/bin/bash -eu

#SBATCH --partition=gpu     ## partition (queue) name
#SBATCH --output=%x_%j.out  ## %x will be replaced by jobname
#SBATCH --error=%x_%j.err   ## %j will be replaced by jobid
#SBATCH --ntasks=1          ## number of tasks (processes)
#SBATCH --cpus-per-task=1   ## number of CPUs per process
#SBATCH --gres=gpu:1        ## number of GPUs per node (gres=gpu:N)
                            ## use --gres=gpu:a100:N for A100 GPUs
                            ## use --gres=gpu:a800:N for A800 GPUs
#SBATCH --time=1-00:00:00   ## day-hour:min:sec

./build/venv/bin/python3 ./tests/gpucheck.py
