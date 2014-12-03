function s_ctrIntBathPipeline_OT5K_Tama3

% CtrInitBatchPipeline
  [homeDir,subDir] = Tama_subj3;

%% Set ctrInitBatchParams
%
%
ctrParams = ctrInitBatchParams;

ctrParams.projectName = 'OT_5K';
ctrParams.logName = 'myConTrackLog';
ctrParams.baseDir = homeDir;
ctrParams.dtDir = 'dwi_2nd';
ctrParams.roiDir = '/dwi_2nd/ROIs';
ctrParams.subs = {subDir{2}, subDir{3}};
% set parameter
ctrParams.roi1 = {'Optic-Chiasm','Optic-Chiasm'};
ctrParams.roi2 = {'Rt-LGN4','Lt-LGN4'};
ctrParams.nSamples = 5000;
ctrParams.maxNodes = 240;
ctrParams.minNodes = 10;
ctrParams.stepSize = 1;
ctrParams.pddpdfFlag = 0;
ctrParams.wmFlag = 0;
ctrParams.oi1SeedFlag = 'true';
ctrParams.oi2SeedFlag = 'true';
ctrParams.multiThread = 0;
ctrParams.xecuteSh = 0;


%% Run ctrInitBatchTrack
%
%
[cmd, info] = ctrInitBatchTrack(ctrParams);

system(cmd);


