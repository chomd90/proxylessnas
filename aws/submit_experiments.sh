#!/bin/bash
METHOD=$1
SPACE=$2
SEED=$3
EPOCHS=$4
SINGLE_LEVEL=$5
EXCLUDE_ZERO=$6
ARCH_LR=$7
EDGE_LR=$8
ADAPT_LR=${9}
ARCH_WD=${10}
N_SEEDS=${11}
AWS=${12}


if [[ $SPACE == darts ]]
then
    datasets=(cifar10)
    mode=search_darts
elif [[ $SPACE == small ]]
then
    datasets=(cifar10)
    mode=search_darts
elif [[ $SPACE == pcdarts ]]
then
    datasets=(cifar10)
    mode=search_pcdarts
else 
    datasets=(cifar10 cifar100 ImageNet16-120)
    mode=search_nasbench201
fi

for d in ${datasets[@]}
do
    echo $d
    for s in $(seq 1 $N_SEEDS)
    do
        if [ "$METHOD" = "megadarts" ] || [ "$METHOD" = "mgdarts" ] || [ "$METHOD" = "schattendarts" ] || [ "$METHOD" = "megdas" ]
        then
            if [[ $mode == search_darts ]]
            then
                ./aws/batch_submit_job.sh $mode ${METHOD} method_${METHOD}_space_${SPACE}_edge $SEED $EPOCHS $d  $SINGLE_LEVEL $EXCLUDE_ZERO $ARCH_LR $EDGE_LR $ADAPT_LR $ARCH_WD $AWS
            else
                ./aws/batch_submit_job.sh $mode ${METHOD} method_${METHOD}_space_${SPACE}_edge $SEED $EPOCHS $d  $SINGLE_LEVEL $EXCLUDE_ZERO $ARCH_LR $EDGE_LR $ADAPT_LR $ARCH_WD $AWS
            fi

            ((SEED++))

        else 
            ./aws/batch_submit_job.sh $mode ${METHOD} method_${METHOD}_space_${SPACE} $SEED $EPOCHS $d  $SINGLE_LEVEL $EXCLUDE_ZERO $ARCH_LR $EDGE_LR $ADAPT_LR $ARCH_WD $AWS
            ((SEED++))
        fi
    done
done
