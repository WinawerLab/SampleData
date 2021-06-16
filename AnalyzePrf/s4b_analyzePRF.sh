#! /bin/bash
#add in the stimfiles and other extras

# Exit upon any error
set -euxo pipefail

# Get the path to the sample data, defined as SAMPLE_DATA_DIR
DIRN=`dirname $0`
source $DIRN/setup.sh ${1-}
logFolder=${LOG_DIR}/s4

mkdir -p $logFolder

matlab -nodisplay -nodesktop -nosplash -r "run ./subroutines/s4b_analyzePRF.m; exit;" > ${logFolder}/analyzePRF.log 2>&1
