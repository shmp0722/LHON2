% This is a sample application to test an implementation of contrack
%
% For the algorithm's details, please refer to:
%
% ConTrack : Finding the most likely pathways between brain regions using
% diffusion tractography. Sherbondy, Dougherty, Ben-Shachar, Napel,
% Wandell, J' Vision 2008. 8(9):15, 1-16.
%
% Author : SM <smenon@stanford.edu>
% Date   : 2013-02-08

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
i = 1;%:length(subDir)

SubDir = fullfile(homeDir,subDir{i});
fgDir  = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_Top100K_V1_3mm_clipped_LGN4mm');
%     roiDir  = fullfile(SubDir,'/dwi_2nd/ROIs');


%% Load the diffusion tensors
% load dt6
dt6f = fullfile(SubDir,'/dwi_2nd/dt6.mat');


% Parameters from the standard run:
%
% Params: 1
% Image Directory: /home/samir/Code/fmri/contrack.git/data/sub100311rd/dti06trilin/bin/
image_dir = fullfile(SubDir, 'dwi_2nd/bin');
% WM/GM Mask Filename: wmProb.nii.gz
wmgm_mask = 'wmProb.nii.gz';
% PDF Filename: pdf.nii.gz
pdf_file = 'pdf.nii.gz';
% ROI MASK Filename: ltLGN_ltCalcFreesurfer_9_20110827T152126.nii.gz
roi_file = 'Rt-LGN4_rh_V1_smooth3mm_NOT_2013-07-17_10.55.52.nii.gz';
% Desired Samples: 10000
% Max Pathway Nodes: 240
% Min Pathway Nodes: 3
% Step Size (mm): 1
% Start Is Seed VOI: true
% End Is Seed VOI: true
% Save Out Spacing: 50
% Threshold for WM/GM specification: 0.01
% Absorption Rate WM: 0
% Absorption Rate NotWM: 0
% Local Path Segment Smoothness Standard Deviation: 14
% Local Path Segment Angle Cutoff: 130
% ShapeFunc Params (LinMidCl,LinWidthCl,UniformS): [ 0.175, 0.15, 100 ]

% clear;

%% Load fibers : Note that these are typically in ras xyz real-world coordinates.
fgF = dir(fullfile(fgDir,'*fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt*.pdb')); 
fg = dtiLoadFiberGroup(fullfile(fgDir,fgF(2).name));



% fiber_file = fullfile(fgDir,'fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4_rh_V1_smooth3mm_NOT_2013-07-10_16.50.36-Lh_NOT0711.pdb');
% fg = dtiLoadFiberGroup(fiber_file);

%   imgCoords  = mrAnatXformCoords(nifti.qto_ijk, acpcCoords);

%% Load the diffusion tensors
file_tensor = fullfile(image_dir, 'tensors.nii.gz');
dwiData = load_nifti(file_tensor); % Just to get the xform
fib2voxXform = inv(dwiData.vox2ras); % Fibers are in ras
[dt6, xformToAcpc, mmPerVoxel, ~, ~, ~] = dtiLoadTensorsFromNifti(file_tensor);

%%
dt62 = dtiLoadDt6(dt6f);


%% Plot 3 slices so we know the rough alignment of the data planes
dtiAxSz = size(dwiData.vol);
dtiAxSz = dtiAxSz([1 2 3]);
figure(1); hold on;
% Plot the x-y plane
x = [[0 dtiAxSz(1)];[0 0]; [dtiAxSz(3) dtiAxSz(3)]./2; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'r', 'LineWidth',2);

x = [[0 dtiAxSz(1)]; [dtiAxSz(2) dtiAxSz(2)]; [dtiAxSz(3) dtiAxSz(3)]./2; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'r', 'LineWidth',2);

x = [[0 0]; [0 dtiAxSz(2)]; [dtiAxSz(3) dtiAxSz(3)]./2; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'g', 'LineWidth',2);

x = [[dtiAxSz(1) dtiAxSz(1)]; [0 dtiAxSz(2)]; [dtiAxSz(3) dtiAxSz(3)]./2; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'g', 'LineWidth',2);

% Plot the y-z plane
x = [[dtiAxSz(1) dtiAxSz(1)]./2;[0 0]; [0 dtiAxSz(3)]; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'b', 'LineWidth',2);

x = [[dtiAxSz(1) dtiAxSz(1)]./2; [dtiAxSz(2) dtiAxSz(2)]; [0 dtiAxSz(3)]; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'b', 'LineWidth',2);

x = [[dtiAxSz(1) dtiAxSz(1)]./2; [0 dtiAxSz(2)]; [0 0]; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'g', 'LineWidth',2);

x = [[dtiAxSz(1) dtiAxSz(1)]./2; [0 dtiAxSz(2)]; [dtiAxSz(3) dtiAxSz(3)]; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'g', 'LineWidth',2);

% Plot the x-z plane
x = [[0 0]; [dtiAxSz(2) dtiAxSz(2)]./2; [0 dtiAxSz(3)]; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'b', 'LineWidth',2);

x = [[dtiAxSz(1) dtiAxSz(1)]; [dtiAxSz(2) dtiAxSz(2)]./2; [0 dtiAxSz(3)]; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'b', 'LineWidth',2);

x = [[0 dtiAxSz(1)]; [dtiAxSz(2) dtiAxSz(2)]./2; [0 0]; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'r', 'LineWidth',2);

x = [[0 dtiAxSz(1)]; [dtiAxSz(2) dtiAxSz(2)]./2; [dtiAxSz(3) dtiAxSz(3)]; [1 1]];
x = dwiData.vox2ras * x;
plot3(x(1,:),x(2,:),x(3,:),'r', 'LineWidth',2);

%% Plot the diffusion tensors for the path (just to see that all is well)
% Get tensors for a path
figure(1); hold on;
for fib_id=1:length(fg.fibers)/10:length(fg.fibers),
  fib_id = round(fib_id);
  % Plot the fibers for a single fiber to make sure everything looks good.
  plot3(fg.fibers{fib_id}(1,1:10:end),fg.fibers{fib_id}(2,1:10:end), fg.fibers{fib_id}(3,1:10:end)'.'); hold on;

  %Extract the tensors along the path and plot them.
  [tensors valid] = ctrExtractDWITensorsAlongPath(fg.fibers{fib_id}, dt6, fib2voxXform);
  for i=1:10:size(fg.fibers{fib_id},2);
    % now plot the rotated ellipse
    [x, y, z] = ctrPlotGetPointSamplesOnEllipsoid( ...
      [fg.fibers{fib_id}(1,i),fg.fibers{fib_id}(2,i),fg.fibers{fib_id}(3,i)], tensors{i}.D);
    sc = surf(x,y,z);
    shading interp; alpha(0.5);
  end
end

figure(1); hold off;
xlabel('X (m, ras, red)');ylabel('Y (m, ras, green)');zlabel('Z (m, ras, blue)');
grid on; axis square;


%%
%   imgCoords  = mrAnatXformCoords(nifti.qto_ijk, acpcCoords);


% Now let's get all of the coordinates that the fibers go through
coords = horzcat(fg.fibers{:});

% get the unique coordinates
coords_unique = unique(round(coords'),'rows');

% These coordsinates are in ac-pc (millimeter) space. We want to transform
% them to image indices.
img_coords = unique(floor(mrAnatXformCoords(inv(xformToAcpc), coords_unique)), 'rows');
% img_coords = unique(floor(mrAnatXformCoords(inv(dt62.xformToAcpc), coords_unique)), 'rows');


% % Now we can calculate FA
% fa = dtiComputeFA(dt62.dt6);
% x = size(dt6.dt6(:,:,:,1));
x = size(dt6(:,:,:,1));

% Now lets take these coordinates and turn them into an image. First we
% will create an image of zeros
OR_img = zeros(x);
% Convert these coordinates to image indices
ind = sub2ind(x, img_coords(:,1), img_coords(:,2),img_coords(:,3));
% Now replace every coordinate that has the optic radiations with a 1
OR_img(ind) = 1;

% Now you have an image. Just for your own interest if you want to make a
% 3d rendering
isosurface(OR_img,.2);

% For each voxel that does not contain the optic radiations we will zero
% out its value
fa(~OR_img) = 0;
%
% % Now we want to save this as a nifti image; The easiest way to do this is
% % just to steal all the information from another image. For example the b0
% % image
% dtiWriteNiftiWrapper(fa, dt.xformToAcpc, 'L-OR-MD3-FA.nii.gz');

%% Now generate the Bingham distribution for all voxels in the DTI dataset
% Size of : dt6bham = [size(dt6,1) size(dt6,2) size(dt6,3)]
% rr = [1:1:40000];
[dt6bham, dt6wat] = ctrGetBinghamIntegConstt(dt6,0.1,ind');
% [dt6bham, dt6wat] = ctrGetBinghamIntegConstt(dt62.dt6,0.01,227113);

% %% Split computation
% rr = [40001:1:80000];
% [tmp tmpw] = ctrGetBinghamIntegConstt(dt6,0.1,rr);
% dt6bham(rr) = tmp(rr);
% dt6wat(rr) = tmpw(rr);
%
% %% Split computation
% save
% rr = [80001:1:120000];
% [tmp tmpw] = ctrGetBinghamIntegConstt(dt6,0.1,rr);
% dt6bham(rr) = tmp(rr);
% dt6wat(rr) = tmpw(rr);
%
% %% Split computation
% rr = [120001:1:160000];
% [tmp tmpw] = ctrGetBinghamIntegConstt(dt6,0.1,rr);
% dt6bham(rr) = tmp(rr);
% dt6wat(rr) = tmpw(rr);

%% Save Bigham distribution for specific fiber group
dt6bhamname = ['dt6bham_',fg.name];
save(dt6bhamname,dt6bham)

dt6watname = ['dt6wat_',fg.name];
save(dt6watname,dt6wat)


%% Now score the path.
%
%  cd '/azure/scr1/shumpei/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI/dt6bham.mat';
% load '/azure/scr1/shumpei/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI/dt6wat.mat';
%%
tmpStructural = dwiData.vol(:,:,:,1,1);

[scores unstable] = contrack_score(fg, dt6, fib2voxXform, tmpStructural.*0 + 1, dt6bham, dt6wat);

 cd '/azure/scr1/shumpei/DWI-Tamagawa-Japan/JMD1-MM-20121025-DWI';
