% To run PRF analysis on one subject with BIDS formatting with vista solver (docker)

%% 1. open matlab and add paths:
tbUse docker-vista;


%%

scriptDir               = fileparts(which('bidsVistaPRF'));
session                 = '01';
subject                 = 'wlsubj042';
runnumber               = 99;
task                    = 'prf';


mainDir                 = sprintf('./DownloadedData'); % points to a folder were your BIDS formated folder is sitting
BidsDir                 = 'BIDS'; % name of the folder with derivatives
projectDir              = sprintf('%s/%s/',mainDir,BidsDir);
apertureFolder          = sprintf('%sderivatives/stim_apertures',projectDir);
dataFolder              = 'fmriprep';


filesDir                = sprintf('%sderivatives/%s/sub-%s/ses-%s/func',projectDir,dataFolder,subject,session);
averageFolName          = 'averageTCs';
averageFolDir           = sprintf('%sderivatives/%s',projectDir,averageFolName);
space                   = 'native';
estHRF                  = 1;

setenv('SUBJECTS_DIR',fullfile(projectDir, 'derivatives', 'freesurfer'));
setenv('PATH', ['/usr/local/bin:' getenv('PATH')]);

%% path2configs


cfg.basename            = sprintf('sub-%s_ses-%s_task-%s_acq-normal_run-%i',subject,session,task,runnumber);
cfg.param               = sprintf('%s/sub-%s/ses-%s/func/%s_cfg.json',averageFolDir,subject,session,cfg.basename,runnumber);
cfg.parambold           = sprintf('%s/sub-%s/ses-%s/func/%s_bold.json',averageFolDir,subject,session,cfg.basename,runnumber);
cfg.events              = sprintf('%s/sub-%s/ses-%s/func/sub-%s_ses-%s_task-%s_events.json',averageFolDir,subject,session,subject,session,task);
cfg.events_tsv          = sprintf('%s/sub-%s/ses-%s/func/sub-%s_ses-%s_task-%s_events.tsv',averageFolDir,subject,session,subject,session,task);
cfg.load                = 0; % if 0 create default cfg file (NYU color retinotopy settings)


dockerscript            = 'prfanalyze_docker.sh';


debug.ifdebug           = 1; % 1-fit pRFs only in rois specifed below; 2 -fit pRFs only in 10 voxels
debug.roiname           = {'V1_exvivo';'V2_exvivo'}; % Roi or Rois from freesurfer label directory for the debug mode

makeReport              = 0;

d 						=  dir(sprintf('%s/*%s*%s*.mgz',filesDir,task,space));
runnums                 =  1:length(d)/2; % / because there are 2 hemi
dataStr                 =  sprintf('%s*.mgz',space);

if makeReport
    vistaMAP2PNG(projectDir, subject,session,runnums);
    
else
    bidsVistaPRF(mainDir,projectDir,subject,session,task,runnums,...
        dataFolder,dataStr,apertureFolder,filesDir,debug,averageFolDir,cfg,...
        dockerscript,runnumber,estHRF,scriptDir);
end
