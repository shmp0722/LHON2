%% SO_dtiFiberGroupPropertyWeightedAverage_test.m
% Average eigenvalues across the fibers, along the bundle length
%
% [eigValFG,SuperFiber, weightsNormalized, weights, fgResampled] = ...
%   dtiFiberGroupPropertyWeightedAverage(fg, dt, numberOfNodes, valNames)
%
% The average is weighted with a gaussian kernel, where fibers close to the
% center-of-mass of a bundle contribute more, whereas fibers at the edges
% contribute less. The variance for this measure, for the subsequent
% t-tests, can be [in the future] computed two ways:
%
%  1. across subjects
%  2. within a subject -- with a bootstrapping procedure, removing one fiber
%        at a time from the bundle, and recomputing your average valNames.
%
% Important assumptions: the fiber bundle is compact. All fibers begin in
% one ROI and end in another. An example of input bundle is smth that
% emerges from clustering or from manualy picking fibers + ends had been
% clipped to ROIs using dtiClipFiberGroupToROIs or smth like that .
%
% INPUTS:
%          valNames - a string array of tensor statistics to be returned.
%                     Possible values: see dtiGetValFromTensors
%                     Default: {'eigvals'}.
% OUTPUTS:
%            valsFG - array with resulting tensor stats. Rows are nodes,
%                     columns correspond to valNames.
%       Superfiber  - a structure describing the mean (core) trajectory and
%                     the spatial dispersion in the coordinates of fibers
%                     within a fiber group.
% weightsNormalized - numberOfNodes by numberOfFibers array of weights
%                     denoting, how much each node in each fiber
%                     contributed to the output tensor stats.
% weights           - numberOfNodes by numberOfFibers array of weights
%                     denoting, the gausssian distance of each node in
%                     each fiber from the fiber tract core
% fgResampled       - The fiber group that has been resampled to
%                     numberOfNodes and each fiber has been reoriented to
%                     start and end in a consitent location
%
% WEB RESOURCES:
%       mrvBrowseSVN('dtiFiberGroupPropertyWeightedAverage');
%       See also: dtiComputeDiffusionPropertiesAlongFG
% 
% TODO: Add checks that the bunch is indeed tight -- e.g., critical var/cov
%       values... length of fibers...
% 
% HISTORY:
%   ER 08/2009 wrote it
%% Set dir and subj

AFQdata = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subs = {...
    'JMD1-MM-20121025-DWI'...
    'JMD2-KK-20121025-DWI'...
    'JMD3-AK-20121026-DWI'...
    'JMD4-AM-20121026-DWI'...
    'JMD5-KK-20121220-DWI'...
    'JMD6-NO-20121220-DWI'...
    'LHON1-TK-20121130-DWI'...
    'LHON2-SO-20121130-DWI'...
    'LHON3-TO-20121130-DWI'...
    'LHON4-GK-20121130-DWI'...
    'LHON5-HS-20121220-DWI'...
    'LHON6-SS-20121221-DWI'...
    'JMD-Ctl-MT-20121025-DWI'...
    'JMD-Ctl-YM-20121025-DWI'...
    'JMD-Ctl-SY-20130222DWI'...
    'JMD-Ctl-HH-20120907DWI'...
    'JMD-Ctl-HT-20120907-DWI'...
    };

%for loop 
i = 1;%:length(subs);
    
dt= fullfile(AFQdata,subs{i},'/dwi_2nd/dt6.mat');
RoiDir = fullfile(AFQdata,subs{i},'/dwi_2nd/ROIs');

% LOR_MD3
fgDir  = fullfile(AFQdata,subs{i},'/dwi_2nd/fibers');
fg = fullfile(fgDir,'LOR_MD3.pdb');
roi1 =fullfile(RoiDir,'Lt-LGN.mat');
roi2 =fullfile(RoiDir,'ctx-lh-pericalcarine.mat');

% % optic tract 100 fibers
% fgDir  = fullfile(AFQdata,subs{i},'/dwi_2nd/fibers/conTrack/OpticTract5000'); 
% fg = fullfile(fgDir,...
%     'fg_OpticTract5000_Optic-Chiasm_clean1111_Lt-LGN_2013-04-18_12.58.43-100.pdb');
% roi1 =fullfile(RoiDir,'Optic-Chiasm_clean1111.mat');
% roi2 =fullfile(RoiDir,'Lt-LGN.mat');

%% Argument checking
if ischar(dt)
    dt = dtiLoadDt6(dt);
end
if ischar(fg)
    fg = fgRead(fg);
end
if ischar(roi1)
    roi1 = dtiReadRoi(roi1);
end
if ischar(roi2)
    roi2 = dtiReadRoi(roi2);
end

numberOfNodes = 5; valNames = 'fa md ad rd shape';...  xform = inv(dt.xformToAcpc);

[eigValFG,SuperFiber, weightsNormalized, weights, fgResampled] = ...
   dtiFiberGroupPropertyWeightedAverage(fg, dt, numberOfNodes, valNames);