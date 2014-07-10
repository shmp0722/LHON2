function pdbfile = Mat2pdb(fgname) 
% change fiber .mat file to .pdb file

fg = fgRead(fgname);
[~,n,~] = fileparts(fgname);
fgoutname = sprintf('%s.pdb',n);
fgWrite(fg,fgoutname,'pdb');
