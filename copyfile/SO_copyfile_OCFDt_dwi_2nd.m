% Copyfile 
% 

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(baseDir)

subs = {...
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
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'
        };

for    ii = 1:16 %length(subs)
    fromDirs = fullfile(baseDir,subs{ii},'dwi_2nd','fibers') ;
    cd(fromDirs)
% for 1:16    
    fromfile1 ='wholeBrain+Mori_LOcc+Mori_ROcc.pdb';
    goDirs1 = 'MoriOccDt.pdb';
   
    
    copyfile(fromfile1,goDirs1)
   
end
disp('i did it')