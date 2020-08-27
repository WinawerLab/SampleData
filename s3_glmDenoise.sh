#! /bin/bash
#add in the stimfiles and other extras

# Exit upon any error
set -euxo pipefail

# Check for python environment
python -c 'import PIL, neuropythy, matplotlib' || die "In command line, run <conda activate winawerlab> prior to masterScript."


# Get the path to the sample data, defined as SAMPLE_DATA_DIR
source setup.sh
logFolder=${LOG_DIR}/s3

mkdir -p $logFolder

matlab -nodisplay -nodesktop -nosplash -r "s3_glmDenoise; exit;" > ${logFolder}/glmDenoise.log 2>&1