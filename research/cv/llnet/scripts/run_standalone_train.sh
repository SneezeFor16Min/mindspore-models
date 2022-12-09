#!/bin/bash
# Copyright 2022 Huawei Technologies Co., Ltd
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
if [ $# -ne 3 ]
then 
    echo "Usage: bash run_standalone_train.sh [DEVICE_ID] [DATASET_PATH] [DEVICE_TARGET]"
exit 1
fi

# check device id
if [ "$1" -eq "$1" ] 2>/dev/null
then
    if [ $1 -lt 0 ] || [ $1 -gt 7 ]
    then
        echo "error: DEVICE_ID=$1 is not in (0-7)"
    exit 1
    fi
else
    echo "error: DEVICE_ID=$1 is not a number"
exit 1
fi

# check dataset path
if [ ! -d $2 ]
then
    echo "error: DATASET_PATH=$2 is not a directory"
exit 1
fi

# check device target
if [ "$3" != "Ascend" ] && [ "$3" != "GPU" ]
then
  echo "error: DEVICE_TARGET is not in [Ascend, GPU]"
  exit 1
fi

python ../train.py --device_id=$1 --dataset_path=$2  --device_target=$3 > train.log 2>&1 &
