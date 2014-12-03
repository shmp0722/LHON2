function [homeDir,subDir] = Tama_subj3

% set directory to Tamagawa subject groups
% [homeDir,subDir] = Tama_subj3

%% Set the path to data directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan3';

subDir = {...
    'AMD-Ctl01-HM-dMRI-Anatomy-2014-09-09'
    'AMD-Ctl02-YM-dMRI-Anatomy-2014-09-09'
    'AMD-Ctl03-TS-dMRI-Anatomy-2014-10-28'
    'MasahikoTerao-dMRI-2014-10-28'
    'ShoyoYoshimine-dMRI-2014-10-28'
    'YoichiroMasuda-dMRI-2014-10-28'
    'LHON4-GK-dMRI-2014-11-25'};

% %% classify all subjects intogroups
% JMD = 1:4;
% CRD = 5:9;
% % LHON = 10:15;
% LHON = [10:14,27];
% 
% Ctl = [1:6];
% RP = [24:26,28,29,34,38,39];

