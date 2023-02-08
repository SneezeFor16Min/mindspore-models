#!/bin/bash
# Copyright 2021 Huawei Technologies Co., Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

if [ $# != 3 ]
then
    echo "Usage: bash run_train_gpu.sh [DATASET] [EPOCHS] [DEVICE_ID]"
exit 1
fi

DATASET=$1
EPOCHS=$2
DEVICE_ID=$3

export CUDA_VISIBLE_DEVICES=$DEVICE_ID
export GLOG_v=3

echo "DATASET: $DATASET   EPOCHS: $EPOCHS   DEVICE_ID: $DEVICE_ID"

if [ ! -d "checkpoints" ]
then
    mkdir checkpoints
fi

if [ ! -d "logs" ]
then
    mkdir logs
fi

echo "Start training..."
if [ $DATASET == spring ]
then
    nohup python -u train.py --dataset $DATASET --reg 100 --dim 4 --epochs $EPOCHS > logs/train_$DATASET.log 2>&1 &
elif [ $DATASET == charged ]
then
    nohup python -u train.py --dataset $DATASET --reg 100 --dim 4 --epochs $EPOCHS --lr 2e-3 > logs/train_$DATASET.log 2>&1 &
elif [ $DATASET == kuramoto ]
then 
    nohup python -u train.py --dataset $DATASET --reg 1 --dim 3 --skip --epochs $EPOCHS > logs/train_$DATASET.log 2>&1 &
fi