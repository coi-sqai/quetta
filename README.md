# Workstation system: quetta

# Workstation system: quetta

## hosts

* quetta.phys.s.u-tokyo.ac.jp (login server ログインサーバ)
  * CPU: Intel(R) Xeon(R) E-2334 CPU @ 3.40GHz x 1
  * Total Number of Cores: 4
  * Total Memory: 32738508 kB
  * only accepts public key authentication / 公開鍵認証のみ
* quetta-c01, quetta-c02, quetta-c03, quetta-c04, quetta-c05, quetta-c06 (CPU server)
  * 1台あたり
    * CPU: Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz x 2
    * Total Number of Physical Cores: 64
    * Total Memory: 500 GB
* quetta-c11, quetta-c12, quetta-c13 (CPU server)
  *  1台あたり
    * CPU: AMD EPYC 9654 96-Core Processor x 2
    * Total Number of Physical Cores: 192
    * Total Memory: 750 GB
* quetta-g01 (GPGPU server)
  * CPU: AMD EPYC 7543 32-Core Processor x 2
  * Total Number of Physical Cores: 64
  * Total Memory: 1000 GB
  * NVIDIA A100 80GB PCIe x 8
* quetta-g02 (GPGPU server)
  * CPU: Intel(R) Xeon(R) Silver 4410Y x 2
  * Total Number of Physical Cores: 24
  * Total Memory: 1000 GB
  * NVIDIA A800 40GB Active x 4
* filesystem
  * /home - SSD 18 TB
  * /work - HD 60 TB
  * spare: SSD 18TB, HD 60+60+60TB

## Compilers, Libraries, etc / コンパイラ、ライブラリ、他

* Ubuntu 22.04
* GNU Compiler 11.4 (gcc, g++, gfortran)
* Intel(R) oneAPI Compiler 2024.2 (icx, icpx, ifx)
* openmpi 4.1.0 (mpicc, mpicxx, mpif90)
  * デフォルトでは mpi* は Intel compiler を呼び出します
  * GNU compiler を使いたい場合は ```source /opt/materiapps/gcc/env.sh``` を実行してください
* OpenBLAS, MKL
* cuda 12.6
* cmake 3.26.4
* python 3.11.4 including numpy, scipy, matplotlib, etc

## Job Scheduler

Slurmを使用

* パーティション(キュー)の情報
  * `sinfo -s`

* ジョブ情報表示
  * `squeue`

* ジョブの投入
  * `sbatch スクリプト名`
  * スクリプトの例
     * [scripts/single.sh](scripts/single.sh): 1ノード/1プロセス/1スレッド
     * [scripts/openmp.sh](scripts/openmp): 1ノード/1プロセス/複数スレッド (OpenMP)
     * [scripts/mpi.sh](scripts/mpi.sh): 1ノード/複数プロセス (MPI)
     * [scripts/hybrid.sh](scripts/hybrid.sh): 1ノード/複数プロセス/複数スレッド (MPI+OpenMP)
     * [scripts/multinode.sh](scripts/multinode.sh): 複数ノード/複数プロセス/複数スレッド (MPI+OpenMP)
     * [scripts/gpu.sh](scripts/gpu.sh): GPUの利用例

* ジョブのキャンセル
  * `scancel ジョブID`

* インタラクティブジョブ
  * `srun --pty bash`
  * `srun --pty --gres=gpu:a100:1 bash` (A100を1枚使う場合)
  * `srun --pty --gres=gpu:a800:1 bash` (A800を1枚使う場合)

## Test programs

* tests/mpicheck.cpp : 割り当てられたプロセス数スレッド数を確認するプログラム

* tests/gpucheck.py : 割り当てられたGPUを確認するプログラム

```bash
$ cmake -B build .
$ cmake --build build
```
