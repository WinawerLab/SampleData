#! /bin/bash
#add in the stimfiles and other extras

# Exit upon any error
set -euo pipefail

# Check for python environment
python -c 'import PIL, neuropythy, matplotlib' || die "In command line, run <conda activate winawerlab> prior to masterScript."


# Get the path to the sample data, defined as SAMPLE_DATA_DIR
DIRN=`dirname $0`
source $DIRN/setup.sh ${1-}
logFolder=${LOG_DIR}/s3

mkdir -p $logFolder

matlab -nodisplay -nodesktop -nosplash -r "run ./subroutines/s3_glmDenoise.m; exit;" > ${logFolder}/glmDenoise.log 2>&1
