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
               --lh-theta=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/lh.angle.mgz \
               --rh-theta=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/rh.angle.mgz \
               --lh-eccen=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/lh.eccen.mgz \
               --rh-eccen=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/rh.eccen.mgz \
               --lh-radius=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/lh.sigma.mgz \
               --rh-radius=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/rh.sigma.mgz \
               --lh-weight=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/lh.vexpl.mgz \
               --rh-weight=/bids/derivatives/analyzePRF/${aprf_run}/sub-${sub}/rh.vexpl.mgz








