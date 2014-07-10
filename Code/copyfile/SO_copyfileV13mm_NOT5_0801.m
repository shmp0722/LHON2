%% SO_copyfileV13mm.m 

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(baseDir)

subs = {...
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
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'
    'JMD-Ctl-FN-20130621-DWI'
    'JMD-Ctl-AM-20130726-DWI'};

%% copyfile
for    ii = 1:length(subs)
    fromDirs = fullfile(baseDir,subs{ii},...
        '/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm/NOT5_Contrack70_0731') ;
    cd(fromDirs)
    fromfile = matchfiles('*_NOT0801.pdb','tr');
    

    for i=1:length(fromfg)
                
        gofg ={'RORV13mmC_Not0801.pdb'
            'LORV13mmC_Not0801.pdb'};
        
        goDirs = fullfile(baseDir,subs{ii},'dwi_2nd','fibers',gofg{i});
        
        copyfile(fromfile{i},goDirs)
        
    end
end
disp('i did it!')