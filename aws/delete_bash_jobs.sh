#!/bin/bash

job_status=(runnable running)
for js in ${job_status[@]}
do

    mapfile -t jobs < <( aws batch list-jobs --job-queue nas-eval --job-status $js | jq '.jobSummaryList[].jobId' )

    for j in "${jobs[@]}" 
    do
        job=${j:1:-1}
        echo $job
        aws batch terminate-job --job-id $job --reason "schedule for deletion"
    done
done
