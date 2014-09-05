%% dtiintersect
% intersect CFM fibers with oppsite hemisphere WM ROI.

%Set the path to data directory
homeDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';

 
subs = {...
    'JMD1-MM-20121025-DWI'
    'JMD2-KK-20121025-DWI'
    'JMD3-AK-20121026-DWI'
    'JMD4-AM-20121026-DWI'
    'JMD5-KK-20121220-DWI'
    'JMD6-NO-20121220-DWI'
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
    'JMD-Ctl-HT-20120907-DWI'
    };


for ii = 1:length(subs)
       
    SubDir=fullfile(homeDir,subs{ii});
    ctrDir = (fullfile(SubDir,'/dwi_2nd/fibers/conTrack/Mori_OCF')); 
    cd(ctrDir)
    
    % select fg and ROI
    fgfile = 'fg_Mori_OCF_Mori_LOcc_Mori_ROcc_2013-05-14_15.01.11.pdb';
    
    Roifile1 = 'CC.mat';
    
    % load dt, fg.pdb
        dt = dtiLoadDt6(fullfile(SubDir,'dwi_2nd','dt6.mat'));
        fg1 = mtrImportFibers(fullfile(ctrDir,fgfile));
%         fg1 = fgRead(fgfile);
       
        % Input arguments
        options = 'and';
        minDist = 0.87;
        handles = 0;
           
        roi1 = dtiReadRoi(fullfile(homeDir,subs{ii},'dwi_2nd','ROIs',Roifile1));
        [fgOut1,contentiousFibers1, keep1, keepID1] = dtiIntersectFibersWithRoi(handles, options, minDist, roi1, fg1); 

        % save the pdb file 
            savefilename = sprintf('%s.pdb',fgOut1.name);   
%             savefile  = fullfile(ctrDir,'Top100kNotWmHippo');
%             cd(savefile)      

            mtrExportFibers(fgOut1,savefilename);
           
    
end




    