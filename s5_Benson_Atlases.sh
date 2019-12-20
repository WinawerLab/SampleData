## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

###   Get docker image:   ###
docker pull nben/neuropythy

### Run docker
docker run --rm -it -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects/" nben/neuropythy atlas sub-wlsubj042 --verbose

docker run --rm -it -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects" nben/neuropythy register_retinotopy --verbose --max-input-eccen=12 \
  --lh-theta=BIDS/derivatives/analyzePRF/coarse/sub-wlsubj042/ses-01/lh.angle.mgz
  --rh-theta=BIDS/derivatives/analyzePRF/coarse/sub-wlsubj042/ses-01/rh.angle.mgz
  --lh-eccen=BIDS/derivatives/analyzePRF/coarse/sub-wlsubj042/ses-01/lh.eccen.mgz
  --rh-eccen=BIDS/derivatives/analyzePRF/coarse/sub-wlsubj042/ses-01/rh.eccen.mgz
  --lh-radius=BIDS/derivatives/analyzePRF/coarse/sub-wlsubj042/ses-01/lh.sigma.mgz
  --rh-radius=BIDS/derivatives/analyzePRF/coarse/sub-wlsubj042/ses-01/rh.sigma.mgz
  --lh-weight=BIDS/derivatives/analyzePRF/coarse/sub-wlsubj042/ses-01/lh.vexpl.mgz
  --rh-weight=BIDS/derivatives/analyzePRF/coarse/sub-wlsubj042/ses-01/rh.vexpl.mgz






