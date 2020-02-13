#! /bin/bash

# Exit upon any error
set -euxo pipefail

function die {
    echo "$*"
    exit 1
}

# Sanity checks:
[ -z "`which matlab`" ] && die "matlab is not on the path!"
[ -r /Applications/freesurfer/license.txt ] || die "No freesurfer license found!"

[ -r DownloadedData/dicoms.zip ] || ./s0_download-data.sh "$PWD/DownloadedData"

cd DownloadedData

../s1_preprocess-data.sh

../s2_addToBIDS.sh

matlab -nodisplay -nodesktop -nosplash ../s3_glmDenoise.m

matlab -nodisplay -nodesktop -nosplash ../s4_prf.m

../s5_Benson_Atlases.sh