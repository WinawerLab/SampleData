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

# run scripts
./s0_download_data.sh ${1-}
./s1_preprocess_data.sh ${1-}
./s2_add_to_bids.sh ${1-}
