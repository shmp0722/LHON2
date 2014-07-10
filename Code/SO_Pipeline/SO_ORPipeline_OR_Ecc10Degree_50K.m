function SO_ORPipeline_OR_Ecc10Degree_50K
%
%
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
    'RP3-TO-13120611-DWI'
    'LHON6-SS-20131206-DWI'
    'RP4-AK-2014-01-31'
     'RP5-KS-2014-01-31'
        };
% /biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI/dwi_2nd/fibers/conTrack/OR_Ecc10Degree_50K

% set id number
JMD = [1,3,5,6];
CRD = [2,4,7,8,9];
% LHON =10:15;
LHON =[10:14,27];

Ctl = 16:23;
% RP = 24:26;
RP = [24:26,28,29];
% Group_subject = {JMD,CRD,LHON,Ctl,RP,RP2};
Group_subject = {JMD,CRD,LHON,Ctl,RP};

% GroupName = {'JMD','CRD','LHON','Ctl','RP','RP2'};
GroupName = {'JMD','CRD','LHON','Ctl','RP'};

FiberName = {'LOR_center10','ROR_center10','LOR_peri10','ROR_peri10'};
diffusivityS = {'fa','md','ad','rd'};

%%
% %% make new directory
% for i = 1:length(subDir)
%     
%     SubDir = fullfile(homeDir,subDir{i});
%     fgDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_CenterPeri');
%     
%     if ~exist(fgDir);mkdir(fgDir);end;
% end



% %% make NOT ROI
% for i =1:length(subDir)
%     SubDir = fullfile(homeDir,subDir{i});
%     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
%     cd(roiDir)
%     
%     % ROI file names you want to merge
%     for hemisphere = 1:2
%         if  i == 22;
%             switch(hemisphere)
%                 case  1 % Left-WhiteMatter
%                     roiname = {...'Brain-Stem',...
%                         ...'Right-Cerebellum-White-Matter','Right-Cerebellum-Cortex',...
%                         ...'Left-Cerebellum-White-Matter','Left-Cerebellum-Cortex',...
%                         'Left-Hippocampus'
%                         'Right-Hippocampus'
%                         'Left-Lateral-Ventricle'
%                         'Right-Lateral-Ventricle'
%                         'Left-Cerebral-White-Matter'};
%                     %                         'Right-Cerebral-Cortex_V13mm_setdiff.mat'};
%                 case 2 % Right-WhiteMatter
%                     roiname = {...'Brain-Stem',HippoWmCerebellumVentricle...
%                         ...'Right-Cerebellum-White-Matter','Right-Cerebellum-Cortex',...
%                         ...'Left-Cerebellum-White-Matter','Left-Cerebellum-Cortex',...
%                         'Left-Hippocampus'
%                         'Right-Hippocampus'
%                         'Left-Lateral-Ventricle'
%                         'Right-Lateral-Ventricle'
%                         'Right-Cerebral-White-Matter'};
%                     %                         'Left-Cerebral-Cortex_V13mm_setdiff.mat'};
%             end
%         else
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
%                         'Left-Cerebral-White-Matter'};
%                     %                         'Right-Cerebral-Cortex_V13mm_setdiff.mat'};
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
%                         'Right-Cerebral-White-Matter'};
%                     %                         'Left-Cerebral-Cortex_V13mm_setdiff.mat'};
%             end
%             
%         end
%         
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
%                 newROI.name = 'Lh_NOT1201';
%             case 2 % Right-WhiteMatter
%                 newROI.name = 'Rh_NOT1201';
%         end
%         % Save Roi
%         dtiWriteRoi(newROI,newROI.name,1)
%     end
% end


%% dtiIntersectFibers
for i = 22:length(subDir) %22(HT) didn't work
    SubDir = fullfile(homeDir,subDir{i});
    fgDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Ecc10Degree_50K');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    %     newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
    %     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    
    cd(fgDir)
    fgF = {'*Rt-LGN4_rh_Peri10Degree*.pdb'
        '*Rt-LGN4_rh_10Degree*.pdb'
        '*Lt-LGN4_lh_Peri10Degree*.pdb'
        '*Lt-LGN4_lh_10Degree*.pdb'};
    % ROI file names you want to merge
    for j = 1:length(fgF)
        
        % Intersect raw OR with Not ROIs
        
        % load fg and ROI
        fg  = dir(fullfile(fgDir,fgF{j}));
        [~,ik] = sort(cat(2,fg.datenum),2,'ascend');
        fg = fg(ik);
%         for k = 1:2
            fg_cur  = fgRead(fg(1).name);
            
            ROIname = {'Lh_NOT1201.mat','Rh_NOT1201.mat'};
            if j<=2; ROIf = fullfile(roiDir, ROIname{1});
            else  ROIf = fullfile(roiDir, ROIname{2});end;
            ROI = dtiReadRoi(ROIf);
            
            % dtiIntersectFibers
            [fgOut1,~, keep1, ~] = dtiIntersectFibersWithRoi([], 'not', [], ROI, fg_cur);
            keep = ~keep1;
            for l =1:length(fgOut1.params)
                fgOut1.params{1,l}.stat=fgOut1.params{1,l}.stat(keep);
            end
            fgOut1.pathwayInfo = fgOut1.pathwayInfo(keep);
            
            % if you want to check the fiber looks like
            %              AFQ_RenderFibers(fgOut1,'numfibers',100)
            
            % save new fg.pdb file
            
            savefilename = sprintf('%s.pdb',fgOut1.name);
            mtrExportFibers(fgOut1,savefilename,[],[],[],2);
%         end
    end
end


%% AFQ_removeFiberOutliers
for i =22%1 :length(subDir)
    SubDir = fullfile(homeDir,subDir{i});
    fgDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Ecc10Degree_50K');
    %     newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
    %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    %     dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    cd(fgDir)
    % get .pdb filename
    ORf_C = dir('*NOT1201.pdb');
    %     ORf{2} = dir('*_Lt-LGN4*NOT1201.pdb');
    
    %% Remove outlier fibers
    for ij = 1:length(ORf_C)
        %         cd(fgDir)
        fg = fgRead(ORf_C(ij).name);
        
        % remove outlier fiber
        for k=4; % max distance
            for j = [2,4] % max length
                %                 cd(fgDir)
                
                maxDist = k;
                maxLen = j;
                numNodes = 100;
                M = 'mean';
                count = 1;
                show = 1;
                
                [fgclean ,keep] =  AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);
                
                for l =1:length(fgclean.params)
                    fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep);
                end
                fgclean.pathwayInfo = fgclean.pathwayInfo(keep);OR_Ecc10Degree_50K
                
                % Align fiber direction from Anterior to posterior
                fgclean = SO_AlignFiberDirection(fgclean,'AP');
                
                % save new fg.pdb file
                fibername       = sprintf('%s_D%dL%d.pdb',fgclean.name,maxDist,maxLen);
                mtrExportFibers(fgclean,fibername,[],[],[],2);
                
                %             %% to save the pdb file.
                %             cd(newDir)
                %             fibername       = sprintf('%s_D%d_L4.pdb',fgclean.name,maxDist);
                %             mtrExportFibers(fgclean,fibername,[],[],[],2);
            end
        end
    end
end


return


%% calculate TP
% for i = 1:length(subDir)    
%     for j = 1:4
%         TP{i,j} = AFQ_CreateTractProfile;
%     end
% end

%
for i =1:length(subDir)
    SubDir = fullfile(homeDir,subDir{i});
    
    newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Ecc10Degree_50K');
    %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    dt =dtiLoadDt6(fullfile(dtDir,'dt6.mat'));
    
    cd(newDir)
    % get .pdb filename
    ORf_CL = dir('*Lt-LGN4_lh_10Degree_ecc*_D4L4.pdb');
    ORf_CR = dir('*Rt-LGN4_rh_10Degree_ecc*_D4L4.pdb');
    ORf_PL = dir('*Lt-LGN4_lh_Peri10Degree*_D4L4.pdb');
    ORf_PR = dir('*Rt-LGN4_rh_Peri10Degree*_D4L4.pdb');
    
    
    fgCL = fgRead(ORf_CL.name);
    fgCR = fgRead(ORf_CR.name);
    fgPL = fgRead(ORf_PL.name);
    fgPR = fgRead(ORf_PR.name);
    fg ={fgCL,fgCR,fgPL,fgPR};
    
    for j = 1:length(fg)
        TP{i,j} = SO_FiberValsInTractProfiles(fg{j},dt,'AP',100,1);
    end
   
end

%% check the fascicles looks like
for i =RP%1:length(subDir)
    SubDir = fullfile(homeDir,subDir{i});
    
    newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Ecc10Degree_50K');
    %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    dtDir  = fullfile(homeDir,subDir{i},'dwi_2nd');
    
    dt =dtiLoadDt6(fullfile(dtDir,'dt6.mat'));
    
    cd(newDir)
%     % get .pdb filename
%     ORf_CL = dir('*Lt-LGN4_lh_10Degree_ecc*_D4L4.pdb');
%     ORf_CR = dir('*Rt-LGN4_rh_10Degree_ecc*_D4L4.pdb');
%     ORf_PL = dir('*Lt-LGN4_lh_Peri10Degree*_D4L4.pdb');
%     ORf_PR = dir('*Rt-LGN4_rh_Peri10Degree*_D4L4.pdb');
    
     % get .pdb filename
    ORf_CL = dir('*Lt-LGN4_lh_10Degree_ecc*_D4L2.pdb');
    ORf_CR = dir('*Rt-LGN4_rh_10Degree_ecc*_D4L2.pdb');
    ORf_PL = dir('*Lt-LGN4_lh_Peri10Degree*_D4L2.pdb');
    ORf_PR = dir('*Rt-LGN4_rh_Peri10Degree*_D4L2.pdb');
    
    fgCL = fgRead(ORf_CL.name);
    fgCR = fgRead(ORf_CR.name);
    fgPL = fgRead(ORf_PL.name);
    fgPR = fgRead(ORf_PR.name);
    fg ={fgCL,fgCR,fgPL,fgPR};

    % render both the fascicles correspod to center visual field
%     figure; hold on;
%     AFQ_RenderFibers(fg{1},'newfig', 0, 'numfibers', 50)
%     AFQ_RenderFibers(fg{2},'newfig', 0, 'numfibers', 50)
%     hold off;
    
    figure; hold on;
    AFQ_RenderFibers(fg{3},'newfig', 0, 'numfibers', 50)
    AFQ_RenderFibers(fg{4},'newfig', 0, 'numfibers', 50)
    hold off;
    
    % check fiber length distribution
%     [Lnorm Lmm]=AFQ_FiberLengthHist(fg{3}, 1);
%     keep =   Lnorm <= 2 & Lnorm >= -2;
%     fg_keep = dtiNewFiberGroup('fg_L2','b',[],[],fg{3}.fibers(logical(keep)));
%     fg_outlier = dtiNewFiberGroup('fg_outlier','b',[],[],fg{3}.fibers(logical(~keep)));
% 
%     AFQ_RenderFibers(fg_keep,'newfig', 0, 'numfibers', 50,'color', [0.5 0.5 0.5])
%     AFQ_RenderFibers(fg_outlier,'newfig', 0, 'numfibers', 50,'color', [1 0.5 0.5])

    
    % add roi
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    
    ROI = {'Lt-LGN4','Rt-LGN4','lh_10Degree_ecc.mat','rh_10Degree_ecc.mat',...
        'lh_Peri10Degree_ecc.mat','rh_Peri10Degree_ecc.mat'};
    
    for j = 1:length(ROI)
        AFQ_RenderRoi(fullfile(roiDir,ROI{j}));
    end
    
    camlight 'headlight' 
    axis image
end


%% save
cd /biac4/wandell/biac3/wandell7/shumpei/matlab/git/LHON/3RP

save TP_10Degree_L2 TP
return
%% Load
cd /biac4/wandell/biac3/wandell7/shumpei/matlab/git/LHON/3RP

load TP_10Degree_L2

%%


%% Render diffusion plots
for k = 1: length(diffusivityS);
    diffusivity = diffusivityS{k};
    for  j=1:length(FiberName);

        % make box
        fa = nan(length(subDir),100);
        md = nan(length(subDir),100);
        ad = nan(length(subDir),100);
        rd = nan(length(subDir),100);
        
        for i =1:length(subDir);
            fa(i,:) = TP{i,j}.vals.fa;
            md(i,:) = TP{i,j}.vals.md;
            ad(i,:) = TP{i,j}.vals.ad;
            rd(i,:) = TP{i,j}.vals.rd;
        end
        %% set plot's color
        c= jet(length(Group_subject));
        
        
        %% render group mean plot
        figure ;hold on;
        for i = 1: length(Group_subject)
            % number of subjects with measurements for this tract
            n  = sum(~isnan(fa(Group_subject{i},1)));
            switch diffusivity
                case 'fa'
                    % group mean diffusion profile
                    m = nanmean(fa(Group_subject{i},:));
                    % standard deviation at each node
                    sd = nanstd(fa(Group_subject{i},:));
                    % standard error of the mean at each node
                    se = sd./sqrt(n);
                case 'md'
                    % group mean diffusion profile
                    m = nanmean(md(Group_subject{i},:));
                    % standard deviation at each node
                    sd = nanstd(md(Group_subject{i},:));
                    % standard error of the mean at each node
                    se = sd./sqrt(n);
                case 'ad'
                    % group mean diffusion profile
                    m = nanmean(ad(Group_subject{i},:));
                    % standard deviation at each node
                    sd = nanstd(ad(Group_subject{i},:));
                    % standard error of the mean at each node
                    se = sd./sqrt(n);
                case 'rd'
                    % group mean diffusion profile
                    m = nanmean(rd(Group_subject{i},:));
                    % standard deviation at each node
                    sd = nanstd(rd(Group_subject{i},:));
                    % standard error of the mean at each node
                    se = sd./sqrt(n);
            end
            
            % plot the mean
            plot(m,'-','Color',c(i,:),'linewidth',3);
            %     % plot the confidence interval
            %     plot(m+se,'--','Color',c(i,:));
            %     plot(m-se,'--','Color',c(i,:));
            
        end
        legend(GroupName)
        title(sprintf('%s %s',FiberName{j},diffusivity))
        hold off;
        
        %% save the plot
        cd /biac4/wandell/biac3/wandell7/shumpei/matlab/git/LHON/3RP/Center_peri_groupcomparison/10Degree

        
        print(gcf,'-dpng',sprintf('%s_%s_10Degree',FiberName{j},diffusivity))
        
    end
end
return
close all

%% individual plot
diffusivity = 'fa';
group = LHON;
c = jet(length(subDir));
X = 1:100;
%% plot individual in the one patient group
figure; hold on;
for  i =group %1:length(subDir)
    %% choose the diffusivity
    
    switch diffusivity
        case 'fa'
            Y = fa(i,:);
            label = 'Fractional Anisotropy';
        case 'md'
            Y = md(i,:);
            label = 'Mead Diffusivity';
        case 'ad'
            Y = ad(i,:);
            label = 'Axial Diffusivity';
        case 'rd'
            Y = rd(i,:);
            label = 'Radial Diffusivity';
    end
    % render individual plot
    plot(X,Y,'Color',c(i,:))
end
% number of subjects with measurements for this tract
n  = sum(~isnan(fa(group,1)));
% group mean diffusion profile
m = nanmean(fa(group,:));
% standard deviation at each node
sd = nanstd(fa(group,:));
% standard error of the mean at each node
se = sd./sqrt(n);

% plot the mean
plot(m,'-','Color',[0.5 0.5 0.5],'linewidth',3);
% plot the confidence interval
plot(m+se,'--','Color',[0.5 0.5 0.5]);
plot(m-se,'--','Color',[0.5 0.5 0.5]);

hold off;


%% individual plot
diffusivity = 'fa';
group = LHON;
c = jet(length(subDir));
X = 1:100;

%%
j=1;
for i =1:length(subDir);
    fa(i,:) = TP{i,j}.vals.fa;
    md(i,:) = TP{i,j}.vals.md;
    ad(i,:) = TP{i,j}.vals.ad;
    rd(i,:) = TP{i,j}.vals.rd;
end

%% plot individual in the one patient group
figure; hold on;
for  i =[15 27]; %1:length(subDir)
    %% choose the diffusivity
    
    switch diffusivity
        case 'fa'
            Y = fa(i,:);
            label = 'Fractional Anisotropy';
        case 'md'
            Y = md(i,:);
            label = 'Mead Diffusivity';
        case 'ad'
            Y = ad(i,:);
            label = 'Axial Diffusivity';
        case 'rd'
            Y = rd(i,:);
            label = 'Radial Diffusivity';
    end
    % render individual plot
    plot(X,Y,'Color',c(i,:))
end
% number of subjects with measurements for this tract
n  = sum(~isnan(fa(group,1)));
% group mean diffusion profile
m = nanmean(fa(group,:));
% standard deviation at each node
sd = nanstd(fa(group,:));
% standard error of the mean at each node
se = sd./sqrt(n);

% plot the mean
plot(m,'-','Color',[0.5 0.5 0.5],'linewidth',3);
% plot the confidence interval
plot(m+se,'--','Color',[0.5 0.5 0.5]);
plot(m-se,'--','Color',[0.5 0.5 0.5]);

hold off;


%% scatter plot

scatter(50:80,TP)


