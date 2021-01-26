## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

# Exit upon any error
set -euxo pipefail

###   Get docker image:   ###
#docker pull nben/neuropythy

### Run docker

sub=$SUBJECT_ID
ses=$SESSION_ID


# aprf_run is used by the bayesian inference
aprf_run=coarse 


mkdir -p "$(SAMPLE_DATA_DIR)/BIDS/derivatives/atlases/sub-${sub}"

docker run --rm -it \
           -v "$(SAMPLE_DATA_DIR)/BIDS/derivatives/freesurfer:/subjects/" \
           -v "$(SAMPLE_DATA_DIR)/BIDS:/bids" \
           nben/neuropythy atlas --verbose "sub-${sub}" \
               --output-path="/bids/derivatives/atlases/sub-${sub}"

docker run --rm -it \
           -v "$(SAMPLE_DATA_DIR)/BIDS/derivatives/freesurfer:/subjects" \
           -v "$(SAMPLE_DATA_DIR)/BIDS:/bids" \
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










