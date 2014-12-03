function SO_ORPipeline_V13mm_clipped_LGN4mm_ID(id,ROI)
% this pipeline make raw optic fibers clean.
% Exclude fibers 
% 1) by anotomical location (waypoint roi)
% 2) distance from fiber core (AFQ_removefiberoutliers)  
% 
% Input
% id  = subject number of tamagawa sbuject list. See Tama_subj
% If you need to create waypoint ROI 
% ROI = 1 or true.   See also SO_GetROIs
%
% See also runSO_DivideFibersAcordingToFiberLength_percentile_Tama2


%% Set directory
[homeDir,subDir] = Tama_subj;

%% make new directory
if ROI==true;
%     for i = id
%         
%         SubDir = fullfile(homeDir,subDir{i});
%         
%         mkdir(fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130'))
%         
%     end
    
    % make NOT ROI
    for i = id
        SubDir = fullfile(homeDir,subDir{i});
        roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
        cd(roiDir)
        
        % ROI file names you want to merge
        for hemisphere = 1:2
           
            switch(hemisphere)
                case  1 % Left-WhiteMatter
                    roiname = {...'Brain-Stem',...
                        'Right-Cerebellum-White-Matter'
                        'Right-Cerebellum-Cortex'
                        'Left-Cerebellum-White-Matter'
                        'Left-Cerebellum-Cortex'
                        'Left-Hippocampus'
                        'Right-Hippocampus'
                        'Left-Lateral-Ventricle'
                        'Right-Lateral-Ventricle'
                        'Left-Cerebral-White-Matter'};
                    %                         'Right-Cerebral-Cortex_V13mm_setdiff.mat'};
                case 2 % Right-WhiteMatter
                    roiname = {...'Brain-Stem',...
                        'Right-Cerebellum-White-Matter'
                        'Right-Cerebellum-Cortex'
                        'Left-Cerebellum-White-Matter'
                        'Left-Cerebellum-Cortex'
                        'Left-Hippocampus'
                        'Right-Hippocampus'
                        'Left-Lateral-Ventricle'
                        'Right-Lateral-Ventricle'
                        'Right-Cerebral-White-Matter'};
                    %                         'Left-Cerebral-Cortex_V13mm_setdiff.mat'};
            end
           
            
            % load all ROIs
            for j = 1:length(roiname)
                roi{j} = dtiReadRoi(roiname{j});
                
                % make sure ROI
                if 1 == isempty(roi{j}.coords)
                    disp(roi{j}.name)
                    disp('number of corrds = 0')
%                     return
                end
            end
            
            % Merge ROI one by one
            newROI = roi{1,1};
            for kk=2:length(roiname)
                newROI = dtiMergeROIs(newROI,roi{1,kk});
            end
            
            % Save the new NOT ROI
            % define file name
            
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
    %     newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
    %     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    % ROI file names you want to merge
    for hemisphere = 1:2        
        % Intersect raw OR with Not ROIs
%         cd(fgDir)
        %         if i<25
        %         fgF = {'*_Rt-LGN4_rh_V1_smooth3mm_NOT_2013*.pdb'
        %             '*_Lt-LGN4_lh_V1_smooth3mm_NOT_2013*.pdb'};
        %         else
        fgF = {'*_Rt-LGN4_rh_V1_smooth3mm_NOT_*.pdb'
            '*_Lt-LGN4_lh_V1_smooth3mm_NOT_*.pdb'};
        %         end;
        
        % load fg and ROI
        fg  = dir(fullfile(fgDir,fgF{hemisphere}));
        [~,ik] = sort(cat(2,fg.datenum),2,'ascend');
        fg = fg(ik);
        fg  = fgRead(fullfile(fgDir,fg(1).name));
        
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
    end
end
%% AFQ_removeFiberOutliers
for i =id
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
    %     newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
    %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    %     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    cd(fgDir)
    % get .pdb filename
    ORf(1) = dir(fullfile(fgDir,'*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4*NOT1201.pdb'));
    ORf(2) = dir(fullfile(fgDir,'*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt-LGN4*NOT1201.pdb'));
  
    for ij = 1:2
        fg = fgRead(ORf(ij).name);
        
        % remove outlier fiber
        %         for k=4; % max distance
%         cd(fgDir)
        
        maxDist = 4;
        maxLen = 4;
        numNodes = 25;
        M = 'mean';
        count = 1;
        show = 1;
        
        [fgclean ,keep] =  AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);
        
        for l =1:length(fgclean.params)
            fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep);
        end
        fgclean.pathwayInfo = fgclean.pathwayInfo(keep);
        
        % Align fiber direction from Anterior to posterior
        fgclean = SO_AlignFiberDirection(fgclean,'AP');
        
        % save new fg.pdb file
        fibername       = sprintf('%s_MD%d.pdb',fgclean.name,maxDist);
        mtrExportFibers(fgclean,fullfile(fgDir,fibername),[],[],[],2);
        
%         %% to save the pdb file.
%         cd(newDir)
%         fibername       = sprintf('%s_D%d_L4.pdb',fgclean.name,maxDist);
%         mtrExportFibers(fgclean,fibername,[],[],[],2);
        
        %         end
    end
    %     end
    clear ORf
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


%% Copy generated fg to fiberDirectory for AFQ analysis

for i =id
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');

    % get .pdb filename
    LORf = dir(fullfile(fgDir,'*Lt-LGN4*_MD4.pdb'));
    RORf = dir(fullfile(fgDir,'*Rt-LGN4*_MD4.pdb'));
    
    %      ORf = dir('*_D5_L4.pdb');
    %     for ij = 1:2
    %         cd(newDir)
    fgL = fgRead(fullfile(fgDir,LORf.name));
    fgR = fgRead(fullfile(fgDir,RORf.name));
    
    fgL.name = 'LOR1206_D4L4';
    fgR.name = 'ROR1206_D4L4';
    %         fgWrite(fgL,[fgL.name ,'.pdb'],'.pdb')
    mtrExportFibers(fgL, fullfile(fgDir,fgL.name), [], [], [], 2);
    mtrExportFibers(fgR, fullfile(fgDir,fgR.name), [], [], [], 2);
    %         fgWrite(fgR,'ROR1206_D4L4.pdb','.pdb')
    %     end
end

%% measure diffusion properties
% see runSO_DivideFibersAcordingToFiberLength_3SD

%% AFQ_removeFiberOutliers
for i =id
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
    
    % get .pdb filename
    ORf(1) = dir(fullfile(fgDir,'*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4*NOT1201.pdb'));
    ORf(2) = dir(fullfile(fgDir,'*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt-LGN4*NOT1201.pdb'));
    
    for ij = 1:2
        fg = fgRead(fullfile(fgDir,ORf(ij).name));
        
        % remove outlier fiber        
        maxDist =4;
        maxLen = 2;
        numNodes = 50;
        M = 'mean';
        count = 1;
        show = 1;
        
        [fgclean ,keep] =  AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);
        
        for l =1:length(fgclean.params)
            fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep);
        end
        fgclean.pathwayInfo = fgclean.pathwayInfo(keep);
        
        % Align fiber direction from Anterior to posterior
        fgclean = SO_AlignFiberDirection(fgclean,'AP');
        
        % save new fg.pdb file
        fibername       = sprintf('%s_D4L2.pdb',fgclean.name);
        mtrExportFibers(fgclean,fullfile(fgDir,fibername),[],[],[],2);
        
%         %% to save the pdb file.
%         cd(newDir)
%         fibername       = sprintf('%s_D4_L2.pdb',fgclean.name);
%         mtrExportFibers(fgclean,fibername,[],[],[],2);
        
        %         end
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
