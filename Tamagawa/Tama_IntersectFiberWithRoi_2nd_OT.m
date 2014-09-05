%% Tama_InteersectFiberWithRoi_OT.m
% to clip and delate fibers which are going throgh LGN 
% and connecting opposite LGN using Roi that opposite hemi sphere 
% white matter. 

% Set the path to data directory
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
    'JMD-Ctl-HT-20120907-DWI'
    };


for subinds = 1:length(subDir);
    % make save dir
    
    SubDir=fullfile(homeDir,subDir{subinds});
    saveDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack')); 
    cd(saveDir)
    
    mkdir('OC_NOToppsiteWM')
    
    % set fg
    fgfile = {...
        'fg_OpticTract5000_Optic-Chiasm_clean1111_Lt-LGN_2013-04-18_12.58.43.pdb'...   % L-Optic Tract
        'fg_OpticTract5000_Optic-Chiasm_clean1111_Rt-LGN_2013-04-18_12.58.43.pdb' };   % R-Optic Tract
           
 
    % loop each hemishere    
    for ii = 1:length(fgfile) 
 
         switch ii 
             case 1
             
                Roifile1 = 'Right-WhiteMatter.mat';
                                                 
             case 2 
                Roifile1 = 'Left-WhiteMatter.mat';       
                   
         end
         
         
% load dt, fg.pdb
        dt = dtiLoadDt6(fullfile(SubDir,'dwi_2nd','dt6.mat'));
        fg1 = mtrImportFibers(fullfile(SubDir,'dwi_2nd','fibers','conTrack','OpticTract5000',fgfile{ii}));
       
% Input parameters
        options = 'not';
        minDist = 0.87;
        handles = 0;
           
        roi1 = dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile1));
        [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi(handles, options, minDist, roi1, fg1); 

        
%  to save the pdb file.

            savefilename = sprintf('%s.pdb',fgOut1.name);   
            savefile  = fullfile(SubDir,'dwi_2nd','fibers','conTrack','OC_NOToppsiteWM');
            cd(savefile)      

            mtrExportFibers(fgOut1,savefilename);
           
    end
end




    