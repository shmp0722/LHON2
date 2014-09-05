% Copyfile 
% '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI/dwi_2nd/fibers/conTrack/T3Top100kNotWmHippo'
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
        };

for    ii = 1:length(subs)
    fromDirs = fullfile(baseDir,subs{ii},'dwi_2nd','ROIs','CC.mat') ;
    goDirs = fullfile(baseDir,subs{ii},'dwi_1st','ROIs') ;

        
    copyfile(fromDirs,goDirs)
end
disp('i did')