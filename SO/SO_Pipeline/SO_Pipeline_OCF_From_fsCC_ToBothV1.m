function SO_Pipeline_OCF_From_fsCC_ToBothV1
% for after generated OCF tract 
%
% 12/9/2013 SO wrote it.
%
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subDir = {...
%     'JMD1-MM-20121025-DWI'
%     'JMD2-KK-20121025-DWI'
%     'JMD3-AK-20121026-DWI'
%     'JMD4-AM-20121026-DWI'
%     'JMD5-KK-20121220-DWI'
%     'JMD6-NO-20121220-DWI'
%     'JMD7-YN-20130621-DWI'
%     'JMD8-HT-20130621-DWI'
%     'JMD9-TY-20130621-DWI'
%     'LHON1-TK-20121130-DWI'
%     'LHON2-SO-20121130-DWI'
%     'LHON3-TO-20121130-DWI'
%     'LHON4-GK-20121130-DWI'
%     'LHON5-HS-20121220-DWI'
%     'LHON6-SS-20121221-DWI'
%     'JMD-Ctl-MT-20121025-DWI'
%     'JMD-Ctl-SY-20130222DWI'
%     'JMD-Ctl-YM-20121025-DWI'
%     'JMD-Ctl-HH-20120907DWI'
%     'JMD-Ctl-HT-20120907-DWI'
%     'JMD-Ctl-FN-20130621-DWI'
%     'JMD-Ctl-AM-20130726-DWI'
%     'JMD-Ctl-SO-20130726-DWI'  
    'RP1-TT-2013-11-01'
    'RP2-KI-2013-11-01'
    'RP3-TO-13120611-DWI'};

%% dtiIntersectFibers
for i = 2:length(subDir)
    % INPUTS
    SubDir=fullfile(homeDir,subDir{i});
    fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsCC_V1V2_3mm'));
    
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    for k=1:2
        % load roi
        cd(roiDir)
        ROI = {'Right-Cerebral-White-Matter.mat','Left-Cerebral-White-Matter.mat'};
        roi = dtiReadRoi(ROI{k});
        
        cd(fgDir)
        % load fg
        if k==1
            fgf = dir('fg_OCF_Top50K*lh*.pdb');
        else
            fgf = dir('fg_OCF_Top50K*rh*.pdb');
        end;
         [~,ik] = sort(cat(2,fgf.datenum),2,'ascend');
        fgf = fgf(ik);
        fg = fgRead(fgf(1).name);
        
        % remove Fibers don't go through CC using dtiIntersectFibers
        [fgOut,~,keep,~] = dtiIntersectFibersWithRoi([],'not',[],roi,fg);
        keep = ~keep;
        
        
%         AFQ_RenderFibers(fgOut, 'newfig', [1],'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg
%         AFQ_RenderFibers(fg, 'newfig', [1],'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg

        
        % keep pathwayInfo and Params.stat to use contrack scoring
        for l = 1:length(fgOut.params)
            fgOut.params{1,l}.stat=fgOut.params{1,l}.stat(keep);
        end
        fgOut.pathwayInfo = fgOut.pathwayInfo(keep);
        
        fgOutname = sprintf('%s.pdb',fgOut.name);
        mtrExportFibers(fgOut, fgOutname,[],[],[],2)
    end
end


%% AFQ_removeoutlier
for i = 2:length(subDir)
    % INPUTS
    SubDir=fullfile(homeDir,subDir{i});
%     fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_FromfsCC_To_Both_V1V2_3mm'));
    fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsCC_V1V2_3mm')); % for RP subject
    
%     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    cd(fgDir)
    
    % load fg
    fgf(1) = dir('fg_OCF_Top50K*Right-Cerebral-White-Matter.pdb');
    fgf(2) = dir('fg_OCF_Top50K*Left-Cerebral-White-Matter.pdb');

    for k=1:2 
        cd(fgDir)
        fg = fgRead(fgf(k).name);
        % run AFQ_removeoutlier
        [fgclean, keep2]=AFQ_removeFiberOutliers(fg,4,4,25,'mean',1, 5,[]);
        
        % keep pathwayInfo and Params.stat for contrack scoring
        for l = 1:length(fgclean.params)
            fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep2);
        end
        fgclean.pathwayInfo = fgclean.pathwayInfo(keep2);
        
        % correct fiber direction
        fgclean = SO_AlignFiberDirection(fgclean, 'AP');
        
        % save the new fg in same directory
        fgclean.name = sprintf('%s_AFQ_D4_L4.pdb',fgclean.name);
        mtrExportFibers(fgclean, fgclean.name,[],[],[],2)
        
        % Save fiber in the /fiber/ directory for afq
        cd(fullfile(SubDir,'/dwi_2nd/fibers'))
        switch k 
            case 1
                name = 'LOCF_D4L4.pdb';
            case 2
                name = 'ROCF_D4L4.pdb';
        end;
        mtrExportFibers(fgclean, name,[],[],[],2)
    end
    
end

% %% Check fibers
% 
% for i = 1:length(subDir)
%     % INPUTS
%     SubDir=fullfile(homeDir,subDir{i});
%     fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_FromfsCC_To_Both_V1V2_3mm'));
%     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
%     cd(fgDir)
%     
%     % load fg
%     fgf = dir('fg_OCF_Top50K*_AFQ_D4_L4.pdb');
%     % k==1, lh; K ==2, rh
%         
%         fg = fgRead(fgf(1).name);
%         
%         % to render both OCF in one figure
%             AFQ_RenderFibers(fg, 'newfig', [1],'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg
%             fg = fgRead(fgf(2).name);
%             
%             % title('JMD','FontSize',12,'FontName','Times');
%             AFQ_RenderFibers(fg, 'newfig', [0],'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg
%             
% end
%         

        


