function SO_GetRois(fsDir, subDir)
% this script return ROIs to generate optic tracty and optic radiation
% using conTrack.
%
% Example Input
% fsDir          = getenv('SUBJECTS_DIR');
% subDir = {...
%       'JMD1-MM-20121025-DWI'...
%       'JMD2-KK-20121025-DWI'...
%       'JMD3-AK-20121026-DWI'};
% 
% refImg; full pathto t1.nii.gz
%       refImg = fullfile('homeDir,subDir,'t1.nii.gz');
% 
% SO Vista lab 2014


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FS could not Autosegment JMD-Ctl-FN cerebral cortex!!
% Never

% Set directory
[homeDir,subDir] = Tama_subj; 
fsDir   = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/freesurfer';

%% fs_mgzSegToNifti.m
% transform Segmentation file .mgz to .nii.gz
for i = 1:length(subDir)
    mgzInDir = fullfile(fsDir,subDir{i},'/mri');
    % .mgz files
    mgz_files = {'aparc+aseg','aseg','aparc.a2009s+aseg'};
    for k = 1:length(mgz_files)
        mgzIn   = [fullfile(mgzInDir, mgz_files{k}),'.mgz'];
        refImg  = fullfile(homeDir,subDir{i},'t1.nii.gz');
        outName = [fullfile(mgzInDir,mgz_files{k}),'.nii.gz'];
        orient  = 'RAS';
        fs_mgzSegToNifti(mgzIn, refImg, outName, orient)
    end
end

%% fs_aparcAsegLabelToNiftiRoi.m
% Create ROI.mat from aseg.nii.gz (especially Cerebral Cortex).
% the other way is fs_ribbon2itk.m
labelVal = {'42','3'};
outfileName = {'Right-Cerebral-Cortex','Left-Cerebral-Cortex'};

for i = 1:length(subDir)
    matRoiDir = fullfile(homeDir,subDir{i},'dwi_2nd/ROIs');

    %loop for every label    
    for ii =1:length(outfileName);
        fsInDir =fullfile(fsDir,subDir{i},'mri');
        cd(fsInDir)
        fsIn = fullfile(fsDir,subDir{i},'mri', 'aseg.nii.gz');
        % create and save nifti ROI in 'fs/mri' directory
        savefile =fullfile(fsDir,subDir{i},'mri',outfileName{ii});
        fs_aparcAsegLabelToNiftiRoi(fsIn,labelVal{ii},savefile)
        
        % Save '.mat' ROI in /ROIs directory
        % Set parameters
        nifti       = sprintf('%s.nii.gz',savefile);
        maskValue   = 0; % All nonZero values are used for the mask
        outFile     = sprintf('%s.mat',savefile);
        outType     = 'mat';  binary = 1; save = 0;
        
        % run dtiRoiFromNifti and Save mat Roi in ROIs directory
        roi = dtiRoiFromNifti(nifti,maskValue,outFile,outType,binary,save);
        cd(matRoiDir)
        dtiWriteRoi(roi,outfileName{ii})  
        
    end
end
%% Create fs.mat ROI from aparc+aseg.nii.gz
for i =1:length(subDir);
   
    fsIn =fullfile(fsDir,subDir{i},'mri','aparc+aseg.nii.gz');
    
    %% Run fs_aparcAsegLabelToNiftiRoi
    % set label and roi names
    labelVal = {...
                '85'
                '4'
                '43'
                '17'
                '53'
                '12'
                '51'
                '2'
                '41'
                '251'
                '252'
                '253'
                '254'
                '255'
                '9'
                '10'
                '48'
                '49'
                '16'
                '24'
                '7'
                '8'
                '46'
                '47'
                '219'
                '220'
                '16'};
    
    
    outfileName = {...
                'Optic-Chiasm'
                'Left-Lateral-Ventricle'
                'Right-Lateral-Ventricle'
                'Left-Hippocampus'
                'Right-Hippocampus'
                'Left-Putamen'
                'Right-Putamen'
                'Left-Cerebral-White-Matter'
                'Right-Cerebral-White-Matter'
                'CC_Posterior'
                'CC_Mid_Posterior'
                'CC_Central'
                'CC_Mid_Anterior'
                'CC_Anterior'
                'Left-Thalamus'
                'Left-Thalamus-Proper'
                'Right-Thalamus'
                'Right-Thalamus-Proper'
                'Brain-Stem'
                'CSF'
                'Left-Cerebellum-White-Matter'
                'Left-Cerebellum-Cortex'
                'Right-Cerebellum-White-Matter'
                'Right-Cerebellum-Cortex'
                'Cerebral_White_Matter'
                'Cerebral_Cortex'
                'Brain-Stem'};   
    %    
    for ii = 1:length(outfileName);        
        % save nifti ROI 
        savefile =fullfile(fsDir,subDir{i},'mri',outfileName{ii});
        fs_aparcAsegLabelToNiftiRoi(fsIn,labelVal{ii},savefile)
        
        % Save 'mat' ROI in ROIs directory
        % Set parameters
        nifti       =  sprintf('%s.nii.gz',savefile);
        maskValue   =  0;       % All nonZero values are used for the mask
        outName     = sprintf('%s.mat',outfileName{ii});
        outFile     = fullfile(homeDir,subDir{i},'dwi_2nd','ROIs',outName);
        outType     = 'mat';  binary = true; save = true;
        
        % run dtiRoiFromNifti
        dtiRoiFromNifti(nifti,maskValue,outFile,outType,binary,save);
        
    end
end
%% create V1,V2 ROI.mat from label file
% If you finish fs_Autosegmentation. You already have V1,V2, and MT label file.
% If you want to get other file. SEE: fs_annotationToLabelFiles.m
% Try 'aparc.annot.a2009s.ctab' as annotation.
% loop for subjects
for i = 1:length(subDir)
    % loop for hemisphere
    for k = 1:2
        hemisphere     = {'lh','rh'};
        annotation     = 'aparc';
%                        = 'aparc.annot.a2009s.ctab';
        annotationFile = fullfile(fsDir,subDir{i},'label',annotation);
        regMgzFile    = fullfile(fsDir,subDir{i},'/mri/rawavg.mgz');
        
        cmd            = fs_annotationToLabelFiles(subDir{i},annotationFile,hemisphere{k});
        
        labelfile_name ={'V1','V2'} ;
        
        % 
        for j = 1:length(labelfile_name)    
            %% ROI not delated
            % define label file name
            hemi= {'lh','rh'};
            hemiLabelfileName = sprintf('%s.%s',hemi{k},labelfile_name{j});
            labelfile    = sprintf('%s.label',hemiLabelfileName);
            labelFileName = fullfile(fsDir,subDir{i},'label',labelfile);
            
            % define ROI name
            niftiRoiName  = fullfile(fsDir,subDir{i},'label',hemiLabelfileName);
            regMgzFile    = fullfile(fsDir,subDir{i},'mri/rawavg.mgz');
            
            % run fs_labelFileToNiftiRoi
            fs_labelFileToNiftiRoi(subDir{i},labelFileName,niftiRoiName,hemi{k},regMgzFile);
            
            % Save 'mat' ROI in ROIs directory
            % Set parameters
            niftiRoiName(niftiRoiName == '.') = '_';
            nifti = sprintf('%s.nii.gz',niftiRoiName);
            maskValue   =  0;       % All nonZero values are used for the mask
            
            hemiLabelfileName(hemiLabelfileName == '.') = '_';
            outName     = sprintf('%s.mat',hemiLabelfileName);
            outFile     = fullfile(homeDir,subDir{i},'dwi_2nd','ROIs',outName);
            outType     = 'mat';  binary = true; save = true;
            
            % run dtiRoiFromNifti
            dtiRoiFromNifti(nifti,maskValue,outFile,outType,binary,save);
            
            
            %% ROI 3mm smooth
            % define label file name
            hemiLabelfileName = sprintf('%s.%s',hemi{k},labelfile_name{j});
            labelfile     = sprintf('%s_smooth3mm',hemiLabelfileName);
            labelFileName = sprintf('%s.label',fullfile(fsDir,subDir{i},'label',labelfile));
            
            % define ROI name
            niftiRoiName  = fullfile(fsDir,subDir{i},'label',labelfile);
            % regMgzFile    = fullfile(fsDir,subJ{i},'/mri/rawavg.mgz');
            % run fs_labelFileToNiftiRoi
            % fs_labelFileToNiftiRoi(subJ{i},labelFileName,niftiRoiName,hemi{k},regMgzFile);
            
            % Save 'mat' ROI in ROIs directory
            % Set parameters
            niftiRoiName(niftiRoiName == '.') = '_';
            nifti = sprintf('%s.nii.gz',niftiRoiName);
            maskValue   =  0;       % All nonZero values are used for the mask
            
            hemiLabelfileName(hemiLabelfileName == '.') = '_';
            outName     = sprintf('%s_smooth3mm.mat',hemiLabelfileName);
            outFile     = fullfile(homeDir,subDir{i},'dwi_2nd','ROIs',outName);
            %             outType     = 'mat';  binary = true; save = true;
            
            % run dtiRoiFromNifti
            dtiRoiFromNifti(nifti,maskValue,outFile,outType,binary,save);
            
        end
    end
end

%% clip V1_smooth3mm.mat
% cut off peripheral V1 ROI at -60mm in  
for i = 1:length(subDir)  % 3 imcomplete

    % directory   
    RoiDir = fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs');       
    lh_V1roi =fullfile(RoiDir,'lh_V1_smooth3mm.mat');
    rh_V1roi =fullfile(RoiDir,'rh_V1_smooth3mm.mat');

    cd(RoiDir)    
    %% Argument checking   
    if ischar(lh_V1roi)
        lh_V1roi = dtiReadRoi(lh_V1roi);
    end
    if ischar(rh_V1roi)
        rh_V1roi = dtiReadRoi(rh_V1roi);
    end
    
    % dtiRoiClip
    apClip=[-120 -60];
    [~, lh_V1roi] = dtiRoiClip(lh_V1roi, [], apClip, []);
    dtiWriteRoi(lh_V1roi, lh_V1roi.name)
    
    [~, rh_V1roi] = dtiRoiClip(rh_V1roi, [], apClip, []);
    dtiWriteRoi(rh_V1roi, rh_V1roi.name)
    
end
%% lets remove V1_smooth 3mm_NOT from cerebral cortex
% SO_dtiRoiClean_GM.m
%%  loop subject
for i = 1:length(subDir)

    RoiDir = fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs');
    roiF = {'lh_V1_smooth3mm_NOT.mat','rh_V1_smooth3mm_NOT.mat'};
    roif = {'Left-Cerebral-Cortex.mat','Right-Cerebral-Cortex.mat'};
    cd(RoiDir)
    for k = 1:length(roiF)
    % load Roi
    roi1 = dtiReadRoi(roiF{k});
        
    % Clean the Roi
    roi1 = dtiRoiClean(roi1,3,['fillholes', 'dilate', 'removesat']);  
    roi1.name = [roi1.name, '_clean'];
    dtiWriteRoi(roi1,roi1.name,1)
    
    roi2= dtiReadRoi(roif{k});
    
    newROI = dtiSetdiffROIs(roi2,roi1);
    name = {'Left-Cerebral-Cortex_V13mm_setdiff','Right-Cerebral-Cortex_V13mm_setdiff'};
    newROI.name = name{k};
    dtiWriteRoi(newROI, newROI.name,1)
    
    end
end

%%
%  SO_dtiRestrictToImageValueRange.m

%% Merge big NotROI and Wm

% run MergeROIs_NOTROI5.m and MergeROIs_Wm.m
%
%%loop subject
for i = 1:length(subDir)
    
    cd(fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs'))
    
    % ROI file names you want to merge
    for k=1:2;
        switch k
            case 1
                roiname = {'Left-Cerebral-White-Matter','Lt-LGN4'};%,'Left-Thalamus-Proper'};
            case 2
                roiname = {'Right-Cerebral-White-Matter','Rt-LGN4'};%,'Right-Thalamus-Proper'};
        end
        % load all ROIs
        for j = 1:length(roiname)
            roi(j) = dtiReadRoi(roiname{j});
        end
        
        % Merge ROI one by one
        newROI = roi(1);
        for kk=2:length(roiname)
            newROI = dtiMergeROIs(newROI,roi(kk));
        end
        switch k
            case 1
                newROI.name = 'Left-Cerebral-White-Matter_Lt-LGN4';%,'Left-Thalamus-Proper'};
            case 2
                newROI.name = 'Right-Cerebral-White-Matter_Rt-LGN4';%,'Right-Thalamus-Proper'};
        end
        
        % Save the new NOT ROI
        dtiWriteRoi(newROI,newROI.name,1)
    end
end

%% MergeROI_fsCC

%loop subject
for i = 1:length(subDir)
    
    cd(fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs'))
    
    % ROI file names you want to merge
    roiname = {'CC_Anterior','CC_Central','CC_Mid_Anterior','CC_Mid_Posterior','CC_Posterior'};
    
    % load all ROIs
    for j = 1:length(roiname)
        roi(j) = dtiReadRoi(roiname{j});
    end
    
    % Merge ROI one by one
    newROI = roi(1);
    for kk=2:length(roiname)
        newROI = dtiMergeROIs(newROI,roi(kk));
    end
    newROI.name = 'fs_CC';
    % Save the new NOT ROI
    dtiWriteRoi(newROI,newROI.name,1)
end

%% WMmask
for i = 1:length(subDir)
    
    cd(fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs'))
    
    % ROI file names you want to merge
    roiname = {'Left-Cerebral-White-Matter_Lt-LGN4'
        'Right-Cerebral-White-Matter_Rt-LGN4'
        'fs_CC'
        'Left-Thalamus-Proper'
        'Right-Thalamus-Proper'};%,'Left-Thalamus-Proper'};
    
    % load all ROIs
    for j = 1:length(roiname)
        roi(j) = dtiReadRoi(roiname{j});
    end
    
    % Merge ROI one by one
    newROI = roi(1);
    for kk=2:length(roiname)
        newROI = dtiMergeROIs(newROI,roi(kk));
    end
    newROI.name = 'WMmask';
    % Save the new NOT ROI
    dtiWriteRoi(newROI,newROI.name,1)
    % Save new niROI
    imagef = fullfile(homeDir,subDir{i},'t1.nii.gz'); 
    ni = dtiRoiNiftiFromMat(newROI,imagef);
    
end

%% MergeROIsV1V2
for i = 1:length(subDir)
    for j = 1:4
        cd(fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs'))
        
        roi1 = {'lh_V1.mat','lh_V1_smooth3mm','rh_V1.mat','rh_V1_smooth3mm'};
        roi2 = {'lh_V2.mat','lh_V2_smooth3mm','rh_V2.mat','rh_V2_smooth3mm'};
        
        roi1 = dtiReadRoi(roi1{j}) ;
        roi2 = dtiReadRoi(roi2{j}) ;
        
        newROI = dtiMergeROIs(roi1,roi2);
        dtiWriteRoi(newROI,newROI.name,1)
    end
end

