%% copy a mat to ROIs directory

fsDir          = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan/freesurfer';
roiDir         = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
subject      = {...
%     'JMD1-MM-20121025-DWI','JMD2-KK-20121025-DWI','JMD3-AK-20121026-DWI'...
%     'JMD5-KK-20121220-DWI','JMD6-NO-20121220-DWI','LHON1-TK-20121130-DWI'...
%     'LHON2-SO-20121130-DWI','LHON3-TO-20121130-DWI','LHON4-GK-20121130-DWI'...
%     'LHON5-HS-20121220-DWI','LHON6-SS-20121221-DWI','JMD-Ctl-MT-20121025-DWI'...
%     'JMD-Ctl-SY-20130222DWI','JMD-Ctl-YM-20121025-DWI','JMD-Ctl-HH-20120907DWI'...
%     'JMD-Ctl-HT-20120907-DWI'
% 'JMD7-YN-20130621-DWI'
% 'JMD8-HT-20130621-DWI'
% 'JMD9-TY-20130621-DWI'
'JMD-Ctl-FN-20130621-DWI'
};

for i    = 1:length(subject)
fromfile = fullfile(fsDir,subject{i},'/label/*.mat');
goDir    = fullfile(roiDir,subject{i},'/dwi_2nd/ROIs');

copyfile(fromfile,goDir)
end