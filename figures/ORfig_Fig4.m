function ORfig_Fig4
% drow figure 4
%
% Shumpei Ogawa 2014

% Set directory
[homeDir,subDir,~,~,~,~,~] = Tama_subj;

%% load fg, ROI and dt6 files
% select the subject{i}
i =23;
% directory
SubDir=fullfile(homeDir,subDir{i});
ORfgDir = fullfile(SubDir,'/dwi_2nd/fibers');
OCFfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsV1V2_3mm');
OTfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/conTrack/OT_5K');

roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
dt6 =fullfile(SubDir,'/dwi_2nd/dt6.mat');

% Optic radiation
cd(ORfgDir)
fg1 = fgRead('RORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');
fg2 = fgRead('LORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');

% occipital callosal fiber
% cd(OCFfgDir)
% fg3 = fgRead('OCF_fsCC_Ctr150_clean.pdb');

cd(OTfgDir)

fg4 = 'fg_OT_5K_Optic-Chiasm_Lt-LGN4_2013-08-29_22.32.30-Right-Cerebral-White-Matter_Ctrk100_AFQ_92.pdb';
fg5 = 'fg_OT_5K_Optic-Chiasm_Rt-LGN4_2013-08-29_22.32.30-Left-Cerebral-White-Matter_Ctrk100_AFQ_91.pdb';
fg4 = fgRead(fg4); fg5 = fgRead(fg5);

FG = {fg1 , fg2, fg4, fg5};
% Load dt6
dt = dtiLoadDt6(dt6);
t1 = niftiRead(dt.files.t1);

% Create TractProfile
for kk = 1:length(FG)
    TractProfile{kk} = SO_FiberValsInTractProfiles(FG{kk},dt,'AP',100,1);
end

% % load ROIs
% roi = {'Optic-Chiasm.mat','Rt-LGN4.mat','Lt-LGN4.mat','lh_V1_smooth3mm_NOT.mat','rh_V1_smooth3mm_NOT.mat'};


%% Fig4 A

% ORs
figure; subplot(1,3,1);
hold on;
AFQ_RenderFibers(fg1, 'newfig', [0],'numfibers', 1000 ,'color', [0.854,0.65,0.125],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fg2, 'newfig', [0],'numfibers', 1000 ,'color', [0.854,0.65,0.125],'radius',[0.5,2]); %fg() = fg

% AFQ_RenderFibers(fg3, 'newfig', [0],'numfibers', 100 ,'color', [0.4, 0.7, 0.7],'radius',[0.5,2]); %fg() = fg
%Optic Tract
AFQ_RenderFibers(fg4, 'newfig', [0],'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fg5, 'newfig', [0],'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg

% T1w
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);

% adjust figure
view(0 ,89);
set(gcf,'Color',[1 1 1])
set(gca,'Color',[1 1 1])
axis image
axis off
camlight('headlight');

hold off;

%% Fig4 B
if(~exist('valName','var') || isempty(valName))
    valName = 'fa';
end

subplot(1,3,2);hold on;
for kk = 1:length(FG)
    vals = dtiGetValFromFibers(dt.dt6,FG{kk},inv(dt.xformToAcpc),valName);
    rgb = vals2colormap(vals);
    switch kk
        case {1,2}
            AFQ_RenderFibers(FG{kk},'color',rgb,'crange',[0.3 0.7],'newfig',0,'numfibers',1000);
        case {3,4}
            AFQ_RenderFibers(FG{kk},'color',rgb,'crange',[0.3 0.7],'newfig',0);
    end
end

% Put T1w
t1 = niftiRead(dt.files.t1);
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);

axis image
axis off
% adjust view and give title
view(0,89)

%% Fig4 C
subplot(1,3,3); hold on;
for kk = 1:length(FG)
    radius = 3;
    subdivs = 20;
    crange = [0.3 0.7];
    cmap    = 'jet';
    newfig = 0;
    
    % drow picture
    AFQ_RenderTractProfile(TractProfile{kk}.coords.acpc, radius, TractProfile{kk}.vals.fa, subdivs, cmap, crange, newfig)
end
% Put T1w
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);

axis image
axis off
% adjust view
view(0,89)
camlight('headlight');

colorbar('off')
hold off

