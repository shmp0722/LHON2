function SO_ctrVisualWhiteMatterPathwayGeneration
% Multi-Subject Tractography for Tamagawa_subjects using conTrack
%
%

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(baseDir)
subJ = {...
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
%          'JMD-Ctl-MT-20121025-DWI'
%     'JMD-Ctl-SY-20130222DWI'
%     'JMD-Ctl-YM-20121025-DWI'
%     'JMD-Ctl-HH-20120907DWI'
%     'JMD-Ctl-HT-20120907-DWI'
%     'JMD-Ctl-FN-20130621-DWI'
%     'JMD-Ctl-AM-20130726-DWI'
%     'JMD-Ctl-SO-20130726-DWI'
%     'RP1-TT-2013-11-01'
%     'RP2-KI-2013-11-01'
'RP3-TO-13120611-DWI'
};

% %% Optic Radiation
% % Set ctrInitBatchParams
% % 
% %
%     ctrParams = ctrInitBatchParams;
% 
%     ctrParams.projectName = 'OR_Top100K_V1_3mm_clipped_LGN4mm';
%     ctrParams.logName = 'myConTrackLog';
%     ctrParams.baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
%     ctrParams.dtDir = 'dwi_2nd';
%     ctrParams.roiDir = '/dwi_2nd/ROIs';
%     ctrParams.subs = subJ;
%                
% % set parameter
%     ctrParams.roi1 = {'Lt-LGN4','Rt-LGN4'};
%     ctrParams.roi2 = {'lh_V1_smooth3mm_NOT','rh_V1_smooth3mm_NOT'};
%     ctrParams.nSamples = 100000;
%     ctrParams.maxNodes = 240;
%     ctrParams.minNodes = 10; % defalt: 10
%     ctrParams.stepSize = 1;
%     ctrParams.pddpdfFlag = 0;
%     ctrParams.wmFlag = 0;
%     ctrParams.oi1SeedFlag = 'true';
%     ctrParams.oi2SeedFlag = 'true';
%     ctrParams.multiThread = 0;
%     ctrParams.xecuteSh = 0;
% 
% 
% %% Run ctrInitBatchTrack
% %
%  [cmd infofile] = ctrInitBatchTrack(ctrParams);
% 
% 
%  %% run conTrack 
%  system(cmd);

 
%% Optic Tract 5K
% Set ctrInitBatchParams
%
%
ctrParams = ctrInitBatchParams;

ctrParams.projectName = 'OT_5K';
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


