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
    'JMD-Ctl-HT-20120907-DWI'};


for subinds = 1:length(subDir)
    % make save dir
    
    SubDir=fullfile(homeDir,subDir{subinds});
    saveDir = (fullfile(SubDir,'dwi_2nd','fibers','conTrack')); 
    cd(saveDir)

    % select fg
    fgfile = {...
        'fg_OR_Top100K_fs2ROIV1_3mm_Rt-LGN_rh_V1_smooth3mm_2013-06-05_01.07.38.pdb'...
        'fg_OR_Top100K_fs2ROIV1_3mm_Lt-LGN_lh_V1_smooth3mm_2013-06-05_01.07.38.pdb'...
            };
 
    % loop each hemishere    
    for ii =1:length(fgfile) 
 
         switch ii 
             case 1
              
                 Roifile1 = 'leftWhite.mat';
                    
                 Roifile2 = 'Right-Hippocampus.nii_1.mat';
                
             case 2 
                 Roifile1 = 'rightWhite.mat';
                 
                 Roifile2 = 'Left-Hippocampus.nii_1.mat';
         end
        
        % load dt and fg
        dt = dtiLoadDt6(fullfile(SubDir,'dwi_2nd','dt6.mat'));
        fg1 = mtrImportFibers(fullfile(SubDir,'dwi_2nd','fibers','conTrack','OR_Top100K_fs2ROIV1_3mm',fgfile{ii}));
       
        % Inputarguments
        options = 'not';
        minDist = 0.87;
        handles = 0;
           
        % delete fiber which inter-shere
        roi1 = dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile1));
        [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi(handles, options, minDist, roi1, fg1); 
        % delete fiber which goes throu Hippocampus
        roi2 =dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile2));
        [fgOut2,contentiousFibers2, keep2, keepID2] = dtiIntersectFibersWithRoi(handles, options, minDist, roi2, fgOut1); 

        % save new fgfile
        switch ii 
             case 1
                 fgOut2.name = 'fg_OR_Top100K_RtLGN_rhV1_3mm-leftWhite-RightHippocampus';   
                 
             case 2 
                 fgOut2.name = 'fg_OR_Top100K_LtLGN_lhV1_3mm-leftWhite-RightHippocampus';
                
         end
            
            savefilename = sprintf('%s.pdb',fgOut2.name);   
            savefile  = fullfile(SubDir,'dwi_2nd','fibers','conTrack','OR_Top100K_fs2ROIV1_3mm');
            cd(savefile)      

            mtrExportFibers(fgOut2,savefilename);                   
    end
end




    