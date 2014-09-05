%% s_itkClasses2roi(ni, labelFile)
% Convert multiple layers (classes) from a nifti segmentation file (created
% by itkGray) into mrVista Gray ROIs 
% 
% itkClasses2roi(ni, labelFile)
%
%   ni = path to a nifti class file (assumed to contain integer data
%           points)
%   labelfile: path to an itk label file
%
% Example:
%   ni        = fullfile(mrvDataRootPath, 'anatomy/anatomyNIFTI/t1_class.nii.gz')
%   labelfile = fullfile(mrvDataRootPath, 'anatomy/anatomyNIFTI/t1_class.lbl');
%   itkClasses2roi(ni, labelfile)
%
% see itkClass2roi.m, nifti2mrVistaAnat.m
 
%%
homedir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd (homedir)

%% navigate to direcotry containing new T1s
subnames = {...
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



%%
Ind = [2];

for subinds = Ind
cd(fullfile(homedir, subnames{subinds}))


%%
    ni        = fullfile(homedir, subnames{subinds}, 'LGN.nii.gz')    
    labelfile = fullfile(homedir, '/JMD1-MM-20121025-DWI/LGN.lbl')
        
    itkClasses2roi(ni, labelfile)
end
