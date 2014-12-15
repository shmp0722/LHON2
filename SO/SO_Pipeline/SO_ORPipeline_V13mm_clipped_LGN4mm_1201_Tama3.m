function SO_ORPipeline_V13mm_clipped_LGN4mm_1201_Tama3(id,ROI)
%
% clean optic radiation based on anatomical locatino information. The way
% point rois are provided from freesurfer.
%
% SO @ Vista lab 2014

%% Set directory
[homeDir,subDir] = Tama_subj3;

%% make new directory
if ROI,
    % Combine contra hemisphere rois as a waypoint roi
    for i = id
        roiDir = fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs');
        
        % ROI file names you want to merge
        for hemisphere = 1:2
            switch(hemisphere)
                case  1 % Left-WhiteMatter
                    roiname = {...
                        '*_Right-Cerebellum-White-Matter*'
                        '*_Right-Cerebellum-Cortex*'
                        '*_Left-Cerebellum-White-Matter*'
                        '*_Left-Cerebellum-Cortex*'
                        '*_Left-Hippocampus*'
                        '*_Right-Hippocampus*'
                        '*_Left-Lateral-Ventricle*'
                        '*_Right-Lateral-Ventricle*'
                        '*_Left-Cerebral-White-Matter*'};
                case 2 % Right-WhiteMatter
                    roiname = {...
                        '*_Right-Cerebellum-White-Matter*'
                        '*_Right-Cerebellum-Cortex*'
                        '*_Left-Cerebellum-White-Matter*'
                        '*_Left-Cerebellum-Cortex*'
                        '*_Left-Hippocampus*'
                        '*_Right-Hippocampus*'
                        '*_Left-Lateral-Ventricle*'
                        '*_Right-Lateral-Ventricle*'
                        '*_Right-Cerebral-White-Matter*'};
            end            
            
            % load all ROIs
            for j = 1:length(roiname)
                roifile = dir(fullfile(roiDir,roiname{j}));
                roi{j} = dtiReadRoi(fullfile(roiDir,roifile.name));
                
                % make sure if ROI has volume
                if 1 == isempty(roi{j}.coords)
                    disp(roi{j}.name)
                    disp('number of corrds = 0')
                    return
                end
            end
            
            % Merge all rois
            newROI = roi{1,1};
            for kk=2:length(roiname)
                newROI = dtiMergeROIs(newROI,roi{1,kk});
            end
            
            % name            
            switch(hemisphere)
                case 1 % Left-WhiteMatter
                    newROI.name = 'Lh_NOT1201';
                case 2 % Right-WhiteMatter
                    newROI.name = 'Rh_NOT1201';
            end
            % Save Roi
            dtiWriteRoi(newROI,newROI.name,1)
        end
    end
    
end
%% exclude fibers from contrack tract using way point ROI
for i = id % 22
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    
    % ROI file names you want to merge
    for hemisphere = 1:2
        % Intersect raw OR with Not ROIs
        fgF = {'*_Rt-LGN4_rh_V1_smooth3mm_NOT_*.pdb'
            '*_Lt-LGN4_lh_V1_smooth3mm_NOT_*.pdb'};
        %         end;
        
        % load fg and ROI
        fg  = dir(fullfile(fgDir,fgF{hemisphere}));
        [~,ik] = sort(cat(2,fg.datenum),2,'ascend');
        fg = fg(ik);
        fg  = fgRead(fullfile(fgDir,fg(1).name));
        
        % pick up waypoint roi for each hemsphere
        ROIname = {'Lh_NOT1201.mat','Rh_NOT1201.mat'};
        ROIf = fullfile(roiDir, ROIname{hemisphere});
        ROI = dtiReadRoi(ROIf);
        
        % dtiIntersectFibers
        [fgOut1,~, keep1, ~] = dtiIntersectFibersWithRoi([], 'not', [], ROI, fg);
        keep = ~keep1;
        for l =1:length(fgOut1.params)
            fgOut1.params{1,l}.stat=fgOut1.params{1,l}.stat(keep);
        end
        fgOut1.pathwayInfo = fgOut1.pathwayInfo(keep);
        
        % save new fg.pdb file
        savefilename = sprintf('%s.pdb',fgOut1.name);
        mtrExportFibers(fgOut1,fullfile(fgDir,savefilename),[],[],[],2);
        
        
        %% AFQ_removeFiberOutliers
        % set distance from fiber core (super fiber)
        maxDist = 4; % sd
        maxLen = 4; % sd
        numNodes = 100;
        M = 'mean';
        count = 1;
        show = 1;
        
        [fgclean ,keep] =  AFQ_removeFiberOutliers(fgOut1,maxDist,maxLen,numNodes,M,count,show);
        
        for l =1:length(fgclean.params)
            fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep);
        end
        fgclean.pathwayInfo = fgclean.pathwayInfo(keep);
        
        % Align fiber direction from Anterior to posterior
        fgclean = SO_AlignFiberDirection(fgclean,'AP');
        
        % save new fg.pdb file
        switch hemisphere
            case {1}
                fibername       = sprintf('ROR_%dL%d.pdb',maxDist,maxLen);
            case {2}
                fibername       = sprintf('LOR_%dL%d.pdb',maxDist,maxLen);
        end
        mtrExportFibers(fgclean,fullfile(fgDir,fibername),[],[],[],2);
    end
end
% %% check fg look
% for i =id
%     SubDir = fullfile(homeDir,subDir{i});
%     %     fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
%     newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
%     %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
%     %     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
%
%     cd(newDir)
%     % get .pdb filename
%     ORf = dir('*_D4_L4.pdb');
%     %      ORf = dir('*_D5_L4.pdb');
%     figure; hold on;
%     for ij = 1:2
%
%         fg = fgRead(ORf(ij).name);
%         AFQ_RenderFibers(fg,'numfibers',50,'newfig',0);
%     end
%     hold off;
%     camlight 'headlight'
% end


% %% Copy generated fg to fiberDirectory for AFQ analysis
%
% for i =id
%     SubDir = fullfile(homeDir,subDir{i});
%     fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
%
%     % get .pdb filename
%     LORf = dir(fullfile(fgDir,'*Lt-LGN4*_D4_L4.pdb'));
%     RORf = dir(fullfile(fgDir,'*Rt-LGN4*_D4_L4.pdb'));
%
%     %      ORf = dir('*_D5_L4.pdb');
%     %     for ij = 1:2
%     %         cd(newDir)
%     fgL = fgRead(LORf.name);
%     fgR = fgRead(RORf.name);
%
%     fgL.name = 'LOR1206_D4L4';
%     fgR.name = 'ROR1206_D4L4';
%     %         fgWrite(fgL,[fgL.name ,'.pdb'],'.pdb')
%     mtrExportFibers(fgL, fullfile(fgDir,fgL.name), [], [], [], 2);
%     mtrExportFibers(fgR, fullfile(fgDir,fgR.name), [], [], [], 2);
%     %         fgWrite(fgR,'ROR1206_D4L4.pdb','.pdb')
%     %     end
% end

%% measure diffusion properties
% see runSO_DivideFibersAcordingToFiberLength_3SD

% %% AFQ_removeFiberOutliers
% for i =id
%     SubDir = fullfile(homeDir,subDir{i});
%     fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
%
%     % get .pdb filename
%     ORf(1) = dir(fullfile(fgDir,'*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4*NOT1201.pdb'));
%     ORf(2) = dir(fullfile(fgDir,'*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt-LGN4*NOT1201.pdb'));
%
%     for ij = 1:2
%         fg = fgRead(fullfile(fgDir,ORf(ij).name));
%
%         % remove outlier fiber
%         maxDist =4;
%         maxLen = 2;
%         numNodes = 50;
%         M = 'mean';
%         count = 1;
%         show = 1;
%
%         [fgclean ,keep] =  AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);
%
%         for l =1:length(fgclean.params)
%             fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep);
%         end
%         fgclean.pathwayInfo = fgclean.pathwayInfo(keep);
%
%         % Align fiber direction from Anterior to posterior
%         fgclean = SO_AlignFiberDirection(fgclean,'AP');
%
%         % save new fg.pdb file
%         fibername       = sprintf('%s_D4L2.pdb',fgclean.name);
%         mtrExportFibers(fgclean,fullfile(fgDir,fibername),[],[],[],2);
%
%         %         %% to save the pdb file.
%         %         cd(newDir)
%         %         fibername       = sprintf('%s_D4_L2.pdb',fgclean.name);
%         %         mtrExportFibers(fgclean,fibername,[],[],[],2);
%
%         %         end
%     end
% end
% %% check fg look
% for i =id
%     SubDir = fullfile(homeDir,subDir{i});
%     %     fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
%     newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
%     %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
%     %     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
%
%     cd(newDir)
%     % get .pdb filename
%     ORf = dir('*_D4_L2.pdb');
%     %      ORf = dir('*_D5_L4.pdb');
%     figure; hold on;
%     for ij = 1:2
%
%         fg = fgRead(ORf(ij).name);
%         AFQ_RenderFibers(fg,'numfibers',50,'newfig',0);
%     end
%     hold off;
%     camlight 'headlight'
% end
