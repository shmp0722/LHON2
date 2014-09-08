function Plot_Fig7_percentile
%%
[homeDir,subDir,JMD,CRD,LHON,Ctl,RP] = Tama_subj2;

%% Load TractProfile
load /biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan2/results/Tama2_Percentile.mat

%%
% axis
X = 1:100;
% line color
c = lines(100);
%% plot
figure; hold on;
for fibID = 1
    for pctl = 2:6
        % take diffusion values
        for subID = 1:length(subDir);
            if isempty(TractProfile{subID,fibID}{pctl}.nfibers);
                fa(subID,:) =nan(1,100);
            else
                fa(subID,:) =  mean([TractProfile{subID,fibID}{pctl}.vals.fa;...
                    TractProfile{subID,fibID+1}{pctl}.vals.fa]);
            end;
            
            if isempty(TractProfile{subID,fibID}{pctl}.nfibers);
                md(subID,:) =nan(1,100);
            else
                md(subID,:) = mean([ TractProfile{subID,fibID}{pctl}.vals.md;...
                    TractProfile{subID,fibID+1}{pctl}.vals.md]);
            end;
            
            if isempty(TractProfile{subID,fibID}{pctl}.nfibers);
                rd(subID,:) =nan(1,100);
            else
                rd(subID,:) = mean([ TractProfile{subID,fibID}{pctl}.vals.rd;...
                    TractProfile{subID,fibID+1}{pctl}.vals.rd]);
            end;
            
            if isempty(TractProfile{subID,fibID}{pctl}.nfibers);
                ad(subID,:) =nan(1,100);
            else
                ad(subID,:) = mean([ TractProfile{subID,fibID}{pctl}.vals.ad;...
                    TractProfile{subID,fibID+1}{pctl}.vals.ad]);
            end;
        end
        
        %% plot
        subplot(2,3,pctl-1); hold on;
        
        %% Control
        st = nanstd(fa(Ctl,:),1);
        m   = nanmean(fa(Ctl,:));
        
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
        
        %% CRD
        for k = CRD %1:length(subDir)
            plot(X,fa(k,:),'Color',c(3,:),...
                'linewidth',1);
        end
        m=nanmean(fa(CRD,:));
        plot(X,m,'Color',c(3,:),...
            'linewidth',3)
        
        %% LHON       
        for k = LHON 
            plot(X,fa(k,:),'Color',rgb2cmyk([1 0 0 0]),...
                'linewidth',1);
        end
      
        h(6) = plot(X,nanmean(fa(LHON,:)),'Color',rgb2cmyk([1 0 0 0]),...
            'linewidth',3);
               
        ylabel('Fractional anisotropy','FontName','Times','FontSize',14);
        xlabel('Location','FontName','Times','FontSize',14);       
        axis([11, 90 ,0.15, 0.750001])
        
        axis('square')
        hold off;
    end
end
%         %% save fig
%         cd /biac4/wandell/biac3/wandell7/shumpei/matlab/git/LHON/3RP/Figure7
%
%         print(gcf,'-depsc2',sprintf('%s_%s_%s','FA',fgN{fibID}(1:end-4),TractProfile{1,fibID}{pctl}.name))
%