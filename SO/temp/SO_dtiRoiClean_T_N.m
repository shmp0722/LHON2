%% SO_dtiRoiClean_T_N.m
%

baseDir ='/biac4/wandell/biac3/wandell4/data/reading_longitude/dti_adults';
cd(baseDir)
    
subs =  {...
        'aab050307','ah051003','am090121','ams051015','as050307'...
        'aw040809','bw040922','ct060309','db061209','dla050311'...
        'gd040901','gf050826','gm050308','jl040902','jm061209'...
        'jy060309','ka040923','mbs040503','me050126','mo061209'...
        'mod070307','mz040828','pp050208','rfd040630','rk050524'...
        'sc060523','sd050527','sn040831','sp050303','tl051015'...
        'Link to JMD1-MM-20121025-DWI'...
        'Link to JMD2-KK-20121025-DWI'...
        'Link to JMD3-AK-20121026-DWI'...
        'Link to JMD4-AM-20121026-DWI'...
        'Link to JMD5-KK-20121220-DWI'...
        'Link to JMD6-NO-20121220-DWI'...
        'Link to LHON1-TK-20121130-DWI'...
        'Link to LHON2-SO-20121130-DWI'...
        'Link to LHON3-TO-20121130-DWI'...
        'Link to LHON4-GK-20121130-DWI'...
        'Link to LHON5-HS-20121220-DWI'...
        'Link to LHON6-SS-20121221-DWI'...
        'Link to JMD-Ctl-MT-20121025-DWI'...
        'Link to JMD-Ctl-SY-20130222DWI'...
        'Link to JMD-Ctl-YM-20121025-DWI'...
        'Link to JMD-Ctl-HH-20120907DWI'...
        'Link to JMD-Ctl-HT-20120907-DWI'};
    
    roifile = {...
        'Optic-Chiasm.mat'
        'ctx-rh-pericalcarine.mat'
        'ctx-lh-pericalcarine.mat'};
        
for ii = 1:length(subs)
    for ij = 1:length(roifile)
        roi = fullfile(baseDir,subs{ii},'dwi_2nd/ROIs',roifile{ij});
        
        roi = dtiReadRoi(roi);
        
        roi = dtiRoiClean(roi,1,['fillholes', 'dilate', 'removesat']);
        roi.name=[roi.name '_clean1112'];
        
        fileName = fullfile(baseDir,subs{ii},'dwi_2nd/ROIs',roi.name );
        dtiWriteRoi(roi, fileName)
    end
end