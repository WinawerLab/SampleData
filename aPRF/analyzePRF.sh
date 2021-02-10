#! /bin/bash
#add in the stimfiles and other extras
source ./../setup.sh
# Exit upon any error
set -euxo pipefail

# Get the path to the sample data, defined as SAMPLE_DATA_DIR
source setup.sh
logFolder=${LOG_DIR}/s4

mkdir -p $logFolder

matlab -nodisplay -nodesktop -nosplash -r "run ./analyzePRF.m; exit;" > ${logFolder}/analyzePRF.log 2>&1
