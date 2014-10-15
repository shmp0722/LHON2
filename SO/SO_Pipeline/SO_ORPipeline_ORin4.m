function SO_ORPipeline_ORin4
%
% We already devided OR in four tracts based on four V1 provided by V1RoiPolEcc.
% So let's clean up tracts

%% Set directory
[homeDir,subDir,JMD,CRD,LHON,Ctl,RP] = Tama_subj2;

%% dtiIntersectFibersWithRoi
for i = 1:length(subDir)
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_in4');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    %     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    % ROI file names you want to merge
    for hemisphere = 1:2
        % Intersect raw OR with Not ROIs
        cd(fgDir)
        
        fgF = {'*Rt-LGN4*.pdb'
            '*Lt-LGN4*.pdb'};
        
        % load fg and ROI
        fg  = dir(fullfile(fgDir,fgF{hemisphere}));
        [~,ik] = sort(cat(2,fg.datenum),2,'ascend');
        fg = fg(ik);        
        
        for j = 1:4% length(fg)
            Fgs  = fgRead(fg(j).name);
            
            ROIname = {'Lh_NOT1201.mat','Rh_NOT1201.mat'};
            ROIf = fullfile(roiDir, ROIname{hemisphere});
            ROI = dtiReadRoi(ROIf);
            
            % dtiIntersectFibers
            [fgOut1,~, keep1, ~] = dtiIntersectFibersWithRoi([], 'not', [], ROI, Fgs);
            keep = ~keep1;
            for l =1:length(fgOut1.params)
                fgOut1.params{1,l}.stat=fgOut1.params{1,l}.stat(keep);
            end
            fgOut1.pathwayInfo = fgOut1.pathwayInfo(keep);       
            
            %% AFQ_removefiberOutlier
            maxDist = 4;
            maxLen = 2;
            numNodes = 50;
            M = 'mean';
            count = 1;
            show = 0;
            
            [fgclean ,keep] =  AFQ_removeFiberOutliers(fgOut1,maxDist,maxLen,numNodes,M,count,show);
            
            for l =1:length(fgclean.params)
                fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep);
            end
            fgclean.pathwayInfo = fgclean.pathwayInfo(keep);
            
            % Align fiber direction from Anterior to posterior
            fgclean = SO_AlignFiberDirection(fgclean,'AP');
                       
            %% to save the pdb file.
            fibername       = sprintf('%s_D%dL2.pdb',fgclean.name,maxDist);
            mtrExportFibers(fgclean,fibername,[],[],[],2);
            
        end
    end
end
% return 

%% to get diffusivities
Analyze_OR4



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
%     ORf{1} = dir('*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4*-Lh_NOT1201.pdb');
%     ORf{2} = dir('*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt-LGN4*-Rh_NOT1201.pdb');
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



%% measure diffusion properties
% see runSO_DivideFibersAcordingToFiberLength_3SD

%% check fascicles shape

for i =1:length(subDir)
    SubDir = fullfile(homeDir,subDir{i});
%     fgDir  = fullfile(SubDir,'/dwi_2nd/fibers');
    newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/Out30degree');
    %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
%         dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');

    cd(newDir)
    % get .pdb filename
    LORf = dir('*Lt-LGN4*_D4L4.pdb');
    RORf = dir('*Rt-LGN4*_D4L4.pdb');

    %      ORf = dir('*_D5_L4.pdb');
    %     for ij = 1:2
    %         cd(newDir)
    fgL = fgRead(LORf.name);
    fgR = fgRead(RORf.name);

    % Render fascicles
    figure; hold on;
    AFQ_RenderFibers(fgL, 'numfibers',100,'newfig',0)
    AFQ_RenderFibers(fgR, 'numfibers',100,'newfig',0)
    camlight 'headlight';
    axis image
    axis off;

end


% %% check fg look
% for i =1:length(subDir)
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
