for i = 1:11
fgfile = fullfile(afq.files.fibers.OCF07Mori{i}); 

Mat2pdb(fgfile)

end