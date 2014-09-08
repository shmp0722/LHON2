function newROI = dtiSetdiffROIs(roi1,roi2)
%
%   newROI = dtiSetdiffROIs(roi1,roi2)
% 
% Purpose: remove roi.coords the part of intersection
%   ROIs
%
%Example:
% roi1 = dtiRead(roi1); roi2 = dtiRead(rois20;
% newROI = dtiSetdiffROIs(roi1,roi2);
% 
%
% SO wrote 


newROI = roi1;
newROI.name = sprintf('%s_%s',roi1.name,roi2.name);

newROI.coords = setdiff(roi1.coords,roi2.coords,'rows');

% save newROI
dtiWriteRoi(newROI, newROI.name)
return;