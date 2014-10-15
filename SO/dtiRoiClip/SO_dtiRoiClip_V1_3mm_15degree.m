function SO_dtiRoiClip_V1_3mm_15degree

%% Clip orig V1 ROI at mean 
    for ii = 1 : length(afq.sub_dirs)
        %     for k = 21:22
        RoiDir = fullfile(AFQdata,subs{ii},'/dwi_2nd/ROIs');
        Roi ={'lh_V1.mat','rh_V1.mat'};
        for kk =  1:2
            
            roi2 = dtiReadRoi(fullfile(RoiDir,Roi{kk}));
            
            % get mean position Y
            Y = round(mean(roi2.coords(:,2,:)));
            
            % dtiRoiClip
            apClip=[-120 Y];
            [roiAnt, roiPost] = dtiRoiClip(roi2, [], apClip, []);
            
            % save
            cd( fullfile(AFQdata,subs{ii},'/dwi_2nd/ROIs'))
            dtiWriteRoi(roiPost, [roiPost.name(1:end-4),'_Center'])
            dtiWriteRoi(roiAnt, [roiAnt.name,'_Peri'])
            
        end
    end