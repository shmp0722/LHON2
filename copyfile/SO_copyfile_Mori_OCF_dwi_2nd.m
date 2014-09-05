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

for    ii = 1:length(subs)
    fromDir = fullfile(baseDir,subs{ii},'dwi_2nd','fibers','conTrack','Mori_OCF') ;
 
    % from file for Tama Dirs
    fromfile1 = fullfile(fromDir,'fg_Mori_OCF_Mori_LOcc_Mori_ROcc_2013-05-14_15.01.11-1000.pdb');
    fromfile2 = fullfile(fromDir,'fg_Mori_OCF_Mori_LOcc_Mori_ROcc_2013-05-14_15.01.11-3000.pdb');
    fromfile3 = fullfile(fromDir,'fg_Mori_OCF_Mori_LOcc_Mori_ROcc_2013-05-14_15.01.11-5000.pdb');

    % go file   
    gofile1 = fullfile(baseDir,subs{ii},'dwi_2nd','fibers','Mori_Occ1000.pdb');
    gofile2 = fullfile(baseDir,subs{ii},'dwi_2nd','fibers','Mori_Occ3000pdb');
    gofile3 = fullfile(baseDir,subs{ii},'dwi_2nd','fibers','Mori_Occ5000.pdb');
    
    copyfile(fromfile1,gofile1)
    copyfile(fromfile2,gofile2)
    copyfile(fromfile3,gofile3)
    
end

disp('i did')