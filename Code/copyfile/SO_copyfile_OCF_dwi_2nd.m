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
    fromDirs = fullfile(baseDir,subs{ii},'dwi_2nd','fibers','conTrack','OCF') ;
% for 1:16    
    fromfile1 = fullfile(fromDirs,'OCF_CC_ctx-lh-pericalcarine_2013-03-29_MD4.pdb');
    fromfile2 = fullfile(fromDirs,'OCF_CC_ctx-rh-pericalcarine_2013-03-29_MD4.pdb');

% for HT{17}     
%     fromfile1 = fullfile(fromDirs,'OCF_CC_ctx-lh-pericalcarine_2013-04-29_MD2.pdb');
%     fromfile2 = fullfile(fromDirs,'OCF_CC_ctx-rh-pericalcarine_2013-04-29_MD2.pdb');
%     
    goDirs1 = fullfile(baseDir,subs{ii},'dwi_2nd','fibers','LOCF_MD4.pdb');
    goDirs2 = fullfile(baseDir,subs{ii},'dwi_2nd','fibers','ROCF_MD4.pdb');
    
    copyfile(fromfile1,goDirs1)
    copyfile(fromfile2,goDirs2)
end
disp('i did')