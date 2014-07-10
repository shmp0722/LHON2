%% S_CtrInitBatchPipeline
% Multi-Subject Tractography
%

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(baseDir)

%% Set ctrInitBatchParams
% 
%
    ctrParams = ctrInitBatchParams;

    ctrParams.projectName = 'MT_Top100K_CC_MT_3mm';
    ctrParams.logName = 'myConTrackLog';
    ctrParams.baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
    ctrParams.dtDir = 'dwi_2nd';
    ctrParams.roiDir = '/dwi_2nd/ROIs';
    ctrParams.subs = {...
        'JMD1-MM-20121025-DWI'
        'JMD2-KK-20121025-DWI'
        'JMD3-AK-20121026-DWI'
        'JMD4-AM-20121026-DWI'
        'JMD5-KK-20121220-DWI'
        'JMD6-NO-20121220-DWI'
        'LHON1-TK-20121130-DWI'
        'LHON2-SO-20121130-DWI'
        'LHON3-TO-20121130-DWI'
        'LHON4-GK-20121130-DWI'
        'LHON5-HS-20121220-DWI'
        'LHON6-SS-20121221-DWI'
        'JMD-Ctl-MT-20121025-DWI'
        'JMD-Ctl-YM-20121025-DWI'
        'JMD-Ctl-HH-20120907DWI'
        'JMD-Ctl-HT-20120907-DWI'};
               
% set parameter
    ctrParams.roi1 = {'CC','CC'};  
    ctrParams.roi2 = {'rh_MT_smooth3mm','lh_MT_smooth3mm'};
    ctrParams.nSamples = 20000;
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


