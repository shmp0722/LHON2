function ORfig
% make good figure 2
%

homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subDir ={
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
    'JMD-Ctl-HT-20120907-DWI'
    'JMD-Ctl-FN-20130621-DWI'
    'JMD-Ctl-AM-20130726-DWI'
    'JMD-Ctl-SO-20130726-DWI'};


%%
% select the subject{i}
i =23;

SubDir=fullfile(homeDir,subDir{i});
ORfgDir = fullfile(SubDir,'/dwi_2nd/fibers');
OCFfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsV1V2_3mm');
OTfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/conTrack/OT_5K');

roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
dt6 =fullfile(SubDir,'/dwi_2nd/dt6.mat');


% change directory
cd(ORfgDir)
% Load fiber groups
fg{1} = fgRead('RORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');
fg{2} = fgRead('LORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');


cd(OCFfgDir)
fg{3}= fgRead('OCF_fsCC_Ctr150_clean.pdb');

cd /biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/JMD-Ctl-SO-20130726-DWI/dwi_2nd/fibers/conTrack/OT_5K

fg4 = 'fg_OT_5K_Optic-Chiasm_Lt-LGN4_2013-08-29_22.32.30-Right-Cerebral-White-Matter_Ctrk100_AFQ_92.pdb';
fg5 = 'fg_OT_5K_Optic-Chiasm_Rt-LGN4_2013-08-29_22.32.30-Left-Cerebral-White-Matter_Ctrk100_AFQ_91.pdb';
fg{4} = fgRead(fg4); fg{5} = fgRead(fg5);


% Load dt6
dt = dtiLoadDt6(dt6);
t1 = niftiRead(dt.files.t1);

% load ROIs
% roi = {'Optic-Chiasm.mat','Rt-LGN4.mat','Lt-LGN4.mat','lh_V1_smooth3mm_lh_V2_smooth3mm.mat','rh_V1_smooth3mm_rh_V2_smooth3mm.mat'};
% roi = {'Optic-Chiasm.mat','Rt-LGN4.mat','Lt-LGN4.mat','lh_V1_smooth3mm_NOT.mat','rh_V1_smooth3mm_NOT.mat',...
%     'rh_V1_smooth3mm_rh_V2_smooth3mm_NOT.mat','lh_V1_smooth3mm_lh_V2_smooth3mm_NOT.mat'};

roi = {'Optic-Chiasm.mat','Rt-LGN4.mat','Lt-LGN4.mat','lh_V1_smooth3mm_NOT.mat','rh_V1_smooth3mm_NOT.mat'};


%% draw visual pathway figure using AFQ_render

% C = lines(100);
c=jet(3);
% ORs
figure; hold on;
AFQ_RenderFibers(fg1, 'newfig', [0],'numfibers', 1000 ,'color', [0.854,0.65,0.125],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fg2, 'newfig', [0],'numfibers', 1000 ,'color', [0.854,0.65,0.125],'radius',[0.5,2]); %fg() = fg
% OCF
% AFQ_RenderFibers(fg3, 'newfig', [0],'numfibers', 100 ,'color', [0.4, 0.7, 0.7],'radius',[0.5,2]); %fg() = fg
%Optic Tract
AFQ_RenderFibers(fg4, 'newfig', [0],'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fg5, 'newfig', [0],'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg


% % add ROIs
% for k =1:length(roi)
% Roi = dtiReadRoi(fullfile(roiDir, roi{k}));
% AFQ_RenderRoi(Roi);
% end

% add T1 anatomy
% AFQ_AddImageTo3dPlot(t1, [0, 0, 20]);
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);
% AFQ_AddImageTo3dPlot(t1, [1, 0, 0]);
% view(-115 ,40);
view(0 ,90);
% get(gcf)
% set(gcf, 'name','OCF')
% get(gca)
set(gcf,'Color',[1 1 1])
set(gca,'Color',[1 1 1])
axis image
axis off
% axis on


%  camlight('headlight');
    %set(lightH, 'position',lightPosition);
%     lighting('gouraud');
%     cameratoolbar('Show');

return

%% save in .eps
   
%     fname = sprintf('%s%s',subDir{i},'opticpathway.eps');
%     print(gcf,'-dpng','Figure2_axialView.png');
    
    print(gcf, '-r0','-depsc2','Figure2_axialView.eps','-r400');
%% in png
print(gcf, '-dpng','Figure2_white2_scaleON_axial.png');

%% Render fiber with diffusion measures (FA, MD, AD, RD)
figure; hold on;

for i =[1:2,4,5]
    vals = dtiGetValFromFibers(dt.dt6,fg{i},inv(dt.xformToAcpc),'fa');
    rgb = vals2colormap(vals,[],[0.3 0.7]);
    
    AFQ_RenderFibers(fg{i},'color',rgb,'newfig', [0],'numfibers', 100);
    
end
% add T1 map
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);
view(0 ,89);
axis image
hold off;

%%

i =23;

SubDir=fullfile(homeDir,subDir{i});
fgDir = fullfile(SubDir,'/dwi_2nd/fibers');
% OCFfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsV1V2_3mm');
% fgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/conTrack/OT_5K');

roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
dt6 =fullfile(SubDir,'/dwi_2nd/dt6.mat');


% change directory
cd(fgDir)

fgN ={'ROR1206_D4L4.pdb','LOR1206_D4L4.pdb','ROTD4L4_1206.pdb','LOTD4L4_1206.pdb',...
    'ROTD3L2_1206.pdb','LOTD3L2_1206.pdb'};
for j =1:4
 fg{j} = fgRead(fgN{j}); 
end

% render fibers with fa value in each fibers
figure; hold on;
for i =[1:4]
    vals = dtiGetValFromFibers(dt.dt6,fg{i},inv(dt.xformToAcpc),'fa');
    rgb = vals2colormap(vals,[],[0.3 0.7]);
    
    AFQ_RenderFibers(fg{i},'color',rgb,'newfig', [0],'numfibers', 100,'crange',[0.3 0.7]);
    
end


% add T1 map
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);
view(0 ,90);
axis image


hold off;



%% dispic

for i =[7,];%[1,3,5:7, 9,10,11,16,17,20:21];%[2,4,8,9,12:15,18:23];
    
    SubDir=fullfile(homeDir,subDir{i});
    ORfgDir = fullfile(SubDir,'/dwi_2nd/fibers');
    OCFfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsV1V2_3mm');
    OTfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/conTrack/OT_5K');
    %
    % roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    dt6 =fullfile(SubDir,'/dwi_2nd/dt6.mat');
    
    % change directory
    cd(ORfgDir)
    % Load fiber groups
    % fg1 = fgRead('fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Rt-LGN4_rh_V1_smooth3mm_NOT_2013-08-27_22.54.23-Lh_NOT0711_clean.pdb');
    % fg2 = fgRead('fg_OR_Top100K_V1_3mm_clipped_LGN4mm_Lt-LGN4_lh_V1_smooth3mm_NOT_2013-08-27_22.54.23-Rh_NOT0711_clean.pdb');
    fg1 = fgRead('RORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');
    fg2 = fgRead('LORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');
    fg3 = fgRead('OCFV1V2Not3mm_MD4.pdb');
    fg4 = 'ROT100_clean.pdb';
    fg5 = 'LOT100_clean.pdb';
    fg4 = fgRead(fg4); fg5 = fgRead(fg5);
    
    
    % Load dt6
    dt = dtiLoadDt6(dt6);
    t1 = niftiRead(dt.files.t1);
    
    % load ROIs
    % roi = {'Optic-Chiasm.mat','Rt-LGN4.mat','Lt-LGN4.mat','lh_V1_smooth3mm_lh_V2_smooth3mm.mat','rh_V1_smooth3mm_rh_V2_smooth3mm.mat'};
%     roi = {'Optic-Chiasm.mat','Rt-LGN4.mat','Lt-LGN4.mat','lh_V1_smooth3mm.mat','rh_V1_smooth3mm.mat'};
    
    % OR
    AFQ_RenderFibers(fg1, 'newfig', [1],'numfibers', 2000 ,'color', [0.854,0.65,0.125],'camera','axial','radius',[0.5,2]); %fg() = fg
    AFQ_RenderFibers(fg2, 'newfig', [0],'numfibers', 2000 ,'color', [0.854,0.65,0.125],'camera','axial','radius',[0.5,2]); %fg() = fg
    % OCF
    AFQ_RenderFibers(fg3, 'newfig', [0],'numfibers', 100 ,'color', [0.84, 0.41, 0.29],'camera','axial','radius',[0.5,2]); %fg() = fg
    %Optic Tract
    AFQ_RenderFibers(fg4, 'newfig', [0],'numfibers', 50 ,'color', [0.67,0.27,0.51],'camera','axial','radius',[0.5,2]); %fg() = fg
    AFQ_RenderFibers(fg5, 'newfig', [0],'numfibers', 50 ,'color', [0.67,0.27,0.51],'camera','axial','radius',[0.5,2]); %fg() = fg
    
    AFQ_AddImageTo3dPlot(t1, [0, 0, -10]);
    
    % get(gcf)
%     set(gcf,'Color',[0 0 0]);
    % Create figure
    % figure1 = figure('Color',[0 0 0]);% black
    
    % get(gca)
    
    % % Create axes
    % axes1 = axes('Parent',figure1,...
    %     'PlotBoxAspectRatio',[6.42066022993911 6.96641634948393 1],...
    %     'FontSize',14,...
    %     'FontName','times',...
    %     'DataAspectRatio',[1 1 1],...
    %     'CameraViewAngle',8.7299314173124,...
    %     'CameraUpVector',[0.220720600663304 -0.496044599620934 0.839775072045924],...
    %     'CameraTarget',[-0.28972551195136 -19.2243924001593 5.82124334479113],...
    %     'CameraPosition',[-187.010847800703 400.410222892431 302.770618598883]);
    
    %% save the figure in .png
    % Figure ? 1024x768 ?PNG???
    % "fig.png" ??????
    cd('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/AFQ_results/6LHON_9JMD_8Ctl/fig3')
    
    width  = 384;
    height = 288;
    set(gcf,'PaperPositionMode','auto')
    pos=get(gcf,'Position');
    pos(3)=width-1; %?????1px???????
    pos(4)=height;
    set(gcf,'Position',pos);
    fname = sprintf('%s%s',subDir{i},'_opticpathway_S.png');
    print('-r0','-dpng',fname);
    
    
    
    %% save the figure in .png
    % Figure ? 1024x768 ?PNG???
    % "fig.png" ??????
    cd('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/AFQ_results/6LHON_9JMD_8Ctl/fig3')
    
    width  = 512;
    height = 384;
    set(gcf,'PaperPositionMode','auto')
    pos=get(gcf,'Position');
    pos(3)=width-1; %?????1px???????
    pos(4)=height;
    set(gcf,'Position',pos);
    fname = sprintf('%s%s',subDir{i},'_opticpathway_M.png');
    print('-r0','-dpng',fname);
    
    close;
end

% AFQ_RenderFibers(fg,'color', rgbValues) - Render the fiber group in a
% specific color.  rgbValues can be defined in 3 ways to do (1) uniform
% coloring for the fiber group, (2) fiberwise coloring or (3) pointwise
% coloring.
% (1) If rgbValues is a 1 x 3 vector of rgb values than each fiber is
% colored that same color. The default color is gray [0.7 0.7 0.7]. To do
% cyan for example rgbValues = [0 1 1].
% (2) If rgbValues is a N x 3 vector where N is the number of fibers in
% the fiber group, then each fiber in the group is rendered in its own
% color. Each fiber's color is defined by the coresponding row of
% rgbValues. For example to color each fiber a random color:
% rgbValues=rand(length(fg.fibers),3)
% (3) If rgbValues is a 1 x N cell array where N is the number of fibers
% in the fiber group, then each node on fiber n is colored based on the
% corresponding row of rgbValues{n}. This means that each cell must have
% the same number of rows as the corresponding fiber in the fiber group.

%For example to color each point on each fiber based on its FA value:
vals = dtiGetValFromFibers(dt.dt6,fg4,inv(dt.xformToAcpc),'fa');
rgb = vals2colormap(vals);
AFQ_RenderFibers(fg4,'color',rgb);
% To color each point on each fiber based on values from any nifti image:

im = readFileNifti('t1.nii.gz');
t1 = niftiRead(dt.files.t1);
im =t1;
vals = dtiGetValFromFibers(im.data,fg4,im.qto_ijk);
rgb = vals2colormap(vals);
AFQ_RenderFibers(fg4,'color',rgb)

