function DivideFibersAcordingToLength
% This script will divide fibers based on fiber length.
%
%
%% Set Tamagawa directory and subjects.
 [homeDir,subDir] = Tama_subj;

%% load afq structure
cd /biac4/wandell/biac3/wandell7/shumpei/matlab/git/LHON/3RP
load 3RP_1210.mat

%% make directory
for ii = 1:length(subDir)
    
    newDir = fullfile(homeDir,subDir{ii},'dwi_2nd','FiberLength','ROR1206_D4L4');
    if ~exist(newDir); mkdir(newDir);end;
end

%% load fiber group
% if isempty(subject); subject = 1:length(subs);end;
for ii = 1%:length(subs)
    newDir = fullfile(homeDir,subDir{ii},'dwi_2nd','FiberLength','ROR1206_D4L4');
    
    % load dt6 file
    dt6 = AFQ_get(afq,'dt6path',ii);
    dt = dtiLoadDt6(dt6);
    % load fg
    fg = fgRead(afq.files.fibers.ROR1206_D4L4{ii});
    % Create a variable to save the origional fiber group before starting to
    % clean it
    fg_orig = fg;
    
    
    % First remove fibers that are too short
    Lnorm     = AFQ_FiberLengthHist(fg_orig,1);
    
    
    SD_m3 = Lnorm < -3; 
    SD_m2 = -3<= Lnorm <= -2;
    SD_m1 = -2<Lnorm<=-1;
    SD_0 =  -1<Lnorm<=0;
    SD_1p  = 0<Lnorm <= 1;
    SD_2p  = 1< Lnorm<=2;
    SD_3p   = 2<Lnorm<=3;
    SD_4p   = Lnorm>3;
    
    
    fg_SDm3 = dtiNewFiberGroup('fg_SDm3','b',[],[],fg_orig.fibers(logical(SD_m3)));
    fg_SDm2 = dtiNewFiberGroup('fg_SDm2','b',[],[],fg_orig.fibers(logical(SD_m2)));
    fg_SDm1 = dtiNewFiberGroup('fg_SDm1','b',[],[],fg_orig.fibers(logical(SD_m1)));
    fg_SD0  = dtiNewFiberGroup('fg_SD0','b',[],[],fg_orig.fibers(logical(SD_0)));
    fg_SD1  = dtiNewFiberGroup('fg_SD1','b',[],[],fg_orig.fibers(logical(SD_1p)));
    fg_SD2  = dtiNewFiberGroup('fg_SD2','b',[],[],fg_orig.fibers(logical(SD_2p)));
    fg_SD3  = dtiNewFiberGroup('fg_SD3','b',[],[],fg_orig.fibers(logical(SD_3p)));
    fg_SD4  = dtiNewFiberGroup('fg_SD4','b',[],[],fg_orig.fibers(logical(SD_4p)));
    
   fgF = {fg_SDm3,fg_SDm2,fg_SDm1,fg_SD0,fg_SD1,fg_SD2,fg_SD3,fg_SD4};
   
   
%% let's get diffusivities 
   for jj =1:length(fgF)
       TractProfile{jj} = SO_FiberValsInTractProfiles(fgF{jj},dt,'AP',100,1);
   end
   %% render fibers
%    AFQ_RenderFibers(fgF{1},'dt',dt,'numfibers',10,'camera','axial','tubes', 0,'radius', [.2 2],'newfig',1)
   t1 = niftiRead(dt.files.t1);

   for jj = 1:length(fgF)
       AFQ_RenderFibers(fgF{jj},'dt',dt,'numfibers',10,'camera','axial','tubes', 0,'radius', [.2 2],'newfig',1)
       %    
       
%        a =  -64.0872
%        b =   69.4895
       %        % if you want to show T1 image togather
               AFQ_AddImageTo3dPlot(t1, [0, 0, -5]);
               AFQ_AddImageTo3dPlot(t1, [5, 0, 0]);
       %        view(0,89) % axial view
       %        %     view(-38,30)
       %        camlight('headlight')
       %        axis image
%        view(70,31) % view form back right
view(84,67.5)
       axis off
       axis([10 50 -110 0 -10 40])
       %% if you want to save the image
       %        print(gcf,'-dpng',sprintf('%s_FA.png',fgF{jj}.name))
       %if you like the image with T1w
              print(gcf,'-dpng',sprintf('%s_FA_onT1w_3.png',fgF{jj}.name))
   end
   %% figure
   figure; hold on;
       AFQ_RenderFibers(fgF{1},'numfibers',1,'camera','axial','tubes', 1,'radius', [.5 5],'newfig',1,'color',c(jj,:))

   for jj = 1:length(fgF)
       AFQ_RenderFibers(fgF{jj},'numfibers',1,'camera','axial','tubes', 1,'radius', [.5 5],'newfig',0,'color',c(jj,:))
   end
   axis image
   axis off
%    color = rand(size(TractProfile{1}.coords.acpc,1),3);
%      figure
%   [X, Y, Z, C] =  AFQ_TubeFromCoords(TractProfile{1}.coords.acpc,2,c(jj,:),20);
%     surf(X, Y, Z, C);
    %% plot
    c = jet(length(fgF));
    figure; hold on;
    X =1: 100;
    
    for jj = 1:length(fgF)
        plot(X,TractProfile{jj}.vals.fa,'color',c(jj,:),'LineWidth',2);
    end
    colormap('hot');
    
    % Create axes
    axes1 = axes('Parent',figure1,'CLim',[-4 4]);
    hold(axes1,'all');
    hold off;    
    
    %%
    figure; hold on;
    for  jj = [1,4,8]
    plot(X,TractProfile{jj}.vals.fa,'color',[1-jj*0.1,0,0]);
    end
    legend('Shortest','Mean','Longest')
    %    fg_orig.fibers = fg_orig.fibers(idx1);
    %    fg_orig.pathwayInfo = fg_orig.pathwayInfo(idx1);
    %
    %    for j = 1: fg_orig.params
    %        fg_orig.params{j}.stat =fg_orig.params{j}.stat(idx1);
    %    end
    %
    %        Lnorm     = AFQ_FiberLengthHist(fg_orig,1);
    
    
    %     fg_keep = dtiNewFiberGroup('keep','b',[],[],fg_orig.fibers(logical(keep1)));
    
    
end


% %% Clip V1_not ROI at mean 
% for ii = 1 : length(afq.sub_dirs)
%     for k = 21:22
%     roi = dtiReadRoi(AFQ_get(afq,'roi2 path',k,ii));
%     
%     % get mean position Y
%     Y = round(mean(roi.coords(:,2,:)));
%     
%     % dtiRoiClip
%     apClip=[-120 Y];
%     [roiAnt, ~] = dtiRoiClip(roi, [], apClip, []);
%     
%     % save
%     cd( fullfile(AFQdata,subs{ii},'/dwi_2nd/ROIs'))
% %     dtiWriteRoi(roiPosterior, roiPosterior.name)
%     dtiWriteRoi(roiAnt, [roiPosterior.name(1:end-4),'_Peri'])
% 
%     end
% end
    %% Clip orig V1 ROI at mean 
    for ii = 1 : length(afq.sub_dirs)
        %     for k = 21:22
        RoiDir = fullfile(homeDir,subDir{ii},'/dwi_2nd/ROIs');
        Roi ={'lh_V1.mat','rh_V1.mat'};
        for kk =  1:2
            
            roi2 = dtiReadRoi(fullfile(RoiDir,Roi{kk}));
            
            % get mean position Y
            Y = round(mean(roi2.coords(:,2,:)));
            
            % dtiRoiClip
            apClip=[-120 Y];
            [roiAnt, roiPost] = dtiRoiClip(roi2, [], apClip, []);
            
            % save
            cd( fullfile(homeDir,subDir{ii},'/dwi_2nd/ROIs'))
            dtiWriteRoi(roiPost, [roiPost.name(1:end-4),'_Center'])
            dtiWriteRoi(roiAnt, [roiAnt.name,'_Peri'])
            
        end
    end
    

