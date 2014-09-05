fsDir          = getenv('SUBJECTS_DIR');

subject        ={...
    'JMD1-MM-20121025-DWI'...
    'JMD2-KK-20121025-DWI'...
    'JMD3-AK-20121026-DWI'...
    'JMD4-AM-20121026-DWI'...
    'JMD5-KK-20121220-DWI'...
    'JMD6-NO-20121220-DWI'...
    'JMD7-YN-20130621-DWI'...
    'JMD8-HT-20130621-DWI'...
    'JMD9-TY-20130621-DWI'...
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
    'JMD-Ctl-HT-20120907-DWI'...
    'JMD-Ctl-FN-20130621-DWI'...
    'JMD-Ctl-AM-20130726-DWI'...
    'JMD-Ctl-SO-20130726-DWI'};

%% for aparc.a2009s    
for i= 23:length(subject)
%   hemisphere     = 'lh'; 
  for j = 1:2
      hemisphere = {'rh','lh'}; 
      annotationFile = 'aparc.a2009s'; 
      regMgzFile = fullfile(fsDir,subject,'mri/rawavg.mgz');
      cmd  = fs_annotationToLabelFiles(subject{i},annotationFile,hemisphere{j});%,regMgzFile)
  end
end

return
%% aparc
for i= 23:length(subject)
%   hemisphere     = 'lh'; 
  for j = 1:2
      hemisphere = {'rh','lh'}; 
      annotationFile = 'aparc.a2009s'; 
      regMgzFile = fullfile(fsDir,subject,'mri/rawavg.mgz');
      cmd  = fs_annotationToLabelFiles(subject{i},annotationFile,hemisphere{j});%,regMgzFile)
  end
end