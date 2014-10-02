function SO_GetRois(fsDir, subDir, RoiDir)
% This function return ROIs.mat to generate optic tracty and optic radiation
% using conTrack.
% 
% Requires; freeesurfer segmentation files
%
% Example 
% fsDir  = getenv('SUBJECTS_DIR');
% subDir = {...
%       'JMD1-MM-20121025-DWI'...
%       'JMD2-KK-20121025-DWI'...
%       'JMD3-AK-20121026-DWI'};
%
% refImg; full path to "t1.nii.gz"
%       refImg = fullfile('homeDir,subDir,'t1.nii.gz');
%
% SO Vista lab 2014

%% Set directory
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
%% Create ROI.mat from aseg.nii.gz
% the other way is fs_ribbon2itk.m
labelVal = {'42','3'};
outfileName = {'Right-Cerebral-Cortex','Left-Cerebral-Cortex'};

for i = 1:length(subDir)    
    for ii =1:length(outfileName);
        fsInDir =fullfile(fsDir,subDir{i},'mri');
        cd(fsInDir)
        fsIn = fullfile(fsDir,subDir{i},'mri', 'aseg.nii.gz');
        % create and save nifti ROI in 'fs/mri' directory
        savefile =fullfile(fsDir,subDir{i},'mri',outfileName{ii});
        fs_aparcAsegLabelToNiftiRoi(fsIn,labelVal{ii},savefile)
        
        % Save '.mat' ROI in /ROIs directory
        nifti       = [savefile,'.nii.gz'];
        maskValue   = 0; % All nonZero values are used for the mask
        outFile     = sprintf('%s.mat',savefile);
        outType     = 'mat';  binary = true; save = true;
        
        % Transform roi.nii.gz to .mat
        roi = dtiRoiFromNifti(nifti,maskValue,outFile,outType,binary,save);
    end
end

%% Create ROI.mat from aparc+aseg.nii.gz
for i =1:length(subDir);
    
    fsIn =fullfile(fsDir,subDir{i},'mri/aparc+aseg.nii.gz');
    
    %% Run fs_aparcAsegLabelToNiftiRoi
    % set label LUT
    labelVal = [ 2 4 7 8 9 10 12 16 17 24 41 43 46 47 48 49 51 53 85 219 220 251 252 253 254 255];
    
%     % Check
%          for ii = 1:length(labelVal);
%              outfileName = fs_getROILabelNameFromLUT(labelVal(ii))
%          end
    
    for ii = 1:length(labelVal);
        % nifti ROI
        outfileName = fs_getROILabelNameFromLUT(labelVal(ii));        
        savefile =fullfile(fsDir,subDir{i},'mri',outfileName);
        fs_aparcAsegLabelToNiftiRoi(fsIn,labelVal(ii),savefile)
        
        % ROI.mat
        nifti       = [savefile,'.nii.gz'];
        maskValue   =  0;       % All nonZero values are used for the mask
        outName     = [outfileName,'.mat'];
        outFile     = fullfile(homeDir,subDir{i},'dwi_2nd','ROIs',outName);
        outType     = 'mat';  binary = true; save = true;
        
        % transform nifti to mat
        dtiRoiFromNifti(nifti,maskValue,outFile,outType,binary,save);
        
    end
end
%% Create V1,V2,MT ROI from fs label file
for i = 1:length(subDir)
    hemi= {'lh','rh'};
    for k = 1:length(hemi)
        labelfile_name ={'V1','V2','MT'} ;
        for j = 1:length(labelfile_name)
            %% ROI not delated
            hemiLabelfileName = [hemi{k},'.',labelfile_name{j}];
            labelFileName = [fullfile(fsDir,subDir{i},'label',hemiLabelfileName),'.label'];
            
            % define ROI name
            niftiRoiName  = fullfile(fsDir,subDir{i},'label',hemiLabelfileName);
            regMgzFile    = fullfile(fsDir,subDir{i},'mri/rawavg.mgz');
            
            % Create nifti ROI
            fs_labelFileToNiftiRoi(subDir{i},labelFileName,niftiRoiName,hemi{k},regMgzFile);
            
            % Save 'mat' ROI in ROIs directory
            % Set parameters
            niftiRoiName(niftiRoiName == '.') = '_';
            nifti = sprintf('%s.nii.gz',niftiRoiName);
            maskValue   =  0;       % All nonZero values are used for the mask
            
            hemiLabelfileName(hemiLabelfileName == '.') = '_';
            outName     = sprintf('%s.mat',hemiLabelfileName);
            
            RoiDir = fullfile(homeDir,subDir{i},'dwi_2nd','ROIs');
            outFile     = fullfile(RoiDir,outName);
            outType     = 'mat';  binary = true; save = true;
            
            % transform nifti to mat ROI
            dtiRoiFromNifti(nifti,maskValue,outFile,outType,binary,save);
            
            
            %% ROI 3mm smooth
            % define label file name
            hemiLabelfileName = sprintf('%s.%s',hemi{k},labelfile_name{j});
            labelfile     = sprintf('%s_smooth3mm',hemiLabelfileName);
%             labelFileName = sprintf('%s.label',fullfile(fsDir,subDir{i},'label',labelfile));
            
            % define ROI name
            niftiRoiName  = fullfile(fsDir,subDir{i},'label',labelfile);           
            niftiRoiName(niftiRoiName == '.') = '_';
            nifti = sprintf('%s.nii.gz',niftiRoiName);
            maskValue   =  0;       % All nonZero values are used for the mask
            
            hemiLabelfileName(hemiLabelfileName == '.') = '_';
            outName     = sprintf('%s_smooth3mm.mat',hemiLabelfileName);
            outFile     = fullfile(homeDir,subDir{i},'dwi_2nd','ROIs',outName);
            %             outType     = 'mat';  binary = true; save = true;
            
            % transform nifti to mat ROI
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

% %% Create fs corpus callosum ROI
% for i = 1:length(subDir)
%     
%     cd(fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs'))
%     
%     % ROI file names you want to merge
%     roiname = {'CC_Anterior','CC_Central','CC_Mid_Anterior','CC_Mid_Posterior','CC_Posterior'};    
%     % load all ROIs
%     for j = 1:length(roiname)
%         roi(j) = dtiReadRoi(roiname{j});
%     end
%     
%     % Merge ROI one by one
%     newROI = roi(1);
%     for kk=2:length(roiname)
%         newROI = dtiMergeROIs(newROI,roi(kk));
%     end
%     newROI.name = 'fs_CC';
%     % Save the new NOT ROI
%     dtiWriteRoi(newROI,newROI.name,1)
% end
% 