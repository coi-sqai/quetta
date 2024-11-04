#!/usr/bin/env python3

import os
import torch

if torch.cuda.is_available():
    print("CUDA is available.")
    if os.environ.get('CUDA_VISIBLE_DEVICES') is None:
        print("CUDA_VISIBLE_DEVICES: not defined")
    else:
        print(f"CUDA_VISIBLE_DEVICES: {os.environ['CUDA_VISIBLE_DEVICES']}")
    print(f"Device Count: {torch.cuda.device_count()}")
    print(f"Device Name: {torch.cuda.get_device_name()}")
    print(f"Device Capability: {torch.cuda.get_device_capability()}")
else:
    print("CUDA is NOT available.")
