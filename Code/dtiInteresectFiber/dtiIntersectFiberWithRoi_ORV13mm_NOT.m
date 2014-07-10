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


for subinds = 2:length(subDir);
        
    SubDir=fullfile(homeDir,subDir{subinds});
    ctrDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped')); 
    cd(ctrDir)
    

    % load whole brain fg
    fgfile = {'fg_OR_Top100K_V1_3mm_clipped_Lt-LGN_lh_V1_smooth3mm_NOT_2013-06-19_18.12.51.pdb'
        'fg_OR_Top100K_V1_3mm_clipped_Rt-LGN_rh_V1_smooth3mm_NOT_2013-06-19_18.12.51.pdb'};
 for k=1:2
    switch(k)
        case 1
            Roifile1 = 'Rh_BigNotROI2.mat';
        case 2
            Roifile1 = 'Lh_BigNotROI2.mat';
    end               
                       
        % load dt, fg, roi
%         dt = dtiLoadDt6(fullfile(SubDir,'dwi_2nd','dt6.mat'));
        fg1 = fgRead(fgfile{k});
        roi1 = dtiReadRoi(fullfile(homeDir,subDir{subinds},'dwi_2nd','ROIs',Roifile1));
        
        % Set arguments
        options = 'not';
        minDist = 0.87;
        handles = 0;
        
        % main function
        [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi(handles, options, minDist, roi1, fg1); 
        
        % save new fg.pdb file 
        savefilename = sprintf('%s.pdb',fgOut1.name);
        mtrExportFibers(fgOut1,savefilename);
 end              
end





    