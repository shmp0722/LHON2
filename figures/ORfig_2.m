% Create figures illustrating the OR, optic tract, FA on the these tracts,
% and possibly the LGN position
%
%
% Repository dependencies
%    VISTASOFT
%    AFQ
%    LHON2
%
% SO Vistasoft lab, 2014

%% Identify the directories and subject types in the study
% The full call can be
%
%  [homeDir,subDir,JMD,CRD,LHON,Ctl,RP] = Tama_subj;
%
[homeDir,subDir] = Tama_subj;

%% load fiber groups (fg) and ROI files

% This selects a specific
whichSubject = 23;

% These directories are where we keep the data at Stanford.
% The pointers must be directed to any site.
SubDir=fullfile(homeDir,subDir{whichSubject});
ORfgDir = fullfile(SubDir,'/dwi_2nd/fibers');
% OCFfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsV1V2_3mm');
dirOTfg= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OT_5K');

% dirROI = fullfile(SubDir,'/dwi_2nd/ROIs');
dt6 =fullfile(SubDir,'/dwi_2nd/dt6.mat');

% Load fiber groups
cd(ORfgDir)

fgrOR = fgRead('RORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');
fglOR = fgRead('LORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');

%% Load optic tract

cd(dirOTfg)

fglOT = 'fg_OT_5K_Optic-Chiasm_Lt-LGN4_2013-08-29_22.32.30-Right-Cerebral-White-Matter_Ctrk100_AFQ_92.pdb';
fglOT = fgRead(fglOT); 

fgrOT = 'fg_OT_5K_Optic-Chiasm_Rt-LGN4_2013-08-29_22.32.30-Left-Cerebral-White-Matter_Ctrk100_AFQ_91.pdb';
fgrOT = fgRead(fgrOT);

% Load dt6
dt6 = dtiLoadDt6(dt6);
t1 = niftiRead(dt6.files.t1);

% load ROIs for Figure 3, but not Figure 4
dirROI = fullfile(SubDir,'dwi_2nd','ROIs')
roiList = {'Optic-Chiasm.mat','Rt-LGN4.mat','Lt-LGN4.mat','lh_V1_smooth3mm_NOT.mat','rh_V1_smooth3mm_NOT.mat'};

%% draw visual pathway figure using AFQ_render

% C = lines(100);
% c=jet(3);
% ORs
mrvNewGraphWin;
hold on;

AFQ_RenderFibers(fgrOR, 'newfig', [0],'numfibers', 100 ,'color', [0.854,0.65,0.125],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fglOR, 'newfig', [0],'numfibers', 100 ,'color', [0.854,0.65,0.125],'radius',[0.5,2]); %fg() = fg
% OCF
% AFQ_RenderFibers(fg3, 'newfig', [0],'numfibers', 100 ,'color', [0.4, 0.7, 0.7],'radius',[0.5,2]); %fg() = fg

%Optic Tract
AFQ_RenderFibers(fglOT, 'newfig', [0],'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fgrOT, 'newfig', [0],'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg

% % add ROIs if you have the LGN
theseROIS = [2 3];
for k = theseROIS
    Roi = dtiReadRoi(fullfile(dirROI, roiList{k}));
    AFQ_RenderRoi(Roi);
end

% add T1 anatomy
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);
view(0 ,89);
set(gcf,'Color',[1 1 1])
set(gca,'Color',[1 1 1])
axis image, axis off
title('Optic tract and optic radiation')
camlight('headlight');
hold off;

%% Overlay the FA for this subject on the OR and OT

% Let's comment this better when BW understands it.
FG = {fgrOR , fglOR, fglOT, fgrOT};
% Set the value for overlay to 'fa'
if(~exist('valName','var') || isempty(valName)), valName = 'fa'; end

mrvNewGraphWin; hold on;
for kk = 1:length(FG)
    % Get the FA values from the fiber group
    vals = dtiGetValFromFibers(dt6.dt6,FG{kk},inv(dt6.xformToAcpc),valName);
    
    % Turn the FA values into RGB colors
    rgb = vals2colormap(vals);
    
    switch kk
        case {1,2}
            AFQ_RenderFibers(FG{kk},'color',rgb,'crange',[0.3 0.7],'newfig',0,'numfibers',100);
        case {3,4}
            AFQ_RenderFibers(FG{kk},'color',rgb,'crange',[0.3 0.7],'newfig',0);
    end
end

% Put T1w
t1 = niftiRead(dt6.files.t1);
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);

axis image, axis off, view(0,89)
title('FA overlay on OT/OR')
colorbar('location','eastoutside');
caxis([0.3 0.7])


%% Render fiber with diffusion measures (FA, MD, AD, RD)

mrvNewGraphWin; hold on;

% Optic radiation
AFQ_RenderFibers(fgrOR,'dt',dt6,'newfig', 0,'numfibers', 100 ,...
    'color', [0.854,0.65,0.125],'radius',[0.5,2],'crange',[0.3 0.7 ]);
AFQ_RenderFibers(fglOR,'dt',dt6, 'newfig', 0,'numfibers', 100 ,...
    'color', [0.854,0.65,0.125],'radius',[0.5,2],'crange',[0.3 0.7 ]);

% AFQ_RenderFibers(fg3, 'newfig', [0],'numfibers', 100 ,'color', [0.4, 0.7, 0.7],'radius',[0.5,2]); %fg() = fg
%Optic Tract
AFQ_RenderFibers(fglOT, 'newfig', 0,'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fgrOT, 'newfig', 0,'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg

% Put T1w
t1 = niftiRead(dt6.files.t1);
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);

axis image
axis off
view(0,89)
title('Core fiber with')


%% End


