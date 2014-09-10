function Plot_Fig6
%% set directory
[homeDir,subDir,JMD,CRD,LHON,Ctl,RP] = Tama_subj2;

%% Load TractProfile

cd('/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan2/results');
load Tama2_TP_SD.mat

%
fgN ={'ROR1206_D4L4.pdb','LOR1206_D4L4.pdb','ROTD4L4_1206.pdb','LOTD4L4_1206.pdb',...
    'ROTD3L2_1206.pdb','LOTD3L2_1206.pdb'};

% Render plots which comparing CRD ,LHON, Ctl
% Y=nan(length(subDir),100);
X = 1:100;
c = lines(100);

%% Figure 6
% take values of Optic tract
fibID =3;%4:6 %ROR
sdID = 1;%:7
% make one sheet diffusivities
% merge both hemisphere
for subID = 1:length(subDir);
    if isempty(TractProfile{subID,fibID}{sdID}.nfibers);
        fa(subID,:) =nan(1,100);
    else
        fa(subID,:) =  mean([TractProfile{subID,fibID}{sdID}.vals.fa;...
            TractProfile{subID,fibID+1}{sdID}.vals.fa]);
    end;
    
    if isempty(TractProfile{subID,fibID}{sdID}.nfibers);
        md(subID,:) =nan(1,100);
    else
        md(subID,:) = mean([ TractProfile{subID,fibID}{sdID}.vals.md;...
            TractProfile{subID,fibID+1}{sdID}.vals.md]);
    end;
    
    if isempty(TractProfile{subID,fibID}{sdID}.nfibers);
        rd(subID,:) =nan(1,100);
    else
        rd(subID,:) = mean([ TractProfile{subID,fibID}{sdID}.vals.rd;...
            TractProfile{subID,fibID+1}{sdID}.vals.rd]);
    end;
    
    if isempty(TractProfile{subID,fibID}{sdID}.nfibers);
        ad(subID,:) =nan(1,100);
    else
        ad(subID,:) = mean([ TractProfile{subID,fibID}{sdID}.vals.ad;...
            TractProfile{subID,fibID+1}{sdID}.vals.ad]);
    end;
end

%% AD ANOVA
%     Ctl_ad  =  ad(Ctl,:);
%     LHON_ad =  ad(LHON,:);
%     CRD_ad  =  ad(CRD,:);
%     
%     for jj= 1: 100
%         pac = nan(14,3);
%         pac(:,1)= Ctl_ad(:,jj);
%         pac(1:6,2)= LHON_ad(:,jj);
%         pac(1:5,3)= CRD_ad(:,jj);
%         [p(jj),~,stats(jj)] = anova1(pac,[],'off');
%         co = multcompare(stats(jj),'display','off');
%         C{jj}=co;
%     end
%     
%     Portion =  p<0.01;

%% OT
% AD
figure;
subplot(2,2,1)
hold on;
% bar(1:100,Portion.*3,1.0)

% Control
st = nanstd(ad(Ctl,:),1);
m   = nanmean(ad(Ctl,:));

% render area plot
A3 = area(m+2*st);
A1 = area(m+st);
A2 = area(m-st);
A4 = area(m-2*st);

% set color and style
set(A1,'FaceColor',[0.6 0.6 0.6],'linestyle','none')
set(A2,'FaceColor',[0.8 0.8 0.8],'linestyle','none')
set(A3,'FaceColor',[0.8 0.8 0.8],'linestyle','none')
set(A4,'FaceColor',[1 1 1],'linestyle','none')

plot(m,'color',[0 0 0], 'linewidth',3 )

% add individual FA plot
for k = CRD %1:length(subDir)
    plot(X,ad(k,:),'Color',c(3,:),...
        'linewidth',1);
end
m   = nanmean(ad(CRD,:));
plot(X,m,'Color',c(3,:) ,'linewidth',3)


% add individual 
for k = LHON %1:length(subDir)
    plot(X,ad(k,:),'Color',[0 1 1],'linewidth',1);
end
% plot mean value
m   = nanmean(ad(LHON,:));
plot(X,m,'Color',[0 1 1] ,'linewidth',3)

% add label
xlabel('Location','fontName','Times','fontSize',14);
ylabel('Axial diffusivity','fontName','Times','fontSize',14);
axis([0, 100 ,0.7, 2.8])

%% RD  ANOVA
%     Ctl_rd  =  rd(Ctl,:);
%     LHON_rd =  rd(LHON,:);
%     CRD_rd  =  rd(CRD,:);
%     
%     for jj= 1: 100
%         pac = nan(14,3);
%         pac(:,1)= Ctl_rd(:,jj);
%         pac(1:6,2)= LHON_rd(:,jj);
%         pac(1:5,3)= CRD_rd(:,jj);
%         [p(jj),~,stats(jj)] = anova1(pac,[],'off');
%         co = multcompare(stats(jj),'display','off');
%         C{jj}=co;
%     end
%     
%     Portion =  p<0.01;

%% RD
subplot(2,2,2)
hold on;
% bar(1:100,Portion.*2.5, 1.0)

% Control
st = nanstd(rd(Ctl,:),1);
m   = nanmean(rd(Ctl,:));

% render area plot
A3 = area(m+2*st);
A1 = area(m+st);
A2 = area(m-st);
A4 = area(m-2*st);

% set color and style
set(A1,'FaceColor',[0.6 0.6 0.6],'linestyle','none')
set(A2,'FaceColor',[0.8 0.8 0.8],'linestyle','none')
set(A3,'FaceColor',[0.8 0.8 0.8],'linestyle','none')
set(A4,'FaceColor',[1 1 1],'linestyle','none')

plot(m,'color',[0 0 0], 'linewidth',3 )
% add individual FA plot
for k = CRD %1:length(subDir)
    plot(X,rd(k,:),'Color',c(3,:),...
        'linewidth',1);
end
m   = nanmean(rd(CRD,:));
plot(X,m,'Color',c(3,:) ,'linewidth',3)


% rdd individual 
for k = LHON %1:length(subDir)
    plot(X,rd(k,:),'Color',[0 1 1],'linewidth',1);
end
% plot mean value
m   = nanmean(rd(LHON,:));
plot(X,m,'Color',[0 1 1] ,'linewidth',3)

% add label
xlabel('Location','fontName','Times','fontSize',14);
ylabel('Radial diffusivity','fontName','Times','fontSize',14);
axis([0, 100 ,0.3, 2.2])

%% OR
fibID = 1;
for subID = 1:length(subDir);
    if isempty(TractProfile{subID,fibID}{sdID}.nfibers);
        fa(subID,:) =nan(1,100);
    else
        fa(subID,:) =  mean([TractProfile{subID,fibID}{sdID}.vals.fa;...
            TractProfile{subID,fibID+1}{sdID}.vals.fa]);
    end;
    
    if isempty(TractProfile{subID,fibID}{sdID}.nfibers);
        md(subID,:) =nan(1,100);
    else
        md(subID,:) = mean([ TractProfile{subID,fibID}{sdID}.vals.md;...
            TractProfile{subID,fibID+1}{sdID}.vals.md]);
    end;
    
    if isempty(TractProfile{subID,fibID}{sdID}.nfibers);
        rd(subID,:) =nan(1,100);
    else
        rd(subID,:) = mean([ TractProfile{subID,fibID}{sdID}.vals.rd;...
            TractProfile{subID,fibID+1}{sdID}.vals.rd]);
    end;
    
    if isempty(TractProfile{subID,fibID}{sdID}.nfibers);
        ad(subID,:) =nan(1,100);
    else
        ad(subID,:) = mean([ TractProfile{subID,fibID}{sdID}.vals.ad;...
            TractProfile{subID,fibID+1}{sdID}.vals.ad]);
    end;
end

%% AD ANOVA
%     Ctl_ad  =  ad(Ctl,:);
%     LHON_ad =  ad(LHON,:);
%     CRD_ad  =  ad(CRD,:);
%     
%     for jj= 1: 100
%         pac = nan(14,3);
%         pac(:,1)= Ctl_ad(:,jj);
%         pac(1:6,2)= LHON_ad(:,jj);
%         pac(1:5,3)= CRD_ad(:,jj);
%         [p(jj),~,stats(jj)] = anova1(pac,[],'off');
%         co = multcompare(stats(jj),'display','off');
%         C{jj}=co;
%     end
%     
%     Portion =  p<0.01;

%% OR
subplot(2,2,3)
hold on;
% bar(1:100,Portion*2,1)


% Control
st = nanstd(ad(Ctl,:),1);
m   = nanmean(ad(Ctl,:));

% render area plot
A3 = area(m+2*st);
A1 = area(m+st);
A2 = area(m-st);
A4 = area(m-2*st);

% set color and style
set(A1,'FaceColor',[0.6 0.6 0.6],'linestyle','none')
set(A2,'FaceColor',[0.8 0.8 0.8],'linestyle','none')
set(A3,'FaceColor',[0.8 0.8 0.8],'linestyle','none')
set(A4,'FaceColor',[1 1 1],'linestyle','none')

plot(m,'color',[0 0 0], 'linewidth',3 )
% add individual FA plot
for k = CRD %1:length(subDir)
    plot(X,ad(k,:),'Color',c(3,:),...
        'linewidth',1);
end
m   = nanmean(ad(CRD,:));
plot(X,m,'Color',c(3,:) ,'linewidth',2)


% add individual 
for k = LHON %1:length(subDir)
    plot(X,ad(k,:),'Color',[0 1 1],'linewidth',1);
end
% plot mean value
m   = nanmean(ad(LHON,:));
plot(X,m,'Color',[0 1 1] ,'linewidth',2)

% add label
xlabel('Location','fontName','Times','fontSize',14);
ylabel('Axial diffusivity','fontName','Times','fontSize',14);
axis([0, 100, 0.9, 1.7])

%% RD  ANOVA
%     Ctl_rd  =  rd(Ctl,:);
%     LHON_rd =  rd(LHON,:);
%     CRD_rd  =  rd(CRD,:);
%     
%     for jj= 1: 100
%         pac = nan(14,3);
%         pac(:,1)= Ctl_rd(:,jj);
%         pac(1:6,2)= LHON_rd(:,jj);
%         pac(1:5,3)= CRD_rd(:,jj);
%         [p(jj),~,stats(jj)] = anova1(pac,[],'off');
%         co = multcompare(stats(jj),'display','off');
%         C{jj}=co;
%     end
%     
%     Portion =  p<0.01;

%% RD
subplot(2,2,4)
hold on;
% bar(1:100,Portion.*2.5, 1.0)

% Control
st = nanstd(rd(Ctl,:),1);
m   = nanmean(rd(Ctl,:));

% render area plot
A3 = area(m+2*st);
A1 = area(m+st);
A2 = area(m-st);
A4 = area(m-2*st);

% set color and style
set(A1,'FaceColor',[0.6 0.6 0.6],'linestyle','none')
set(A2,'FaceColor',[0.8 0.8 0.8],'linestyle','none')
set(A3,'FaceColor',[0.8 0.8 0.8],'linestyle','none')
set(A4,'FaceColor',[1 1 1],'linestyle','none')

plot(m,'color',[0 0 0], 'linewidth',3 )

% add individual FA plot
for k = CRD %1:length(subDir)
    plot(X,rd(k,:),'Color',c(3,:),...
        'linewidth',1);
end
m   = nanmean(rd(CRD,:));
plot(X,m,'Color',c(3,:) ,'linewidth',3)


% rdd individual 
for k = LHON %1:length(subDir)
    plot(X,rd(k,:),'Color',[0 1 1],'linewidth',1);
end
% plot mean value
m   = nanmean(rd(LHON,:));
plot(X,m,'Color',[0 1 1] ,'linewidth',3)

% add label
xlabel('Location','fontName','Times','fontSize',14);
ylabel('Ridial diffusivity','fontName','Times','fontSize',14);
axis([0, 100 ,0.2, 0.9])

% %% save figure
% cd /biac4/wandell/biac3/wandell7/shumpei/matlab/git/LHON/3RP/Figure6
% print(gcf,'-depsc','Figure6(2)')
