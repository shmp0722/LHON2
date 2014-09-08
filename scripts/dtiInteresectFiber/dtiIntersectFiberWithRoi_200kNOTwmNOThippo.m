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
%     'JMD-Ctl-HH-20120907DWI'
    };


for subinds = 5 %length(subDir);
    % make save dir
    
    SubDir=fullfile(homeDir,subDir{subinds});
    saveDir = (fullfile(SubDir,'dwi_2nd','fibers','conTrack')); 
    cd(saveDir)
    
    mkdir('Top200kNotWmHippo')
    
    
%     cd(SubDir)
    
    % select fg
    fgfile = {...
        'fg_Top200000_Rt-LGN_ctx-rh-pericalcarine_2013-03-04_12.00.16.pdb'...
        'fg_Top200000_Lt-LGN_ctx-lh-pericalcarine_2013-03-04_12.00.16.pdb'...
            };
 
    % loop each hemishere    
    for ii =2 1:length(fgfile) 
 
         switch ii 
             case 1
              
                 Roifile1 = 'leftWhite.mat';
                    
                 Roifile2 = 'Right-Hippocampus.nii_1.mat';
                
             case 2 
                 Roifile1 = 'rightWhite.mat';
                 
                 Roifile2 = 'Left-Hippocampus.nii_1.mat';
         end
        
        % change dir
%         cd(fullfile(SubDir,'dwi_2nd','fibers','conTrack','TamagawaDWI3'));
        
        % load dt, fg.pdb
        dt = dtiLoadDt6(fullfile(SubDir,'dwi_2nd','dt6.mat'));
        fg1 = mtrImportFibers(fullfile(SubDir,'dwi_2nd','fibers','conTrack','Top200000',fgfile{ii}));
       
        % Inputarguments
        options = 'not';
        minDist = 0.87;
        handles = 0;
        
        % Delete fibers by "not" roi1   
        roi1 = dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile1));
        [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi(handles, options, minDist, roi1, fg1); 
        
        % Delete fibers by "not" roi1   

        roi2 =dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile2));
        [fgOut2,contentiousFibers2, keep2, keepID2] = dtiIntersectFibersWithRoi(handles, options, minDist, roi2, fgOut1); 
    
        %  to save the pdb file.
        
        
%          switch ii
%              case  1
%                  fibername = 'Tama3_Rt-LGN_calcarine-NOT-leftWhite-Rt-Hippocampus.pdb';
%  
%              case  2
%  
%                  fibername = 'Tama3_Lt-LGN_calcarine-NOT-leftWhite-Lt-Hippocampus.pdb';
%          end
            savefilename = sprintf('%s.pdb',fgOut2.name);   
            savefile  = fullfile(SubDir,'dwi_2nd','fibers','conTrack','Top200kNotWmHippo');
            cd(savefile)      

            mtrExportFibers(fgOut2,savefilename);
            
           
    end
end




    