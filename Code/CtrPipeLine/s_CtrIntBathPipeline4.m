%% S_CtrInitBatchPipeline
% Multi-Subject conTrack Tractography
%
baseDir = '/biac4/wandell/biac2/wandell2/data/diffusion/horiguchi/20121220_3701';
cd(baseDir)

%% Set ctrInitBatchParams
% 
%
    ctrParams = ctrInitBatchParams;

    ctrParams.projectName = 'OR_Top100000';
    ctrParams.logName = 'myConTrackLog';
    ctrParams.baseDir = baseDir;
    ctrParams.dtDir = '96dirs_b2000_1point5iso_cat';
    ctrParams.roiDir = 'ROIs';
    ctrParams.subs = {'96dirs_b2000_1point5iso_cat'};
    ctrParams.roi1 = {'O-Chsm','O-Chsm','Rt-LGN','Lt-LGN'};
    ctrParams.roi2 = {'Lt-LGN','Rt-LGN','ctx-lh-pericalcarine.nii_1','ctx-rh-pericalcarine.nii_1'};
    ctrParams.nSamples = 100000;
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

