#!/bin/bash
$(aws ecr get-login --no-include-email --region us-east-2)
DOCKER_IMG_NAME=nas-theory:$1

docker run -it --gpus 0 \
    --mount type=bind,source=/home/liamcli/Projects/Data,target=/data \
    --mount type=bind,source=/home/liamcli/Projects/nas-theory,target=/nas-theory \
    --mount type=bind,source=/media/liamcli/fastfiles/results/desktop/test,target=/results \
    --rm ${DOCKER_IMG_NAME}

