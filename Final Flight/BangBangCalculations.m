%% BangBang Calculations

w=295;

g=9.81;
rho = 1.225;
% Ct = @(w) ((4.3636e-5)*w+.0713-.01);
Cn = .01777;
Diam = .066;
m=.068;
Ixx=5.8286E-5;
Iyy=7.1691E-5;
Izz=.0001;
I = [m,0,0,0;0,Ixx, 0, 0;0, 0,Iyy,0;0,0,0,Izz];


hover = @(Ct) 4*rho*Diam^4*Ct*w^2/m-g;

Ct = fsolve(hover,.05);

clearvars w;

hover = @(w) 4*rho*Diam^4*Ct*w^2/m-g;
Up = @(w) 4*rho*Diam^4*Ct*w^2/m-1.5*g;
Down = @(w) 4*rho*Diam^4*Ct*w^2/m-.7*g;
w0 = fsolve(hover,300);
wU= fsolve(Up,300);
wD = fsolve(Down,300);
Switch =@(t) 1/2*(1.3*g)*t^2-1;
tSwitch = fsolve(Switch,.5);
tSwitchU = tSwitch+.30;

%% BangBang Calculations with Ct Calculated Using dynamics
% % 
% g=9.81;
% rho = 1.225;
% Ct = @(w) ((4.3636e-5)*w+.0713);
% Cn = .01777;
% Diam = .066;
% m=.075;
% Ixx=5.8286E-5;
% Iyy=7.1691E-5;
% Izz=.0001;
% I = [m,0,0,0;0,Ixx, 0, 0;0, 0,Iyy,0;0,0,0,Izz];
% hover = @(w) 4*rho*Diam^4*Ct(w)*w^2/m-g;
% Up = @(w) 4*rho*Diam^4*Ct(w)*w^2/m-1.4*g;
% Down = @(w) 4*rho*Diam^4*Ct(w)*w^2/m-.6*g;
% w0 = fsolve(hover,300);
% wU= fsolve(Up,300);
% wD = fsolve(Down,300);
% Switch =@(t) 1/2*(1.4*g)*t^2-.5;
% tSwitch = fsolve(Switch,.5);
%}

%{ 
% temp = ones([12,1]);
% temp = diag(temp);
% T = temp;
% T = swap(1,3,temp)*T;
% T = swap(2,6,temp)*T;
% T = swap(3,8,temp)*T;
% T = swap(4,11,temp)*T;
% T = swap(5,7,temp)*T;
% T = swap(6,10,temp)*T;
% T = swap(7,9,temp)*T;
% T = swap(8,12,temp)*T;
% T = swap(9,12,temp)*T;
% T = swap(10,11,temp)*T;
% CLin = zeros(3,12);
% CLin(1,6)=1;
% CLin(2,4)=1;
% CLin(3,8)=1;

function Mat = swap (row1,row2,mat)
    
    temp2 = mat(row1,:);
    mat(row1,:)=mat(row2,:);
    mat(row2,:)=temp2;
    Mat=mat;
    
end
%}