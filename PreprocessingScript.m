%Import EEG data and convert from .hdf5 file to .m file
file =ghdf5read('Wagner428.hdf5');
data1=file.RawData.Samples';
Fs=250;%sampling frequency
[a,b]=size(data1);%obtain size of data

%Apply bandpass filter between 1 and 30hz
data = bandpass(data1, [1, 30], Fs);

%Normalize data
%take standard deviation of first 13 to 20s for john, 13 to 25s for jen and eva and then
%normailze by dividing data by standard deviation. 
x=20;
c1=data(:,1)/std(data(13*250:x*250,1));
c2=data(:,2)/std(data(13*250:x*250,2));
c3=data(:,3)/std(data(13*250:x*250,3));
c4=data(:,4)/std(data(13*250:x*250,4));
c5=data(:,5)/std(data(13*250:x*250,5));
c6=data(:,6)/std(data(13*250:x*250,6));
c7=data(:,7)/std(data(13*250:x*250,7));
c8=data(:,8)/std(data(13*250:x*250,8));
c9=data(:,9)/std(data(13*250:x*250,9));
c10=data(:,10)/std(data(13*250:x*250,10));
c11=data(:,11)/std(data(13*250:x*250,11));
c12=data(:,12)/std(data(13*250:x*250,12));
c13=data(:,13)/std(data(13*250:x*250,13));
c14=data(:,14)/std(data(13*250:x*250,14));
c15=data(:,15)/std(data(13*250:x*250,15));
c16=data(:,16)/std(data(13*250:x*250,16));
c17=data(:,17)/std(data(13*250:x*250,17));
c18=data(:,18)/std(data(13*250:x*250,18));
c19=data(:,19)/std(data(13*250:x*250,19));
c20=data(:,20)/std(data(13*250:x*250,20));
c21=data(:,21)/std(data(13*250:x*250,21));
c22=data(:,22)/std(data(13*250:x*250,22));
c23=data(:,23)/std(data(13*250:x*250,23));
c24=data(:,24)/std(data(13*250:x*250,24));
c25=data(:,25)/std(data(13*250:x*250,25));
c26=data(:,26)/std(data(13*250:x*250,26));
c27=data(:,27)/std(data(13*250:x*250,27));
c28=data(:,28)/std(data(13*250:x*250,28));
c29=data(:,29)/std(data(13*250:x*250,29));
c30=data(:,30)/std(data(13*250:x*250,30));
c31=data(:,31)/std(data(13*250:x*250,31));
c32=data(:,32)/std(data(13*250:x*250,32));

data=[c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13...
    c14 c15 c16 c17 c18 c19 c20 c21 c22 c23 c24 c25 c26...
    c27 c28 c29 c30 c31 c32];


%Perform a Laplacian montage on the data
lchannels=zeros(a,b);
lchannels(:,1)=data(:,1)-((data(:,2)+data(:,3)+data(:,5))/3); %Fp1
lchannels(:,2)=data(:,2)-((data(:,1)+data(:,4)+data(:,9))/3); %Fp2
lchannels(:,3)=data(:,3)-((data(:,1)+data(:,5)+data(:,6)+data(:,7))/4); %AF3
lchannels(:,4)=data(:,4)-((data(:,2)+data(:,7)+data(:,8)+data(:,9))/4); %AF4

lchannels(:,5)=data(:,5)-((data(:,3)+data(:,6)+data(:,10))/3); %F7
lchannels(:,6)=data(:,6)-((data(:,3)+data(:,5)+data(:,10)+data(:,7)+data(:,11))/5);%F3
lchannels(:,7)=data(:,7)-((data(:,3)+data(:,4)+data(:,6)+data(:,8)+data(:,11)+data(:,12))/6);%Fz
lchannels(:,8)=data(:,8)-((data(:,4)+data(:,9)+data(:,7)+data(:,12)+data(:,13))/5);%F4
lchannels(:,9)=data(:,9)-((data(:,4)+data(:,8)+data(:,13))/3); %F8

lchannels(:,10)=data(:,10)-((data(:,5)+data(:,6)+data(:,11)+data(:,14)+data(:,15))/5); %FC5
lchannels(:,11)=data(:,11)-((data(:,6)+data(:,7)+data(:,10)+data(:,12)+data(:,15)+data(:,16))/6);%FC1
lchannels(:,12)=data(:,12)-((data(:,7)+data(:,8)+data(:,11)+data(:,13)+data(:,16)+data(:,17))/6);%FC2
lchannels(:,13)=data(:,13)-((data(:,9)+data(:,8)+data(:,12)+data(:,17)+data(:,18))/5);%FC6

lchannels(:,14)=data(:,14)-((data(:,10)+data(:,15)+data(:,19))/3); %T7
lchannels(:,15)=data(:,15)-((data(:,10)+data(:,11)+data(:,19)+data(:,20)+data(:,14)+data(:,16))/6);%C3
lchannels(:,16)=data(:,16)-((data(:,11)+data(:,12)+data(:,20)+data(:,21)+data(:,15)+data(:,17))/6);%Cz
lchannels(:,17)=data(:,17)-((data(:,12)+data(:,13)+data(:,21)+data(:,22)+data(:,16)+data(:,18))/6);%C4
lchannels(:,18)=data(:,18)-((data(:,13)+data(:,17)+data(:,22))/3); %T8

lchannels(:,19)=data(:,19)-((data(:,14)+data(:,15)+data(:,20)+data(:,24)+data(:,23))/5);%CP5
lchannels(:,20)=data(:,20)-((data(:,15)+data(:,16)+data(:,19)+data(:,21)+data(:,24)+data(:,25))/6);%CP1
lchannels(:,21)=data(:,21)-((data(:,16)+data(:,17)+data(:,20)+data(:,22)+data(:,25)+data(:,26))/6);%CP2
lchannels(:,22)=data(:,22)-((data(:,18)+data(:,17)+data(:,21)+data(:,26)+data(:,27))/5);%CP6


lchannels(:,23)=data(:,23)-((data(:,19)+data(:,24)+data(:,28)+data(:,29))/4); %P7
lchannels(:,24)=data(:,24)-((data(:,19)+data(:,20)+data(:,23)+data(:,25)+data(:,28)+data(:,29))/6);%P3
lchannels(:,25)=data(:,25)-((data(:,20)+data(:,21)+data(:,24)+data(:,26)+data(:,29)+data(:,30))/6);%Pz
lchannels(:,26)=data(:,26)-((data(:,21)+data(:,22)+data(:,25)+data(:,27)+data(:,30)+data(:,31))/6);%P4
lchannels(:,27)=data(:,27)-((data(:,22)+data(:,26)+data(:,31)+data(:,30))/4); %P8

lchannels(:,28)=data(:,28)-((data(:,23)+data(:,24)+data(:,29))/3); %PQ7
lchannels(:,29)=data(:,29)-((data(:,23)+data(:,24)+data(:,25)+data(:,28)+data(:,32))/5); %PQ3
lchannels(:,30)=data(:,30)-((data(:,26)+data(:,27)+data(:,25)+data(:,31)+data(:,32))/5); %PQ4
lchannels(:,31)=data(:,31)-((data(:,30)+data(:,26)+data(:,27))/3); %PQ8
lchannels(:,32)=data(:,32);

%Trim the first and last 6 seconds of data
lchannels=lchannels(6*250:(end-6*250),:);

%Use EEGLAB to implement infomax ICA and remove artifacts


% Compute the PSD for each channel
window=250;
overap=249;

[s1,f,t]=spectrogram(EEG.data(1,:),window,overap,[1:30],Fs,'onesided','yaxis'); 
s2=spectrogram(EEG.data(2,:),window,overap,[1:30],Fs,'onesided','yaxis'); 
s3=spectrogram(EEG.data(3,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s4=spectrogram(EEG.data(4,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s5=spectrogram(EEG.data(5,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s6=spectrogram(EEG.data(6,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s7=spectrogram(EEG.data(7,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s8=spectrogram(EEG.data(8,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s9=spectrogram(EEG.data(9,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s10=spectrogram(EEG.data(10,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s11=spectrogram(EEG.data(11,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s12=spectrogram(EEG.data(12,:),window,overap,[1:30],Fs,'onesided','yaxis'); 
s13=spectrogram(EEG.data(13,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s14=spectrogram(EEG.data(14,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s15=spectrogram(EEG.data(15,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s16=spectrogram(EEG.data(16,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s17=spectrogram(EEG.data(17,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s18=spectrogram(EEG.data(18,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s19=spectrogram(EEG.data(19,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s20=spectrogram(EEG.data(20,:),window,overap,[1:30],Fs,'onesided','yaxis'); 
s21=spectrogram(EEG.data(21,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s22=spectrogram(EEG.data(22,:),window,overap,[1:30],Fs,'onesided','yaxis'); 
s23=spectrogram(EEG.data(23,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s24=spectrogram(EEG.data(24,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s25=spectrogram(EEG.data(25,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s26=spectrogram(EEG.data(26,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s27=spectrogram(EEG.data(27,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s28=spectrogram(EEG.data(28,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s29=spectrogram(EEG.data(29,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s30=spectrogram(EEG.data(30,:),window,overap,[1:30],Fs,'onesided','yaxis'); 
s31=spectrogram(EEG.data(31,:),window,overap,[1:30],Fs,'onesided','yaxis');  
s32=spectrogram(EEG.data(32,:),window,overap,[1:30],Fs,'onesided','yaxis');