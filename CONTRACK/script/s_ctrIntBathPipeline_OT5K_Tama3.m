function s_ctrIntBathPipeline_OT5K_Tama3(id)

% CtrInitBatchPipeline

%% set to Tamagawa3

[homeDir,subDir,JMD,CRD,LHON,Ctl,RP,AMDC] = Tama_subj2;

% pick up squeeae subjects

subs = reshape1d(subDir(id));
  
%% Set ctrInitBatchParams
% Create Params structure
ctrParams = ctrInitBatchParams;

ctrParams.projectName = 'OT_5K';
ctrParams.logName = 'myConTrackLog';
ctrParams.baseDir = homeDir;
ctrParams.dtDir = 'dwi_2nd';
ctrParams.roiDir = '/dwi_2nd/ROIs';
ctrParams.subs =subs;

% set parameter
ctrParams.roi1 = {'85_Optic-Chiasm','85_Optic-Chiasm'};
ctrParams.roi2 = {'Rt-LGN4','Lt-LGN4'};
ctrParams.nSamples = 5000;
ctrParams.maxNodes = 150;
ctrParams.minNodes = 20;
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


