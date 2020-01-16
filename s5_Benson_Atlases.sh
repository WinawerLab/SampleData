## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

###   Get docker image:   ###
#docker pull nben/neuropythy

### Run docker
#
# This script assumes you are in the root directory for the project, which is one directory level up from the BIDS project directory, called 'bids'. Therefore 'bids' should be a subdirectory in the current directory. Otherwise this script will fail.
sub=wlsubj042
ses=01
# aprf_run is used by the bayesian inference
aprf_run=coarse 

mkdir -p "$(pwd)/BIDS/derivatives/atlases/sub-${sub}/ses-${ses}"

docker run --rm -it \
           -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects/" \
           -v "$(pwd)/BIDS:/bids" \
           nben/neuropythy atlas --verbose "sub-${sub}" \
               --output-path="/bids/derivatives/atlases/sub-${sub}/ses-${ses}"

docker run --rm -it \
           -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects" \
           -v "$(pwd)/BIDS:/bids" \
           nben/neuropythy register_retinotopy "sub-${sub}" --verbose --max-input-eccen=12 \
               --surf-outdir="/bids/derivatives/atlases/sub-${sub}/ses-${ses}" \
               --vol-outdir="/bids/derivatives/atlases/sub-${sub}/ses-${ses}" \
               --lh-theta=BIDS/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/lh.angle.mgz \
               --rh-theta=BIDS/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/rh.angle.mgz \
               --lh-eccen=BIDS/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/lh.eccen.mgz \
               --rh-eccen=BIDS/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/rh.eccen.mgz \
               --lh-radius=BIDS/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/lh.sigma.mgz \
               --rh-radius=BIDS/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/rh.sigma.mgz \
               --lh-weight=BIDS/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/lh.vexpl.mgz \
               --rh-weight=BIDS/derivatives/analyzePRF/${aprf_run}/sub-${sub}/ses-${ses}/rh.vexpl.mgz








