function [cmdRL cmdFB] = Class2CommandBin(yR,yL)
if yR==1 && yL ==1
    cmdRL = 0;
    cmdFB = -1;
elseif yR==1 && yL==2
    cmdRL = -1;
    cmdFB = 0;
elseif yR==2 && yL==1
    cmdRL = 1;
    cmdFB = 0;
elseif yR==2 && yL==2
    cmdRL = 0;
    cmdFB = 1;
else
    error('you didn''t consider this case');
end
end