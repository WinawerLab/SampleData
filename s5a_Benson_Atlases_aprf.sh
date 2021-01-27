## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

# Exit upon any error
set -euxo pipefail

###   Get docker image:   ###
docker pull nben/neuropythy # do want to specify a version of neuropythy?

### Run docker

sub=$SUBJECT_ID
ses=$SESSION_ID


# aprf_run is used by the bayesian inference
aprf_run=coarse 



mkdir -p "$SAMPLE_DATA_DIR/BIDS/derivatives/atlases/sub-${sub}"

# Make an anatomy-derived retinotopic atlas
docker run --rm -it \
           -v "$SAMPLE_DATA_DIR/BIDS/derivatives/freesurfer:/subjects/" \
           -v "$SAMPLE_DATA_DIR/BIDS:/bids" \
           nben/neuropythy atlas --verbose "sub-${sub}" \
               --output-path="/bids/derivatives/atlases/sub-${sub}"

# Make a Bayesian atlas using functional and anatomical data
docker run --rm -it \
           -v "$SAMPLE_DATA_DIR/BIDS/derivatives/freesurfer:/subjects" \
           -v "$SAMPLE_DATA_DIR/BIDS:/bids" \
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


<<<<<<< HEAD:s5a_Benson_Atlases_aprf.sh

=======
# Make an ROI directory
mkdir -p "$(pwd)/BIDS/derivatives/rois/sub-${sub}"
docker run -i --rm \
           -v "$(pwd)/BIDS/derivatives/freesurfer/sub-${sub}:/subjects/${sub}" \
           -v "$(pwd)/BIDS:/bids" \
           -v "$(pwd)/../subroutines:/runpy/" \
           nben/neuropythy bash <<EOF 
           python /runpy/subscript_rois.py ${sub} 
           EOF
>>>>>>> 772de3e07f40731e1cfe82e7d99eac7047d9e099:s5_Benson_Atlases.sh







