% To run PRF analysis on sample data

%% 2. Convert gifti files to mgz files (here we do it in Matlab)
% Note that we might have already done this for the glmDenoise step.
projectDir = pwd; % E.g., '/Volumes/server/Projects/SampleData/BIDS';

cd (fullfile(projectDir, 'derivatives', 'fmriprep','sub-wlsubj042', 'ses-01', 'func'));

% finds the gifti files
d = dir('./*fsnative*.gii');

% convert to mgz using freesurfer
for ii = 1:length(d)   
    [~, fname] = fileparts(d(ii).name);    
    str = sprintf('mri_convert %s.gii %s.mgz', fname, fname);
    system(str);
end

%% 3. Analyze PRF
subject           = 'wlsubj042';
session           = '01';
tasks             = 'prf';
runnums           = 1:2;
dataFolder        = 'fmriprep'; 
dataStr           = 'fsnative*.mgz';
apertureFolder    = [];
prfOptsPathCoarse = fullfile(projectDir, 'derivatives', 'stim_apertures', sprintf('sub-%s', subject), sprintf('ses-%s', session), 'prfOptsCoarse.json');
prfOptsPathFine   = fullfile(projectDir, 'derivatives', 'stim_apertures', sprintf('sub-%s', subject), sprintf('ses-%s', session), 'prfOptsFine.json');
modelTypeCoarse   = 'coarse';
modelTypeFine     = 'fine';
tr                = [];

% run the coarse PRF analysis (GRID only; should be very fast - minutes)
bidsAnalyzePRF(projectDir, subject, session, tasks, runnums, ...
    dataFolder, dataStr, apertureFolder, modelTypeCoarse, prfOptsPathCoarse, tr)
   
%%
% run the full PRF analysis (optimze each voxel, can be many hours)
bidsAnalyzePRF(projectDir, subject, session, tasks, runnums, ...
       dataFolder, dataStr, apertureFolder, modelTypeFine, prfOptsPathFine, tr)

%% 
% Convert the outputs into MGZ format for use in step 6 (atlases).
% To do this:
%   1. read in the output ang, ecc, R2, and rfsize files
%   2. get the subject's FreeSurfer directory and read in surf/lh.curv using read_curv()
%   3. lh_vertex_count = numel(lh_curv); rh_vertex_count = numel(ang) - lh_vertex_count;
%   4. lh_ang = ang(1:lh_vertex_count); rh_ang = ang(lh_vertex_count+1:end);
%   5. the angle needs to be converted to degrees clockwise (with 0 as the UVM), so probably:
%       fixed_ang = mod(90 - ang + 180, 360) - 180
%      (I think aprf outputs angle in degrees ccw starting at the RHM)
%   6. ecc and rfsize need to be converted from px to deg; R2 needs to be converted from % to fraction (R2/100)
%   7. Use MRIwrite() (from matlab FreeSurfer toolbox) to write out mgz files. To get an example header, you
%      can read in any of the mgz files in the subject's directory then replace the mgz.vol field with the
%      vertex data; the header doesn't matter for vertex data.
