#!/bin/bash -eu

#SBATCH --partition=cpu     ## partition (queue) name
#SBATCH --output=%x_%j.out  ## %x will be replaced by jobname
#SBATCH --error=%x_%j.err   ## %j will be replaced by jobid
#SBATCH --ntasks=1          ## number of tasks (processes)
#SBATCH --cpus-per-task=16  ## number of CPUs per process
#SBATCH --time=2-00:00:00   ## day-hour:min:sec

srun ./build/mpicheck
