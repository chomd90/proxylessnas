#!/usr/bin/env bash

DOCKER_IMG_NAME=nas-theory:$1
DOCKERFILE_PATH=aws/config.dockerfile
NINA_URL=974768463953.dkr.ecr.us-east-2.amazonaws.com
AMEET_URL=219809570322.dkr.ecr.us-east-1.amazonaws.com
AMEET_URL2=219809570322.dkr.ecr.us-east-2.amazonaws.com


# Assume that the script runs from the root directory.
docker build --build-arg NAS_VER=$(date +%Y%m%d-%H%M%S) -t ${DOCKER_IMG_NAME} -f ${DOCKERFILE_PATH} .

if [[ $2 == push ]]; then
    echo "Pushing to AWS..."
    if [[ $3 == nina ]] 
    then
        docker tag ${DOCKER_IMG_NAME} ${NINA_URL}/${DOCKER_IMG_NAME}
        # Login into ECR.
        $(aws ecr get-login --no-include-email --region us-east-2)
        docker push ${NINA_URL}/${DOCKER_IMG_NAME}
    elif [[ $3 == ameet ]]
    then
        # Login into ECR.
        docker tag ${DOCKER_IMG_NAME} ${AMEET_URL}/${DOCKER_IMG_NAME}
        $(aws ecr get-login --no-include-email --region us-east-1)
        docker push ${AMEET_URL}/${DOCKER_IMG_NAME}
    elif [[ $3 == ameet2 ]]
    then
        # Login into ECR.
        docker tag ${DOCKER_IMG_NAME} ${AMEET_URL2}/${DOCKER_IMG_NAME}
        $(aws ecr get-login --no-include-email --region us-east-2)
        docker push ${AMEET_URL2}/${DOCKER_IMG_NAME}
    fi
fi
