%   Compute a weighted average of a variable (FA/MD/RD/AD) in a track segment
%
%  [fa, md, rd, ad, cl, SuperFiber,fgClipped, cp, cs, fgResampled] = ...
%    dtiComputeDiffusionPropertiesAlongFG(fg, dt, roi1, roi2, numberOfNodes, [dFallOff])
%
%   From a fiber group (fg), and diffusion data (dt), compute the weighted
%   2 value of a diffusion property (taken from dt) between the two ROIS at
%   a NumberOfNodes, along the fiber track segment between the ROIs,
%   sampled at numberOfNodes point.
%
% INPUTS:
%       fg            - fiber group structure.
%       dt            - dt6.mat structure or a nifti image.  If a nifti
%                       image is passed in then only 1 value will be 
%                       output and others will be empty
%       roi1          - first ROI for the fg
%       roi2          - second ROI for the fg
%       numberOfNodes - number of samples taken along each fg
%       dFallOff      - rate of fall off in weight with distance. More
%                       comments here.
%
% OUTPUTS:
%       fa         - Weighted fractional anisotropy
%       md         - Weighted mead diffusivity
%       rd         - Weighted radial diffusivity
%       ad         - Weighted axial diffusivity
%       cl         - Weighted Linearity
%       SuperFiber - structure containing the core of the fiber group
%       fgClipped  - fiber group clipped to the two ROIs
%       cp         - Weighted Planarity 
%       cs         - Weighted Sphericity
%       fgResampled- The fiber group that has been resampled to
%                    numberOfNodes and each fiber has been reoriented to
%                    start and end in a consitent location
%
% WEB RESOURCES:
%   mrvBrowseSVN('dtiComputeDiffusionPropertiesAlongFG')
%   http://white.stanford.edu/newlm/index.php/Diffusion_properties_along_trajectory
%   See dtiFiberGroupPropertyWEightedAverage
%
% EXAMPLE USAGE:
%
% HISTORY:
%  ER wrote it 12/2009
%
% (C) Stanford University, VISTA Lab

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
    
dt= fullfile(AFQdata,subs{i},'/dwi_2nd','dt6.mat');
fgDir  = fullfile(AFQdata,subs{i},'/dwi_2nd/fibers');
RoiDir = fullfile(AFQdata,subs{i},'/dwi_2nd/ROIs');
fg = fullfile(fgDir,'LOR_MD3.pdb');
roi1 =fullfile(RoiDir,'Lt-LGN.mat');
roi2 =fullfile(RoiDir,'ctx-lh-pericalcarine.mat');

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

numberOfNodes = 30;
dFallOff = 1;

% Number of fiber groups
numfg = length(fg);
% Create Tract Profile structure
TractProfile = AFQ_CreateTractProfile;
% Pre allocate data arrays
fa=nan(numberOfNodes,numfg);
md=nan(numberOfNodes,numfg);
rd=nan(numberOfNodes,numfg);
ad=nan(numberOfNodes,numfg);
cl=nan(numberOfNodes,numfg);

[fa, md, rd, ad, cl, SuperFiber,fgClipped, cp, cs, fgResampled] = ...
    dtiComputeDiffusionPropertiesAlongFG(fg, dt, roi1, roi2, numberOfNodes, dFallOff);
return
%%
cd(fgDir)
fgClipped.name = 'fgClipped';
fgWrite(fgClipped)
fgResampled.name = 'fgResampled';
fgWrite(fgResampled)



