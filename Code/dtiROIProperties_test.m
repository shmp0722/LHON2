%% dtiROIproperties_test.m
% compute min mean max,FA,MD,AD,RD 

% Set directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
 
subDir = {...
    'JMD1-MM-20121025-DWI','JMD2-KK-20121025-DWI','JMD3-AK-20121026-DWI',...
    'JMD4-AM-20121026-DWI','JMD5-KK-20121220-DWI','JMD6-NO-20121220-DWI',...
    'LHON1-TK-20121130-DWI','LHON2-SO-20121130-DWI','LHON3-TO-20121130-DWI',...
    'LHON4-GK-20121130-DWI','LHON5-HS-20121220-DWI','LHON6-SS-20121221-DWI',...
    'JMD-Ctl-MT-20121025-DWI','JMD-Ctl-SY-20130222DWI','JMD-Ctl-YM-20121025-DWI',...
    'JMD-Ctl-HH-20120907DWI','JMD-Ctl-HT-20120907-DWI'};

%loop subject
for i = 1:length(subDir)
   
       cd(fullfile(homeDir,subDir{i},'/dwi_2nd/ROIs'))
       
       dt6File = fullfile(homeDir,subDir{i},'/dwi_2nd/dt6.mat');
       RoiFileName = {'ctx-lh-pericalcarine.mat','CC_Posterior.mat','ctx-rh-pericalcarine.mat',...
           'Lt-LGN.mat','Rt-LGN.mat','Optic-Chiasm_clean1111.mat'};
       for j = 1:length(RoiFileName)
           [FA,MD,radialADC,axialADC] = dtiROIProperties(dt6File, RoiFileName{j});
           fa{i,j}=FA;
           md{i,j}=MD;
           rd{i,j}=radialADC;
           ad{i,j}=axialADC;
       end
end


%% l-calc fa mean
l = fa{1,1}(1,2);
for k= 2:6;
     l = l+fa{k,1}(1,2);
end 
AveMeanLHON = l/6; AveMeanLHON 

% l-calc fa mean
m = fa{7,1}(1,2);
for k= 8:12;
     m = m+fa{k,1}(1,2);
end 
AveMeanJMD = m/6; AveMeanJMD

% l-calc fa mean
m = fa{13,1}(1,2);
for k= 14:17
     m = m+fa{k,1}(1,2);
end 
AveMeanNorm = m/6; AveMeanNorm

%% R-LGN

% fa mean
l = fa{1,5}(1,2);
for k= 2:6;
     l = l+fa{k,1}(1,2);
end 
AveMeanLHON = l/6; AveMeanLHON 

%  fa mean
m = fa{7,5}(1,2);
for k= 8:12;
     m = m+fa{k,1}(1,2);
end 
AveMeanJMD = m/6; AveMeanJMD

% fa mean
m = fa{13,5}(1,2);
for k= 14:17
     m = m+fa{k,1}(1,2);
end 
AveMeanNorm = m/6; AveMeanNorm

%% Optic chiasm

% fa mean
l = fa{1,5}(1,2);
for k= 2:6;
     l = l+fa{k,1}(1,2);
end 
AveMeanLHON = l/6; AveMeanLHON 

%  fa mean
m = fa{7,5}(1,2);
for k= 8:12;
     m = m+fa{k,1}(1,2);
end 
AveMeanJMD = m/6; AveMeanJMD

% fa mean
m = fa{13,5}(1,2);
for k= 14:17
     m = m+fa{k,1}(1,2);
end 
AveMeanNorm = m/6; AveMeanNorm

