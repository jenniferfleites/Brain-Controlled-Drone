%% Global Parameters
clear;
close all;
DataRemovedFromBandpass = 6; %sec
OneSidedBuffer = 1; %sec (1/2 total seconds removed per switch time)
EventWindow = 5; %sec

%% load data

JH.name = 'WagnerPower_250.mat';
JH.lag = 1.175;
JH.start = 15;
JH.Fs = 250;
JH.FreqStepSize = 1;
JH.FreqStart = 1;
JH.FreqStop = 30;
JH.ylim = [0 .3];
JH.FeatSaveName = 'Wagner_Feat';

Jen.name = 'FleitesPower_250.mat';
Jen.lag = .848;%WRONG______________
Jen.start = 20;
Jen.Fs = 250;
Jen.FreqStepSize = 1;
Jen.FreqStart = 1;
Jen.FreqStop = 30;
Jen.FeatSaveName = 'Fleites_Feat';
Jen.ylim = [0 150];

Eva.name = 'CheungPower_250.mat';
Eva.lag = 1.18;%WRONG__________________________-
Eva.FreqStepSize = 1;
Eva.start = 20;
Eva.Fs = 250;
Eva.FreqStart = 1;
Eva.FreqStop = 30;
Eva.ylim = [0 400];
Eva.FeatSaveName = 'Cheung_Feat';

File = Eva; %Set This _____________________________

Pow1 = load(File.name,'s15');
Pow1 = Pow1.s15;
Pow2 = load(File.name,'s17');
Pow2 = Pow2.s17;
OldPow = [Pow1;Pow2]';
Pow = zeros(size(OldPow));
for iPow=1:size(Pow,1)
    for jPow = 1:size(Pow,2)
        Pow(iPow,jPow) = (real(OldPow(iPow,jPow))).^2+(imag(OldPow(iPow,jPow))).^2;
    end
end

Fs = File.Fs;
start = File.start;
lag = File.lag;
FreqStepSize = File.FreqStepSize;
FreqStart = File.FreqStart;
FreqStop = File.FreqStop;

%% Create feature vector w/classes
y = zeros(length(Pow),1);
x = zeros(size(Pow));
if OneSidedBuffer*2>EventWindow
    error('Buffer is greater than the total event window');
end

% remove excess data
tStart = start+lag-DataRemovedFromBandpass; % intended start time, plus lag time, -6 seconds removed
i_pow=ceil(tStart*Fs); %references pow
i_x = 1;%references into x
itKind = 1;%labels
while i_pow+Fs*(EventWindow-1)<length(Pow)
    FeatWindow = i_pow+OneSidedBuffer*Fs:i_pow+(EventWindow-OneSidedBuffer)*Fs-1;
    y(i_x:i_x+length(FeatWindow)-1) = itKind;
    x(i_x:i_x+length(FeatWindow)-1,:) = Pow(FeatWindow,:);
    
    i_pow = i_pow+(EventWindow)*Fs;
    i_x = i_x+length(FeatWindow);
    
    if itKind==5
        itKind=1;
    else
        itKind = itKind+1;
    end
end
lastnonzero = find(y,1,'last');
if sum(y(lastnonzero+1:end))>0
    error('Didn''t properly remove trailing zeros');
elseif y(lastnonzero)==0
    error('index is to a zero value')
elseif sum(y(1:lastnonzero)==0)>0
    error('zero value in class vector');
elseif sum(x(1:lastnonzero,:)==0)>0
    error('zero values in feature vector');
end
x = x(1:lastnonzero,:);

y = y(1:lastnonzero);
if sum(y==0)
    error('zero in class vector');
end
classLabels = {'Nothing','Soft Right','Soft Left','Hard Right','Hard Left'};

%% Select Freq Features
MuStart = 8;
MuEnd = 13;
SensStart = 13;
SensEnd = 13;

Freqs = FreqStart:FreqStepSize:FreqStop;
FeatFreqs = (Freqs>MuStart-FreqStepSize&Freqs<MuEnd)|(Freqs>SensStart-FreqStepSize&Freqs<SensEnd);
FeatFreqs = [FeatFreqs,FeatFreqs];
disp(find(FeatFreqs));
if size(x,2)>size(x,1)
    error('FeatFreqs Dims Size (or it''s really short)');
end
x = x(:,FeatFreqs);
t = (0:length(x)-1)/Fs;
if sum(FeatFreqs>0)~=10
    disp('You changed FeatFreqs w/o changing what you''re plotting');
end
oldx = x;
for k_RO = 1:size(x,2)
    x(:,k_RO) = RemoveOutliers(x(:,k_RO),'major');
end
figure;
plot(t,oldx(:,7));
yl = ylim;
ylabel('Power (\muV^2)');
xlabel('Time (sec)');
figure;
plot(t,x(:,7));
ylabel('Power (\muV^2)');
xlabel('Time (sec)');
ylim(yl);

save(File.FeatSaveName,'x','y','Fs');

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
function [NewData] = RemoveOutliers(Data,varargin)
%RemoveOutliers Removes Major or Minor Outliers
%   varargin = [major/minor, 'EEG' if filtering eeg data]
IQR = iqr(Data);
lbound =0;
if nargin > 1
    if strcmp(varargin{1,1},'minor')
        coeff = 1.5;
    elseif strcmp(varargin{1,1},'major')
        coeff = 3;
    else
        error('Input should either be ''minor'' or ''major''.');
    end
elseif nargin ==1
    coeff = 1.5; %default minor
end

if nargin >2
    if strcmp('EEG',varargin{1,2})
        lbound = 1;
    end
end

if nargin >3
    error('Too Many Input Args');
end

ubound = prctile(Data,75)+coeff*IQR;

if lbound
    lbound = prctile(Data,25)-coeff*IQR;
elseif find(prctile(Data,25)-coeff*IQR > Data)
    disp('The data Has negative values');
end



NewData = Data;

ind = find(Data > ubound | Data < lbound);
LogInd = zeros(size(Data));
LogInd(ind) = 1; %Find where it's too big
opInd = ~LogInd; %Get opposite
NewData(ind) = mean(Data(opInd)); %Remove those spots
end