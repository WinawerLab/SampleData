## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

# Exit upon any error
set -euxo pipefail

###   Get docker image:   ###
#docker pull nben/neuropythy

### Run docker
#
# This script assumes you are in the root directory for the project, which is one directory level up from the BIDS project directory, called 'bids'. Therefore 'bids' should be a subdirectory in the current directory. Otherwise this script will fail.
sub=wlsubj042
ses=01
# aprf_run is used by the bayesian inference
aprf_run=coarse 

cd DownloadedData

mkdir -p "$(pwd)/BIDS/derivatives/atlases/sub-${sub}"

docker run --rm -it \
           -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects/" \
           -v "$(pwd)/BIDS:/bids" \
           nben/neuropythy atlas --verbose "sub-${sub}" \
               --output-path="/bids/derivatives/atlases/sub-${sub}"

docker run --rm -it \
           -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects" \
           -v "$(pwd)/BIDS:/bids" \
           nben/neuropythy register_retinotopy "sub-${sub}" --verbose --max-input-eccen=12 \
               --surf-outdir="/bids/derivatives/atlases/sub-${sub}" \
               --vol-outdir="/bids/derivatives/atlases/sub-${sub}" \
               --surf-format="mgz" \
               --lh-theta=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/lh.angle.mgz \
               --rh-theta=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/rh.angle.mgz \
               --lh-eccen=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/lh.eccen.mgz \
               --rh-eccen=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/rh.eccen.mgz \
               --lh-radius=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/lh.sigma.mgz \
               --rh-radius=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/rh.sigma.mgz \
               --lh-weight=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/lh.vexpl.mgz \
               --rh-weight=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/rh.vexpl.mgz \


# Make an ROI directory
mkdir -p "$(pwd)/BIDS/derivatives/rois/sub-${sub}"
docker run -i --rm \
           -v "$(pwd)/BIDS/derivatives/freesurfer/sub-${sub}:/subjects/${sub}" \
           -v "$(pwd)/BIDS:/bids" \
           -v "$(pwd)/../:/runpy/" \
           nben/neuropythy bash <<EOF
python /runpy/s6_subscript_rois.py ${sub}
EOF



cd ..






