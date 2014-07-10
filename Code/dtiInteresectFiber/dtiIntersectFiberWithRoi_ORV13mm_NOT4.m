%% Set the path to data directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
subDir = {...
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
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'};


for subinds = 1:length(subDir);
        
    SubDir=fullfile(homeDir,subDir{subinds});
    fgDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_fs2ROIV1_3mm')); 
    cd(fgDir)
    

    % load fg
    switch subinds
        case {1,2,3,4,5,6,10,11,12,13,14,15,16,17,18,19,20}
            fgfile = {'fg_OR_Top100K_fs2ROIV1_3mm_Lt-LGN_lh_V1_smooth3mm_2013-06-05_01.07.38.pdb'
                'fg_OR_Top100K_fs2ROIV1_3mm_Rt-LGN_rh_V1_smooth3mm_2013-06-05_01.07.38.pdb'};
        case {7,8,9}
            fgfile = {'fg_OR_Top100K_fs2ROIV1_3mm_Lt-LGN_lh_V1_smooth3mm_2013-06-26_16.55.51.pdb'
                'fg_OR_Top100K_fs2ROIV1_3mm_Rt-LGN_rh_V1_smooth3mm_2013-06-26_16.55.51.pdb'};
    end
    
    % hemisphere
    for k=1:2
        switch(k)
            case 1
                Roifile1 = 'Rh_BigNotROI4.mat';
            case 2
                Roifile1 = 'Lh_BigNotROI4.mat';
        end
        
        % load dt, fg, roi
        
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

%% Run AFQ_removeFiberOutliers loop 
% subj
for i = 1:length(subDir);
    cd(fgDir)

    switch i
        case {1,2,3,4,5,6,10,11,12,13,14,15,16,17,18,19,20}
            fiberfile_pdb = {'fg_OR_Top100K_fs2ROIV1_3mm_Lt-LGN_lh_V1_smooth3mm_2013-06-05_01.07.38-Rh_BigNotROI4.pdb'
                'fg_OR_Top100K_fs2ROIV1_3mm_Rt-LGN_rh_V1_smooth3mm_2013-06-05_01.07.38-Lh_BigNotROI4.pdb'};
        case {7,8,9}
            fiberfile_pdb = {'fg_OR_Top100K_fs2ROIV1_3mm_Lt-LGN_lh_V1_smooth3mm_2013-06-26_16.55.51-Rh_BigNotROI4.pdb'
                'fg_OR_Top100K_fs2ROIV1_3mm_Rt-LGN_rh_V1_smooth3mm_2013-06-26_16.55.51-Lh_BigNotROI4.pdb'};
    end
    
    for ij = 1:length(fiberfile_pdb)
        fg = fgRead(fiberfile_pdb{ij});
        
        % Run AFQ with different maximum distance
         for j=3:5;
            
            maxDist = j;
            maxLen = 4;
            numNodes = 30;
            M = 'mean';
            count = 1;
            show = 1;            
                                 
            [fgclean keep] =  AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);
            
            %% to save the pdb file.
            fgclean.name = sprintf('%s_MD%d.pdb',fgclean.name,maxDist);
                        
            fgWrite(fgclean,a);
         end
    end
end





    