%% [LOR_FG, LOR_roi1, LOR_roi2] = SO_AFQ_Segment_OR(dt, LOR_FG, varargin)
% THIS FUNCTION IS STILL BEING DEVELOPED
% Define the vertical occipital fasciculus from a wholebrain fiber group.
%
% [vofFG, vofROI1, vofROI2] = AFQ_Segment_VOF(dt, wholebrainFG);
%
%
% Copyright Jason D Yeatman and Hiromasa Takamura, December 2012
%%
AFQdata = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subs = {...
    'JMD1-MM-20121025-DWI'...
    'JMD2-KK-20121025-DWI'...
    'JMD3-AK-20121026-DWI'...
    'JMD4-AM-20121026-DWI'...
    'JMD5-KK-20121220-DWI'...
    'JMD6-NO-20121220-DWI'...
    'JMD7-YN-20130621-DWI'...
    'JMD8-HT-20130621-DWI'...
    'JMD9-TY-20130621-DWI'...
    'LHON1-TK-20121130-DWI'...
    'LHON2-SO-20121130-DWI'...
    'LHON3-TO-20121130-DWI'...
    'LHON4-GK-20121130-DWI'...
    'LHON5-HS-20121220-DWI'...
    'LHON6-SS-20121221-DWI'...
    'JMD-Ctl-MT-20121025-DWI'...
    'JMD-Ctl-YM-20121025-DWI'...
    'JMD-Ctl-SY-20130222DWI'...
    'JMD-Ctl-HH-20120907DWI'...
    'JMD-Ctl-HT-20120907-DWI'...
    };
%for
i = 1;%:length(subs);
    
    dt= fullfile(AFQdata,subs{i},'/dwi_2nd','dt6.mat');
    fgDir = fullfile(AFQdata,subs{i},'/dwi_2nd/fibers/conTrack/OR_Top100K_fs2ROIV1_3mm');
    FG ='fg_OR_Top100K_fs2ROIV1_3mm_Lt-LGN_lh_V1_smooth3mm_2013-06-05_01.07.38.pdb';
%     cd(fgDir)
    %% Argument checking
    if ischar(dt)
        dt = dtiLoadDt6(dt);
    end
%     if ischar(FG)
%         FG = fgRead(FG);
%     end
    %     % Check if other files were passed in so computations can be skipped
    %     if ~isempty(varargin)
    %         for ii = 1:length(varargin)
    %             if isstruct(varargin{ii}) && isfield(varargin{ii},'deformX')...
    %                     && isfield(varargin{ii},'coordLUT')...
    %                     && isfield(varargin{ii},'inMat')
    %                 invDef= varargin{1};
    %             end
    %         end
    %     end
    
    %     % Path to the templates directory
    %     tdir = fullfile(fileparts(which('mrDiffusion.m')), 'templates');
    %     template = fullfile(tdir,'MNI_EPI.nii.gz');
    
    % Path to the VOF ROIs in MNI space
    %     AFQbase = AFQ_directories;
    %     AFQtemplates = fullfile(AFQbase,'templates');
    %     vof_roi_1 = fullfile(AFQtemplates,'L_VOF_ROI1.nii.gz');
    %     vof_roi_2 = fullfile(AFQtemplates,'L_VOF_ROI2.nii.gz');
    
    AFQrois = fullfile(AFQdata, subs{i}, '/dwi_2nd/ROIs');
    
%     ROR_roi1 = fullfile(AFQrois,'R_VOF_ROI1.nii.gz');
%     ROR_roi2 = fullfile(AFQrois,'R_VOF_ROI2.nii.gz');
    
    LOR_roi1 = dtiReadRoi(fullfile(AFQrois,'LOR_Test.mat'));
%     LOR_roi2 = dtiReadRoi(fullfile(AFQrois,'LORwaypoint2.mat'));
    
%     % Compute spatial normalize dtiWriteRoiation
%     if ~exist('invDef','var') || isempty(invDef)
%         [sn, Vtemplate, invDef] = mrAnatComputeSpmSpatialNorm(dt.b0, dt.xformToAcpc, template);
%     end
    
%     % Convert the ROIs to the individual's native space
%     [~, ~, vofROI1]=dtiCreateRoiFromMniNifti(dt.dataFile, ROR_roi1, invDef);
%     [~, ~, vofROI2]=dtiCreateRoiFromMniNifti(dt.dataFile, ROR_roi2, invDef);
    
    % Compute the PDD at each point in each ROI
    LOR_roi1_pdd = dtiGetValFromTensors(dt.dt6, LOR_roi1.coords, inv(dt.xformToAcpc), 'pdd');
%     LOR_roi2_pdd = dtiGetValFromTensors(dt.dt6, LOR_roi2.coords, inv(dt.xformToAcpc), 'pdd');
    
    % Find every coordinate in each VOF ROI where the PDD is in the Y direction
%     [~, vofROI1_pddZ] = max(abs(vofROI1_pdd),[],2);
%     vofROI1_pddZ = vofROI1_pddZ == 3; % Z direction
%     [~, vofROI2_pddZ] = max(abs(vofROI2_pdd),[],2);
%     vofROI2_pddZ = vofROI2_pddZ == 3;
    
% switch()
%     case 
%     % Select the voxels which have biggest PDD in Y direction   
%     [~, LOR_ROI1_pddY] = max(abs(LOR_roi1_pdd),[],2);
%     [ LOR_ROI1_pddY] = max(abs(LOR_roi1_pdd),[],2);
%     LOR_ROI1_pddY = LOR_ROI1_pddY == 2; % Y direction
%     [~, LOR_ROI2_pddY] = max(abs(LOR_roi2_pdd),[],2);
%     LOR_ROI2_pddY = LOR_ROI2_pddY == 2; % Ydirection
    

    % Select the voxel which have the PDD value more than 0.27 in Y
    % direction
        
    a = abs(LOR_roi1_pdd);
    pddY = a(:,2)>0.27; % 2 pdd value threshhold in Y direction
    
    
%     LOR_ROI1_pddMax = LOR_ROI1_pddMax < 0.2; % Y direction
%     [~, LOR_ROI2_pddY] = max(abs(LOR_roi2_pdd),[],2);
%     LOR_ROI2_pddY = LOR_ROI2_pddY < 0.2; % Ydirection
% % end

    
    
    % Retain VOF ROI coordinates that have a PDD in the Y direction
    
    c = LOR_roi1.coords(pddY,:);
    LOR_roi1.coords = c;
%     LOR_roi2.coords = LOR_roi2.coords(LOR_ROI2_pddY,:);
    
%     % Intersect the wholebrain fiber group with the ROIs
%     LOR_FG = dtiIntersectFibersWithRoi([],'and',[],LOR_roi1,LOR_FG);
% %     LOR_FG = dtiIntersectFibersWithRoi([],'and',[],LOR_roi2,LOR_FG);
%     
%     return
%     %%
%     % AFQ_RenderFibers(vofFG,'camera','sagittal')
%     
%     % Save new fg and ROIs 
%     LOR_FG.name = sprintf('%s.pdb',fullfile(fgDir,LOR_FG.name));
%     
%     fgWrite(LOR_FG, LOR_FG.name,'pdb')
    dtiWriteRoi(LOR_roi1,fullfile(AFQrois,'LOR_Test_post.mat'))
%     dtiWriteRoi(LOR_roi2,fullfile(AFQrois,'LORwaypoint2_post.mat'))

%end