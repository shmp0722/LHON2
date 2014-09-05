%% Set the path to data directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
subDir = {...
    'JMD1-MM-20121025-DWI'
    'JMD2-KK-20121025-DWI'
    'JMD3-AK-20121026-DWI'
    'JMD4-AM-20121026-DWI'
    'JMD5-KK-20121220-DWI'
    'JMD6-NO-20121220-DWI'
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
    'JMD7-YN-20130621-DWI'
    'JMD8-HT-20130621-DWI'
    'JMD9-TY-20130621-DWI'
    };

for subinds = 18:length(subDir);
    
    SubDir =fullfile(homeDir,subDir{subinds});
    fgDir  =fullfile(SubDir,'dwi_2nd','fibers');
    ctrDir = (fullfile(SubDir,'dwi_2nd','fibers','conTrack','OCF_Top50K_fsV1V2_3mm'));
    cd(ctrDir)
    
    if 1<= subinds <=17;
        fgfile = 'fg_OCF_Top50K_fsV1V2_3mm_lh_V1_smooth3mm_lh_V2_smooth3mm_rh_V1_smooth3mm_rh_V1_smooth3mm_2013-06-03_18.20.11.pdb';
    else 18<= subinds <=21;
        fgfile = 'fg_OCF_Top50K_fsV1V2_lh_V1_smooth3mm_lh_V2_smooth3mm_rh_V1_smooth3mm_rh_V2_smooth3mm_2013-07-17_10.43.01.pdb';
    end
    % load dt, fg.pdb
    dt = dtiLoadDt6(fullfile(SubDir,'dwi_2nd','dt6.mat'));
    fg = fgRead(fgfile);
    
    % Inputarguments
    options = 'and';
    minDist = 0.87;
    handles = 0;
    
    Roifile = 'fs_CC.mat';
    roi = dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile));
    [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi([], options, minDist, roi, fg);
    
    % keep pathwayInfo and Params.stat for contrack scoring
    
    for l = 1:length(fgOut1.params)
        fgOut1.params{1,l}.stat=fgOut1.params{1,l}.stat(keep1);
    end
    fgOut1.pathwayInfo = fgOut1.pathwayInfo(keep1);
    % save the pdb file
    fgOut1.name = sprintf('%s.pdb','OCF50k_V1V23mm_fsCC');
    mtrExportFibers(fgOut1, fgOut1.name,[],[],[],2)
    
    %% AFQ_removeoutlier
    for MD = 4:5;
        node=50;
        MLen = 5;
        maxIter = 5;
        [fgclean, keep2]=AFQ_removeFiberOutliers(fgOut1,MD,MLen ,node,'mean',1, maxIter,[]);
        % keep pathwayInfo and Params.stat for contrack scoring
        for l = 1:length(fgclean.params)
            fgclean.params{1,l}.stat=fgclean.params{1,l}.stat(keep2);
        end
        fgclean.pathwayInfo = fgclean.pathwayInfo(keep2);
        [p,n,e]=fileparts(fgclean.name);
        fgclean.name = sprintf('%s_node%d_MD%d.pdb',n,node,MD);
        % save fg
        mtrExportFibers(fgclean, fgclean.name,[],[],[],2)
    end
end




