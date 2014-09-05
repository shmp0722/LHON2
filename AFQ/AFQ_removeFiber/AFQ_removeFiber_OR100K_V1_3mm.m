%% AFQ_removeFiberOutliers
%  Remove fibers from a fiber group that differ substantially from the
%   mean fiber in the group.
%
%   [fg keep]=AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,[M = 'mean'],[count = 0],[maxIter = 5], [show = 0])
%
%   Inputs:
%   fg       = input fiber group structure to be cleaned
%   maxDist  = the maximum gaussian distance a fiber can be from the core of
%              the tract and be retained in the fiber group
%   maxLen   = The maximum length of a fiber (in stadard deviations from the
%              mean length)
%   numNodes = Each fiber will be resampled to have numNodes points
%   M        = median or mean to represent the center of the tract
%   count    = whether or not to print pruning results to screen
%   maxIter  = The maximum number of iterations for the algorithm
%   show     = whether or not to show which fibers are being removed in each
%              iteration. If show == 1 then the the fibers that are being
%              kept and removed will be rendered in 3-D and the user will be
%              prompted to decide whether continue with the cleaning
%
%   Outputs:
%   fg       = Cleaned fiber group
%   keep     = A 1xN vector where n is the number of fibers in the origional
%              fiber group.  Each entry in keep denotes whether that fiber
%              was kept (1) or removed (0).
%
%    Example:
%    AFQdata = '/home/jyeatman/matlab/svn/vistadata/AFQ/';
%    fg = dtiReadFibers(fullfile(AFQdata,'fibers/L_Arcuate_uncleaned.mat'));
%    maxDist = 4; maxLen = 4;
%    numNodes = 25; M = 'mean'; count = 1; show = 1;
%    [fgclean keep]=AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);
%    % Note that the output fgclean will be equivalent to
%    fgclean = dtiNewFiberGroup; fgclean.fibers = fg.fibers(keep);


%% Set the subdir and group of fibers

homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(homeDir)

subs = {...
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
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'
    };


fiberfile_pdb = {'fg_OR_Top100K_V1_3mm_clipped_Lt-LGN_lh_V1_smooth3mm_NOT_2013-06-19_18.12.51-Rh_BigNotROI2_clean.pdb'...
    ,'fg_OR_Top100K_V1_3mm_clipped_Rt-LGN_rh_V1_smooth3mm_NOT_2013-06-19_18.12.51-Lh_BigNotROI2_clean.pdb'};

%% Run AFQ_removeFiberOutliers loop 


for ii=13:length(subs) % ctr
    
    fgDir = fullfile(homeDir,subs{ii},'dwi_2nd','fibers','conTrack','OR_Top100K_V1_3mm_clipped');
     
    
    for ij = 1%1:length(fiberfile_pdb)
        fgfile = fullfile(fgDir,fiberfile_pdb{ij});
        fg = fgRead(fgfile);
        
        % Run AFQ with different maximum distance
         for i=3:5;
            
            maxDist = i;
            maxLen = 4;
            numNodes = 25;
            M = 'mean';
            count = 1;
            show = 1;            
                                 
            [fgclean keep] =  AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);
            
            %% to save the pdb file.
            
            fibername       = sprintf('%s/%s_MD%d.pdb',fgDir,fgclean.name,maxDist);
                        
            mtrExportFibers(fgclean,fibername);
         end
    end
end

