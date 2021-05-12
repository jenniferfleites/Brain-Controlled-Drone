%% Write out the continuous plant matrices
% Define the plant 
% NoiseCharacterization;
A2by2= [0,1;0,0];
Ts = .005;
g= 9.81;
% b = -0.0624;
Bt = [0;-0.0624];
At = A2by2;

b = 3.1802;
Be = [0;b;0];
Ae = [0,1,0;0,0,0;-g,0,0];


b = 2.7736;
Ba = [0;b;0];
Aa = [0,1,0;0,0,0;g,0,0];


b = -.6618;
Br = b;
Ar = 0;

%% Write out Cost function for feedback Gains
Qt=zeros(2);
Qe=zeros(3);
Qa=zeros(3);

Qt(1,1)= 8;
Qt(2,2) = 4;
Rt = 1/200;

% Qe(1,1)= 1/10;
% Qe(2,2) = 300;%30000;
% Qe(3,3) = 1;
% Re = 100;
% 
% Qa(1,1) = 1/10;
% Qa(2,2) = 300;%000;
% Qa(3,3) = 1;
% Ra = 100;

Qe(1,1)= 1/10;
Qe(2,2) = 200000;
Qe(3,3) = 1;
Re = 12*16;

Qa(1,1) = 1/10;
Qa(2,2) = 200000;
Qa(3,3) = 1;
Ra = 24*16;

% Qe(1,1)= 1/10;
% Qe(2,2) = 200000;
% Qe(3,3) = 1;
% Re = 48*16;
% 
% Qa(1,1) = 1/10;
% Qa(2,2) = 200000;
% Qa(3,3) = 1;
% Ra = 24*16;

Qr=2;
Rr = 1/100;

Kt = lqr(At,Bt,Qt,Rt);
Ke = lqr(Ae,Be,Qe,Re);
Ka = lqr(Aa,Ba,Qa,Ra);
Kr = lqr(Ar,Br,Qr,Rr);

Kr = Kr;%   -0.7805
%{
% calculate gains
K = lqr(A,B,Q,R);

%% Make closed loop system
% u = - kx
Acl= A-B*K;


% Output all states
C= eye(2); D=0;
C(3,:) = -K;

%% Make state space representation
ssc = ss(Acl,B,C,D);

%% Simulate the responses



clf
% rlocus(ss);
subplot(1,2,1);
bode(ssc);
subplot(2,2,2);
nyquist(ssc);
subplot(2,2,4);
x0 =[1;1];
initial(ssc,x0);
disp(K);
disp(pole(ssc));
%}