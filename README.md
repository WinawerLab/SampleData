# SampleData

Code related to the processing of the Winawer lab sample dataset

The scripts in this directory present an example analysis of fMRI data like
those often performed in the Winawer lab. 

Main scripts:
- `masterScript.sh`: checks for dependencies (matlab, freesurfer license, python
environment) and calls the rest of the scripts in this section, in order. Takes
a very long time, so you may want to call each section separately (which will
also ease debugging).
- `s0_download-data.sh`: downloads the DICOMs and extra files from the OSF.
- `s1_preprocess-data.sh`: converts data from DICOMs to NIFTIs, then defaces,
  preprocesses, and runs the BIDS validator on the data. Uses docker to do all
  this; this script takes the longest time.
- `s2_addToBIDS.sh`: copies over the extra files (e.g., stimulus) into the BIDS
  directory, then runs BIDS validator. This takes <5 minutes.
- `s3_glmDenoise.sh`: runs
  [GLMdenoise](https://github.com/kendrickkay/GLMdenoise) on the preprocessed
  data (just the `sfp` task), estimating the response of each voxel to the
  log-polar grating stimuli. Uses MATLAB.
- `s4_prf.sh`: runs [analyzePRF](https://github.com/kendrickkay/analyzePRF) on
  the preprocessed data (just the `prf` task), estimating the location and size
  of each voxels' population receptive field (pRF). Uses MATLAB.
- `s5_Benson_Atlases.sh`: runs
  [neuropythy](https://github.com/noahbenson/neuropythy) on the data to generate
  the anatomical atlas of visual areas and the Bayesian retinotopic analysis
  (combining the anatomical atlas and the pRF results from above). Uses Docker.
- `s6_vista.sh`: runs [vistasoft](https://github.com/vistalab/vistasoft) on the
  preprocessed data (just the `prf` task) to estimate the location and size of
  each voxels' pRF. This is similar to `s4_prf.sh`, but uses another algorithm
  to do so. Uses MATLAB and Docker.

Sub-scripts:
- `completeJSONS.sh`: called by `s1_preprocess-data.sh` to fill out the
  information contained in the sidecar jsons for BIDS. Script written by NYU
  CBI, necessary for fMRIprep.
- `setup.sh`: called at the beginning of each script to set environmental
  variables to make sure we get paths correct.
- `subroutines/`, contains helper scripts used by the main scripts:
  - `s3_glmDenoise.m`: actually calls GLMdenoise on the data, after setting the
    various arguments. Saves out many images for examining the quality of the
    fit. Uses MATLAB, python, and the Winawer Lab `MRI_tools` repo (see below).
  - `s4_prf.m`: actually calls analyzePRF on the data, after setting various
    arguments. Uses MATLAB and the Winawer Lab `MRI_tools` repo (see below).
  - `s6_vista.m`: actually calls vistasoft on the data, after setting various
    arguments. Uses MATLAB, docker, and ???.
  - `subscript_rois.py`: Saves out `.annot` files for the proposed visual areas
    from the Bayesian retinotopic analysis. Called at the end of
    `s5_Benson_Atlases.sh`. Uses python.

## Dependencies:
- matlab (version??) must be on the system path (MATLAB 9.6?)
- [ToolboxToolbox](https://github.com/ToolboxHub/ToolboxToolbox), for managing
  matlab dependencies. Follow its README for setting it up.
  - [Winawer lab Toolbox
    Registry](https://github.com/WinawerLab/ToolboxRegistry).
- docker
- freesurfer license must be at `/Applications/freesurfer/license.txt`
  (note that currently this will fail in Linux) or at the location
  specified by the environmental variable `$FREESURFER_LICENSE`
- setup the `winawerlab` python environment, as described
  [here](https://wikis.nyu.edu/display/winawerlab/Python+and+Conda)
  (you can activate it, following step 4, but you shouldn't need to if
  you use `masterScript.sh`, because we activate it there).
- download the Winawer Lab
  [MRI_tools](https://github.com/WinawerLab/MRI_tools) repo and make
  sure that its `BIDS` folder is on your path. One way to do this,
  from the command line, is (note this will only last for this
  session, if you want to permanently add that folder to your path,
  add the last line to your `~/.bashrc` file):

```
# download the repo
git clone git@github.com:WinawerLab/MRI_tools.git ~/Documents/MRI_tools
# add it to your path
export PATH="$HOME/Documents/MRI_tools/BIDS/:$PATH"
```
