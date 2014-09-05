%% Initializing the parallel toolbox
poolwasopen=1; % if a matlabpool was open already we do not open nor close one
if (matlabpool('size') == 0),
    c = parcluster;
    c.NumWorkers = 8;
    matlabpool(c);
    poolwasopen=0;
end

%% run feClipFibersVolume

% Load fg
% one example  
cd('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm/NOT5_Contrack70_0731')

% fgfile = {'fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4_rh_V1_smooth3mm_NOT_2013-07-10_16_50_36-Lh_NOT0711_Ctr_55214_AFQ_51332_BWhiteMatter.mat'
% 'fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt-LGN4_lh_V1_smooth3mm_NOT_2013-07-10_16_50_36-Rh_NOT0711_Ctr_12216_AFQ_10928.pdb'
% 'fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4_rh_V1_smooth3mm_NOT_2013-07-03_12.34.12-Lh_BigNotROI7_FAp15.pdb'};

fgfile = 'fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4_rh_V1_smooth3mm_NOT_2013-07-10_16.50.36-Lh_NOT0711.pdb';

fg = fgRead(fgfile);
% Keep parameters, once
params      = fg.params;
pathwayInfo = fg.pathwayInfo;

% Clear parameters fields that we do not need:
fg.params      = [];
fg.pathwayInfo = [];

% Load roi
cd('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI/dwi_2nd/ROIs')
roi = dtiReadRoi('Right-Cerebral-White-Matter_Rt-LGN.mat');

% Clip the fibers' nodes that are 1mm away from the WM.
maxVolDist = 1; % mm
fg1 = feClipFibersToVolume_2(fg, roi.coords,maxVolDist);

% Back parameter

% % Show a random 2000 fibers
% fg1.fibers = fg1.fibers(randsample(1:length(fg1.fibers),500));
% feConnectomeDisplay(fg1,figure)

% Save the clipped fiber group back to disk.
cd('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm/NOT5_Contrack70_0731')

fgname = sprintf('%s_1mm_WM.mat',fg1.name);
fg1.name = sprintf('%s_1mm_WM',fg1.name);
fgWrite(fg1,fgname,'mat')
Mat2pdb(fgname)
