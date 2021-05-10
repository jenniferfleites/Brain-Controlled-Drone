function [x,y] = getBinaryFeatures(x,y,LeftOrRight)
%getBinaryFeatures - takes x and y and returns the binary vector
%corresponding to hard right/left and nothing
% LeftOrRight = +1 or -1 for Left and Right respectively
if LeftOrRight == 1
    indcs = y==1|y==5;
elseif LeftOrRight==-1
    indcs = y==1|y==4;
end
 
x = x(indcs,:);
y = y(indcs);
if LeftOrRight == 1
    indcs = y==5;
elseif LeftOrRight==-1
    indcs = y==4;
end
y(indcs) = 2;
end