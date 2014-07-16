function RegionWhereisDamaged_1220(diffusivity)
%
% 
%
%
%%
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subDir = {...
    'JMD1-MM-20121025-DWI'
    'JMD3-AK-20121026-DWI'
    'JMD5-KK-20121220-DWI'
    'JMD6-NO-20121220-DWI'
    'JMD2-KK-20121025-DWI'
    'JMD4-AM-20121026-DWI'
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
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'
    'JMD-Ctl-FN-20130621-DWI'
    'JMD-Ctl-AM-20130726-DWI'
    'JMD-Ctl-SO-20130726-DWI'
    'RP1-TT-2013-11-01'
    'RP2-KI-2013-11-01'
    'RP3-TO-13120611-DWI'};
% %% Load TractProfile
% 
% cd /biac4/wandell/biac3/wandell7/shumpei/matlab/git/LHON/3RP
% load 3RP_3SD_TractProfile.mat

% %% classify all subjects intogroups
% JMD = 1:4;
% CRD = 5:9;
% LHON = 10:15;
% Ctl = 16:23;
% RP = 24:26;
%%
if ~exist('diffusivity','var') || isempty(diffusivity),  diffusivity = 'ad'; end
diffusivity = lower(mrvParamFormat(diffusivity));
% if ~exist(subject) || isempty(subject),  subject = 1:length(subDir); end
%%
for i = 1:26; %id; % subject =1
    SubDir = fullfile(homeDir,subDir{i});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers');
    %     newDir = fullfile(SubDir,'/dwi_2nd/fibers/conTrack/OR_1130');
    %     roiDir = fullfile(SubDir,'/dwi_2nd/ROIs');
    dt  = fullfile(homeDir,subDir{i},'dwi_2nd','dt6.mat');
    dt  = dtiLoadDt6(dt);    
    
    fgN ={'ROR1206_D4L4.pdb','LOR1206_D4L4.pdb','ROTD4L4_1206.pdb','LOTD4L4_1206.pdb',...
        'ROCF_D4L4.pdb','LOCF_D4L4.pdb'};
    
    %%
    figure; hold on;
    for fibID = 1:length(fgN)
        fg_cur = fgRead(fullfile(fgDir,fgN{fibID}));
      
        %% Test dtiGetValfromFibers
        if(~exist('valName','var') || isempty(valName))
    valName = 'md';
end
if(~exist('interpMethod','var') || isempty(interpMethod))
    interpMethod = 'trilin';
end
if(~exist('uniqueVox','var') || isempty(uniqueVox))
    uniqueVox = 0;
end

if(iscell(fg_cur))
    coords = horzcat(fg_cur{:})';
else
    coords = horzcat(fg_cur.fibers{:})';
end

coords2 = mrAnatXformCoords(inv(dt.xformToAcpc), coords);

if uniqueVox==1
    coords = unique(round(coords),'rows');
end

if(size(dt.dt6,4)==6)
  [tmp1,tmp2,tmp3,tmp4,tmp5,tmp6] = dtiGetValFromTensors(dt.dt6,coords2,eye(4),'famdadrd',interpMethod);
  tmp = [tmp1(:) tmp2(:) tmp3(:) tmp4(:) tmp5(:) tmp6(:)];
%   clear tmp1 tmp2 tmp3 tmp4;
% else
%   % assume it's a scalar
%   switch lower(interpMethod)
%     case 'nearest'
%         interpParams = [0 0 0 0 0 0];  
%     case 'trilin'
%         interpParams = [1 1 1 0 0 0];
%     case 'spline'
%         interpParams = [7 7 7 0 0 0];
%     otherwise
%         error(['Unknown interpMethod "' interpMethod '".']);
%   end
%   spCoefs = spm_bsplinc(dt.dt6, interpParams);
%   tmp = spm_bsplins(spCoefs, coords(:,1), coords(:,2), coords(:,3), interpParams);
% end

% if uniqueVox == 1
%     val=tmp;
%     disp(['Num unique voxels: ' num2str(size(coords,1))]);
% else
    fiberLen=cellfun('size', fg_cur.fibers, 2);
    start = 1;
    val = cell(1,length(fg_cur.fibers));
    for ii=1:length(fg_cur.fibers)
        val{ii} = tmp(start:start+fiberLen(ii)-1,:);
        start = start+fiberLen(ii);
    end
% end

return;

        
        
        
        
        %%
        
        coords = horzcat(fg_cur.fibers{:})';
%         coords = mrAnatXformCoords(xform, coords);
        
        
        [FA,MD,AD,RD,val5,val6] = dtiGetValFromTensors(dt.dt6,coords,inv(dt.xformToAcpc),'famdadrd');        
        
         vals_md = dtiGetValFromFibers(dt.dt6,fg_cur,inv(dt.xformToAcpc),diffusivity); 
        
        
        
        
        
        
        
        
        switch diffusivity
            case 'fa'
                vals =  FA;
                range = [0.3 0.7];
            case 'md'
                vals =  MD;
                range = [0.6 1.0];
            case 'ad'
                vals =  AD;
                range = [0.6 1.0];                
            case 'rd'
                vals =  RD;
                range = [1.1 1.5];
        end
        
        
        rgb = vals2colormap(vals,[],range);
        if fibID <3; numfibers =50; else numfibers =20;end;
              
        
        AFQ_RenderFibers(fg_cur,'color',rgb,'numfibers',numfibers,'camera','axial',...
            'crange',range,'newfig',0);
    end
    
    t1 = niftiRead(dt.files.t1);
    AFQ_AddImageTo3dPlot(t1, [0, 0, -30]);
    
    axis image
    axis off
    %     cbar_handle = findobj(gcf,'tag','Colorbar');
    
    view(0,89)
    title(sprintf('%s %s%s',subDir{i},diffusivity,'-map'),'fontsize',14)
    
    colormap('jet') ;
%     shading('interp');
%     lighting('gouraud');
    caxis(range);
    colorbar;
    
    hold off;
    
    
    %% save the figure
    cd /biac4/wandell/biac3/wandell7/shumpei/matlab/git/LHON/3RP/RegionWhrereisDamaged(fig)
    print(gcf,'-dpng',sprintf('%s_%s%s.png',subDir{i},diffusivity,'map'))
end
close all
return


%% Setting the lighting etc.
colormap('jet') ;
shading('interp');
lighting('gouraud');
% set the axis and the color range
% axis([min(x)-r(1) max(x)+r(1) min(y)-r(1) max(y)+r(1)...
%     min(z)-r(1) max(z)+r(1) crange(1) crange(2)]);
caxis(crange);
% add a colorbar
colorbar;

% Set figure window properties if it is a new window
if newfig == 1
    lightH = camlight('headlight');
    axis('image');
end

% set(gca,'cameraposition',[min(x)-r(1) 0 0],'cameratarget',[0 0 0]);
% xlabel('X mm'); ylabel('Y mm'); zlabel('Z mm')
% camlight('headlight');

return




%%
%     %% Render 3D plot with tract profile
%     sdID = 1;
%     subID = i;
% %     fibID = 1;
%     % TractProfile{subID,fibID}{sdID}.vals
%
%
%     figure; hold on;
%
%     for fibID = 1:length(fgN)
%         fg_cur = fgRead(fullfile(fgDir,fgN{fibID}));
%         AFQ_RenderFibers(fg_cur,'numfibers',20,'camera','axial','tractprofile',...
%             TractProfile{subID,fibID}{sdID},'val','fa','newfig',0)
%     end
%     axis image
%     axis off
%     view(0,89)
%     title(sprintf('%s_%s',subDir{i}))
%
%     hold off;

