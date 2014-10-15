function s_ctrIntBathPipeline_OR_10degree_Top50K
% Multi-Subject Tractography for Tamagawa_subjects using conTrack
%

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

cd(baseDir)

%% Set ctrInitBatchParams
% 
%
    ctrParams = ctrInitBatchParams;

    ctrParams.projectName = 'OR_Ecc10Degree_50K';
    ctrParams.logName = 'myConTrackLog';
    ctrParams.baseDir = baseDir;
    ctrParams.dtDir = 'dwi_2nd';
    ctrParams.roiDir = '/dwi_2nd/ROIs';
%     ctrParams.roiDir = '/fs_Retinotopy2';
    ctrParams.subs = {...
%         'JMD1-MM-20121025-DWI'
%         'JMD2-KK-20121025-DWI'
%         'JMD3-AK-20121026-DWI'
%         'JMD4-AM-20121026-DWI'
%         'JMD5-KK-20121220-DWI'
%         'JMD6-NO-20121220-DWI'
%         'JMD7-YN-20130621-DWI'
%         'JMD8-HT-20130621-DWI'
%         'JMD9-TY-20130621-DWI'
%         'LHON1-TK-20121130-DWI'
%         'LHON2-SO-20121130-DWI'
%         'LHON3-TO-20121130-DWI'
%         'LHON4-GK-20121130-DWI'
%         'LHON5-HS-20121220-DWI'
%         'LHON6-SS-20121221-DWI'
%         'JMD-Ctl-MT-20121025-DWI'
%         'JMD-Ctl-SY-20130222DWI'
%         'JMD-Ctl-YM-20121025-DWI'
%         'JMD-Ctl-HH-20120907DWI'
        'JMD-Ctl-HT-20120907-DWI'
%         'JMD-Ctl-FN-20130621-DWI'
%         'JMD-Ctl-AM-20130726-DWI'
%         'JMD-Ctl-SO-20130726-DWI'
%         'RP1-TT-2013-11-01'
%         'RP2-KI-2013-11-01'
%         'RP3-TO-13120611-DWI'
%         'LHON6-SS-20131206-DWI'
%         'RP4-AK-2014-01-31'
%         'RP5-KS-2014-01-31'
        };
               
% set parameter
    ctrParams.roi1 = {'Lt-LGN4','Rt-LGN4','Lt-LGN4','Rt-LGN4'};
    ctrParams.roi2 = {'lh_Peri10Degree_ecc','rh_Peri10Degree_ecc'...
        'lh_10Degree_ecc','rh_10Degree_ecc'};
    ctrParams.nSamples = 50000;
    ctrParams.maxNodes = 240;
    ctrParams.minNodes = 30; % defalt: 10
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

 


