function s_ctrIntBathPipeline_ORin4_Tama2
% Multi-Subject Tractography for Tamagawa_subjects using conTrack
%
%

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan2';
cd(baseDir)

%% Set ctrInitBatchParams
% 
%
    ctrParams = ctrInitBatchParams;

    ctrParams.projectName = 'OR_in4';
    ctrParams.logName = 'myConTrackLog';
    ctrParams.baseDir = baseDir;
    ctrParams.dtDir = 'dwi_2nd';
    ctrParams.roiDir = '/dwi_2nd/ROIs';
    ctrParams.subs = {...
%     'JMD1-MM-20121025-DWI'
%     'JMD3-AK-20121026-DWI'
%     'JMD5-KK-20121220-DWI'
%     'JMD6-NO-20121220-DWI'
%     'JMD2-KK-20121025-DWI'
%     'JMD4-AM-20121026-DWI'
%     'JMD7-YN-20130621-DWI'
%     'JMD8-HT-20130621-DWI'
%     'JMD9-TY-20130621-DWI'
%     'LHON1-TK-20121130-DWI'
    'LHON2-SO-20121130-DWI'
%     'LHON3-TO-20121130-DWI'
%     'LHON4-GK-20121130-DWI'
%     'LHON5-HS-20121220-DWI'
%     'LHON6-SS-20121221-DWI'
%     'JMD-Ctl-MT-20121025-DWI'
%     'JMD-Ctl-YM-20121025-DWI'
%     'JMD-Ctl-SY-20130222DWI'
%     'JMD-Ctl-HH-20120907DWI'
%     'JMD-Ctl-HT-20120907-DWI'
%     'JMD-Ctl-FN-20130621-DWI'
%     'JMD-Ctl-AM-20130726-DWI'
%     'JMD-Ctl-SO-20130726-DWI'
%     'RP1-TT-2013-11-01'
%     'RP2-KI-2013-11-01'
%     'RP3-TO-13120611-DWI'
%     'LHON6-SS-20131206-DWI'
%     'RP4-AK-2014-01-31'
%     'RP5-KS-2014-01-31'
%     'JMD3-AK-20140228-dMRI'
%     'JMD-Ctl-09-RN-20130909'
%     'JMD-Ctl-10-JN-20140205'
%     'JMD-Ctl-11-MT-20140217'
%     'RP6-SY-2014-02-28-dMRI'
%     'Ctl-12-SA-20140307'
%     'Ctl-13-MW-20140313-dMRI-Anatomy'
%     'Ctl-14-YM-20140314-dMRI-Anatomy'
%     'RP7-EU-2014-03-14-dMRI-Anatomy'
%     'RP8-YT-2014-03-14-dMRI-Anatomy'
    };

               
% set parameter
    ctrParams.roi1 = {'Rt-LGN4','Rt-LGN4','Rt-LGN4','Rt-LGN4','Lt-LGN4','Lt-LGN4','Lt-LGN4','Lt-LGN4'};
    ctrParams.roi2 = {'rh_3Degree_ecc','rh_Peri15Degree_ecc','rh_Ven_45pol3-15ecc','rh_Dor_135pol3-15ecc',...
        'lh_3Degree_ecc','lh_Peri15Degree_ecc','lh_Ven_45pol3-15ecc','lh_Dor_135pol3-15ecc'};
    ctrParams.nSamples = 30000;
    ctrParams.maxNodes = 240;
    ctrParams.minNodes = 60; % defalt: 10
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

 


