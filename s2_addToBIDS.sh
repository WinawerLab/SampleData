#! /bin/bash
#add in the stimfiles and other extras

# Exit upon any error
set -euxo pipefail

# Get the path to the sample data, defined as SAMPLE_DATA_DIR
DIRN=`dirname $0`
source $DIRN/setup.sh ${1-}
logFolder=${LOG_DIR}/s2

mkdir -p $logFolder

# COPY_DISABLE=1 to not copy the .DS_Store
export COPYFILE_DISABLE=0

rsync -avzh "$SAMPLE_DATA_DIR/AddThisToBIDSFolder/"  "$STUDY_DIR"

# Re-check the BIDS-validator now that we added some more files
#     We'll be running the Docker containers as yourself, not as root:
userID=$(id -u):$(id -g)


# Run the docker!
docker run --name BIDSvalidation_container \
           --user $userID \
           --rm \
           --volume $STUDY_DIR:/data:ro \
           bids/validator \
               /data \
           > ${logFolder}/bids-validator_report.txt 2>&1  
           #>> ${STUDY_DIR}/derivatives/bids-validator_report.txt 2>&1
