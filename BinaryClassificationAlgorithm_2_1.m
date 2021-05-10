%% Classification Algorithm
% John Harry Wagner
% Created : 4/10/2021, John Harry Wagner
%
% Modified: v2.0
% 5/6/2021 John Harry Wagner
% Loads data and implements getBinaryFeatures.m
% Return models
%% load data

svmkernel = 'rbf'; %'rbf' or 'linear'

name = 'Wagner';
load([name,'_Feat']);

[xRight,yRight] = getBinaryFeatures(x,y,-1);
[xLeft,yLeft] = getBinaryFeatures(x,y,1);
RightMdl = ClassifyBinFeatures(xRight,yRight,name,svmkernel,-1);
LeftMdl = ClassifyBinFeatures(xLeft,yLeft,name,svmkernel,1);

save('RBF_Mdls','RightMdl','LeftMdl');

function Mdl = ClassifyBinFeatures(x,y,savename,svmkernel,LeftOrRight)
% ClassifyBinFeatures - Performs the classifications and saves relevant
% data
% svmkernel will change the kernel, chooes between 'linear' and 'gaussian'
% LeftOrRight = +1 or -1 for Left or Right side respectively
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

%% Classify

%Fit and predict
Mdl = fitcsvm(xTrain,yTrain,'KernelFunction',svmkernel); %fits the model with LINEAR KERNEL
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
save([savename,'_',side,'_',svmkernel,'SVM_outputs'],'ClassStats');

end