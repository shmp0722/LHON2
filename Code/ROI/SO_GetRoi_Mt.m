function SO_GetRoi_Mt

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set directory
[homeDir,subDir,~,~,~,~,~] = Tama_subj;
fsDir = fullfile(homeDir,'freesurfer');

%% create V1,V2 ROI.mat from label file
% If you finish fs_Autosegmentation. You already have V1,V2, and MT label file.
% If you want to get other file. SEE: fs_annotationToLabelFiles.m
% Try 'aparc.annot.a2009s.ctab' as annotation.
% loop for subjects
for i = 1:length(subDir)
    hemi= {'lh','rh'};    
    % loop for hemisphere
    for k = 1:length(hemi)
        labelfile_name ={'MT'} ;
        
        % loop for label
        %         for j = 1:length(labelfile_name)
        %% ROI not delated
        % define label file name
        hemiLabelfileName = sprintf('%s.%s',hemi{k},labelfile_name{1});
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
        % save in Tama2 directory
        outFile     = fullfile([homeDir,'2'],subDir{i},'dwi_2nd','ROIs',outName);
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
        outFile     = fullfile([homeDir,'2'],subDir{i},'dwi_2nd','ROIs',outName);
        %             outType     = 'mat';  binary = true; save = true;
        
        % run dtiRoiFromNifti
        dtiRoiFromNifti(nifti,maskValue,outFile,outType,binary,save);
        
        %         end
    end
end