% Script: Group analysis of Arcuate: weighted average diffusion properties computed
%         along the FG path. 
%
%ER wrote it 12/2009
%
%% 0. Set up homeDir

homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

subs = {...
    'JMD1-MM-20121025-DWI'...
    'JMD2-KK-20121025-DWI'...
    'JMD3-AK-20121026-DWI'...
    'JMD4-AM-20121026-DWI'...
    'JMD5-KK-20121220-DWI'...
    'JMD6-NO-20121220-DWI'...
    'LHON1-TK-20121130-DWI'...
    'LHON2-SO-20121130-DWI'...
    'LHON3-TO-20121130-DWI'...
    'LHON4-GK-20121130-DWI'...
    'LHON5-HS-20121220-DWI'...
    'LHON6-SS-20121221-DWI'...
    'JMD-Ctl-MT-20121025-DWI'...
    'JMD-Ctl-YM-20121025-DWI'...
    'JMD-Ctl-SY-20130222DWI'...
     'JMD-Ctl-HH-20120907DWI'...
    };

for ii = 1:length(subs); 
%% I. Set up fibersDir, dtDir andd roisDir for each participant 
fibersDir=fullfile(homeDir,subs{ii},'dwi_2nd','fibers'); 

% fibersDir(2)={'/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON6-SS-20121221-DWI/dwi_2nd/fibers/conTrack/TamagawaDWI3'}; 
roisDir=fullfile(homeDir,subs{ii},'ROIs'); 

% roisDir(2)={'/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON6-SS-20121221-DWI/ROIs'};
dtDir=fullfile(homeDir,subs{ii},'dwi_2nd'); 

% dtDir(2)={'/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/LHON6-SS-20121221-DWI/dwi_2nd'};

%% II. Set up parameters
numberOfNodes = 100;
propertyofinterest='fa'; %Can also be md, rd, ad
fgName='LOR_MD3.pdb'; 
roi1name='Lt-LGN.mat'; 
roi2name='ctx-lh-pericalcarine.mat';


%% III. Loop

fibersFile = fullfile(fibersDir, fgName); 
roi1File   = fullfile(roisDir, roi1name); 
roi2File   = fullfile(roisDir, roi2name); 

% III. 1 LOAD THE DATA
roi1  = dtiReadRoi(roi1File);
roi2  = dtiReadRoi(roi2File);
fg    = fgRead(fibersFile);

cd(dtDir); dt=dtiLoadDt6('dt6.mat'); 

% III. 2 Compute
[fa(:, sfg),md(:, sfg),rd(:, sfg),ad(:, sfg), SuperFibersGroup(sfg)]= ...
    dtiComputeDiffusionPropertiesAlongFG(fg, dt, roi1, roi2, numberOfNodes);

end

%% IV Plot results
figure; 
title(['Weighted average along the FG trajectory for ' propertyofinterest]); 
plot(eval(propertyofinterest));
title(propertyofinterest); xlabel(['First node <-> Last node']); 
for sfg=1:numsfgs
    x(sfg) = SuperFibersGroup(sfg).fibers{1}(1, 1);
    y(sfg) = SuperFibersGroup(sfg).fibers{1}(2, 1);
    z(sfg) = SuperFibersGroup(sfg).fibers{1}(3, 1);
    xe(sfg)= SuperFibersGroup(sfg).fibers{1}(1, end);
    ye(sfg)= SuperFibersGroup(sfg).fibers{1}(2, end);
    ze(sfg)= SuperFibersGroup(sfg).fibers{1}(3, end);
end

display('Center-of-mass coordinates for superfiber endpoints are displayed as text');

%You can add a legend if you like -- i did not. 
text(1, 0.5, {['x=' num2str(mean(x)) ], ['y=' num2str(mean(y))],  ['z=' num2str(mean(z))]}); 
text(numberOfNodes-3, 0.5, {['x=' num2str(mean(xe)) ], ['y=' num2str(mean(ye))],  ['z=' num2str(mean(ze))]}); 
% legend('','') % Goes here
%%

