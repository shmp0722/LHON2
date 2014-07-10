function matfile = Pdb2mat(fgname) 
% change fiber .pdb file to .mat file
% 
fg = fgRead(fgname);
fg.name = sprintf('%s.mat',fg.name);
fgWrite(fg,fg.name,'mat');
