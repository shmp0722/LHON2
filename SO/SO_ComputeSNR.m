% FP_ComputeSNR 
% Compute SNR for Shumpei's data
%
%
% This is an example of how to use dwiGet to compute SNR of a diffusion
% image measurements in the set of coordinates identified by a fiber group. 
%
% The calculations are performed on the B0 images
% collected. If you have a sufficient number of B0 images collected (nB0 > 8?) you can
% realiably compute SNR using a voxel-wise calculation without account for
% smal samples. Otherwise you need to account for small sampels and use a
% summary SNR measure across the whole set of coordiantes.
%
% Writen by franco Pestilli (c) Vista soft stanford university
%

% Set directory for Tamagawa data

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
    'JMD-Ctl-HT-20120907-DWI'...
    };

for i= 1:length(subs)

% Identify the files we will use for computing SNR
    for k=1:2;
        switch k
            case 1
                bvalsF = fullfile(homeDir, subs{i},'/raw/dwi1st_aligned_trilin.bvals');
                bvecsF = fullfile(homeDir, subs{i},'/raw/dwi1st_aligned_trilin.bvecs');
                dFile  = fullfile(homeDir, subs{i},'/raw/dwi1st_aligned_trilin.nii.gz');
            case 2
                bvalsF = fullfile(homeDir, subs{i},'/raw/dwi1st_aligned_trilin.bvals');
                bvecsF = fullfile(homeDir, subs{i},'/raw/dwi1st_aligned_trilin.bvecs');
                dFile  = fullfile(homeDir, subs{i},'/raw/dwi1st_aligned_trilin.nii.gz');
        end
        % Load the files into a DWI structure
        dNifti = niftiRead(dFile);
        bvecs = dlmread(bvecsF);
        bvals = dlmread(bvalsF);
        dwi = dwiCreate('nifti',dNifti,'bvecs',bvecs,'bvals',bvals);
        
        % Identify a set of coordinates to comput SNR.
        %
        % Load a fiber group
        fgF = fullfile(homeDir, subs{i},'/dwi_2nd/fibers/LOR_MD3.pdb');
        fg  = fgRead(fgF);
        
        % Get all the coordinates fro the fiber group in the DWi volume (not acpc but img coordinates)
        % Get the xform from acpc to img from the dwi nifti file
        xform = niftiGet(dNifti,'qto_ijk');
        % Transfrom the fg in image coordinates
        fg.fibers = fgGet(fg,'image coords',1:length(fg.fibers),xform)';
        
        % Extract the unique coordinates in the fiber group
        coords = floor(vertcat(fg.fibers{:})');
        coords = unique(coords','rows');
        
        % Compute the snr across the coordinates of the fiber group
        switch k
            case 1
                totalSNR_dwi1st{i} = dwiGet(dwi,'b0 snr roi',coords);
                voxelSNR_dwi1st{i} = dwiGet(dwi,'b0 snr image',coords); % Please notice this calculation does not correct for small samples.
            case 2
                totalSNR_dwi2nd{i} = dwiGet(dwi,'b0 snr roi',coords);
                voxelSNR_dwi2nd{i} = dwiGet(dwi,'b0 snr image',coords); % Please notice this calculation does not correct for small samples.
        end
    end
end
