function ORfig_2

% make good figure 2

[homeDir,subDir,JMD,CRD,LHON,Ctl,RP] = Tama_subj;


%% load fg and ROI files
% select the subject{i}
i =23;

SubDir=fullfile(homeDir,subDir{i});
ORfgDir = fullfile(SubDir,'/dwi_2nd/fibers');
% OCFfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OCF_Top50K_fsV1V2_3mm');
OTfgDir= fullfile(SubDir,'/dwi_2nd/fibers/conTrack/conTrack/OT_5K');

% roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
dt6 =fullfile(SubDir,'/dwi_2nd/dt6.mat');

% Load fiber groups
cd(ORfgDir)
fg1 = fgRead('RORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');
fg2 = fgRead('LORV13mmClipBigNotROI5_clean_clean_D5_L4.mat');

% occipital callosal fiber
% cd(OCFfgDir)
% fg3 = fgRead('OCF_fsCC_Ctr150_clean.pdb');

% Optic tract
cd(OTfgDir)
fg4 = 'fg_OT_5K_Optic-Chiasm_Lt-LGN4_2013-08-29_22.32.30-Right-Cerebral-White-Matter_Ctrk100_AFQ_92.pdb';
fg5 = 'fg_OT_5K_Optic-Chiasm_Rt-LGN4_2013-08-29_22.32.30-Left-Cerebral-White-Matter_Ctrk100_AFQ_91.pdb';
fg4 = fgRead(fg4); fg5 = fgRead(fg5);

% Load dt6
dt = dtiLoadDt6(dt6);
t1 = niftiRead(dt.files.t1);

% % load ROIs
% roi = {'Optic-Chiasm.mat','Rt-LGN4.mat','Lt-LGN4.mat','lh_V1_smooth3mm_NOT.mat','rh_V1_smooth3mm_NOT.mat'};


%% draw visual pathway figure using AFQ_render

% C = lines(100);
% c=jet(3);
% ORs
figure; 
subplot(1,3,1)
hold on;

AFQ_RenderFibers(fg1, 'newfig', [0],'numfibers', 100 ,'color', [0.854,0.65,0.125],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fg2, 'newfig', [0],'numfibers', 100 ,'color', [0.854,0.65,0.125],'radius',[0.5,2]); %fg() = fg
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
AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);
view(0 ,89);
% get(gcf)
% set(gcf, 'name','OCF')
% get(gca)
set(gcf,'Color',[1 1 1])
set(gca,'Color',[1 1 1])
axis image
axis off
% axis on


camlight('headlight');
    %set(lightH, 'position',lightPosition);
%     lighting('gouraud');
%     cameratoolbar('Show');
hold off;

%%
FG = {fg1 , fg2, fg4, fg5};
%
if(~exist('valName','var') || isempty(valName))
    valName = 'fa';
end

subplot(1,3,2);hold on;
    for kk = 1:length(FG)
        vals = dtiGetValFromFibers(dt.dt6,FG{kk},inv(dt.xformToAcpc),valName);
        rgb = vals2colormap(vals);
        switch kk
            case {1,2}
                
                AFQ_RenderFibers(FG{kk},'color',rgb,'crange',[0.3 0.7],'newfig',0,'numfibers',100);
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


%% Render fiber with diffusion measures (FA, MD, AD, RD)

subplot(1,3,3); hold on;

% Optic radiation
AFQ_RenderFibers(fg1,'dt',dt,'newfig', 0,'numfibers', 100 ,...
    'color', [0.854,0.65,0.125],'radius',[0.5,2],'crange',[0.3 0.7 ]); 
AFQ_RenderFibers(fg2,'dt',dt, 'newfig', 0,'numfibers', 100 ,...
    'color', [0.854,0.65,0.125],'radius',[0.5,2],'crange',[0.3 0.7 ]); 

% AFQ_RenderFibers(fg3, 'newfig', [0],'numfibers', 100 ,'color', [0.4, 0.7, 0.7],'radius',[0.5,2]); %fg() = fg
%Optic Tract
AFQ_RenderFibers(fg4, 'newfig', 0,'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg
AFQ_RenderFibers(fg5, 'newfig', 0,'numfibers', 50 ,'color', [0.67,0.27,0.51],'radius',[0.5,2]); %fg() = fg

  % Put T1w
    t1 = niftiRead(dt.files.t1);    
    AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);
    
    axis image
    axis off
    % adjust view and give title
    view(0,89)




