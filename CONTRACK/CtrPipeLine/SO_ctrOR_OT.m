function SO_ctrOR_OT(homeDir, subjDir,numfib_OR, numfib_OT)
% To identify optic radiation and optic tract using Multi-Subject cnotrack
% tractography
%
%
% SO@Vista lab 2014

%%
cd(homeDir)
subjDir;

%% Optic Radiation
% Set Params for contrack fiber generation

%
ctrParams = ctrInitBatchParams;

ctrParams.projectName = 'OR_Top100K_V1_3mm_clipped_LGN4mm';
ctrParams.logName = 'myConTrackLog';
ctrParams.baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
ctrParams.dtDir = 'dwi_2nd';
ctrParams.roiDir = '/dwi_2nd/ROIs';
ctrParams.subs = subJ;

% set parameter
ctrParams.roi1 = {'Lt-LGN4','Rt-LGN4'};
ctrParams.roi2 = {'lh_V1_smooth3mm_NOT','rh_V1_smooth3mm_NOT'};
ctrParams.nSamples = 100000;
ctrParams.maxNodes = 240;
ctrParams.minNodes = 10; % defalt: 10
ctrParams.stepSize = 1;
ctrParams.pddpdfFlag = 0;
ctrParams.wmFlag = 0;
ctrParams.oi1SeedFlag = 'true';
ctrParams.oi2SeedFlag = 'true';
ctrParams.multiThread = 0;
ctrParams.xecuteSh = 0;


%% Run ctrInitBatchTrack
%
[cmd infofile] = ctrInitBatchTrack(ctrParams);


%% run conTrack
system(cmd);


%% Optic Tract 5K

% Create params structure
ctrParams = ctrInitBatchParams;

% 
ctrParams.projectName = projectName;
ctrParams.logName = 'myConTrackLog';
ctrParams.baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
ctrParams.dtDir = 'dwi_2nd';
ctrParams.roiDir = '/dwi_2nd/ROIs';
ctrParams.subs = subJ;


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
[cmd infofile] = ctrInitBatchTrack(ctrParams);

system(cmd);

%% OCF from LH to RH
% Set ctrInitBatchParams
%
%
ctrParams = ctrInitBatchParams;

ctrParams.projectName = 'OCF_Top50K_fsV1V2_3mm';
ctrParams.logName = 'myConTrackLog';
ctrParams.baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
ctrParams.dtDir = 'dwi_2nd';
ctrParams.roiDir = '/dwi_2nd/ROIs';
ctrParams.subs = subJ;

% set parameter
ctrParams.roi1 = {'lh_V1_smooth3mm_lh_V2_smooth3mm'};
ctrParams.roi2 = {'rh_V1_smooth3mm_rh_V2_smooth3mm'};
ctrParams.nSamples = 50000;
ctrParams.maxNodes = 240;
ctrParams.minNodes = 10;
ctrParams.stepSize = 1;
ctrParams.pddpdfFlag = 0;
ctrParams.wmFlag = 0;
ctrParams.oi1SeedFlag = 'true';
ctrParams.oi2SeedFlag = 'true';
ctrParams.multiThread = 0;
ctrParams.xecuteSh = 0;

% ctrInitBatchTrack
[cmd infofile] = ctrInitBatchTrack(ctrParams);

%% Run ctrInitBatchTrack

system(cmd);

%% OCF CC to bothe V1+V2
% Set ctrInitBatchParams
%
%
ctrParams = ctrInitBatchParams;

ctrParams.projectName = 'OCF_Top50K_fsCC_V1V2_3mm';
ctrParams.logName = 'myConTrackLog';
ctrParams.baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
ctrParams.dtDir = 'dwi_2nd';
ctrParams.roiDir = '/dwi_2nd/ROIs';
ctrParams.subs = subJ;

% set parameter
ctrParams.roi1 = {'fs_CC','fs_CC'};
ctrParams.roi2 = {'rh_V1_smooth3mm_rh_V2_smooth3mm','lh_V1_smooth3mm_lh_V2_smooth3mm'};

%     ctrParams.roi1 = {'CC','CC'};
%     ctrParams.roi2 = {'lh_V1_smooth3mm_lh_V2_smooth3mm','rh_V1_smooth3mm_rh_V2_smooth3mm'};

ctrParams.nSamples = 50000;
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
[cmd infofile] = ctrInitBatchTrack(ctrParams);

system(cmd);


