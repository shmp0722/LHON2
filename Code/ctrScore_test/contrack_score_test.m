function contrack_score_test
% To understand contrack_score.m
% see also testctrscore.m,
%

%% Initializing the parallel toolbox
poolwasopen=1; % if a matlabpool was open already we do not open nor close one
if (matlabpool('size') == 0),
    c = parcluster;
    c.NumWorkers = 8;
    matlabpool(c);
    poolwasopen=0;
end
%% Set directory
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
    'JMD-Ctl-FN-20130621-DWI'
    'JMD-Ctl-AM-20130726-DWI'
    'JMD-Ctl-HT-20120907-DWI'
    'JMD-Ctl-SO-20130726-DWI'
    };

%% make directory and define Dirs
for i = 1%:length(subDir)
    
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
    roiDir  = fullfile(SubDir,'/dwi_2nd/ROIs');
    
    Ids = {
        '*-Rh_NOT0711.pdb'
        '*-Lh_NOT0711.pdb'};
    cd(fgDir)
    
    for ij = 1%:length(Ids)
        %% Load fibers : Note that these are typically in ras xyz real-world coordinates.
        fgF = dir(Ids{ij});
        fg  = fgRead(fgF.name);
        %         fg  = fgGet(fg,'fibers')
        %% Load the diffusion tensors
        % load dt6
        dt6f = fullfile(SubDir,'/dwi_2nd/dt6.mat');
        dt6 = dtiLoadDt6(dt6f);
        fib2voxXform = inv(dt6.xformToAcpc);
        
        %% Change coords of fibers in acpc space to image space
        % Now let's get all of the coordinates that the fibers go through
        coords = horzcat(fg.fibers{:});
        
        % get the unique coordinates
        coords_unique = unique(floor(coords'),'rows');
        
        % These coordsinates are in ac-pc (millimeter) space. We want to transform
        % them to image indices.
        img_coords = unique(floor(mrAnatXformCoords(inv(dt6.xformToAcpc), coords_unique)), 'rows');
        
        % % Now we can calculate FA
%         fa = dtiComputeFA(dt6.dt6);
         x = size(dt6.dt6(:,:,:,1));
        % Now lets take these coordinates and turn them into an image. First we
        % will create an image of zeros
        OR_img = zeros(x);
        % Convert these coordinates to image indices
        ind = sub2ind(x, img_coords(:,1), img_coords(:,2),img_coords(:,3));
        
        
        %% Load white_matter_mask.nii.gz
        WMmaskNifti = fullfile(SubDir,'/dwi_2nd/ROIs/WMmask.nii.gz');
        dwiROI = niftiRead(WMmaskNifti);
        %% Split computation
        
        %         % Size of : dt6bham = [size(dt6.dt6,1) size(dt6.dt6,2) size(dt6.dt6,3)]
        %         rr = 1:1:40000;
        %         [dt6bham, dt6wat] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
        %         dt6bham = {size(dt6.dt6,1) size(dt6.dt6,2) size(dt6.dt6,3)};
        %         dt6wat  =
        
        % Get the Bconstt value for each voxel
%         Bconstt = size(squish(dt6.dt6(:,:,:,1).*0,3),1);
        %         dt6bham = zeros(Bconstt);
        %         dt6wat  = zeros(Bconstt);
        cd(fullfile('/azure/scr1/shumpei/DWI-Tamagawa-Japan',subDir{i}))
        
        %% calculate bham
        % Split computation
        for rr = ind;
        [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
        dt6bham(rr) = tmp(rr);
        dt6wat(rr) = tmpw(rr);
        end
        
        
%         %% Split computation
%         save dt6bham1 dt6bham
%         save dt6wat1 dt6wat
%         rr = 40001:80000;
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         
%         %% Split computation
%         save dt6bham2 dt6bham
%         save dt6wat2 dt6wat
%         rr = 80001:120000;
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         
%         %% Split computation
%         save dt6bham dt6bham
%         save dt6wat dt6wat
%         rr = [120001:160000];
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         
%         %% Split computation
%         save dt6bham dt6bham
%         save dt6wat dt6wat
%         rr =160001:200001;
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         
%         %% Split computation
%         save dt6bham dt6bham
%         save dt6wat dt6wat
%         rr = 200001:240000;
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         
%         %% Split computation
%         save dt6bham dt6bham
%         save dt6wat dt6wat
%         rr = 240001:300000;
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         
%         %% Split computation
%         save dt6bham dt6bham
%         save dt6wat dt6wat
%         rr = 300001:400000;
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         
%         %% Split computation
%         save dt6bham dt6bham
%         save dt6wat dt6wat
%         rr = 400001:500000;
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         
%         %% Split computation
%         save dt6bham dt6bham
%         save dt6wat dt6wat
%         rr = 500001:Bconstt;
%         [tmp, tmpw] = ctrGetBinghamIntegConstt(dt6.dt6,0.1,rr);
%         dt6bham(rr) = tmp(rr);
%         dt6wat(rr) = tmpw(rr);
%         save dt6bham dt6bham
%         save dt6wat dt6wat
         
        %% Compute it for all voxels.
%         cd(fullfile('/azure/scr1/shumpei/DWI-Tamagawa-Japan',subDir{i}))
%         load dt6bham
%         load dt6wat
        [ scores, algo_unstable ] = contrack_score(fg, dt6, fib2voxXform, [], dwiROI, dt6bham, dt6wat);
    end
end
return
