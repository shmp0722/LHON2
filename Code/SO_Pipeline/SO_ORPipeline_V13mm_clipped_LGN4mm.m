function SO_ORPipeline_V13mm_clipped_LGN4mm

%% MergeROis_NOTROI.m
% merge ROIs to create Big NOT ROI.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ctl HT does not have cerebellum segmentation file!
% If you want to creat ROI which include cerebelum,
% You should exclude HT, and create HT's ROI by hand.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subDir = {...
        'JMD1-MM-20121025-DWI'
        'JMD2-KK-20121025-DWI'
        'JMD3-AK-20121026-DWI'
        'JMD4-AM-20121026-DWI'
        'JMD5-KK-20121220-DWI'
        'JMD6-NO-20121220-DWI'
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
        'JMD-Ctl-SY-20130222DWI'
        'JMD-Ctl-YM-20121025-DWI'
        'JMD-Ctl-HH-20120907DWI'
        'JMD-Ctl-FN-20130621-DWI'
        'JMD-Ctl-AM-20130726-DWI'
        'JMD-Ctl-HT-20120907-DWI'
        'JMD-Ctl-SO-20130726-DWI'
    'RP1-TT-2013-11-01'
    'RP2-KI-2013-11-01'
    };

% %% make new directory
% for i = 1:length(subDir)
%     
%     SubDir = fullfile(homeDir,subDir{i});
%     
%     mkdir(fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130'))
%          
% end

% %% make NOT ROI
% for i = 1:length(subDir)
%     SubDir = fullfile(homeDir,subDir{i});
%     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
%     cd(roiDir)
%     
%     % ROI file names you want to merge
%     for hemisphere = 1:2
%         if i<22
%             switch(hemisphere)
%                 case  1 % Left-WhiteMatter
%                     roiname = {...'Brain-Stem',...
%                         'Right-Cerebellum-White-Matter'
%                         'Right-Cerebellum-Cortex'
%                         'Left-Cerebellum-White-Matter'
%                         'Left-Cerebellum-Cortex'
%                         'Left-Hippocampus'
%                         'Right-Hippocampus'
%                         'Left-Lateral-Ventricle'
%                         'Right-Lateral-Ventricle'
%                         'Left-Cerebral-White-Matter'
%                         'Right-Cerebral-Cortex_V13mm_setdiff.mat'};
%                 case 2 % Right-WhiteMatter
%                     roiname = {...'Brain-Stem',...
%                         'Right-Cerebellum-White-Matter'
%                         'Right-Cerebellum-Cortex'
%                         'Left-Cerebellum-White-Matter'
%                         'Left-Cerebellum-Cortex'
%                         'Left-Hippocampus'
%                         'Right-Hippocampus'
%                         'Left-Lateral-Ventricle'
%                         'Right-Lateral-Ventricle'
%                         'Right-Cerebral-White-Matter'
%                         'Left-Cerebral-Cortex_V13mm_setdiff.mat'};
%             end
%         else i = 22;
%             switch(hemisphere)
%                 case  1 % Left-WhiteMatter
%                     roiname = {...'Brain-Stem',...
%                         ...'Right-Cerebellum-White-Matter','Right-Cerebellum-Cortex',...
%                         ...'Left-Cerebellum-White-Matter','Left-Cerebellum-Cortex',...
%                         'Left-Hippocampus'
%                         'Right-Hippocampus'
%                         'Left-Lateral-Ventricle'
%                         'Right-Lateral-Ventricle'
%                         'Left-Cerebral-White-Matter'
%                         'Right-Cerebral-Cortex_V13mm_setdiff.mat'};
%                 case 2 % Right-WhiteMatter
%                     roiname = {...'Brain-Stem',HippoWmCerebellumVentricle...
%                         ...'Right-Cerebellum-White-Matter','Right-Cerebellum-Cortex',...
%                         ...'Left-Cerebellum-White-Matter','Left-Cerebellum-Cortex',...
%                         'Left-Hippocampus'
%                         'Right-Hippocampus'
%                         'Left-Lateral-Ventricle'
%                         'Right-Lateral-Ventricle'
%                         'Right-Cerebral-White-Matter'
%                         'Left-Cerebral-Cortex_V13mm_setdiff.mat'};
%             end
%         end
%         
%         % load all ROIs
%         for j = 1:length(roiname)
%             roi{j} = dtiReadRoi(roiname{j});
%             
%             % make sure ROI
%             if 1 == isempty(roi{j}.coords)
%                 disp(roi{j}.name)
%                 disp('number of corrds = 0')
%                 return
%             end
%         end
%         
%         % Merge ROI one by one
%         newROI = roi{1,1};
%         for kk=2:length(roiname)
%             newROI = dtiMergeROIs(newROI,roi{1,kk});
%         end
%         
%         % Save the new NOT ROI
%         % define file name
%         
%         switch(hemisphere)
%             case 1 % Left-WhiteMatter
%                 newROI.name = 'Lh_NOT0711';
%             case 2 % Right-WhiteMatter
%                 newROI.name = 'Rh_NOT0711';
%         end
%         % Save Roi
%         dtiWriteRoi(newROI,newROI.name,1)
%     end
% end


%% dtiIntersectFibers
for i = 24:length(subDir)
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
%     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    % ROI file names you want to merge
    for hemisphere = 1:2
        
        % Intersect raw OR with Not ROIs
        cd(fgDir)
        
        fgF = {'*_Rt-LGN4_rh_V1_smooth3mm_NOT*_NOT0711.pdb'
            '*_Lt-LGN4_lh_V1_smooth3mm_NOT*_NOT0711.pdb'};
        
        
        % load fg and ROI
        fg  = dir(fullfile(fgDir,fgF{hemisphere}));
%          sort(fg.)
        fg  = fgRead(fg.name);
        
        ROIname = {'Lh_NOT0711.mat','Rh_NOT0711.mat'};
        ROIf = fullfile(roiDir, ROIname{hemisphere});
        ROI = dtiReadRoi(ROIf);
        
        % dtiIntersectFibers
        [fgOut1,~, keep1, ~] = dtiIntersectFibersWithRoi([], 'not', [], ROI, fg);
        keep = ~keep1;
        for l =1:length(fgOut1.params)
            fgOut1.params{1,l}.stat=fgOut1.params{1,l}.stat(keep);
        end
        fgOut1.pathwayInfo = fgOut1.pathwayInfo(keep);
        
        % correct fiber direction anterior to posteror
         for kk =1:length(fgOut1.fibers)
            if fgOut1.fibers{kk}(2,1)<fgOut1.fibers{kk}(2,end);
                fgOut1.fibers(kk) = fliplr(fgOut1.fibers(kk));end
        end
        
        
        % save new fg.pdb file
        cd(newDir)
        savefilename = sprintf('%s.pdb',fgOut1.name);
        mtrExportFibers(fgOut1,savefilename,[],[],[],2);
    end
end

% %% conTrack scoring
% for i =23:length(subDir)
%     SubDir = fullfile(homeDir,subDir{i});
%     fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
%     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
%     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
%
%     cd(fgDir)
%
%     % Set number of fibers you want
%     nFiber = round(length(fgOut1.fibers)*0.7);
%     %15578;%5236;%10342;%round(length(fgOut1.fibers)*0.7);
%
%     % get .txt and .pdb filename
%     ORf{1} = dir('*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4*-Lh_NOT0711.pdb');
%     ORf{2} = dir('*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt-LGN4*-Rh_NOT0711.pdb');
%     for j = 1:2
%         tmp = strfind(ORf{j}.name, '_');
%         n = ORf{j}.name(tmp(1):tmp(14)-4);
%
%         dTxt = sprintf('%s/%s%s.txt',fgDir,'ctrSampler',n);
%         dPdb = sprintf('%s/%s',fgDir,ORf{j}.name);
%
%         % Set number of fibers you want
%         fg =fgRead(dPdb);
%         nFiber = round(length(fg.fibers)*0.7);
%         %15578;%5236;%10342;%round(length(fgOut1.fibers)*0.7);
%
%         % define filename for output fiber group
%         outputfibername = fullfile(fgDir, sprintf('%s_%d.pdb',ORf{j}.name(1:end-4),nFiber));
%
%         % make command to get 80% fibers for contrack
%         ContCommand = sprintf('contrack_score.glxa64 -i %s -p %s --thresh %d --sort %s', ...
%             dTxt, outputfibername, nFiber, dPdb);
%
%         % run contrack
%         system(ContCommand);
%     end
% end


%% AFQ_removeFiberOutliers
for i =25:length(subDir)
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
    newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
    %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    %     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    cd(fgDir)
    % get .pdb filename
    ORf{1} = dir('*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4*NOT0711.pdb');
    ORf{2} = dir('*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt-LGN4*NOT0711.pdb');
    
    for ij = 1:2
        cd(fgDir)
        fg = fgRead(ORf{ij}.name);
        
        % remove outlier fiber
        for k=4:5; % max distance
            cd(fgDir)

            maxDist = k;
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
            
            % save new fg.pdb file
            fibername       = sprintf('%s_MD%d.pdb',fgclean.name,maxDist);
            mtrExportFibers(fgclean,fibername,[],[],[],2);
            
            %% to save the pdb file.
            cd(newDir)
            fibername       = sprintf('%s_D%d_L4.pdb',fgclean.name,maxDist);
            mtrExportFibers(fgclean,fibername,[],[],[],2);
            
        end
    end
end
return

