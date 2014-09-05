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
    'JMD-Ctl-HT-20120907-DWI'
};


for subinds = 1:length(subDir);
        
    SubDir=fullfile(homeDir,subDir{subinds});
    ctrDir = (fullfile(SubDir,'dwi_2nd','fibers')); 
    cd(ctrDir)
    
    
    % load whole brain fg
    fgfile = 'WholeBrainFG.mat';
 
    %   
                 
                 Roifile1 = 'Mori_LOcc.mat';                  
                 Roifile2 = 'Mori_ROcc.mat';
               
                       
        % load dt, fg.pdb
        dt = dtiLoadDt6(fullfile(SubDir,'dwi_2nd','dt6.mat'));
        FG = fullfile(ctrDir,fgfile);
        fg1 = fgRead(fgfile);
       
        % Inputarguments
        options = 'and';
        minDist = 0.87;
        handles = 0;
           
        roi1 = dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile1));
        [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi(handles, options, minDist, roi1, fg1); 

        roi2 =dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile2));
        [fgOut2,contentiousFibers2, keep2, keepID2] = dtiIntersectFibersWithRoi(handles, options, minDist, roi2, fgOut1); 

        % save the pdb file 
      fgOut2.name = 'wholeBrain+MoriOcc';

        savefilename = sprintf('%s.pdb',fgOut2.name);
        %             savefile  = fullfile(ctrDir,'Top100kNotWmHippo');
        %             cd(savefile)
        
        mtrExportFibers(fgOut2,savefilename);
            
           
end





    