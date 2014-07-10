%% SO_dtiROIDiffusivities.m
%% Set the path to data directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
subDir = {...
    'JMD1-MM-20121025-DWI'
    'JMD3-AK-20121026-DWI'
    'JMD5-KK-20121220-DWI'
    'JMD6-NO-20121220-DWI'
    'JMD2-KK-20121025-DWI'
    'JMD4-AM-20121026-DWI'
    'JMD7-YN-20130621-DWI'
    'JMD8-HT-20130621-DWI'
    'JMD9-TY-20130621-DWI'
    'LHON1-TK-20121130-DWI'
    'LHON2-SO-20121130-DWI'
    'LHON3-TO-20121130-DWI'
    'LHON4-GK-20121130-DWI'
    'LHON5-HS-20121220-DWI'
    'LHON6-SS-20121221-DWI'
    'JMD-Ctl-MT-20121025-DWI'
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'
    'JMD-Ctl-FN-20130621-DWI'
    'JMD-Ctl-AM-20130726-DWI'};

%% get ROI diffusivities and volume

for i = 1:length(subDir);
    
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    % define files
    roi = fullfile(roiDir,'Optic-Chiasm.mat');
    dt  = fullfile(dtDir,'dt6.mat');
    
    roi = dtiReadRoi(roi);
    dt  = dtiLoadDt6(dt);
    %1. Get coords from ROI-- roi.coords!
    %2. Compute FA, MD, RD properties for ROI
    [val1,val2,val3,val4,val5,val6] =...
        dtiGetValFromTensors(dt.dt6, roi.coords, inv(dt.xformToAcpc),'dt6','nearest');
    dt6 = [val1,val2,val3,val4,val5,val6];
    [vec,val] = dtiEig(dt6);
    
    % diffusivities
    [fa{i},md{i},rd{i},ad{i}] = dtiComputeFA(val);
    
    % volume
    t1 = readFileNifti(fullfile(SubDir,'t1.nii.gz'));
    v{i} = dtiGetRoiVolume(roi,t1,dt);    
     
end

for i = 1:length(subDir)
volume{i} =   v{i}.volume;
end

OC_Volume = mat2dataset(volume);
OC_fa = mat2dataset(fa);
OC_md = mat2dataset(md);
OC_ad = mat2dataset(ad);
OC_rd = mat2dataset(rd);

% See exampleFgAnalysisForTama

