%% SO_copyfileV13mm.m 
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

for    ii = 21%2:length(subs)
    fromDirs = fullfile(baseDir,subs{ii},'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped') ;
    
    switch ii
        case {1,2,3,4,5,6,10,11,12,13,14,15,16,17,18,19,20}
            fromfg ={...
                'fg_OR_Top100K_V1_3mm_clipped_Rt-LGN_rh_V1_smooth3mm_NOT_2013-06-19_18.12.51-Lh_BigNotROI_FA_p15_Cor_clean.pdb'
                'fg_OR_Top100K_V1_3mm_clipped_Lt-LGN_lh_V1_smooth3mm_NOT_2013-06-19_18.12.51-Rh_BigNotROI_FA_p15_Cor_clean.pdb'};
        case {7,8,9}
            fromfg ={...
                'fg_OR_Top100K_V1_3mm_clipped_Rt-LGN_rh_V1_smooth3mm_NOT_2013-06-26_16.58.13-Lh_BigNotROI_FA_p15_Cor_clean.pdb'
                'fg_OR_Top100K_V1_3mm_clipped_Lt-LGN_lh_V1_smooth3mm_NOT_2013-06-26_16.58.13-Rh_BigNotROI_FA_p15_Cor_clean.pdb'};
        case {21}
            fromfg = {...
                'fg_OR_Top100K_V1_3mm_clipped_Rt-LGN_rh_V1_smooth3mm_NOT_2013-07-02_15.23.28-Lh_BigNotROI_FA_p15_Cor_clean.pdb'
                'fg_OR_Top100K_V1_3mm_clipped_Lt-LGN_lh_V1_smooth3mm_NOT_2013-07-02_15.23.28-Rh_BigNotROI_FA_p15_Cor_clean.pdb'};
        case{22}
            
    end
    
    for i=1:length(fromfg)
        fromfile = fullfile(fromDirs,fromfg{i});
        
        gofg ={...
            'RORV13mmClipBigNotROI5_clean.pdb'
            'LORV13mmClipBigNotROI5_clean.pdb'
            };
        
        goDirs = fullfile(baseDir,subs{ii},'dwi_2nd','fibers',gofg{i});
        
        copyfile(fromfile,goDirs)
        
    end
end
disp('i did it!')