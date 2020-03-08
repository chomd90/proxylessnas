#!/bin/bash

#for arch_seed in $(seq 21 24)
#do
#    for seed in $(seq 1 5) 
#    do
#        ./aws/batch_submit_eval_job.sh megadarts$arch_seed $seed
#    done
#done
aws=$1
seed=$2
drop_path=$3
batch_size=$4

#./aws/batch_submit_eval_job.sh dartsedartscifar10204 $seed $drop_path 
#./aws/batch_submit_eval_job.sh dartsedartscifar10205 $seed $drop_path 
#./aws/batch_submit_eval_job.sh dartsedartscifar10206 $seed $drop_path 
#./aws/batch_submit_eval_job.sh dartsedartscifar10207 $seed $drop_path 
#
#./aws/batch_submit_eval_job.sh dartsmegadartscifar107700 $seed $drop_path 
#./aws/batch_submit_eval_job.sh dartsmegadartscifar107701 $seed $drop_path 
#./aws/batch_submit_eval_job.sh dartsmegadartscifar107702 $seed $drop_path 
#./aws/batch_submit_eval_job.sh dartsmegadartscifar107703 $seed $drop_path 

#./aws/batch_submit_eval_job.sh megadarts21 $seed $drop_path 
#./aws/batch_submit_eval_job.sh megadarts22 $seed $drop_path 
#./aws/batch_submit_eval_job.sh megadarts23 $seed $drop_path 
#./aws/batch_submit_eval_job.sh megadarts24 $seed $drop_path 

#for s in $(seq 400 410)
#do
#    ./aws/batch_submit_eval_job.sh megadarts22  $s 0.3
#done

#./aws/batch_submit_eval_job.sh pcdartseedartscifar103100 $seed $drop_path $aws 
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103101 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103102 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103103 $seed $drop_path $aws
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103200 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103201 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103202 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103203 $seed $drop_path $aws
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103300 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103301 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103302 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103303 $seed $drop_path $aws

#./aws/batch_submit_eval_job.sh pcdartseedartscifar103400 $seed $drop_path $aws 
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103401 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103402 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103403 $seed $drop_path $aws
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103500 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103501 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103502 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103503 $seed $drop_path $aws
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103600 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103601 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103602 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103603 $seed $drop_path $aws

#./aws/batch_submit_eval_job.sh pcdartseedartscifar105100 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105101 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105102 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105103 $seed $drop_path $aws
#
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105300 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105301 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105302 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105303 $seed $drop_path $aws
#
#./aws/batch_submit_eval_job.sh pcdartsmegadartscifar104100 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartsmegadartscifar104101 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartsmegadartscifar104102 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartsmegadartscifar104103 $seed $drop_path $aws
#
#./aws/batch_submit_eval_job.sh pcdartsmegadartscifar104300 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartsmegadartscifar104301 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartsmegadartscifar104302 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartsmegadartscifar104303 $seed $drop_path $aws

#./aws/batch_submit_eval_job.sh pcdartseedartscifar103110 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103111 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103112 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103113 $seed $drop_path $aws
./aws/batch_submit_eval_job.sh pcdartseedartscifar103114 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.035
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103120 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103121 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103122 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103123 $seed $drop_path $aws
./aws/batch_submit_eval_job.sh pcdartseedartscifar103124 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.035
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103130 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103131 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103132 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103133 $seed $drop_path $aws
./aws/batch_submit_eval_job.sh pcdartseedartscifar103134 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.035


#./aws/batch_submit_eval_job.sh pcdartseedartscifar103110 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103111 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103112 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103113 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103120 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103121 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103122 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103123 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103130 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103131 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103132 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103133 $seed $drop_path $aws $batch_size train.init_channels=36 train.learning_rate=0.05
# Train with label smoothing and more params
#start=$seed
#let end=start+4
#for s in $(seq $start $end)
#do
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103103 $s $drop_path $aws $batch_size train.init_channels=42 train.label_smoothing=true
#done

# NOT SUBMITTED
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105200 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105201 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105202 $seed $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar105203 $seed $drop_path $aws


# Stage 3
#start=$seed
#let end=start+10
#for s in $(seq $start $end)
#do
##./aws/batch_submit_eval_job.sh pcdartseedartscifar103103 $s $drop_path $aws
#./aws/batch_submit_eval_job.sh pcdartseedartscifar103402 $s $drop_path $aws
#done
