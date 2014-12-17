function SO_ORPipeline_V13mm_clipped_LGN4mm_1201_Tama3(id,ROI,show)
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
            dtiWriteRoi(newROI,fullfile(roiDir,newROI.name),1)
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
        roi = dtiReadRoi(ROIf);
        
        % dtiIntersectFibers
        [fgOut1,~, keep1, ~] = dtiIntersectFibersWithRoi([], 'not', [], roi, fg);
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
                fibername       = sprintf('ROR_D%dL%d.pdb',maxDist,maxLen);
            case {2}
                fibername       = sprintf('LOR_D%dL%d.pdb',maxDist,maxLen);
        end
        mtrExportFibers(fgclean,fullfile(fgDir,fibername),[],[],[],2);
    end
end
%% check fiber shapes
if show,
    for i =id
        SubDir = fullfile(homeDir,subDir{i});
        fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
        %     newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
        %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
        dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd/dt6.mat');
        
        % get .pdb filename
        ORf = dir(fullfile(fgDir,'*_D4L4.pdb'));
        % render fibers
        figure; hold on;
        for ij = 1:2
            fg = fgRead(ORf(ij).name);
            AFQ_RenderFibers(fg,'numfibers',50,'newfig',0);
        end
        dt6 = dtiLoadDt6(dtDir);
        t1 = niftiRead(dt6.files.t1);
        AFQ_AddImageTo3dPlot(t1,[0 0 -10]);
        axis image
        hold off;
        camlight 'headlight'
    end
    clear fg, clear t1, clear ORf;
end

