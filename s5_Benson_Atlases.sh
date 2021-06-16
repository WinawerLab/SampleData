## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

# Exit upon any error
set -euo pipefail

###   Get container image:   ###
container_pull nben/neuropythy

### Run docker

sub=$SUBJECT_ID
ses=$SESSION_ID

mkdir -p "$SAMPLE_DATA_DIR/BIDS/derivatives/atlases/sub-${sub}"

container_run --rm -it \
           -v "$SAMPLE_DATA_DIR/BIDS/derivatives/freesurfer:/subjects/" \
           -v "$SAMPLE_DATA_DIR/BIDS:/bids" \
           nben/neuropythy atlas --verbose "sub-${sub}" \
               --output-path="/bids/derivatives/atlases/sub-${sub}"

# apply the bayesian algorithm to vistasoft prf solutions, stoerd in the folder prfanalyze-vista
container_run --rm -it \
           -v "$SAMPLE_DATA_DIR/BIDS/derivatives/freesurfer:/subjects" \
           -v "$SAMPLE_DATA_DIR/BIDS:/bids" \
           nben/neuropythy register_retinotopy "sub-${sub}" --verbose --max-input-eccen=12 \
               --surf-outdir="/bids/derivatives/atlases/sub-${sub}" \
               --vol-outdir="/bids/derivatives/atlases/sub-${sub}" \
               --surf-format="mgz" \
               --lh-theta=/bids/derivatives/prfanalyze-vista/sub-${sub}/ses-${ses}/lh.angle.mgz \
               --rh-theta=/bids/derivatives/prfanalyze-vista/sub-${sub}/ses-${ses}/rh.angle.mgz \
               --lh-eccen=/bids/derivatives/prfanalyze-vista/sub-${sub}/ses-${ses}/lh.eccen.mgz \
               --rh-eccen=/bids/derivatives/prfanalyze-vista/sub-${sub}/ses-${ses}/rh.eccen.mgz \
               --lh-radius=/bids/derivatives/prfanalyze-vista/sub-${sub}/ses-${ses}/lh.sigma.mgz \
               --rh-radius=/bids/derivatives/prfanalyze-vista/sub-${sub}/ses-${ses}/rh.sigma.mgz \
               --lh-weight=/bids/derivatives/prfanalyze-vista/sub-${sub}/ses-${ses}/lh.vexpl.mgz \
               --rh-weight=/bids/derivatives/prfanalyze-vista/sub-${sub}/ses-${ses}/rh.vexpl.mgz \


# Make an ROI directory
mkdir -p "$SAMPLE_DATA_DIR/BIDS/derivatives/rois/sub-${sub}"
container_run -i --rm \
           -v "$SAMPLE_DATA_DIR/BIDS/derivatives/freesurfer/sub-${sub}:/subjects/${sub}" \
           -v "$SAMPLE_DATA_DIR/BIDS:/bids" \
           -v "$SAMPLE_DATA_DIR/../subroutines:/runpy/" \
           nben/neuropythy bash <<EOF
python /runpy/subscript_rois.py ${sub}
EOF
