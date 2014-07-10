%% Tamafig.m
% make plots for LHON and JMD project
%% 6LHON_9JMD_7Ctl
cd /biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/AFQ_results/6LHON_9JMD_7Ctl;
load('AFQ_6LHON_9JMD_7Ctl.mat');

%% ROR
vol_JMD  = afq.vals.volume{1,22}(1:9,:);
vol_LHON = afq.vals.volume{1,22}(10:15,:);
vol_Ctl  = afq.vals.volume{1,22}(16:22,:);

Jvol.mean = mean(vol_JMD);
% cJMD, and aJMD
vol_cJMD  = afq.vals.volume{1,22}(1:4,:);
vol_aJMD  = afq.vals.volume{1,22}(5:9,:);

Lvol.mean = mean(vol_LHON);
Cvol.mean = mean(vol_Ctl);

figure(1); hold on ;
X = 1:length(Jvol.mean);
Y1 = Jvol.mean;
Y2 = Lvol.mean;
Y3 = Cvol.mean;
Y4 = cJvol.mean;
Y5 = aJvol.mean;
plot(X,Y1,X,Y2,X,Y3,X,Y4,X,Y5,'linewidth',3);
% plot(X,Y1,X,Y2,X,Y3);

legend('JMD','LHON','Ctl','conMD','adultMD');
xlabel('Location','fontName','Times','fontSize',12);
ylabel('Volume [mm^3]','fontName','Times','fontSize',12);
title('R-Optic Radiation','fontName','Times','fontSize',14);



%% LOR
% JMD 
vol_JMD  = afq.vals.volume{1,23}(1:9,:);
% cJMD, and aJMD
vol_cJMD  = afq.vals.volume{1,23}(1:4,:);
vol_aJMD  = afq.vals.volume{1,23}(5:9,:);

vol_LHON = afq.vals.volume{1,23}(10:15,:);
vol_Ctl  = afq.vals.volume{1,23}(16:22,:);

Jvol.mean = mean(vol_JMD);
cJvol.mean = mean(vol_cJMD);
aJvol.mean = mean(vol_aJMD);


Lvol.mean = mean(vol_LHON);
Cvol.mean = mean(vol_Ctl);

figure(2); hold on ;
X = 1:length(Jvol.mean);
Y1 = Jvol.mean;
Y2 = Lvol.mean;
Y3 = Cvol.mean;
Y4 = cJvol.mean;
Y5 = aJvol.mean;
plot(X,Y1,X,Y2,X,Y3,X,Y4,X,Y5,'linewidth',3);
legend('JMD','LHON','Ctl','conMD','adultMD');
xlabel('Location','fontName','Times','fontSize',12);
ylabel('Volume [mm^3]','fontName','Times','fontSize',12);
title('L-Optic Radiation','fontName','Times','fontSize',14);


%%




boxplot(vol_JMD);

figure(2)
boxplot(vol_LHON);

figure(3)
boxplot(afq.vals.volume{1,22});
    c = lines(3);

num = round(rand(100)*100); 
figure(num(i));hold on ;


 figure(fignums(jj)); hold on;
            % collect the value of interest
            switch(property)
                case 'fa'
                    vals = data{ii}(tracts(jj)).FA;
                    label = 'Fractional Anisotropy';
                case 'rd'
                    vals = data{ii}(tracts(jj)).RD;
                    label = 'Radial Diffusivity';
                case 'ad'
                    vals = data{ii}(tracts(jj)).AD;
                    label = 'Axial Diffusivity';
                case 'md'
                    vals = data{ii}(tracts(jj)).MD;
                    label = 'Mead Diffusivity';
            end
            % number of subjects with measurements for this tract
            n  = sum(~isnan(vals(:,1)));
            % group mean diffusion profile
            m  = nanmean(vals);
            % standard deviation at each node
            sd = nanstd(vals);
            % standard error of the mean at each node
            se = sd./sqrt(n);
            % plot the mean
            h(ii) = plot(m,'-','Color',c(ii,:),'linewidth',3);
            % plot the confidence interval
            plot(m+se,'--','Color',c(ii,:));
            plot(m-se,'--','Color',c(ii,:));
            % label the axes etc.
            xlabel('Location','fontName','Times','fontSize',12);
            ylabel(label,'fontName','Times','fontSize',12);
            title(fgNames{tracts(jj)},'fontName','Times','fontSize',12);
            set(gca,'fontName','Times','fontSize',12);
        end
        % add a legend to the plot
        legend(h,gnames);












%% first OR node 50-90. fgnamewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww{22} ROR,fgname{23} LOR;
% ROR
for ii = 1:length(afq.sub_dirs) ;
    figure(ii);hold on;
    X = 50:90;
    Y1 = afq.vals.fa{22}(:,51:90);
    Y2 = afq.vals.fa{22}(2,50:90);
    Y3 = afq.vals.fa{22}(3,50:90);
    
    c = lines(3);
    
    plot(X,Y1,'Color',c(1,:),'linewidth',3);
    plot(X,Y2,'Color',c(2,:),'linewidth',3);
    plot(X,Y3,'Color',c(3,:),'linewidth',3);
    
    label = 'Quantitative T1';

    % scale the axes and name them
    %         axis(axisScale);
    xlabel('Location','fontName','Times','fontSize',12);
    ylabel(label,'fontName','Times','fontSize',12)
    title(afq.fgnames{ii},'fontName','Times','fontSize',12)
    set(gcf,'Color','w');
    set(gca,'Color',[.9 .9 .9],'fontName','Times','fontSize',12)
    
    
    hold off;
end





%% make figs LHON, JMD %%
for i = 1:11
% fg = fgRead(afq.files.fibers.LOCF_MD2{1});
% fg = fgRead(afq.files.fibers.clean{i,1});
fg = fgRead(afq.files.fibers.ROCF_MD3{i});

AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg
% title('JMD','FontSize',12,'FontName','Times');
exi
end

%% to render both OR in one fig
for i = 1:length(afq.sub_dirs)
% fg = fgRead(afq.files.fibeuntitled.mrs.LOCF_MD2{1});
% fg = fgRead(afq.files.fibers.clean{i,1});
fg = fgRead(afq.files.fibers.RORV13mmClipBigNotROI5_clean{i});

AFQ_RenderFibers(fg, 'newfig', [1],'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg

fg = fgRead(afq.files.fibers.LORV13mmClipBigNotROI5_{i});

% title('JMD','FontSize',12,'FontName','Times');
AFQ_RenderFibers(fg, 'newfig', [0],'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg

end


%% to render both OT in one fig
for i = 1:length(afq.sub_dirs)
% fg = fgRead(afq.files.fibeuntitled.mrs.LOCF_MD2{1});
% fg = fgRead(afq.files.fibers.clean{i,1});
fg = fgRead(afq.files.fibers.ROT100_clean{i});

AFQ_RenderFibers(fg, 'newfig', [1],'color', [.7 .7 1],'camera','axial'); %fg() = fg

fg = fgRead(afq.files.fibers.LOT100_clean{i});

% title('JMD','FontSize',12,'FontName','Times');
AFQ_RenderFibers(fg, 'newfig', [0],'color', [.7 .7 1],'camera','axial'); %fg() = fg

end

% AFQ_RenderFibers(fg,'newfig', [1]) - Check if rendering should be in new
% window [1] or added to an old window [0]. Default is new figure.

%% render 2 fiber group with fa colormap 
for i = 1:sum(afq.sub_group)

dt = dtiLoadDt6(afq.files.dt6{i});

fgL = fgRead(afq.files.fibers.LORV13mmClipBigNotROI5_clean{i});
fgR = fgRead(afq.files.fibers.RORV13mmClipBigNotROI5_clean{i});

valsL = dtiGetValFromFibers(dt.dt6,fgL,inv(dt.xformToAcpc),'fa');
valsR = dtiGetValFromFibers(dt.dt6,fgR,inv(dt.xformToAcpc),'fa');

rgbL = vals2colormap(valsL);
rgbR = vals2colormap(valsR);

%AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', rgb,'camera','axial');

% Now let's render the tract profile meaning the values along the fiber
% core. Let's dop it for a new tract.
 AFQ_RenderFibers(fgL, 'numfibers',1000 ,'dt', dt, 'radius', [.5 4],'camera','axial','val','fa','crange',[0.3 0.7]);
 AFQ_RenderFibers(fgR,'newfig', [0], 'numfibers',1000 ,'dt', dt, 'radius', [.5 4],'camera','axial','val','fa','crange',[0.3 0.7]);

 % save fig
 set(gcf,'Color','w','InvertHardCopy','off','PaperPositionMode','auto');
 if i <= sum(afq.sub_group);
     k = strfind(afq.sub_dirs{i}, '/');
     tmp = afq.sub_dirs{i}([k(7)+1:k(7)+4]);
     saveas(gcf,[tmp '_FA_spf1000'],'png');
 else i > sum(afq.sub_group);
     k = strfind(afq.sub_dirs{i}, '/');
     tmp = afq.sub_dirs{i}([k(7)+5:k(7)+10]);
     saveas(gcf,[tmp '_FA_spf1000'],'png');
     saveas(gcf,[tmp '_FA_spf1000'],'fig');
 end
 close;
 
 % To color each point on each fiber based on values
 AFQ_RenderFibers(fgL, 'numfibers', 3000 ,'color', rgbL,'camera','axial','crange',[0.3 0.7]);
 AFQ_RenderFibers(fgR, 'newfig', [0],'numfibers', 3000 ,'color', rgbR,'camera','axial','crange',[0.3 0.7]);
 
 % save fig2
 set(gcf,'Color','w','InvertHardCopy','off','PaperPositionMode','auto');
 if i <= sum(afq.sub_group);
     k = strfind(afq.sub_dirs{i}, '/');
     tmp = afq.sub_dirs{i}([k(7)+1:k(7)+4]);
     saveas(gcf,[tmp '_FA_tube3000'],'png');
     saveas(gcf,[tmp '_FA_tube3000'],'fig');
 else i > sum(afq.sub_group);
     k = strfind(afq.sub_dirs{i}, '/');
     tmp = afq.sub_dirs{i}([k(7)+5:k(7)+10]);
     saveas(gcf,[tmp '_FA_tube3000'],'png');
     saveas(gcf,[tmp '_FA_tube3000'],'fig');
 end
 close;
end

%% render 2 fiber group with fa colormap 
for i =7% 1:6
% fg = fgRead(afq.files.fibers.LOCF_MD2{1});
% fg = fgRead(afq.files.fibers.clean{i,1});

dt = dtiLoadDt6(afq.files.dt6{i});

fgL = fgRead(afq.files.fibers.LOCF_MD3{i});
fgR = fgRead(afq.files.fibers.ROCF_MD3{i});

valsL = dtiGetValFromFibers(dt.dt6,fgL,inv(dt.xformToAcpc),'fa');
valsR = dtiGetValFromFibers(dt.dt6,fgR,inv(dt.xformToAcpc),'fa');

rgbL = vals2colormap(valsL);
rgbR = vals2colormap(valsR);

%AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', rgb,'camera','axial');

% Now let's render the tract profile meaning the values along the fiber
% core. Let's dop it for a new tract.
AFQ_RenderFibers(fgL, 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 1.0]);
AFQ_RenderFibers(fgR,'newfig', [0], 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 1.0]);

% AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg


%title('LHON','FontSize',12,'FontName','Times');

end

%% render 2 fiber group with fa colormap 
for i = 7:11
% fg = fgRead(afq.files.fibers.LOCF_MD2{1});
% fg = fgRead(afq.files.fibers.clean{i,1});

dt = dtiLoadDt6(afq.files.dt6{i});

% fgL = fgRead(afq.files.fibers.LOR_MD3{i});
% fgR = fgRead(afq.files.fibers.ROR_MD3{i});

fgL = fgRead(afq.files.fibers.LORV13mmClipBigNotROI5_clean{i});
fgR = fgRead(afq.files.fibers.RORV13mmClipBigNotROI5_clean{i});

valsL = dtiGetValFromFibers(dt.dt6,fgL,inv(dt.xformToAcpc),'fa');
valsR = dtiGetValFromFibers(dt.dt6,fgR,inv(dt.xformToAcpc),'fa');

rgbL = vals2colormap(valsL);
rgbR = vals2colormap(valsR);

%AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', rgb,'camera','axial');

% Now let's render the tract profile meaning the values along the fiber
% core. Let's dop it for a new tract.
AFQ_RenderFibers(fgL, 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 0.7]);
AFQ_RenderFibers(fgR,'newfig', [0], 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 0.7]);

% AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg

% t1 = niftiRead(dt.files.t1);
% AFQ_AddImageTo3dPlot(t1, [1 0 0]);
% AFQ_AddImageTo3dPlot(t1, [0 0 -9]);

%title('LHON','FontSize',12,'FontName','Times');

end




%% render B-OR_MD3 with fa colormap 
for i = 1:6

dt = dtiLoadDt6(afq.files.dt6{i});

fgL = fgRead(afq.files.fibers.LOR_MD4{i});
fgR = fgRead(afq.files.fibers.ROR_MD4{i});

valsL = dtiGetValFromFibers(dt.dt6,fgL,inv(dt.xformToAcpc),'fa');
valsR = dtiGetValFromFibers(dt.dt6,fgR,inv(dt.xformToAcpc),'fa');

rgbL = vals2colormap(valsL);
rgbR = vals2colormap(valsR);

%AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', rgb,'camera','axial');

% Now let's render the tract profile meaning the values along the fiber
% core. Let's dop it for a new tract.
AFQ_RenderFibers(fgL, 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 0.7]);
AFQ_RenderFibers(fgR,'newfig', [0], 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 0.7]);

%title('LHON','FontSize',12,'FontName','Times');

end


%% render OCF07Mori_MD with fa colormap 
for i = 1%:6
% fg = fgRead(afq.files.fibers.LOCF_MD2{1});
% fg = fgRead(afq.files.fibers.clean{i,1});

dt = dtiLoadDt6(afq.files.dt6{i});

fgL = fgRead(afq.files.fibers.OCF07Mori_MD4{i});
% fgR = fgRead(afq.files.fibers.ROCF_MD3{i});

valsL = dtiGetValFromFibers(dt.dt6,fgL,inv(dt.xformToAcpc),'fa');
% valsR = dtiGetValFromFibers(dt.dt6,fgR,inv(dt.xformToAcpc),'fa');

rgbL = vals2colormap(valsL);
% rgbR = vals2colormap(valsR);

%AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', rgb,'camera','axial');

% Now let's render the tract profile meaning the values along the fiber
% core. Let's dop it for a new tract.
AFQ_RenderFibers(fgL, 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 1.0]);
% AFQ_RenderFibers(fgR,'newfig', [0], 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 1.0]);

% AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg


%title('LHON','FontSize',12,'FontName','Times');

end

%% renderOCFV1V2Not3mm_MD4 with fa colormap 
for i = 1:6
% fg = fgRead(afq.files.fibers.LOCF_MD2{1});
% fg = fgRead(afq.files.fibers.clean{i,1});

dt = dtiLoadDt6(afq.files.dt6{i});

fgL = fgRead(afq.files.fibers.OCFV1V2Not3mm_MD4{i});
% fgR = fgRead(afq.files.fibers.ROCF_MD3{i});

valsL = dtiGetValFromFibers(dt.dt6,fgL,inv(dt.xformToAcpc),'fa');
% valsR = dtiGetValFromFibers(dt.dt6,fgR,inv(dt.xformToAcpc),'fa');

rgbL = vals2colormap(valsL);
% rgbR = vals2colormap(valsR);

%AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', rgb,'camera','axial');

% Now let's render the tract profile meaning the values along the fiber
% core. Let's dop it for a new tract.
AFQ_RenderFibers(fgL, 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 1.0]);
% AFQ_RenderFibers(fgR,'newfig', [0], 'numfibers',100 ,'dt', dt, 'radius', [.4 3],'camera','axial','val','fa','crange',[0.2 1.0]);

% AFQ_RenderFibers(fg, 'numfibers', 100 ,'color', [.7 .7 1],'camera','axial'); %fg() = fg


%title('LHON','FontSize',12,'FontName','Times');

end

