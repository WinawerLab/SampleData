#! /bin/bash
source setup.sh

# Exit upon any error
set -exo pipefail

function die {
    echo "$*"
    exit 1
}

# Check dependencies:
#	Check for alias to open matlab from shell
[ -z "`which matlab`" ] && die "matlab is not on the path!"
#	Check for freesurfer license file
[ -r $(fsLicensePath) ] || die "No freesurfer license found!"
#	Check for python environment
python -c 'import PIL, neuropythy, matplotlib' || die "In command line, run <conda activate winawerlab> prior to masterScript."

# run scripts
./s0_download_data.sh ${1-}
./s1_preprocess_data.sh ${1-}
./s2_add_to_bids.sh ${1-}
./s3_glm_denoise.sh ${1-}
./s4_vista_prf.sh ${1-}
./s5_benson_atlases.sh ${1-}
