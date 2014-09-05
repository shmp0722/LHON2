function ttest_for1017
%% Load afq file
% cd /biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/AFQ_results/6LHON_9JMD_8Ctl
cd /Users/shumpei/Documents/MATLAB/git/LHON/6LHON_9JMD_8Ctl
load AFQ_6L_9J_8C_1017.mat

%% averaged left and right
diffusivity = 'fa';

switch diffusivity
    case 'fa'
        OR  = ((afq.vals.fa{21}(:,1:100)+afq.vals.fa{22}(:,1:100))/2)';
        OT  = ((afq.vals.fa{24}(:,1:100)+afq.vals.fa{25}(:,1:100))/2)';
        OCF_B  = ((afq.vals.fa{27}(:,1:100)+afq.vals.fa{28}(:,1:100))/2)';
        yaxis = 'Fractional Anisotropy';
    case 'md'
        OR  = ((afq.vals.md{21}(:,1:100)+afq.vals.md{22}(:,1:100))/2)';
        OT  = ((afq.vals.md{24}(:,1:100)+afq.vals.md{25}(:,1:100))/2)';
        OCF_B  = ((afq.vals.md{27}(:,1:100)+afq.vals.md{28}(:,1:100))/2)';

        yaxis = 'Mean Diffusivity';
    case 'ad'
        OR  = ((afq.vals.ad{21}(:,1:100)+afq.vals.ad{22}(:,1:100))/2)';
        OT  = ((afq.vals.ad{24}(:,1:100)+afq.vals.ad{25}(:,1:100))/2)';
        OCF_B  = ((afq.vals.ad{27}(:,1:100)+afq.vals.ad{28}(:,1:100))/2)';

        yaxis = 'Axial Diffusivity';
    case 'rd'
        OR  = ((afq.vals.rd{21}(:,1:100)+afq.vals.rd{22}(:,1:100))/2)';
        OT  = ((afq.vals.rd{24}(:,1:100)+afq.vals.rd{25}(:,1:100))/2)';
        OCF_B  = ((afq.vals.rd{27}(:,1:100)+afq.vals.rd{28}(:,1:100))/2)';                
        yaxis = 'Radial Diffusivity';
end

JMD_OR  = mean(OR(:,1:4),2);
CRD_OR  = mean(OR(:,5:9),2);
LHON_OR = mean(OR(:,10:15),2);
Ctl_OR  = mean(OR(:,16:23),2);

JMD_OT  = mean(OT(:,1:4),2);
CRD_OT  = nanmean(OT(:,5:9),2);
LHON_OT = mean(OT(:,10:15),2);
Ctl_OT  = mean(OT(:,16:23),2);

JMD_OCF_B  = mean(OCF_B(:,1:4),2);
CRD_OCF_B  = nanmean(OCF_B(:,5:9),2);
LHON_OCF_B = mean(OCF_B(:,10:15),2);
Ctl_OCF_B  = mean(OCF_B(:,16:23),2);

%% Mann-Whitney U test
% compare OT in diffusivity between CRD and Ctl 
for i =1:100 
X = OT(i,6:9); %n = 5; 
Y = OT(i,16:23); 
[p(i),h(i)] = ranksum(X,Y);
end
bar(1:100,h); % from node 53 to 93  
axis([1 100 0 2])
title(sprintf('OT %d CRD and Ctl',diffusivity));
name = sprintf('OT_%d_MannWhitney_CRD_Ctl.eps',diffusivity);
print(gcf,'-depsc',name)

% compare between LHON and Ctl
for i =1:100 
X = OT(i,10:15); %n = 5; 
Y = OT(i,16:23); 
[p(i),h(i)] = ranksum(X,Y);
end

bar(1:100,h); % from node 53 to 93  
axis([1 100 0 2])
title('OT Mann Whitney U test LHON and Ctl')
% from node 44 to 94


% compare between LHON and Ctl
for i =1:100 
X = OT(i,10:15); %n = 5; 
Y = OT(i,16:23); 
[p(i),h(i)] = ranksum(X,Y);
end

bar(1:100,h); % from node 53 to 93  
axis([1 100 0 2])
title('OT Mann Whitney U test LHON and Ctl')





