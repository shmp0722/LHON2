function Figure4(subject,valName,interpMethod)
% To make pictures of the region where we find diffusivities (AD,RD) difference
% diffusivity = 'fa', 'md', 'ad', 'rd'
% test = 'minus', 'effect size'
% radius = radius of tube
% pathway = 'OT', 'OR' or 'OCF'

% The current valname options are:
%      - 'fa' (fractional anisotropy) (DEFAULT)
%      - 'md' (mean diffusivity)
%      - 'eigvals' (triplet of values for 1st, 2nd and 3rd eigenvalues)
%      - 'shapes' (triplet of values indicating linearity, planarity and
%                spherisity)
%      - 'dt6' (the full tensor in [Dxx Dyy Dzz Dxy Dxz Dyz] format
%      - 'pdd' (principal diffusion direction)
%      - 'linearity'
%      - 'fa md pdd', 'fa md ad rd', 'fa md pdd dt6'
%      - 'fa md ad rd shape'


%% Set the path to data directory
[homeDir,subDir,JMD,CRD,Ctl,RP] = Tama_subj2;

%%
if(~exist('valName','var') || isempty(valName))
    valName = 'fa';
end
if(~exist('interpMethod','var') || isempty(interpMethod))
    interpMethod = 'trilin';
end

%%
 ii = subject;  %1: size(afq.sub_dirs,2) % Subjects loop
    
    SubDir = fullfile(homeDir,subDir{ii});
    fgDir  = fullfile(SubDir,'/dwi_2nd/fibers');
    dt6  = fullfile(homeDir,subDir{ii},'dwi_2nd/dt6.mat');
    dt = dtiLoadDt6(dt6);
    cd(fgDir)
    
    % 'OR'
    fgR_OR = fgRead([TractProfile{ii,1}{1}.name, '.pdb']);
    fgL_OR = fgRead([TractProfile{ii,2}{1}.name, '.pdb']);
    
    % 'OT'
    fgR_OT = fgRead([TractProfile{ii,3}{1}.name, '.pdb']);
    fgL_OT = fgRead([TractProfile{ii,4}{1}.name, '.pdb']);
    
    FG = {fgR_OR,fgL_OR,fgR_OT,fgL_OT};
    %
    figure;hold on;
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
    
    camlight('headlight');   
    

