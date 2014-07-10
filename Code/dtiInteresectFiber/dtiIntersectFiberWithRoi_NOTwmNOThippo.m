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
    };



for subinds = 1:length(subDir);
    % make save dir
    
    SubDir=fullfile(homeDir,subDir{subinds});
    saveDir = (fullfile(SubDir,'dwi_1st','fibers','conTrack')); 
    cd(saveDir)
    
%     mkdir('T3Top100kNotWmHippo')
    
    % set fg
    fgfile = {...
        'fg_Top100000_Rt-LGN_ctx-rh-pericalcarine_2013-03-07_16.52.12.pdb'...   % R-optic radiation
        'fg_Top100000_Lt-LGN_ctx-lh-pericalcarine_2013-03-07_16.52.12.pdb' };   % L-optic radiation
           
 
    % loop each hemishere    
    for ii = 1:length(fgfile) 
 
         switch ii 
             case 1
             
                Roifile1 = 'leftWhite.mat';
                   
                Roifile2 = 'Right-Hippocampus.nii_1.mat';
                
             case 2 
                 Roifile1 = 'rightWhite.mat';
                 
                 Roifile2 = 'Left-Hippocampus.nii_1.mat';
         end
        
        % load dt, fg.pdb
        dt = dtiLoadDt6(fullfile(SubDir,'dwi_1st','dt6.mat'));
        fg1 = mtrImportFibers(fullfile(SubDir,'dwi_1st','fibers','conTrack','Top100000',fgfile{ii}));
       
        % Input parameters
        options = 'not';
        minDist = 0.87;
        handles = 0;
           
        roi1 = dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_1st','ROIs',Roifile1));
       

        [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi(handles, options, minDist, roi1, fg1); 

        roi2 =dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_1st','ROIs',Roifile2));
         
        [fgOut2,contentiousFibers2, keep2, keepID2] = dtiIntersectFibersWithRoi(handles, options, minDist, roi2, fgOut1); 
        
         %  to save the pdb file.

            savefilename = sprintf('%s.pdb',fgOut2.name);   
            savefile  = fullfile(SubDir,'dwi_2nd','fibers','conTrack','T3Top100kNotWmHippo');
            cd(savefile)      

            mtrExportFibers(fgOut2,savefilename);
           
    end
end




    