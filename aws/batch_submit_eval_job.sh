#!/usr/bin/env bash

# Construct command.
aws=$4
if [[ $aws == ameet ]]
then
    JOB_QUEUE=nas-eval
    JOB_DEFINITION=arch_eval:1
    S3_BUCKET=megadarts
else
    JOB_QUEUE=nasbench201
    JOB_DEFINITION=nasbench201:3
    S3_BUCKET=nas-theory
fi

echo $JOB_QUEUE $JOB_DEFINITION

JOB_COMMAND="\"./evaluate_arch.sh\""

echo ${JOB_COMMAND}

# Utils.
function join_by { local IFS="$1"; shift; echo "$*"; }

ARCH=$1
SEED=$2
DROP_PATH=$3
BATCH_SIZE=$5

JOB_COMMAND_ARGS=(
    "\"${ARCH}\""
    "\"${SEED}\""
    "\"${DROP_PATH}\""
    "\"${BATCH_SIZE}\""
    "\"${S3_BUCKET}\""
    "\"$6\""
    "\"$7\""
)

JOB_COMMAND_ARGS_STR=$(join_by , "${JOB_COMMAND_ARGS[@]}")
JOB_COMMAND="[${JOB_COMMAND},${JOB_COMMAND_ARGS_STR}]"

echo ${JOB_COMMAND}

aws batch submit-job \
    --job-name $1-seed$2-dataset$4-$(date +'%Y-%m-%d-exp-%H-%M-%S') \
    --job-queue ${JOB_QUEUE} \
    --job-definition ${JOB_DEFINITION} \
    --container-overrides \
        command=${JOB_COMMAND}
