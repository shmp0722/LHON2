%% SO_copyfiles_OT100.m
% INTRODUCTORY TEXT
%%
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
    'JMD-Ctl-AM-20130726-DWI'
    };
%%
for    ii = 1:length(subDir)
    fromDirs = fullfile(homeDir,subDir{ii},'dwi_2nd/fibers/conTrack/OT_5K');

    cd(fromDirs)   
    
    fromfile1 = fullfile(fromDirs,'fg_OT_5K_Optic-Chiasm_Rt-LGN4_2013-08-05_14.16.34-Left-Cerebral-White-Matter_Ctrk100_clean.pdb');
    fromfile2 = fullfile(fromDirs,'fg_OT_5K_Optic-Chiasm_Lt-LGN4_2013-08-05_14.16.34-Right-Cerebral-White-Matter_Ctrk100_clean.pdb');

% for HT{17}     
%     fromfile1 = fullfile(fromDirs,'OCF_CC_ctx-lh-pericalcarine_2013-04-29_MD2.pdb');
%     fromfile2 = fullfile(fromDirs,'OCF_CC_ctx-rh-pericalcarine_2013-04-29_MD2.pdb');
%     
    goDirs1 = fullfile(homeDir,subDir{ii},'dwi_2nd','fibers','R-OT100_clean.pdb');
    goDirs2 = fullfile(homeDir,subDir{ii},'dwi_2nd','fibers','L-OT100_clean.pdb');
    
    copyfile(fromfile1,goDirs1)
    copyfile(fromfile2,goDirs2)
end
disp('i did it')