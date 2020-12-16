#! /bin/bash
#add in the stimfiles and other extras
# Exit upon any error
set -euxo pipefail

# Get the path to the sample data, defined as SAMPLE_DATA_DIR
source setup.sh
logFolder=${LOG_DIR}/s7

mkdir -p $logFolder

matlab -nodisplay -nodesktop -nosplash -r "run ./subroutines/s6_vista.m; exit" > ${logFolder}/vista.log 2>&1
