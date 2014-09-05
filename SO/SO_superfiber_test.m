%% get a superfiber
% set directory

baseDir = '/biac4/wandell/biac2/wandell/data/DWI-Tamagawa-Japan';
cd(baseDir)

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
    'JMD-Ctl-YM-20121025-DWI'
    'JMD-Ctl-SY-20130222DWI'
    'JMD-Ctl-HH-20120907DWI'
    'JMD-Ctl-HT-20120907-DWI'};

% loop subs and ORfg
for    ii = 1:length(subs)
    fromDirs = fullfile(baseDir,subs{ii},'/dwi_2nd/fibers') ;
    cd(fromDirs)
    
     ORfg ={...
%     'LOR_MD3.pdb'
%     'LOR_MD4.pdb'
%     'ROR_MD3.pdb'
%     'ROR_MD4.pdb'    
    'fg_ROR_BigNotROI_MD3.pdb'
    'fg_ROR_BigNotROI_MD4.pdb'
    'fg_ROR_BigNotROI_MD5.pdb'
    'fg_LOR_BigNotROI_MD3.pdb'
    'fg_LOR_BigNotROI_MD4.pdb'
    'fg_LOR_BigNotROI_MD5.pdb'};
    
    for i = 1:length(ORfg)
   
        fg= fgRead(ORfg{i});
        numNodes = 100;
        
        [SuperFiber1, sfg1] = dtiComputeSuperFiberRepresentation(fg, [], numNodes,'median');
        [SuperFiber2, sfg2] = dtiComputeSuperFiberRepresentation(fg, [], numNodes,'mean');
        
        sFg1 = dtiNewFiberGroup([fg.name '_superFiber_Median'],[0 0 155],[],[],SuperFiber1.fibers);
        sFg2 = dtiNewFiberGroup([fg.name '_superFiber_Mean'],[0 0 155],[],[],SuperFiber2.fibers);
        
        % Save the two superfibers

        mtrExportFibers(sFg1,sFg1.name);
        mtrExportFibers(sFg2,sFg2.name);

    end
end
     
