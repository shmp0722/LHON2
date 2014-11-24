function [Lmm,Lnorm, Mu, Sigma] = Fiberlength(fg)
% returns the fiber length and mean length
% 
% [Lmm,Lnorm, Mu, Sigma] = Fiberlength(fg)
%
% Example
% fg = fgread(fg)
% SO Vista lab 2014
%% calculate each fiber length
[Lmm] =cellfun(@length,fg.fibers);
[Lnorm, Mu, Sigma]= zscore(Lmm);
