%% Tama_AFQ_removeFiber_OT
%  Remove fibers from a fiber group that differ substantially from the
%   mean fiber in the group.

%% Set the subdir and group of fibers

% set base and subj Dirs.
baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subjDirs     = {...
    'JMD1-MM-20121025-DWI'...
    'JMD2-KK-20121025-DWI'...
    'JMD3-AK-20121026-DWI'...
    'JMD4-AM-20121026-DWI'...
    'JMD5-KK-20121220-DWI'...
    'JMD6-NO-20121220-DWI'...
    'LHON1-TK-20121130-DWI'...
    'LHON2-SO-20121130-DWI'...
    'LHON3-TO-20121130-DWI'...
    'LHON4-GK-20121130-DWI'...
    'LHON5-HS-20121220-DWI'...
    'LHON6-SS-20121221-DWI'...
    'JMD-Ctl-MT-20121025-DWI'...
    'JMD-Ctl-SY-20130222DWI'...
    'JMD-Ctl-YM-20121025-DWI'...
    'JMD-Ctl-HH-20120907DWI'...
    'JMD-Ctl-HT-20120907-DWI'};



fiberfile_pdb = {...
'fg_OpticTract5000_Optic-Chiasm_clean1111_Lt-LGN_2013-04-18_12.58.43.pdb'
'fg_OpticTract5000_Optic-Chiasm_clean1111_Rt-LGN_2013-04-18_12.58.43.pdb'
    };
    
%% Run AFQ_removeFiberOutliers loop 


for ii = 1:length(subjDirs)
    
        fgDir = fullfile(baseDir,subjDirs{ii},'dwi_2nd','fibers','conTrack','OpticTract5000');
        
    for ij = 1:length(fiberfile_pdb)
        
        fgfile = fullfile(fgDir,fiberfile_pdb{ij});
        
        fg = fgRead(fgfile);
        
        % Run AFQ with different maximum distance
        for i=1:4;
            
            maxDist =  i;
            maxLen = 4;
            numNodes = 25;
            M = 'mean';
            count = 1;
            show = 1;            
            
            % AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show)
            
            [fgclean keep] =  AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);
            
            %% to save the pdb file.
            
            Indexunderscore = strfind(fiberfile_pdb{ij}, '_');
%             fibersubmane    = fiberfile_pdb{ij}([Indexunderscore(1)+1:Indexunderscore(4)-1]);
            fibersubmane    = fiberfile_pdb{ij}([Indexunderscore(1)+1:Indexunderscore(5)-1]);

            fibername       = sprintf('%s/%sMD%d.pdb',fgDir,fibersubmane,maxDist);
                        
            mtrExportFibers(fgclean,fibername);
           
        end
    end
end

