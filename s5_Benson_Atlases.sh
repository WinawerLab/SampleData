## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

###   Get docker image:   ###
docker pull nben/neuropythy

### Run docker
docker run --rm -it -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects/" nben/neuropythy atlas sub-wlsubj042 --verbose


