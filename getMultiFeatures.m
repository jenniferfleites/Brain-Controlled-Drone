function [x,y] = getMultiFeatures(x,y,LeftOrRight)
%getMultiFeatures - takes x and y and returns the binary vector
%corresponding to hard right/left and nothing
% LeftOrRight = +1 or -1 for Left and Right respectively
if LeftOrRight == 1
    indcs = y==1|y==3|y==5;
elseif LeftOrRight==-1
    indcs = y==1|y==2|y==4;
end
 
x = x(indcs,:);
y = y(indcs);

if LeftOrRight == 1
    indcs = y==3;
elseif LeftOrRight==-1
    indcs = y==2;
end
y(indcs) = 2;

if LeftOrRight == 1
    indcs = y==5;
elseif LeftOrRight==-1
    indcs = y==4;
end
y(indcs) = 3;
end