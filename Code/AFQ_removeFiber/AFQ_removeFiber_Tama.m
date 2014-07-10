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
         'JMD-Ctl-HH-20120907DWI'};


     
     
    
fiber_pdb = {...
    'fg_Top200000_Rt-LGN_ctx-rh-pericalcarine_2013-03-04_12.00.16.pdb'
    'fg_Top200000_Lt-LGN_ctx-lh-pericalcarine_2013-03-04_12.00.16.pdb'
    };
     
ij = 1:length(fiber_pdb);

fgfile = fullfile(homeDir,subs{ii},'dwi_2nd','fibers','conTrack','Top200000',fiberfile_pdb{ij});
fg = fgRead(fgfile);

maxDist = 2; maxLen = 4;
numNodes = 25; M = 'mean'; count = 1; show = 1;


 
% AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show)
[fgclean keep] =  AFQ_removeFiberOutliers(fg,maxDist,maxLen,numNodes,M,count,show);

%% to save the pdb file.
% outfibernane = sprintf(): 

mtrExportFibers(fgclean,'LHON2_200k_ROR_AFQ_test_Dist2.pdb');