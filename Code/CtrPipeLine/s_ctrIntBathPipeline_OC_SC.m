function s_ctrIntBathPipeline_OC_SC

% CtrInitBatchPipeline
%
%

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(baseDir)

%% Set ctrInitBatchParams
%
%
ctrParams = ctrInitBatchParams;

ctrParams.projectName = 'OC_SC';
ctrParams.logName = 'myConTrackLog';
ctrParams.baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
ctrParams.dtDir = 'dwi_2nd';
ctrParams.roiDir = '/dwi_2nd/ROIs';
ctrParams.subs = {...
    'JMD1-MM-20121025-DWI'
%     'JMD2-KK-20121025-DWI'
%     'JMD3-AK-20121026-DWI'
%     'JMD4-AM-20121026-DWI'
%     'JMD5-KK-20121220-DWI'
%     'JMD6-NO-20121220-DWI'
%     'JMD7-YN-20130621-DWI'
%     'JMD8-HT-20130621-DWI'
%     'JMD9-TY-20130621-DWI'
%     'LHON1-TK-20121130-DWI'
%     'LHON2-SO-20121130-DWI'
%     'LHON3-TO-20121130-DWI'
%     'LHON4-GK-20121130-DWI'
%     'LHON5-HS-20121220-DWI'
%     'LHON6-SS-20121221-DWI'
%     'JMD-Ctl-MT-20121025-DWI'
%     'JMD-Ctl-SY-20130222DWI'
%     'JMD-Ctl-YM-20121025-DWI'
%     'JMD-Ctl-HH-20120907DWI'
%     'JMD-Ctl-HT-20120907-DWI'
%     'JMD-Ctl-FN-20130621-DWI'
%     'JMD-Ctl-AM-20130726-DWI'
%     'JMD-Ctl-SO-20130726-DWI'
%     'RP1-TT-2013-11-01'};
%     'RP2-KI-2013-11-01'
%     'RP3-TO-13120611-DWI'
% 'LHON6-SS-20131206-DWI'
%     'RP4-AK-2014-01-31'
%     'RP5-KS-2014-01-31'
    };


% set parameter
ctrParams.roi1 = {'Optic-Chiasm','Optic-Chiasm'};
ctrParams.roi2 = {'Rt-SC_m','Lt-SC_m'};
ctrParams.nSamples = 5000;
ctrParams.maxNodes = 240;
ctrParams.minNodes = 25;
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

%%





