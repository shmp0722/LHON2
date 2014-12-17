function SO_Pipeline_OT5K_Tama3_2(id,show_flag)
% To get the Optic Tract is able to analyse.
[homeDir,subDir] = Tama_subj3;

%% exclude fibers depend on anatomical location (waypoint ROI)
for i = id
    % INPUTS
    SubDir   = fullfile(homeDir,subDir{i});
    fiberDir = fullfile(homeDir,subDir{i},'/dwi_2nd/fibers');
    fgDir    = (fullfile(fiberDir,'/conTrack/OT_5K'));
    RoiDir   = fullfile(SubDir,'/dwi_2nd/ROIs');
    
    % load fg
    Fgf = {'*_Lt-LGN4*.pdb'
        '*_Rt-LGN4*.pdb'};
    roif= {'41_Right-Cerebral-White-Matter.mat','2_Left-Cerebral-White-Matter.mat'};
    
    for j = 1:2
        % load roi
        roi = dtiReadRoi(fullfile(RoiDir,roif{j}));
        fgF = dir(fullfile(fgDir,Fgf{j}));
        
        nFiles = size(fgF,1);
        if nFiles >1,
            fg = fgRead((fullfile(fgDir,fgF(nFiles).name)));
        elseif nFiles ==1,
            fg = fgRead((fullfile(fgDir,fgF.name)));
        else
            sprintf('please make sure if fg files exist')
        end
        
        
        % remove Fibers don't go through CC using dtiIntersectFibers
        [fgOut,~,keep,~] = dtiIntersectFibersWithRoi([],'not',[],roi,fg);
        
        % keep pathwayInfo and Params.stat to use contrack scoring
        keep = ~keep;
        for l = 1:length(fgOut.params)
            fgOut.params{1,l}.stat=fgOut.params{1,l}.stat(keep);
        end
        fgOut.pathwayInfo = fgOut.pathwayInfo(keep);
        
        % save
        fgOutname = sprintf('%s.pdb',fgOut.name);
        mtrExportFibers(fgOut, fullfile(fgDir,fgOutname),[],[],[],2)
        
        %% conTrack scoring
        cd(fgDir)

        nFiber=100;
        % get .txt and .pdb filename
        identifier = fg.name(end-8:end);
        dTxtF ={ ['*Lt*',identifier,'.txt'],['*Rt*',identifier,'.txt']};
        dTxt = dir(fullfile(fgDir,dTxtF{j}));
        dPdb = fullfile(fgDir,[fgOut.name,'.pdb']);
%         fullfile(fgDir,'fg_OT_5K_85_Optic-Chiasm_Lt-LGN4_2014-12-13_10.32.48-41_Right-Cerebral-White-Matter_cleaned.pdb');
        % give filename to output f group
        outputfibername = fullfile(fgDir, sprintf('%s_Ctrk%d.pdb',fgOut.name,nFiber));
        
        % score the fibers to particular number
        ContCommand = sprintf('contrack_score.glxa64 -i %s -p %s --thresh %d --sort %s', ...
            dTxt(end).name, outputfibername, nFiber, dPdb);
        %         contrack_score.glxa64 -i ctrSampler.txt -p scoredFgOut_top5000.pdb --thresh 5000 --sort fgIn.pdb
        % run contrack
        system(ContCommand);
        
        % load contrack scored fibers
        fgf = {...
            '*Lt-LGN4*Right-Cerebral-White-Matter_Ctrk100.pdb'
            '*Rt-LGN4*Left-Cerebral-White-Matter_Ctrk100.pdb'};
        
        fgF = dir(fullfile(fgDir,fgf{j}));
        if size(fgF,1)>1,
            fg  = fgRead(fullfile(fgDir,fgF(1).name));
        elseif size(fgF,1)==1,
            fg  = fgRead(fullfile(fgDir,fgF.name));
        end
%         fgWrite(fg,[fg.name,'.pdb'],'pdb')
%         fg = fgRead([fg.name,'.pdb'])
        
        [fgclean, keep2]=AFQ_removeFiberOutliers(fg,4,2,25,'mean',1, 5,[]);
        % keep pathwayInfo and Params.stat for contrack scoring
        for l = 1:length(fgclean.params)
            fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep2);
        end
        fgclean.pathwayInfo = fgclean.pathwayInfo(keep2);
        
        %%
        fgclean = SO_AlignFiberDirection(fgclean,'AP');
        
        fgclean.name = sprintf('%s_AFQ_%d.pdb',fgclean.name,length(fgclean.fibers));
        fgWrite(fgclean, fullfile(fgDir,fgclean.name),'pdb')
        
        % Copy the fg file in upper directory
        fgN = {'LOTD4L4_1206','ROTD4L4_1206'};        
        fgWrite(fgclean,fullfile(fiberDir,fgN{j},'.pdb'),'pdb')
        fgWrite(fgclean,fullfile(fgDir,fgN{j},'.pdb'),'pdb')
        clear fgclean, clear fg;
    end
end

%% check generated OT shape
if show_flag;
    for i = id
        % INPUTS
        SubDir   = fullfile(homeDir,subDir{i});
        %     fgDir    = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K'));
        fiberDir = fullfile(SubDir,'/dwi_2nd/fibers');
        fgN = {'LOTD4L4_1206*','ROTD4L4_1206*'};
        
        % Render OT fig
        figure; hold on;
        for j= 1:2
            fgF = dir(fgN{j});
            fg  = fgRead(fullfile(fiberDir,fgF.name));
            AFQ_RenderFibers(fg,'numfibers',10,'newfig',0)
            
        end
        camlight 'headlight';
        axis off
        axis image
        title([subDir{i}])
        hold off;
        
    end
end
end