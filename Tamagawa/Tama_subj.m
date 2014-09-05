function [homeDir,subDir,JMD,CRD,LHON,Ctl,RP] = Tama_subj

% set directory to Tamagawa subject groups
% [homeDir,subDir,JMD,CRD,LHON,Ctl,RP] = Tama_subj

%% Set the path to data directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';


% subDir = {...
%     'JMD1-MM-20121025-DWI'
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
%     'RP8-YT-2014-03-14-dMRI-Anatomy'};



%%
subDir = {...
    'JMD1-MM-20121025-DWI'
    'JMD3-AK-20121026-DWI'
    'JMD5-KK-20121220-DWI'
    'JMD6-NO-20121220-DWI'
    'JMD2-KK-20121025-DWI'
    'JMD4-AM-20121026-DWI'
    'JMD7-YN-20130621-DWI'
    'JMD8-HT-20130621-DWI'
    'JMD9-TY-20130621-DWI'
    'LHON1-TK-20121130-DWI'
    'LHON2-SO-20121130-DWI'
    'LHON3-TO-20121130-DWI'
    'LHON4-GK-20121130-DWI'
    'LHON5-HS-20121220-DWI'
    'LHON6-SS-20121221-DWI'
    'JMD-Ctl-MT-20121025-DWI'
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'
    'JMD-Ctl-FN-20130621-DWI'
    'JMD-Ctl-AM-20130726-DWI'
    'JMD-Ctl-SO-20130726-DWI'
    'RP1-TT-2013-11-01'
    'RP2-KI-2013-11-01'
    'RP3-TO-13120611-DWI'
    'LHON6-SS-20131206-DWI'
    'RP4-AK-2014-01-31'
    'RP5-KS-2014-01-31'
    'JMD3-AK-20140228-dMRI'
    'JMD-Ctl-09-RN-20130909'
    'JMD-Ctl-10-JN-20140205'
    'JMD-Ctl-11-MT-20140217'
    'RP6-SY-2014-02-28-dMRI'
    'Ctl-12-SA-20140307'
    'Ctl-13-MW-20140313-dMRI-Anatomy'
    'Ctl-14-YM-20140314-dMRI-Anatomy'
    'RP7-EU-2014-03-14-dMRI-Anatomy'
    'RP8-YT-2014-03-14-dMRI-Anatomy'};

%% classify all subjects intogroups
JMD = 1:4;
CRD = 5:9;
% LHON = 10:15;
LHON = [10:14,27];

Ctl = [16:23,31:33,35:37];
RP = [24:26,28,29,34,38,39];

% %%
% i = 1:length(subDir);
% 
% SubDir = fullfile(homeDir,subDir{i});
% fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped');
% roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
% dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
% 
% % define
% fg  = fullfile(fgDir,'');
% roi = fullfile(roiDir,'');
% dt  = fullfile(dtDir,'dt6.mat');
% 
% %% Argument checking
% 
% dt = dtiLoadDt6(dt);
% 
% fg = fgRead(fg);
% 
% roi = dtiReadRoi(roi);
% 
% return