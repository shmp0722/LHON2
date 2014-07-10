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

fgL = fgRead(afq.files.fibers.LOR_MD3{i});
fgR = fgRead(afq.files.fibers.ROR_MD3{i});

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
for i = 1:6
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

