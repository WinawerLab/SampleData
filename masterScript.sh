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

[ -r DownloadedData/dicoms.zip ] || ./s0_download-data.sh 

# run scripts 
./s1_preprocess-data.sh
./s2_addToBIDS.sh
./s3_glmDenoise.sh
./s4a_vistaPRF.sh
./s4b_analyzePRF.sh
./s5_Benson_Atlases.sh