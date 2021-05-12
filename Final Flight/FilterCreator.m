%% CreateFilter

s = tf('s');
CutoffFreq=15;
filt = 1/(1+s/CutoffFreq);
dFilt  = c2d(filt,.005);
num = dFilt.Numerator{1,1};
denom = dFilt.Denominator{1,1};
denom = denom(2);

%% Create R filter

s = tf('s');
CutoffFreq=15;
filt = 1/(1+s/CutoffFreq);
dFilt  = c2d(filt,.005);
rnum = dFilt.Numerator{1,1};
rdenom = dFilt.Denominator{1,1};
rdenom = rdenom(2);