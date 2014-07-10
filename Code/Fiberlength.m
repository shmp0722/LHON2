function [Lmm,Lnorm, Mu, Sigma] = Fiberlength(fg)
% return the fiber length and mean length
%
% Example
% fg = fgread(fg)

% for i =1:length(fg.fibers)
% 
%     % sum distance between node to node    
%     for j = 1:length(fg.fibers{i})-1
%         fg.fibers(j);
%         D(j) = pdist2(fg.fibers{i}(:,j)',fg.fibers{i}(:,j+1)');
%     end
%     Lmm(i) = sum(D);
% end


%% calculate each fiber length
[Lmm] =cellfun('length',fg.fibers);
[Lnorm, Mu, Sigma]= zscore(Lmm);
