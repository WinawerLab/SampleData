# SampleData

Code related to the processing of the Winawer lab sample dataset

The scripts in this directory present an example analysis of fMRI data like
those often performed in the Winawer lab. 

You can set the directory to put all data and analyses in by passing a path to
any of the main scripts. Alternatively, if they're called with no arguments, the
data directory is set to `DownloadedData/` within this directory or
`scratch/$(whoami)/SampleData/DownloadedData` if the `$CLUSTER` environmental
variable is equal to `GREENE` (and thus we think we're on NYU's greene cluster);
ideally this would be a general solution for different compute clusters, but we
couldn't come up with one.

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
  matlab dependencies. See the [Winawer lab
  wiki](https://wikis.nyu.edu/display/winawerlab/ToolboxToolbox) for info on how
  to set it up.
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

- if you're running this on your local machine, then you should be good to go.
- if you're running this on a compute cluster that's not NYU's greene, then
  you'll need a couple more changes: you'll need to at least chang:
  1. `subroutines/utils.sh`: change `on_cluster()` function to something that
     will work for your cluster (note that we use `set -e pipefail`, so you
     can't rely on catching errors).
  2. `subroutines/utils.sh`: check `load_modules()` and make sure the modules
     are correctly named. If your cluster uses some other command to handle
     packages, you'll have to change this more.
  3. `setup.sh`: check that the path `/scratch/$(whoami)` exists and that you
     have write access (and your cluster admin is okay with placing a lot of
     large files here). If not, change `$SAMPLE_DATA_DIR` to some other path (in
     the first if block at the top of the file) or pass a path to the scripts
     when calling them..
