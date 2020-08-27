#! /bin/bash
#add in the stimfiles and other extras

# Exit upon any error
set -euxo pipefail

# Get the path to the sample data, defined as SAMPLE_DATA_DIR
source setup.sh
logFolder=${LOG_DIR}/s4

mkdir -p $logFolder

matlab -nodisplay -nodesktop -nosplash -r "s4_prf; exit;" > ${logFolder}/prf.log 2>&1