%% load AFQ structure

% get data
data{1} = AFQ_get(afq,'control_data');
data{2} = AFQ_get(afq,'patient_data');
data{3} = AFQ_get(afq,'norms');

gnames = {'control', 'patient'};



% Now lets render a fiber group heatmapped for fa values.
% First get FA for each point of each fiber
% valName.  The current valname options are:
%    - 'fa' (fractional anisotropy) (DEFAULT)
%    - 'md' (mean diffusivity)
%    - 'eigvals' (triplet of values for 1st, 2nd and 3rd eigenvalues)
%    - 'shapes' (triplet of values indicating linearity, planarity and
%              spherisity)
%    - 'dt6' (the full tensor in [Dxx Dyy Dzz Dxy Dxz Dyz] format
%    - 'pdd' (principal diffusion direction)
%    - 'linearity'
%    - 'fa md pdd', 'fa md ad rd', 'fa md pdd dt6'
%    - 'fa md ad rd shape'

vals = dtiGetValFromFibers(dt.dt6,fg,inv(dt.xformToAcpc),'fa');
vals = dtiGetValFromFibers(dt.dt6,fg(9),inv(dt.xformToAcpc),'md');

vals = dtiGetValFromFibers(dt.dt6,fg,inv(dt.xformToAcpc),'fa');


% Then convert each fa value to a color
rgb = vals2colormap(vals);
% Now render the fibers colored based on fa
AFQ_RenderFibers(fgL, 'numfibers', 100 ,'color', rgbL,'camera','axial');
AFQ_AddImageTo3dPlot(t1, [-10 0 0]);

% Now let's render the tract profile meaning the values along the fiber
% core. Let's dop it for a new tract. how about the inferior fronto
% occipital fasciculus
AFQ_RenderFibers(fg(9), 'numfibers',1000 ,'dt', dt, 'radius', [.5 3]);
AFQ_AddImageTo3dPlot(t1, [-10 0 0]);

% Now let's render the RD profile

AFQ_RenderFibers(fg(9), 'numfibers',100 ,'dt', dt, 'radius', [.5 3],'val','rd','crange',[.5 .6]);
AFQ_AddImageTo3dPlot(t1, [-10 0 0]);

% Let's add an ROI to the plot
[roi1 roi2] = AFQ_LoadROIs(9,[], afq);

AFQ_RenderRoi(roi1, [1 0 0])
AFQ_RenderRoi(roi2, [1 0 0])

%% plot LOR_MD3,ROR_MD3
%AFQ_plot 
% [patient_data control_data]=AFQ_run(sub_dirs, sub_group); afq.fgnames{21 26} = {ROR_MD3 LOR_MD3}
 AFQ_plot('patient',afq.patient_data(21),'control',afq.control_data(21), 'group','property','ad');
 AFQ_plot('patient',afq.patient_data(26),'control',afq.control_data(26), 'group','property','ad');

 AFQ_plot('patient',afq.patient_data(21),'control',afq.control_data(21), 'group','property','fa');
 AFQ_plot('patient',afq.patient_data(26),'control',afq.control_data(26), 'group','property','fa');
  AFQ_plot('patient',afq.patient_data(28),'control',afq.control_data(28), 'group','property','fa');
 
 AFQ_plot('patient',afq.patient_data(21),'control',afq.control_data(21), 'group','property','md');
 AFQ_plot('patient',afq.patient_data(26),'control',afq.control_data(26), 'group','property','md');
 
 AFQ_plot('patient',afq.patient_data(21),'control',afq.control_data(21), 'group','property','rd');
 AFQ_plot('patient',afq.patient_data(26),'control',afq.control_data(26), 'group','property','rd');
 
 %,'property',rd);
 %%
 
 AFQ_plot('patient',afq.patient_data,'control',afq.control_data,'tracts',[24:31],'group');
 AFQ_plot('patient',afq.patient_data,'control',afq.control_data,'tracts',[32:34],'group');
 
 AFQ_plot(afq, 'group','tracts',[29]);

 AFQ_plot(afq, 'group','tracts',[47]);
 
%% B-ORV13mmClipNOTROI_clean

AFQ_plot(afq,'individual','tracts',[60:61]) ;
AFQ_plot(afq,'group','tracts',[60:61]) ;

%% OR_MD4 
AFQ_plot(afq,'individual','tracts',[21,22]) ;
AFQ_plot(afq,'group','tracts',[21,22]) ;

%% OR_MD3
AFQ_plot(afq,'individual','tracts',[48:49]) ;
AFQ_plot(afq,'group','tracts',[48:49]) ;


AFQ_plot(afq.norms, afq.patient_data, 'ci',[5 95], 'legend',afq.sub_names, 'individual');
 

'savefigs'
%% %% plot Occupital Forceps Major

 AFQ_plot('patient',afq.patient_data(9),'control',afq.control_data(9), 'group','property','ad');

 AFQ_plot('patient',afq.patient_data(9),'control',afq.control_data(9), 'group','property','fa');
 
 AFQ_plot('patient',afq.patient_data(9),'control',afq.control_data(9), 'group','property','md');
 
 AFQ_plot('patient',afq.patient_data(9),'control',afq.control_data(9), 'group','property','rd');
 
%%  Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'FontSize',12,'FontName','Times');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(YMatrix1,'Parent',axes1,'LineStyle','--');
set(plot1(1),'LineWidth',3,'DisplayName','patient','LineStyle','-');
set(plot1(4),'LineWidth',3,'Color',[0 0.5 0],'DisplayName','control',...
    'LineStyle','-');
set(plot1(5),'Color',[0 0.5 0]);
set(plot1(6),'Color',[0 0.5 0]);

% Create xlabel
xlabel('Location','FontSize',12,'FontName','Times');

% Create ylabel
ylabel('Radial Diffusivity','FontSize',12,'FontName','Times');

% Create title
title('Left Thalmic Radiation','FontSize',12,'FontName','Times');
title('Callosum Forceps Major LHON','FontSize',12,'FontName','Times');



% Create legend
legend(axes1,'show');

%%
figure1 = figure;hold on;
% OCF1000,5000
plot1 = plot(afq.patient_data(1, 21).FA(end,:));
set(plot1(1),'LineWidth',3,'DisplayName','patient','LineStyle','-');
plot2 = plot(afq.patient_data(1, 22).FA(end,:));
set(plot2(4),'LineWidth',3,'Color',[0 0.5 0],'DisplayName','control',...

title('LHON6 OCF1000','FontSize',12,'FontName','Times');

% OCF5000
plot(afq.patient_data(1, 25).FA(end,:));
title('Adult onset JMD Optic radiation','FontSize',12,'FontName','Times');

% OCF 
plot(afq.patient_data(1, 25).FA(end,:));figure(gcf);

 
%%
% [abn abnTracts] = AFQ_ComparePatientsToNorms(patient_data, norms, cutoff, property, comp)
% 
%  Inputs:
%  patient_data = Fiber tract diffusion profiles for the patients.  See
%                 AFQ_ComputeTractProperties and AFQ_ComputeNorms
%  norms        = Normative fiber tract diffusion profiles see AFQ_ComputeNorms
%  cutoff       = Percentile bands that define the range to be considered
%                 normal
%  property     = String defining what property to analyze.  For example
%                 'FA' or 'RD'
%  comp         = Defines whether to compare tract means (comp = 'mean') or
%                 compare pointwise along the tract profile
%                 (comp ='profile').  The default is to compare along the
%                 tract profiles.
% 
% 
%  Outputs:
%  abn          = A 1 x N vector where N is the number of patients.
%                 Each patient that is abnormal on at least one tract is
%                 marked with a 1 and each subject that is normal on every
%                 tract is marked with a 0. The criteria for abnormal is
%                 defined in afq.params.cutoff.  See AFQ create
% 
%  abnTracts    = An M by N matrix where M is the number of subjects and N
%                 is the number of tracts. Each row is a subject and each
%                 column is a tract.  1 means that tract was abnormal for
%                 that subject and 0 means it was normal.


