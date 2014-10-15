%% SO_dtiRoiClip_V1_3mm
% Clip V1 ROI, Y= -60

% homeDir
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

% subs in colum
subJ = {...
%     'JMD7-YN-20130621-DWI'
%     'JMD8-HT-20130621-DWI'
%     'JMD9-TY-20130621-DWI'
%     'JMD-Ctl-FN-20130621-DWI'
%     'JMD-Ctl-AM-20130726-DWI'
%     'JMD-Ctl-SO-20130726-DWI' 
    'RP1-TT-2013-11-01'};
%     'RP2-KI-2013-11-01'};
%loop subject
for i = 1:length(subJ)  % 3 imcomplete

    % define derectory   
    RoiDir = fullfile(homeDir,subJ{i},'/dwi_2nd/ROIs');
       
    roi5 =fullfile(RoiDir,'lh_V1_smooth3mm.mat');
    roi6 =fullfile(RoiDir,'rh_V1_smooth3mm.mat');

    cd(RoiDir)
    
    %% Argument checking
   
    if ischar(roi5)
        roi5 = dtiReadRoi(roi5);
    end
    if ischar(roi6)
        roi6 = dtiReadRoi(roi6);
    end
    
    % dtiRoiClip
    apClip=[-120 -60];
    [roi5, roi5Not] = dtiRoiClip(roi5, [], apClip, []);
    dtiWriteRoi(roi5Not, roi5Not.name)
    
    [roi6, roi6Not] = dtiRoiClip(roi6, [], apClip, []);
    dtiWriteRoi(roi6Not, roi6Not.name)
    
end