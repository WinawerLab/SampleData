## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

###   Get docker image:   ###
docker pull nben/neuropythy

### Run docker
#
# This script assumes you are in the root directory for the project, which is one directory level up from the BIDS project directory, called 'bids'. Therefore 'bids' should be a subdirectory in the current directory. Otherwise this script will fail.
sub=wlsubj042
ses=01

mkdir -p "$(pwd)/BIDS/derivatives/atlases/sub-${sub}/ses-${ses}"

docker run --rm -it -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects/" nben/neuropythy atlas -o "$(pwd)/BIDS/derivatives/atlases/sub-${sub}/ses-${ses}" --verbose

docker run --rm -it -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects" nben/neuropythy register_retinotopy --verbose --max-input-eccen=12 \
  --lh-theta=BIDS/derivatives/analyzePRF/coarse/sub-${sub}/ses-${ses}/lh.angle.mgz
  --rh-theta=BIDS/derivatives/analyzePRF/coarse/sub-${sub}/ses-${ses}/rh.angle.mgz
  --lh-eccen=BIDS/derivatives/analyzePRF/coarse/sub-${sub}/ses-${ses}/lh.eccen.mgz
  --rh-eccen=BIDS/derivatives/analyzePRF/coarse/sub-${sub}/ses-${ses}/rh.eccen.mgz
  --lh-radius=BIDS/derivatives/analyzePRF/coarse/sub-${sub}/ses-${ses}/lh.sigma.mgz
  --rh-radius=BIDS/derivatives/analyzePRF/coarse/sub-${sub}/ses-${ses}/rh.sigma.mgz
  --lh-weight=BIDS/derivatives/analyzePRF/coarse/sub-${sub}/ses-${ses}/lh.vexpl.mgz
  --rh-weight=BIDS/derivatives/analyzePRF/coarse/sub-${sub}/ses-${ses}/rh.vexpl.mgz






