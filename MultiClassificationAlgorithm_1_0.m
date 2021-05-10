%% Classification Algorithm
% John Harry Wagner
% Created : 4/10/2021, John Harry Wagner
%
% Modified: v1.0
% 5/9/2021 John Harry Wagner
% Splits Right and Left

clear;
name = 'Cheung';
load([name,'_Feat']);

[xRight,yRight] = getMultiFeatures(x,y,-1);
[xLeft,yLeft] = getMultiFeatures(x,y,1);
ClassifyFeatures(xRight,yRight,name,-1);
ClassifyFeatures(xLeft,yLeft,name,1);
function ClassifyFeatures(x,y,name,LeftOrRight)
%% Split Data
test_set = .25; %fraction out of 1

TotalLength = size(x,1);

trainIndcs = randperm(TotalLength,floor((1-test_set)*TotalLength));
testIndcs = zeros(TotalLength-length(trainIndcs),1);
%get inverse indcs
k_test = 1;
for k_train=1:TotalLength
    if ~ismember(k_train,trainIndcs)
        testIndcs(k_test)=k_train;
        k_test=k_test+1;
    end
end
if testIndcs(end)==0
    error('Inverse Indexing Algorithm didn''t work');
end
xTrain = x(trainIndcs,:);
yTrain = y(trainIndcs,:);
xTest = x(testIndcs,:);
yTest = y(testIndcs);

%% Classify starting with 1 feat and going through all of them

Mdl = fitcecoc(xTrain,yTrain); %fits the model with LINEAR KERNEL
yPredict = predict(Mdl,xTest);

Success = sum(yPredict==yTest);
Acc = Success/length(yTest);
TrainSucc = yTrain==predict(Mdl,xTrain);
BadAcc = sum(TrainSucc)/length(yTrain);

ClassStats.Acc = Acc;
ClassStats.yPredict = yPredict;
ClassStats.BadAcc = BadAcc;

% disp(ClassStats.BadAcc)
ClassStats.BestAccFeatNum = size(x,2);
ClassStats.BestAcc = Acc;
ClassStats.yTest = yTest;

disp(['Test Accuracy: ', num2str(ClassStats.BestAcc)]);
if LeftOrRight>0
    side = 'Left';
else
    side = 'Right';
end
save([name,'_',side,'_ECOC_outputs'],'ClassStats');
function plotMatrix(t,mat,rownum,maxcolnum,varargin)
% mat needs to be a vertical matrix
% optional input of y limits
if size(t,1)==1
    t = t';
end
A = [t,mat];
[m,n] = size(A) ; %#ok<ASGLU>
n = n-1;
lastcol = maxcolnum-(rownum*maxcolnum-n);
for i = 1:n
    if i/maxcolnum<=rownum-1
        subplot(rownum,maxcolnum,i);
    else
        newi = i-n+rownum*lastcol;
        subplot(rownum,lastcol,newi);
    end
    plot(A(:,1),A(:,i+1))
    if nargin>4
        ylim(varargin{1,1});
    end
end
end
end
