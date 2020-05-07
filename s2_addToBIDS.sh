#! /bin/bash
#add in the stimfiles and other extras

# Exit upon any error
set -euxo pipefail

# Get the path to the sample data, defined as SAMPLE_DATA_DIR
source setup.sh

# COPY_DISABLE=1 to not copy the .DS_Store
export COPYFILE_DISABLE=0

rsync -avzh "$SAMPLE_DATA_DIR/AddThisToBIDSFolder/"  "$SAMPLE_DATA_DIR/BIDS/"

# Re-check the BIDS-validator now that we added some more files
#     We'll be running the Docker containers as yourself, not as root:
userID=$(id -u):$(id -g)

# Path to project folder
studyFolder="$SAMPLE_DATA_DIR/BIDS"

# Run the docker!
docker run --name BIDSvalidation_container \
           --user $userID \
           --rm \
           --volume $studyFolder:/data:ro \
           bids/validator \
               /data \
           >> ${studyFolder}/derivatives/bids-validator_report.txt 2>&1