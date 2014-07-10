% Convert a layer from a nifti segmentation file (created by itkGray) into
% a mrVista Gray ROI 
%
% ROI = itkClass2roi(ni, varargin)
%
%   INPUTS:
%       ni: a matrix, a nifti struct, or a path to a nifti file
%       Optional Inputs:
%           spath: a directory in which to save the ROI (if no path, then
%                 don't save; just return the ROI struct)
%           color: a 3-vector or color char (rbgcymkw)
%           comments: string for ROI.comments
%           name: string for ROI.name
%           layer: integer layer number in input matrix to be converted to
%                   ROI (Note that an ITK gray segmentation file can have
%                   any number of layers. We may want to convert only one
%                   of them to an ROI.)
%   OUTPUT:
%       ROI: a mrVista gray-view ROI struct
%
% see nifti2mrVistaAnat.m, itkClasses2roi.m
%
% Example:
%
%   ni =   '3DAnatomy/t1_class.nii';
%   fname = 'LeftWhiteMatter'
%   col = 'm';
%   ROI = itkClass2roi(ni, 'name', fname, 'color', col, 'layer', 2);
%
% April, 2009: JW

%% Set the fullpath to data directory
basedir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(basedir)


%% navigate to direcotry containing new T1s
subnames = {...cd(fullfile(basedir, subnames{subinds})

    'JMD1-MM-20121025-DWI'
    'JMD2-KK-20121025-DWI'
    'JMD3-AK-20121026-DWI'
    'JMD4-AM-20121026-DWI'
    'JMD5-KK-20121220-DWI'
    'JMD6-NO-20121220-DWI'
    'LHON1-TK-20121130-DWI'
    'LHON2-SO-20121130-DWI'
    'LHON3-TO-20121130-DWI'
    'LHON4-GK-20121130-DWI'
    'LHON5-HS-20121220-DWI'
    'LHON6-SS-20121221-DWI'
    'JMD-Ctl-MT-20121025-DWI'
    'JMD-Ctl-YM-20121025-DWI'};

subinds = 10;
%%
Ind = [1];

for subinds = Ind
cd(fullfile(basedir, subnames{subinds}))

%% s_itkClass2roi
% Example:
%
%   ni    = fullfile(subnames{subinds}, 'LGN.nii.gz');
%   fname = 'L-LGN'
%   col = 'm';
%
%
%   ROI = itkClass2roi(ni, 'name', fname, 'color', col, 'layer', 2);
 
 
 
    ni        = fullfile(subnames{subinds}, 'LGN.nii.gz');
    labelfile = fullfile('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI/LGN.lbl');
    itkClasses2roi(ni, labelfile)
end
 
 
 
