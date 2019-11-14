## Run Noah Benson's reinotopic map atlas
#   See retinotopy tutorial for details: https://nben.net/Retinotopy-Tutorial/#atlas-generation

###   Get docker image:   ###
docker pull nben/neuropythy

### Run docker
docker run --rm -it -v "$(pwd)/BIDS/derivatives/freesurfer:/subjects/" nben/neuropythy atlas sub-wlsubj042 --verbose


### after running bids_AnalyzePRF
% in Matlab
% results -> MGZs

% find the subject's freesurfer directory


% read in a sample MGZ (from subject freesurfer)

% read in rh.curv and lh.curv
% use this to det the number of l and r vertices

% use the mgz header read in for a new file

% overwrite the vol field with left data and save

% overwrite the vol field with right data and save

% what are the files expected by bayesian retinotopy?
% left and right theta (in radians), eccen, size, r2




