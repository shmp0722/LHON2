%% Set the path to data directory
homeDir = '/biac4/wandell/biac3/wandell4/data/reading_longitude/dti_adults';

 
subDir = {'aab050307','ah051003','am090121','ams051015','as050307'...
                'aw040809','bw040922','ct060309','db061209','dla050311'... 
                'gd040901','gf050826','gm050308','jl040902','jm061209'...
                'jy060309','ka040923','mbs040503','me050126','mo061209'...    
                'mod070307','mz040828','pp050208','rfd040630','rk050524'...
                'sc060523','sd050527','sn040831','sp050303','tl051015'};


for subinds = 1:length(subDir);
    % make save dir
    
    SubDir=fullfile(homeDir,subDir{subinds});
    saveDir = (fullfile(SubDir,'dwi_2nd','fibers','conTrack')); 
    cd(saveDir)
    
   mkdir('T3Top100kNotWmHippo')
  
  
    % select fg
    fgfile = {... 
        'fg_Top100k_NOTdilate_rtLGN_ctx-rh-pericalcarine_2013-04-15_17.02.35.pdb'...
        'fg_Top100k_NOTdilate_ltLGN_ctx-lh-pericalcarine_2013-04-15_17.02.35.pdb'...
              };
 
    % loop each hemishere    
    for ii = 1:length(fgfile) 
 
         switch ii 
             case 1
              
                 Roifile1 = 'Left-WhiteMatter.mat';
                    
                 Roifile2 = 'Right-Hippocampus.mat';
                
             case 2 
                 Roifile1 = 'Right-WhiteMatter.mat';
                 
                 Roifile2 = 'Left-Hippocampus.mat';
         end
        
         
        % load dt, fg.pdb
        dt = dtiLoadDt6(fullfile(SubDir,'dwi_2nd','dt6.mat'));
        fg1 = mtrImportFibers(fullfile(SubDir,'dwi_2nd','fibers','conTrack','Top100k_NOTdilate',fgfile{ii}));
       
        % Inputarguments
        options = 'not';
        minDist = 0.87;
        handles = 0;
           
        roi1 = dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile1));
       

        [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi(handles, options, minDist, roi1, fg1); 

        roi2 =dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile2));
%         fg2 = mtrImportFibers(fgOut1);

        [fgOut2,contentiousFibers2, keep2, keepID2] = dtiIntersectFibersWithRoi(handles, options, minDist, roi2, fgOut1); 
%         [fgOut2,contentiousFibers2, keep2, keepID2] = dtiIntersectFibersWithRoi(handles, options, minDist, roi2, fg2); 

%         
%          %  to save the pdb file.


%         switch ii
%             case  1
%                 fibername = 'Tama3_Rt-LGN_calcarine-NOT-leftWhite-Rt-Hippocampus.pdb';
% 
%             case  2
% 
%                 fibername = 'Tama3_Lt-LGN_calcarine-NOT-leftWhite-Lt-Hippocampus.pdb';
%         end
            savefilename = sprintf('%s.pdb',fgOut2.name);   
            savefile  = fullfile(SubDir,'dwi_2nd','fibers','conTrack','T3Top100kNotWmHippo');
            cd(savefile)      

            mtrExportFibers(fgOut2,savefilename);
            
           
    end
end




    