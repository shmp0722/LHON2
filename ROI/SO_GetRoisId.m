function SO_GetRoisId
% This function return ROIs.mat to generate optic tract and optic radiation
% using conTrack.
%
% Requires; freesurfer segmentation files
% AC-PC alignment
%
% Example
% fsDir  = getenv('SUBJECTS_DIR');
% subDir = {...
%       'JMD1-DWI'...
%       'JMD2-DWI'...
%       'JMD3-DWI'};
%
% refImg; full path to "t1.nii.gz"
%       refImg = fullfile('homeDir,subDir,'t1.nii.gz');
%
% SO Vista lab 2014

%% Set directory
 [homeDir,subDir] = fileparts(pwd);
 fsDir  = getenv('SUBJECTS_DIR');
%% transform fs segmentation files.mgz to .nii.gz
% for i = id
    mgzInDir = fullfile(fsDir,subDir,'/mri');
    % .mgz files
    mgz_files = {'aseg','aparc+aseg','aparc.a2009s+aseg'};
    for k = 1:length(mgz_files)
        mgzIn   = [fullfile(mgzInDir, mgz_files{k}),'.mgz'];
        refImg  = fullfile(homeDir,subDir,'t1.nii.gz');
        outName = [fullfile(mgzInDir,mgz_files{k}),'.nii.gz'];
        orient  = 'RAS';
        if ~exist(outName),
        fs_mgzSegToNifti(mgzIn, refImg, outName, orient);end;
    end
% end
%% Create ROI.mat from aseg.nii.gz
labelVal = {'42','3'};
outfileName = {'Right-Cerebral-Cortex','Left-Cerebral-Cortex'};

% for i = id
    for ii =1:length(outfileName);
        fsIn = fullfile(fsDir,subDir,'/mri/aseg.nii.gz');
        roiDir =fullfile(homeDir,subDir,'dwi_2nd','ROIs');
        if ~exist(roiDir);mkdir(roiDir);end;
        % create and save nifti ROI
        savefile =fullfile(fsDir,subDir,'mri',outfileName{ii});
        if ~exist([savefile,'.nii.gz']);
            fs_aparcAsegLabelToNiftiRoi(fsIn,labelVal{ii},savefile)
            
            % Transform nifti to mat
            niftiROI    = [savefile,'.nii.gz'];
            matROI      = [outfileName{ii},'.mat'];
            maskValue   = 0; % All nonZero values are used for the mask
            %         outFile     = sprintf('%s.mat',savefile);
            outFile     =fullfile(roiDir,matROI);
            outType     = 'mat';  binary = true; save = true;
            dtiRoiFromNifti(niftiROI,maskValue,outFile,outType,binary,save);
        end
    end
% end


%% Create ROI.mat from aparc+aseg.nii.gz
% for i =id;
    roiDir =fullfile(homeDir,subDir,'dwi_2nd','ROIs');
    % aparc+aseg.nii.gz
    fsIn =fullfile(fsDir,subDir,'mri/aparc+aseg.nii.gz');
    % take label name from LUT
    labelVal = [ 2 4 7 8 9 10 12 16 17 24 41 43 46 47 48 49 51 53 85 219 220 251 252 253 254 255]; 
%     labelVal = [ 2 4 7 8 9 16 17 24 43 46 47 48 49 51 53 85 219 220 251 252 253 254 255]; % 10, 12, 41
%         labelVal = [ 2 41]; 

    for ii = 1:length(labelVal);
        % nifti ROI
        outfileName = fs_getROILabelNameFromLUT(labelVal(ii));
        savefile =fullfile(fsDir,subDir,'mri',outfileName);
        if ~exist([savefile,'.nii.gz']),
            fs_aparcAsegLabelToNiftiRoi(fsIn,labelVal(ii),[savefile,'.nii.gz'])
            
            % ROI.mat
            niftiROI       = [savefile,'.nii.gz'];
            maskValue   =  0;       % All nonZero values are used for the mask
            outName     = [outfileName,'.mat'];
            outFile     = fullfile(roiDir,outName);
            outType     = 'mat';  binary = true; save = true;
            
            % transform nifti to mat
            dtiRoiFromNifti(niftiROI,maskValue,outFile,outType,binary,save);
        end
    end
% end
%% If fs_aparcAsegLabelToNiftiRoi does not worl well
% all roi is empty

% for i =id;
    roiDir =fullfile(homeDir,subDir,'dwi_2nd','ROIs');
    rois = dir(fullfile(roiDir,'aparc+aseg*'));
    
%     if ~empty(rois),
        cd(roiDir)
        for jj = 1:length(rois)
            
            % take label number from aparc+aseg label
            [~,f,~]=fileparts(rois(jj).name);
            ind_s = find(f=='_');
            ind_e = length(f);
            labelVal = f(ind_s+1:ind_e);
            
            savefile = [fs_getROILabelNameFromLUT(labelVal), '.mat'];
            movefile(rois(jj).name, savefile);
            cur_roi = dtiReadRoi(savefile);
            cur_roi.name = fs_getROILabelNameFromLUT(labelVal);
            dtiWriteRoi(cur_roi,savefile)
        end
%     end
% end
    
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
            RoiDir = fullfile(homeDir,subDir,'dwi_2nd','ROIs');
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
            outFile     = fullfile(homeDir,subDir,'dwi_2nd','ROIs',outName);
            
            % transform nifti to mat ROI
            dtiRoiFromNifti(niftiROI,maskValue,outFile,outType,binary,save);end
        end
    end
% end

%% clip V1_smooth3mm.mat
% cut off peripheral V1 ROI at -60mm in
% for i = id  % 3 imcomplete    
    % Load V1 ROIs
    RDir = fullfile(homeDir,subDir,'/dwi_2nd/ROIs');
    lh_V1roi =fullfile(RDir,'lh_V1_smooth3mm.mat');
    rh_V1roi =fullfile(RDir,'rh_V1_smooth3mm.mat');    
    lh_V1roi = dtiReadRoi(lh_V1roi);
    rh_V1roi = dtiReadRoi(rh_V1roi);    
    
    % Clip ROIs
    apClip=[-120 -60];
    [~, lh_V1roi] = dtiRoiClip(lh_V1roi, [], apClip, []);
    dtiWriteRoi(lh_V1roi, lh_V1roi.name)
    
    [~, rh_V1roi] = dtiRoiClip(rh_V1roi, [], apClip, []);
    dtiWriteRoi(rh_V1roi, rh_V1roi.name)    
% end

%% Create fs corpus callosum ROI
% for i = id

    cd(fullfile(homeDir,subDir,'/dwi_2nd/ROIs'))

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
% end

