function [cmdRL cmdFB] = Class2CommandMulti(yR,yL)
% Class2CommandMulti - Gives the command from the classification
% 1 means Right or Forward, -1 means Left or Backward, 0 means no movement
% It is baised not to move unless the specific condition is met

if yR==1
    if yL ==1
        cmdRL = 0;
        cmdFB = -1;
    elseif yL==2
        cmdRL = 0;
        cmdFB = 0;
    elseif yL==3
        cmdRL = -1;
        cmdFB = 0;
    end
elseif yR==2
    if yL==1
        cmdRL = 0;
        cmdFB = 0;
    elseif yL==2
        cmdRL = 0;
        cmdFB = 0;
    elseif yL==3
        cmdRL = 0;
        cmdFB = 0;
    end    
else
    if yL==1
        cmdRL = 1;
        cmdFB = 0;
    elseif yL==2
        cmdRL = 0;
        cmdFB = 0;
    elseif yL==3
        cmdRL = 0;
        cmdFB = 1;
    end 
end
end