#! /bin/bash

function die {
    echo "$*"
    exit 1
}

# Sanity checks:
[ -z "`which matlab`" ] && die "matlab is not on the path!"
[ -r /Applications/freesurfer/license.txt ] || die "No freesurfer license found!"

mkdir temp && cd temp
git clone https://github.com/winawerlab/sampledata && cd sampledata

mkdir -p DownloadedData 

./s0_download-data.sh "$PWD/DownloadedData" && cd DownloadedData

./s1_preprocess-data.sh

./s2_addToBIDS.sh

matlab -nodisplay -nodesktop -nosplash ./s3_glmDenoise.m

matlab -nodisplay -nodesktop -nosplash ./s4_prf.m

./s5_Benson_Atlases.sh


