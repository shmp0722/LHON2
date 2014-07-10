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


%%[val1,val2,val3,val4,val5,val6,val7] = dtiGetValFromTensors(dt6, coords, xform, valName, interpMethod)
% Interpolates dt6 tensor field and computes stats at each of the coords
%
%  [val1,val2,val3,val4,val5,val6,val7] = ...
%     dtiGetValFromTensors(dt6, coords, [xform], [valName], [interpMethod])
%
% This  also works for a scalar image in place of the dt6. In that case,
% 'valName' is ignored. (OK, but what does it do in that case? BW)
%
% Inputs:
%  xform: the transform that converts coords to dt6 indices. Default is
%    eye(4) (ie. no xform).  As an example,
%    dtiFiberGroupPropertyWeightedAverage sets the xform to
%    inv(dt.xformToAcpc).  This is the inverse of the transform from coords
%    to acpc, suggesting that the coords in there are acpc and the xform
%    maps from acpc to image space.
%  coords: Nx3 matrix of coords. The returned val will be of length N.  The
%    coords are often in ACPC space while the dt6 indices are in image
%    space.  So xform would move from ACPC to image, typically.
%  interpMethod: 'nearest', 'trilin' (default), 'spline'
%val = dtiGetValFromFibers(dt6struct.dt6, fg, xform, valName, interpMethod, uniqueVox);
%
% The values returned (val1, val2, etc.) differ depending on the string in
% valName.  The current valnaem options are:
%    - 'fa' (fractional anisotropy) (DEFAULT)
%    - 'md' (mean diffusivity)
%    - 'eigvals' (triplet of values for 1st, 2nd and 3rd eigenvalues)
%    - 'shapes' (triplet of values indicating linearity, planarity and
%              spherisity)
%    - 'dt6' (the full tensor in [Dxx Dyy Dzz Dxy Dxz Dyz] format
%    - 'pdd' (principal diffusion direction)
%    - 'linearity'subDir
%    - 'fa md pdd', 'fa md ad rd', 'fa md pdd dt6'
%    - 'fa md ad rd shape'
%
% HISTORY:
% 2005.03.18 RFD (bob@white.stanford.edu) wrote it.
% 2006.08.07 RFD: we no longer set NaNs to 0. If there are missing
%   data, the caller should know about it and deal with as they wish.
% 2012.09 BW - Coments and consistency with other methods
%dt6
% Bob (c) Stanford VISTA Team


dt6filename = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON1-TK-20121130-DWI/dwi_2nd/dt6.mat';
dt6struct = dtiLoadDt6(dt6filename);

fgfilename = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON1-TK-20121130-DWI/dwi_2nd/fibers/opticradiation_AFQ_test_clean.pdb';
fg = fgRead(fgfilename);
val = dtiGetValFromFibers(dt6struct.dt6, fg, xform, valName, interpMethod, uniqueVox);

% [fg,opts] = dtiReadFibers(fgfilename);
%  xform = eye(4);
   xform = dt6struct.xformToAcpc;
valName = 'famdadrd';
interpMethod='trilin';
uniqueVox=0;

% val = dtiGetValFromFibers(dt6struct.dt6, fg, xform, valName, interpMethod, uniqueVox);
val = dtiGetValFromFibers(dt6struct.dt6, fg, inv(dt6struct.xformToAcpc), valName);

% %%
% 
% for ii = 1:length(val)
%     
%    Checksuru(ii) = sum(~isnan(val{ii}));
% end

