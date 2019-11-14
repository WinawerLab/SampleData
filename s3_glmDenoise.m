% To run GLM denoise on sample data
% 1. open matlab and add the appropriate toolbox paths:
tbUse WinawerLab_SampleData;

% 2. Convert gifti files to mgz files
projectDir = '/Volumes/server/Projects/SampleData/BIDS';


cd (fullfile(projectDir, 'derivatives', 'fmriprep','sub-wlsubj042', 'ses-01', 'func'));

% finds the gifti files
d = dir('./*fsnative*.gii');

% convert to mgz using freesurfer
for ii = 1:length(d)
    [~, fname] = fileparts(d(ii).name);
    str = sprintf('mri_convert %s.gii %s.mgz', fname, fname);
    system(str);
end

% 3. GLM denoise
subject           = 'wlsubj042';
session           = '01';
tasks             = 'sfp';
runnums           = [];
dataFolder        = 'fmriprep';
dataStr           = 'fsnative*mgz';
designFolder      = 'single_event';
stimdur           = 4; % seconds
modelType         = 'shortblocks';
glmOptsPath       = [];
tr                = [];

% run the GLM
bidsGLM(projectDir, subject, session, tasks, runnums, ...
    dataFolder, dataStr, designFolder, stimdur, modelType, glmOptsPath, tr)

% To get images of the GLM denoise output, run the following python command in the terminal:
% dependency: https://github.com/winawerlab/mri_tools
% python ~/Code/MRI_tools/BIDS/GLMdenoisePNGprocess.py "/Volumes/server/Projects/SampleData/BIDS/derivatives/GLMdenoise/shortblocks/sub-wlsubj042/ses-01/figures"
