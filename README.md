# SampleData
Code related to the processing of the Winawer lab sample dataset

Dependencies:
- matlab (version??) must be on the system path
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
