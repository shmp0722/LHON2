function SO_Pipeline_OT5K
% To get the Optic Tract is able to analyse.


homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subDir ={
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
    'JMD-Ctl-HT-20120907-DWI'
    'JMD-Ctl-FN-20130621-DWI'
    'JMD-Ctl-AM-20130726-DWI'
    'JMD-Ctl-SO-20130726-DWI'
    'RP1-TT-2013-11-01'
    'RP2-KI-2013-11-01'
    'RP3-TO-13120611-DWI'
    'LHON6-SS-20131206-DWI'
    'RP4-AK-2014-01-31'
    'RP5-KS-2014-01-31'
    'JMD3-AK-20140228-dMRI'
    'JMD-Ctl-09-RN-20130909'
    'JMD-Ctl-10-JN-20140205'
    'JMD-Ctl-11-MT-20140217'
    'RP6-SY-2014-02-28-dMRI'
    'Ctl-12-SA-20140307'
    'Ctl-13-MW-20140313-dMRI-Anatomy'
    'Ctl-14-YM-20140314-dMRI-Anatomy'
    'RP7-EU-2014-03-14-dMRI-Anatomy'
    'RP8-YT-2014-03-14-dMRI-Anatomy'
    };

%% dtiIntersectFibers
% exclude fibers using waypoint ROI
for i = 1:length(subDir)
    % INPUTS
    SubDir=fullfile(homeDir,subDir{i});
    fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    
    cd(fgDir)
    % load fg
    fgf = {'*fg_OT_5K_Optic-Chiasm_Lt-LGN4*.pdb'
        '*fg_OT_5K_Optic-Chiasm_Rt-LGN4*.pdb'};
    % way point ROI. Oposit side WM
    roif= {'Right-Cerebral-White-Matter','Left-Cerebral-White-Matter'};
    
    for j = 1:2
        % load roi
        cd(roiDir)
        roi = dtiReadRoi(roif{j});
        cd(fgDir)
        fgF = dir(fgf{j});
        fg = fgRead(fgF.name);
        
        % remove Fibers don't go through CC using dtiIntersectFibers
        [fgOut,~,keep,~] = dtiIntersectFibersWithRoi([],'not',[],roi,fg);
        
        % keep pathwayInfo and Params.stat to use contrack scoring
        keep = ~keep;
        for l = 1:length(fgOut.params)
            fgOut.params{1,l}.stat=fgOut.params{1,l}.stat(keep);
        end
        fgOut.pathwayInfo = fgOut.pathwayInfo(keep);
        
        fgOutname = sprintf('%s.pdb',fgOut.name);
        mtrExportFibers(fgOut, fgOutname,[],[],[],2)
    end
end

%% contrack scoring
for i =1:length(subDir)
    % INPUTS
    SubDir=fullfile(homeDir,subDir{i});
    fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    cd(fgDir)
    % load fg and calcurate nFiber
    fgf = {...
        '*fg_OT_5K_Optic-Chiasm_Lt-LGN4*Right-Cerebral-White-Matter.pdb'
        '*fg_OT_5K_Optic-Chiasm_Rt-LGN4*Left-Cerebral-White-Matter.pdb'};
    for j= 1:2
        fgF=dir(fgf{j});
        fg = fgRead(fgF.name);
        %         nFiber = round(length(fg.fibers)*0.7);
        nFiber=100;
        
        % get .txt and .pdb filename
        dTxtF = {'*ctrSampler_OT_5K_Optic-Chiasm_Lt-LGN4*.txt'
            '*ctrSampler_OT_5K_Optic-Chiasm_Rt-LGN4*.txt'};
        dTxt = dir(dTxtF{j});
        dPdb = fullfile(fgDir,fgF.name);
        
        % give filename to output f group
        outputfibername = fullfile(fgDir, sprintf('%s_Ctrk%d.pdb',fg.name,nFiber));
        
        % score the fibers to particular number
        ContCommand = sprintf('contrack_score.glxa64 -i %s -p %s --thresh %d --sort %s', ...
            dTxt(end).name, outputfibername, nFiber, dPdb);
        %         contrack_score.glxa64 -i ctrSampler.txt -p scoredFgOut_top5000.pdb --thresh 5000 --sort fgIn.pdb
        % run contrack
        system(ContCommand);
    end
end


%% AFQ_removeoutlier
for i = 1:length(subDir)
    % INPUTS
    SubDir=fullfile(homeDir,subDir{i});
    fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    cd(fgDir)
    % load fg and calcurate nFiber
    fgf = {...
        '*fg_OT_5K_Optic-Chiasm_Lt-LGN4*Right-Cerebral-White-Matter_Ctrk100.pdb'
        '*fg_OT_5K_Optic-Chiasm_Rt-LGN4*Left-Cerebral-White-Matter_Ctrk100.pdb'};
    for j= 1:2
        fgF = dir(fgf{j});
        fg  = fgRead(fgF.name);
        
        [fgclean, keep2]=AFQ_removeFiberOutliers(fg,4,4,25,'mean',1, 5,[]);
        % keep pathwayInfo and Params.stat for contrack scoring
        for l = 1:length(fgclean.params)
            fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep2);
        end
        fgclean.pathwayInfo = fgclean.pathwayInfo(keep2);
        fgclean.name = sprintf('%s_AFQ_%d.pdb',fgclean.name,length(fgclean.fibers));
        mtrExportFibers(fgclean, fgclean.name,[],[],[],2)
    end
end

%% SO_AlignFiberDirection
for i = 1:length(subDir)
    % INPUTS
    SubDir   = fullfile(homeDir,subDir{i});
    fgDir    = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
    fiberDir = fullfile(SubDir,'/dwi_2nd/fibers');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    cd(fgDir)
    % load fg and calcurate nFiber
    fgf = {...
        '*Lt-LGN4*Right-Cerebral-White-Matter_Ctrk100_AFQ*'
        '*Rt-LGN4*Left-Cerebral-White-Matter_Ctrk100_AFQ*'};
    fgN = {'LOTD4L4_1206','ROTD4L4_1206'};
    
    for j= 1:2
        cd(fgDir)
        
        fgF = dir(fgf{j});
        fg  = fgRead(fgF.name);
        fg = SO_AlignFiberDirection(fg,'AP');
        % AFQ_RenderFibers(fg,'numfibers',10)
        
        cd(fiberDir)
        fg.name = fgN{j};
        fgWrite(fg,[fg.name '.pdb'],'pdb')
    end
end

%% check generated OT shape
for i = 1:length(subDir)
    % INPUTS
    SubDir   = fullfile(homeDir,subDir{i});
    %     fgDir    = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
    fiberDir = fullfile(SubDir,'/dwi_2nd/fibers');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    %     cd(fgDir)
    % load fg and calcurate nFiber
    
    fgN = {'LOTD4L4_1206*','ROTD4L4_1206*'};
    
    % Render OT fig
    figure; hold on;
    for j= 1:2
        cd(fiberDir)
        
        fgF = dir(fgN{j});
        fg  = fgRead(fgF.name);
        AFQ_RenderFibers(fg,'numfibers',10,'newfig',0)
        
    end
    camlight 'headlight';
    axis off
    axis image
    hold off;
    
end

%% AFQ_removeoutlier
for i = 1:length(subDir)
    % INPUTS
    SubDir=fullfile(homeDir,subDir{i});
    fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    cd(fgDir)
    % load fg and calcurate nFiber
    fgf = {...
        '*fg_OT_5K_Optic-Chiasm_Lt-LGN4*Right-Cerebral-White-Matter_Ctrk100.pdb'
        '*fg_OT_5K_Optic-Chiasm_Rt-LGN4*Left-Cerebral-White-Matter_Ctrk100.pdb'};
    for j= 1:2
        fgF = dir(fgf{j});
        fg  = fgRead(fgF.name);
        
        [fgclean, keep2]=AFQ_removeFiberOutliers(fg,3,2,25,'mean',1, 5,[]);
        % keep pathwayInfo and Params.stat for contrack scoring
        for l = 1:length(fgclean.params)
            fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep2);
        end
        fgclean.pathwayInfo = fgclean.pathwayInfo(keep2);
        fgclean.name = sprintf('%s_AFQD3L2_%d.pdb',fgclean.name,length(fgclean.fibers));
        mtrExportFibers(fgclean, fgclean.name,[],[],[],2)
    end
end

%% SO_AlignFiberDirection
for i = 1:length(subDir)
    % INPUTS
    SubDir   = fullfile(homeDir,subDir{i});
    fgDir    = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
    fiberDir = fullfile(SubDir,'/dwi_2nd/fibers');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    cd(fgDir)
    % load fg and calcurate nFiber
    fgf = {...
        '*Lt-LGN4*Right-Cerebral-White-Matter_Ctrk100_AFQD3L2*'
        '*Rt-LGN4*Left-Cerebral-White-Matter_Ctrk100_AFQD3L2*'};
    fgN = {'LOTD3L2_1206','ROTD3L2_1206'};
    
    for j= 1:2
        cd(fgDir)
        
        fgF = dir(fgf{j});
        fg  = fgRead(fgF.name);
        fg = SO_AlignFiberDirection(fg,'AP');
        % AFQ_RenderFibers(fg,'numfibers',10)
        
        cd(fiberDir)
        fg.name = fgN{j};
        fgWrite(fg,[fg.name '.pdb'],'pdb')
    end
end
%% check generated OT shape
for i = 1:length(subDir)
    % INPUTS
    SubDir   = fullfile(homeDir,subDir{i});
    %     fgDir    = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
    fiberDir = fullfile(SubDir,'/dwi_2nd/fibers');
    roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    %     cd(fgDir)
    % load fg and calcurate nFiber
    
    fgN = {'LOTD3L2_1206*','ROTD3L2_1206*'};
    
    % Render OT fig
    figure; hold on;
    for j= 1:2
        cd(fiberDir)
        
        fgF = dir(fgN{j});
        fg  = fgRead(fgF.name);
        AFQ_RenderFibers(fg,'numfibers',10,'newfig',0)
        
    end
    camlight 'headlight';
    axis off
    axis image
    hold off;
    
end

