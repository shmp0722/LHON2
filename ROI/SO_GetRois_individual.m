function SO_GetRois_individual
% This function return ROIs.mat to generate optic tract and optic radiation
% using conTrack.
%
% Requires; freesurfer segmentation files
% AC-PC alignment
%
%
% Example just run under subject d
% SO_GetRois_individual 

% SO Vista lab 2014

%% Set directory
if notDefined('homeDir')||notDefined('subDir')
    [homeDir,subDir] = fileparts(pwd);
    fsDir  = getenv('SUBJECTS_DIR');
end

%% transform fs segmentation files.mgz to .nii.gz
% .mgz files
mgzInDir = fullfile(fsDir,subDir,'/mri');
refImg  = fullfile(homeDir,subDir,'t1.nii.gz');
RoiDir = fullfile(homeDir,subDir,'/ROIs');
mgz_files = {'aseg','aparc+aseg','aparc.a2009s+aseg'};
for k = 1:length(mgz_files)
    mgzIn   = [fullfile(mgzInDir, mgz_files{k}),'.mgz'];    
    % save directory
    if ~exist(RoiDir), mkdir(RoiDir),end;
    % take all rois from fs segmentation file
    fs_roisFromAllLabels(mgzIn,RoiDir,'mat',refImg)
end

%% Create V1,V2,MT ROI from fs label file
% for i = id
hemi= {'lh','rh'};
for k = 1:length(hemi)
    labelfile_name ={'V1','V2','MT'} ;
    for j = 1:length(labelfile_name)
        %% ROI
        hemiLabelfileName = [hemi{k},'.',labelfile_name{j}];
        labelFileName = [fullfile(fsDir,subDir,'label',hemiLabelfileName),'.label'];
        
        % define ROI name
        RoiName  = fullfile(fsDir,subDir,'label',hemiLabelfileName);
        regMgzFile    = fullfile(fsDir,subDir,'mri/rawavg.mgz');
        
        % Create nifti ROI
        if ~exist(RoiName),
            smoothingKernel = 3;
            [RoiName, ~] = ...
                fs_labelFileToNiftiRoi(subDir,labelFileName,RoiName,hemi{k},regMgzFile,smoothingKernel);
            
            % Save 'mat' ROI in ROIs directory
            niftiROI = [RoiName,'.nii.gz'];
            maskValue   =  0;       % All nonZero values are used for the mask
            
            hemiLabelfileName(hemiLabelfileName == '.') = '_';
            outName     = sprintf('%s.mat',hemiLabelfileName);
            %%%
            outFile     = fullfile(RoiDir,outName);
            outType     = 'mat';  binary = true; save = true;
            
            % transform nifti to mat ROI
            dtiRoiFromNifti(niftiROI,maskValue,outFile,outType,binary,save);
            
            %% ROI 3mm smooth
            % define label file name
            hemiLabelfileName = sprintf('%s.%s',hemi{k},labelfile_name{j});
            labelfile     = sprintf('%s_smooth3mm',hemiLabelfileName);
            
            % define ROI name
            RoiName  = fullfile(fsDir,subDir,'label',labelfile);
            RoiName(RoiName == '.') = '_';
            niftiROI = sprintf('%s.nii.gz',RoiName);
            maskValue   =  0;       % All nonZero values are used for the mask
            
            hemiLabelfileName(hemiLabelfileName == '.') = '_';
            outName     = sprintf('%s_smooth3mm.mat',hemiLabelfileName);
            outFile     = fullfile(RoiDir,outName);
            
            % transform nifti to mat ROI
            dtiRoiFromNifti(niftiROI,maskValue,outFile,outType,binary,save);
        end
    end
end


%% clip V1_smooth3mm.mat
% cut off peripheral V1 ROI at -60mm in
% Load V1 ROIs
lh_V1roi =fullfile(RoiDir,'lh_V1_smooth3mm.mat');
rh_V1roi =fullfile(RoiDir,'rh_V1_smooth3mm.mat');
lh_V1roi = dtiReadRoi(lh_V1roi);
rh_V1roi = dtiReadRoi(rh_V1roi);

% Clip ROIs
apClip=[-120 -60];
[~, lh_V1roi] = dtiRoiClip(lh_V1roi, [], apClip, []);
dtiWriteRoi(lh_V1roi, fullfile(RoiDir,lh_V1roi.name))

[~, rh_V1roi] = dtiRoiClip(rh_V1roi, [], apClip, []);
dtiWriteRoi(rh_V1roi, fullfile(RoiDir,rh_V1roi.name))

% %% Create fs corpus callosum ROI
% % ROI file names you want to merge
% roiname = {'*CC_Anterior*','*CC_Central','*CC_Mid_Anterior*','*CC_Mid_Posterior*','*CC_Posterior*'};
% % load all ROIs
% for j = 1:length(roiname)
%     ROI = dir(fullfile(RoiDir,roiname{j}));
%     roi(j) = dtiReadRoi(fullfile(RoiDir,ROI.name));
% end
% 
% % Merge ROI one by one
% newROI = roi(1);
% for kk=2:length(roiname)
%     newROI = dtiMergeROIs(newROI,roi(kk));
% end
% newROI.name = 'fs_CC';
% % Save the new NOT ROI
% dtiWriteRoi(newROI,fullfile(RoiDir,newROI.name),1)
% end





