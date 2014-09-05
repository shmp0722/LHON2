%% S_CtrInitBatchPipeline
% Multi-Subject Tractography
%

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(baseDir)

%% Set ctrInitBatchParams
% 
%
    ctrParams = ctrInitBatchParams;

    ctrParams.projectName = 'Top200000';
    ctrParams.logName = 'myConTrackLog';
    ctrParams.baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
    ctrParams.dtDir = 'dwi_1st';
    ctrParams.roiDir = 'ROIs';
    ctrParams.subs = {...
%         'JMD1-MM-20121025-DWI'
%         'JMD2-KK-20121025-DWI'
%         'JMD3-AK-20121026-DWI'
%         'JMD4-AM-20121026-DWI'
%         'JMD5-KK-20121220-DWI'
%         'JMD6-NO-20121220-DWI'
%         'LHON1-TK-20121130-DWI'
%         'LHON2-SO-20121130-DWI'
%         'LHON3-TO-20121130-DWI'
%         'LHON4-GK-20121130-DWI'
%         'LHON5-HS-20121220-DWI'
%         'LHON6-SS-20121221-DWI'
%         'JMD-Ctl-MT-20121025-DWI'
%         'JMD-Ctl-YM-20121025-DWI'
%         'JMD-Ctl-SY-20130222DWI'
        'JMD-Ctl-HH-20120907DWI'};
    
    ctrParams.roi1 = {...
%         'O-Chsm','O-Chsm',...
%         'Rt-LGN','Lt-LGN',...
        'Rt-LGN','Lt-LGN'};
    
    ctrParams.roi2 = {...
%         'Lt-LGN','Rt-LGN',...
        'ctx-rh-pericalcarine','ctx-lh-pericalcarine',...
%         'ctx-rh-pericalcarine.nii_1_cleaned','ctx-lh-pericalcarine.nii_1_cleaned'
        };
    
    ctrParams.nSamples = 200000;
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
%        'ctx-rh-pericalcarine.nii_1_cleaned','ctx-lh-pericalcarine.nii_1_cleaned'

 [cmd infofile] = ctrInitBatchTrack(ctrParams);

 system(cmd);


