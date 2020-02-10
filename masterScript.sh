#! /bin/bash

[ -r /Applications/freesurfer/license.txt ] || {
    echo "No freesurfer license found!"
    exit 1
}

mkdir temp && cd temp
git clone https://github.com/winawerlab/sampledata && cd sampledata

./s0_download-data.sh "$PWD"

./s1_preprocess-data.sh

./s2_addToBIDS.sh

matlab -nodisplay -nodesktop -nosplash ./s3_glmDenoise.m

matlab -nodisplay -nodesktop -nosplash ./s4_prf.m

./s5_Benson_Atlases.sh


