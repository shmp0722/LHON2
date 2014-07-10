function val = dtiGetValFromFibers(dt6, fg, xform, valName, interpMethod, uniqueVox)
%
% val = dtiGetValFromFibers(dt6_OR_scalarImage, fiberGroup, xform, [valName='fa'], [interpMethod='trilin'], [uniqueVox=0])
%
% Returns an interpolated image value for each fiber coordinate. If the
% image is a dt6 structure, then you can specify what type of value you'd
% like from the tensors by specifying 'valName' (see dtiGetValFromTensors
% for options).
% 
% Input parameters:
%   xform        - the transform that converts fiber coords to dt6 indices.
%   interpMethod - 'nearest','trilin', 'spline' method for interpolation.
%   [uniqueVox]  - 0 returns values for each fiber node, 1 returns values for
%                  each unique voxel touched by the fg

% HISTORY:
% 2005.03.18 RFD (bob@white.stanford.edu) wrote it.
% 2009.03.23 DY: in creating the FIBERLEN variable, replaced call to length
% with a call to size and picking out the column dimension, which is the
% number of nodes. Length would just take the largest dimension, which
% would be 3 (number of rows), if the number of nodes in that path is 1 or 2.
% 2010.11.08 JMT: Added option to get one value for each unique voxel.


% chdir('..\mrDataExample\mrDiffusionData\mm20040325_new')
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON1-TK-20121130-DWI/dwi_2nd';
%   dt = dtiLoadDt6('dti06\dt6.mat');
dt6 = dtiLoadDt6('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON1-TK-20121130-DWI/dwi_2nd/dt6.mat');
%   fg = dtiReadFibers('fibers\LFG_CC.mat');
fg = dtiRead('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON1-TK-20121130-DWI/dwi_2nd/fibers/opticradiation_AFQ_test_clean.pdb') ;

%%
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
%       roi1          - first ROI for the fgdtiComputeDiffusionPropertiesAlongFG
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

%%
% Average eigenvalues across the fibers, along the bundle length
%
% [eigValFG,SuperFiber, weightsNormalized, weights, fgResampled] = ...
%   dtiFiberGroupPropertyWeightedAverage(fg, dt, numberOfNodes, valNames)
%
% The average is weighted with a gaussian kernel, where fibers close to the
% center-of-mass of a bundle contribute more, whereas fibers at the edges
% contribute less. The variance for this measure, for chdir('..\mrDataExample\mrDiffusionData\mm20040325_new')
%   dt = dtiLoadDt6('dti06\dt6.mat');
%   fg = dtiReadFibers('fibers\LFG_CC.mat');the subsequent
% t-tests, can be [in the future] computed two ways:
%
%  1. across subjects
%  2. within a subject -- with a bootstrapping procedure, removing one fiber
%        at a time from the bundle, and recomputing your average valNames.
%
% Important assumptions: the fiber bundle is compact. All fibers begin in
% one ROI and end in another. An example of input bundle is smth that
% emerges from clustering or from manualy picking fibers + ends had been
% clipped to ROIs using dtiClipFiberGroupToROIs or smth like t
hat .
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

%%

if(~exist('valName','var') || isempty(valName))
    valName = 'fa';
end
if(~exist('interpMethod','var') || isempty(interpMethod))
    interpMethod = 'trilin';
end
if(~exist('uniqueVox','var') || isempty(uniqueVox))
    uniqueVox = 0;
end

if(iscell(fg))
    coords = horzcat(fg{:})';
else
    coords = horzcat(fg.fibers{:})';
end
keyboard
coords = mrAnatXformCoords(xform, coords);

if uniqueVox==1
    coords = unique(round(coords),'rows');
end

if(size(dt6,4)==6)
  [tmp1,tmp2,tmp3,tmp4,tmp5,tmp6] = dtiGetValFromTensors(dt6,coords,eye(4),valName,interpMethod);
  tmp = [tmp1(:) tmp2(:) tmp3(:) tmp4(:) tmp5(:) tmp6(:)];
  clear tmp1 tmp2 tmp3 tmp4;
else
  % assume it's a scalar
  switch lower(interpMethod)
    case 'nearest'
        interpParams = [0 0 0 0 0 0];  fg = fgRead(fgfilename);

    case 'trilin'
        interpParams = [1 1 1 0 0 0];
    case 'spline'
        interpParams = [7 7 7 0 0 0];
    otherwise
        error(['Unknown interpMethod "' interpMethod '".']);
  end
  spCoefs = spm_bsplinc(dt6, interpParams);
  tmp = spm_bsplins(spCoefs, coords(:,1), coords(:,2), coords(:,3), interpParams);
end

if uniqueVox == 1
    val=tmp;
    disp(['Num unique voxels: ' num2str(size(coords,1))]);
else
    fiberLen=cellfun('size', fg.fibers, 2);
    start = 1;
    val = cell(1,length(fg.fibers));
    for ii=1:length(fg.fibers)
        val{ii} = tmp(start:start+fiberLen(ii)-1,:);
        start = start+fiberLen(ii);
    end
end

return;
