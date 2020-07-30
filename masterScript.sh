#! /bin/bash

# Exit upon any error
set -euxo pipefail

function die {
    echo "$*"
    exit 1
}

# Check dependencies:
#	Check for alias to open matlab from shell
[ -z "`which matlab`" ] && die "matlab is not on the path!"
#	Check for freesurfer license file
[ -r /Applications/freesurfer/license.txt ] || die "No freesurfer license found!"
#	Check for python environment
python -c 'import PIL, neuropythy, matplotlib' || die "In command line, run <conda activate winawerlab> prior to masterScript."

[ -r DownloadedData/dicoms.zip ] || ./s0_download-data.sh "$PWD/DownloadedData"

# script 1, shell
./s1_preprocess-data.sh

# script 2, shell
./s2_addToBIDS.sh

# script 3, matlab
source setup.sh; matlab -nodisplay -nodesktop -nosplash -r "s3_glmDenoise; exit;"

# script 4, matlab
source setup.sh; matlab -nodisplay -nodesktop -nosplash -r "s4_prf; exit"

# script 5, shell
./s5_Benson_Atlases.sh