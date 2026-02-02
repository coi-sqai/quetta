# SQAI Workstation System: quetta

## hosts

* quetta.phys.s.u-tokyo.ac.jp (login server ログインサーバ)
  * only accepts public key authentication / 公開鍵認証のみ

| hostname | OS | CPU | Sockets | Phys. Cores per CPU | Total Logical Cores | Hyperthreading | BogoMIPS | Memory (GB) | GPU | #GPUs |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| quetta | Ubuntu 24.04.3 LTS | Intel(R) Xeon(R) E-2334 CPU @ 3.40GHz | 1 | 4 | 8 | 1 | 6816.00 | 125 |  | 0 |
| quetta-c01 | Ubuntu 24.04.2 LTS | Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz | 2 | 32 | 64 | 0 | 5200.00 | 503 |  | 0 |
| quetta-c02 | Ubuntu 24.04.2 LTS | Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz | 2 | 32 | 64 | 0 | 5200.00 | 503 |  | 0 |
| quetta-c03 | Ubuntu 24.04.2 LTS | Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz | 2 | 32 | 64 | 0 | 5200.00 | 503 |  | 0 |
| quetta-c04 | Ubuntu 24.04.2 LTS | Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz | 2 | 32 | 64 | 0 | 5200.00 | 503 |  | 0 |
| quetta-c05 | Ubuntu 24.04.2 LTS | Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz | 2 | 32 | 64 | 0 | 5200.00 | 503 |  | 0 |
| quetta-c06 | Ubuntu 24.04.2 LTS | Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz | 2 | 32 | 64 | 0 | 5200.00 | 503 |  | 0 |
| quetta-c11 | Ubuntu 24.04.2 LTS | AMD EPYC 9654 96-Core Processor | 2 | 96 | 192 | 0 | 4800.05 | 755 |  | 0 |
| quetta-c12 | Ubuntu 24.04.2 LTS | AMD EPYC 9654 96-Core Processor | 2 | 96 | 192 | 0 | 4800.05 | 755 |  | 0 |
| quetta-c13 | Ubuntu 24.04.2 LTS | AMD EPYC 9654 96-Core Processor | 2 | 96 | 192 | 0 | 4799.99 | 755 |  | 0 |
| quetta-c21 | Ubuntu 24.04.2 LTS | AMD EPYC 9754 128-Core Processor | 2 | 128 | 256 | 0 | 4493.30 | 1511 |  | 0 |
| quetta-g01 | Ubuntu 24.04.2 LTS | AMD EPYC 7543 32-Core Processor | 2 | 32 | 64 | 0 | 5600.15 | 1007 | NVIDIA A100 80GB PCIe | 8 |
| quetta-g02 | Ubuntu 24.04.2 LTS | Intel(R) Xeon(R) Silver 4410Y | 2 | 12 | 24 | 0 | 4000.00 | 1007 | NVIDIA A800 40GB Active | 4 |
| quetta-g03 | Ubuntu 24.04.2 LTS | INTEL(R) XEON(R) GOLD 6530 | 2 | 32 | 64 | 0 | 4200.00 | 1007 | NVIDIA H100 NVL | 2 |

* filesystem
  * /home - SSD 18 TB
  * /work - HD 60 TB
  * spare: SSD 18TB, HD 60+60+60TB

## 学外からのアクセス

* まず、アクセスサーバ(qport.sqai.jp)にSSHし、そこからさらにログインサーバ(quetta)にSSHする
* その際、ssh-agent転送を有効にしておくこと

   ```bash
   # 最初にアクセスサーバにSSH
   ssh -A qport.sqai.jp -l ユーザ名
   # そこからさらにログインサーバにSSH
   ssh quetta
   ```

## Compilers, Libraries, etc / コンパイラ、ライブラリ、他

* Ubuntu: lsb_release -d
* GNU Compiler (gcc, g++, gfortran): gcc --version
* Intel(R) oneAPI Compiler (icx, icpx, ifx): icx -V
* OpenBLAS, MKL
* cuda: ls -l /etc/alternatives/cuda
* cmake: cmake --version
* python3 including numpy, scipy, matplotlib, etc: python3 --version

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
     * [scripts/openmp.sh](scripts/openmp.sh): 1ノード/1プロセス/複数スレッド (OpenMP)
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
  * `srun --pty --gres=gpu:h100:1 bash` (H100を1枚使う場合)

## Test programs

* tests/mpicheck.cpp : 割り当てられたプロセス数スレッド数を確認するプログラム
* tests/gpucheck.py : 割り当てられたGPUを確認するプログラム
* How to build test programs

   ```bash
   cmake -B build .
   cmake --build build
   ```
