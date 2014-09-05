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
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'
    'JMD-Ctl-FN-20130621-DWI'
    'JMD7-YN-20130621-DWI'
    'JMD8-HT-20130621-DWI'
    'JMD9-TY-20130621-DWI'
        };

for    ii = 1:length(subs)
    fromDirs = fullfile(baseDir,subs{ii},'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsV1V2_3mm') ;
 
    
    fromfile2 = fullfile(fromDirs,'OCF50k_V1V23mm_fsCC_node50_MD4.pdb');
    goDirs2 = fullfile(baseDir,subs{ii},'dwi_2nd','fibers','OCF50kV1V23mmFsCCnode50_MD4.pdb');
    
    
    copyfile(fromfile2,goDirs2)
   
end
disp('i did it!')