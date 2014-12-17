function [homeDir,subDir,AMDC,JMDC] = Tama_subj3

% set directory to Tamagawa subject groups
% [homeDir,subDir] = Tama_subj3

%% Set the path to data directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan3';

subDir = {...
    'AMD-Ctl01-HM-dMRI-Anatomy-2014-09-09'
    'AMD-Ctl02-YM-dMRI-Anatomy-2014-09-09'
    'AMD-Ctl03-TS-dMRI-Anatomy-2014-10-28'
    'AMD-Ctl04-AO-61yo-dMRI-Anatomy'
    'AMD-Ctl05-TM-71yo-dMRI-Anatomy'
    'AMD-Ctl06-YM-66yo-dMRI-Anatomy'
    'AMD-Ctl07-MS-61yo-dMRI-Anatomy'
    'AMD-Ctl08-HO-62yo-dMRI-Anatomy'
    'AMD-Ctl09-KH-70yo-dMRI-Anatomy-dMRI'
    'AMD-Ctl10-TH-65yo-dMRI-Anatomy-dMRI'
    'JMD-Ctl05-MT-20141028-DWI'
    'JMD-Ctl07-SY-20141028-DWI'
    'JMD-Ctl14-YM-20141028-DWI'
    'JMD-Ctl05-MT-20141028-DWI'
    'JMD-Ctl07-SY-20141028-DWI'
    'JMD-Ctl14-YM-20141028-DWI'
    'LHON4-GK-dMRI-2014-11-25'};
%%
AMDC = 1:10;
JMDC = 11:16;
