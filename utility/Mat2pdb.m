function fg =  Mat2pdb(fg) 
%    Mat2pdb(fgname)
% change fiber .mat file to .pdb file
%
%
if isstr(fg);
fg = fgRead(fg);
end
if isstruct(fg);end
if isempty(fg);
    sprintf('NO fibers')
end

% [~,n,~] = fileparts(fg);
% fgoutname = sprintf('%s.pdb',n);
fgWrite(fg,fg.name,'pdb');
