#!/usr/bin/env bash

# Construct command.
AWS=${13}
echo $AWS
if [[ $AWS == ameet ]] 
then
    jobdef=4
    bucket=megadarts
else
    jobdef=3
    bucket=nas-theory
fi

echo $jobdef

JOB_QUEUE=nasbench201
JOB_DEFINITION=nasbench201:$jobdef
JOB_COMMAND="\"./run_hydra_config.sh\""

echo ${JOB_COMMAND}

# Utils.
function join_by { local IFS="$1"; shift; echo "$*"; }

JOB_COMMAND_ARGS=(
    "\"$1\""
    "\"$2\""
    "\"$3\""
    "\"$4\""
    "\"$5\""
    "\"$6\""
    "\"$7\""
    "\"$8\""
    "\"$bucket\""
    "\"search.arch_learning_rate=${9}\""
    "\"search.edge_learning_rate=${10}\""
    "\"search.adapt_lr=${11}\""
    "\"search.arch_weight_decay=${12}\""
)

JOB_COMMAND_ARGS_STR=$(join_by , "${JOB_COMMAND_ARGS[@]}")
JOB_COMMAND="[${JOB_COMMAND},${JOB_COMMAND_ARGS_STR}]"

echo ${JOB_COMMAND}

aws batch submit-job \
    --job-name $1-$2-$3-$4-$(date +'%Y-%m-%d-exp-%H-%M-%S') \
    --job-queue ${JOB_QUEUE} \
    --job-definition ${JOB_DEFINITION} \
    --container-overrides \
        command=${JOB_COMMAND}
