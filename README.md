# SampleData
Code related to the processing of the Winawer lab sample dataset

Dependencies:
- matlab (version??) must be on the system path
- docker
- freesurfer license must be at `/Applications/freesurfer/license.txt`
  (note that currently this will fail in Linux) or at the location
  specified by the environmental variable `$FREESURFER_LICENSE`
- setup the `winawerlab` python environment, as described
  [here](https://wikis.nyu.edu/display/winawerlab/Python+and+Conda). Make
  sure this environment is activated before you run these scripts (run
  `conda activate winawerlab` in the terminal)
