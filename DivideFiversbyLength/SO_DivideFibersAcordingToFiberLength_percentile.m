function [TractProfile, fg_20,fg_40,fg_60,fg_80,fg_100]...
    = SO_DivideFibersAcordingToFiberLength_percentile(fg,dt,showHist,direction,Nodes)
% divide the fascicle into 5groups based on fiber length percentile and return diffusion
% properties in Tractprofile structure
%
% Example
% fg = fgRead('fg'); % or fullpath
% dt =  dtiLoadDt6(dt);
% showHist = 1 or 0 ;% show original fiber length distribution histgraph
% direction = 'AP', 'LR', or 'SI'; % align fiber direction
% Nodes = 100;
% 

%% Argument check

if ~isstruct(dt); dt = dtiLoadDt6(dt);end;
% load fg
if ~isstruct(fg); fg = fgRead(fg);end;
% Create a variable to save the origional fiber group before starting to
% clean it
fg_orig = fg;

%     % First classfy fibers according to length
%     Lnorm     = AFQ_FiberLengthHist(fg_orig,distribution);
%     Lnorm     = AFQ_FiberLengthHist(fg_orig,1);

% Calculate the length in mm of each fiber in the fiber group
Lmm=cellfun('length',fg.fibers);
% Calculate distribution of lengths

x = prctile(Lmm,[0 20 40 60 80 100]);
Med = median(Lmm);

% divide fibers in 5 group based on fiberlength percentile
a = Lmm<x(2);
b = Lmm<x(3) & Lmm>=x(2);
c = Lmm<x(4) & Lmm>=x(3);
d = Lmm<x(5) & Lmm>=x(4);
e = Lmm<=x(6) & Lmm>=x(5);

%% draw histgraph if you want
if showHist==1
    figure;hold on;
    [n, xout]=hist(Lmm,20);
    bar(xout,n,'FaceColor','b','EdgeColor','k');
    axis([min(xout) max(xout) 0 max(n)]);
    xlabel('Fiber Length (mm)');
    plot([Med Med],[0 max(n)],'Color',[0.5,0.5,0.5],'linewidth',2);
    plot([x(2) x(2)],[0 max(n)],'--r');
    plot([x(3) x(3)],[0 max(n)],'--r');
    plot([x(4) x(4)],[0 max(n)],'--r');
    plot([x(5) x(5)],[0 max(n)],'--r');
end

%% creat new fibers
% In case 
if sum(a) <5;fg_20 =[];
else
    fg_20 = dtiNewFiberGroup('fg_20','b',[],[],fg_orig.fibers(logical(a)));
end

if sum(b) <5;fg_40 =[];
else
    fg_40 = dtiNewFiberGroup('fg_40','b',[],[],fg_orig.fibers(logical(b)));
end

if sum(c) <5;fg_60 =[];
else
    fg_60  = dtiNewFiberGroup('fg_60','b',[],[],fg_orig.fibers(logical(c)));
end

if sum(d) <5; fg_80 =[];
else
    fg_80  = dtiNewFiberGroup('fg_80','b',[],[],fg_orig.fibers(logical(d)));
end

if sum(e) <5;fg_100 =[];
else
    fg_100  = dtiNewFiberGroup('fg_100','b',[],[],fg_orig.fibers(logical(e)));
end

fgF = {fg, fg_20,fg_40,fg_60,fg_80,fg_100};


%% let's get diffusivities

for jj =1:length(fgF)
    %     direction ='AP';
    %     Nodes =100;
    if isempty(fgF{jj});
        TractProfile{jj} = AFQ_CreateTractProfile;
    else
        TractProfile{jj} = SO_FiberValsInTractProfiles(fgF{jj},dt,direction,Nodes,1);
    end
end
