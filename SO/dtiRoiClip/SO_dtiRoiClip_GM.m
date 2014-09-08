%% SO_dtiRoiClip_V1_3mm
% Clip V1 ROI, Y= -60

% homeDir
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

% subs in colum
subJ = {
    'JMD1-MM-20121025-DWI'
    'JMD2-KK-20121025-DWI'
    'JMD3-AK-20121026-DWI'
    'JMD4-AM-20121026-DWI'
    'JMD5-KK-20121220-DWI'
    'JMD6-NO-20121220-DWI'
    'JMD7-YN-20130621-DWI'
    'JMD8-HT-20130621-DWI'
    'JMD9-TY-20130621-DWI'
    'LHON1-TK-20121130-DWI'
    'LHON2-SO-20121130-DWI'
    'LHON3-TO-20121130-DWI'
    'LHON4-GK-20121130-DWI'
    'LHON5-HS-20121220-DWI'
    'LHON6-SS-20121221-DWI'
    'JMD-Ctl-MT-20121025-DWI'
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-FN-20130621-DWI'
    'JMD-Ctl-HT-20120907-DWI'};

%loop subject
for i = 2:length(subJ)  % 3 imcomplete

    % define derectory   
    RoiDir = fullfile(homeDir,subJ{i},'/dwi_2nd/ROIs');
       
    roi5 =fullfile(RoiDir,'Left-Cerebral-Cortex.mat');
    roi6 =fullfile(RoiDir,'Right-Cerebral-Cortex.mat');

    cd(RoiDir)
    
    %% Argument checking
   
    if ischar(roi5)
        roi5 = dtiReadRoi(roi5);
    end
    if ischar(roi6)
        roi6 = dtiReadRoi(roi6);
    end
    
    % dtiRoiClip
    apClip=[-60 80];
    [roi5, roi5Not] = dtiRoiClip(roi5, [], apClip, []);
    dtiWriteRoi(roi5Not, roi5Not.name)
    
    [roi6, roi6Not] = dtiRoiClip(roi6, [], apClip, []);
    dtiWriteRoi(roi6Not, roi6Not.name)
    
end