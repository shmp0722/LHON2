function [TractProfile, fg_SDm3,fg_SDm2,fg_SDm1,fg_SD1,fg_SD2,fg_SD3]...
    = SO_DivideFibersAcordingToFiberLength_SD3(fg,dt,distribution,direction,Nodes)
% divide the fascicle into 7groups according to fiber length (standard 
% deviation from -3 to 3, and orinal fascicle) and return difusion 
% properties of these fascicles with Tractprofile structure  
%
% Example
% fg = fgRead('fg'); % or fullpath
% dt =  dtiLoadDt6(dt);
% distribution = 1 ;% show original fiber length distribution histgraph
% direction = 'AP', 'LR', or 'SI'; % align fiber direction
% Nodes =100;

%% Argument check
   
    if ~isstruct(dt); dt = dtiLoadDt6(dt);end;
    % load fg
    if ~isstruct(fg); fg = fgRead(fg);end;
    % Create a variable to save the origional fiber group before starting to
    % clean it
    fg_orig = fg;
    
    % First classfy fibers according to length
    Lnorm     = AFQ_FiberLengthHist(fg_orig,distribution);      
   
%     SD_m4 = Lnorm < -3 ;
    SD_m3 =  Lnorm < -2 ;
    SD_m2 =  Lnorm < -1 & Lnorm >= -2;
    SD_m1 =  Lnorm < 0 & Lnorm >= -1;
    SD_1p  = Lnorm < 1 & Lnorm >= 0;
    SD_2p  = Lnorm < 2 & Lnorm >= 1;
    SD_3p   = Lnorm >= 2;
    
    %% creat new fibers     
    if sum(SD_m3) <5;fg_SDm3 =[];
    else
        fg_SDm3 = dtiNewFiberGroup('fg_SDm3','b',[],[],fg_orig.fibers(logical(SD_m3)));
    end;
    
    if sum(SD_m2) <5;fg_SDm2 =[];
    else
    fg_SDm2 = dtiNewFiberGroup('fg_SDm2','b',[],[],fg_orig.fibers(logical(SD_m2)));
    end;
    
    if sum(SD_m1) <5;fg_SDm1 =[];
    else
    fg_SDm1  = dtiNewFiberGroup('fg_SDm1','b',[],[],fg_orig.fibers(logical(SD_m1)));
    end;
    if sum(SD_1p) <5;fg_SD1 =[];
    else
    fg_SD1  = dtiNewFiberGroup('fg_SD1','b',[],[],fg_orig.fibers(logical(SD_1p)));
    end;
    
    if sum(SD_2p) <5;fg_SD2 =[];
    else
    fg_SD2  = dtiNewFiberGroup('fg_SD2','b',[],[],fg_orig.fibers(logical(SD_2p)));
    end;
    
    if sum(SD_3p) <5;fg_SD3 =[];
    else
    fg_SD3  = dtiNewFiberGroup('fg_SD3','b',[],[],fg_orig.fibers(logical(SD_3p)));
    end
    
   fgF = {fg, fg_SDm3,fg_SDm2,fg_SDm1,fg_SD1,fg_SD2,fg_SD3};
   
      
%% let's get diffusivities 
for jj =1:length(fgF)
    if isempty(fgF{jj});
        TractProfile{jj}= AFQ_CreateTractProfile;
    else
        TractProfile{jj} = SO_FiberValsInTractProfiles(fgF{jj},dt,direction,Nodes,1);
    end
end
 