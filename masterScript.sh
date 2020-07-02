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
[ -z "conda activate winawerlab" ] || die "Unable to find winawerlab python environment"

[ -r DownloadedData/dicoms.zip ] || ./s0_download-data.sh "$PWD/DownloadedData"

cd DownloadedData

../s1_preprocess-data.sh

../s2_addToBIDS.sh

source setup.sh; matlab -nodisplay -nodesktop -nosplash -r s3_glmDenoise

source setup.sh; matlab -nodisplay -nodesktop -nosplash -r s4_prf

../s5_Benson_Atlases.sh