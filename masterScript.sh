#! /bin/bash
source setup.sh

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

# run scripts
./s0_download-data.sh ${1-}
./s1_preprocess-data.sh ${1-}
./s2_addToBIDS.sh ${1-}
./s3_glmDenoise.sh ${1-}
./s4_vistaPRF.sh ${1-}
./s5_Benson_Atlases.sh ${1-}
