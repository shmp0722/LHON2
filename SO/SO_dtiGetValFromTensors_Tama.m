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
%    - 'linearity'
%    - 'fa md pdd', 'fa md ad rd', 'fa md pdd dt6'
%    - 'fa md ad rd shape'
%
% HISTORY:
% 2005.03.18 RFD (bob@white.stanford.edu) wrote it.
% 2006.08.07 RFD: we no longer set NaNs to 0. If there are missing
%   data, the caller should know about it and deal with as they wish.
% 2012.09 BW - Coments and consistency with other methods
%
% Bob (c) Stanford VISTA Team

dt6 = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON1-TK-20121130-DWI/dwi_2nd/dt6.mat';
coords = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON1-OR_AFQ_test_Dist3.pdb';
xform = eye(4);
interpMethod = 'trilin';

[val1,val2,val3,val4,val5,val6,val7] = dtiGetValFromTensors(dt6, coords,...
    xform, valName, interpMethod)




