%% New T Plant
syms g A3 b tao
Ts = .005;
A2= sym([0,1;0,0]);
% B1 = b;
B2 = [0;b];

A2disc = double(expm(A2*Ts));

B2disc = int(expm(A2*(Ts-tao))*B2,0,Ts);

bnew = 1;
Bt_kal = double(subs(B2disc,b,bnew));
At_kal = A2disc;
Ct_kal = [-1,0];

%% Other Plants
Atemp = zeros(4);
A4 = sym(Atemp);
A4(4,1) = g;
A4(3,2) = -g;
B4 = sym(eye(4));
A4disc = expm(A4*Ts);
A = double(subs(A4disc,9.81));
B4disc = int(expm(A4*(Ts-tao))*B4,0,Ts);
B = double(subs(B4disc,9.81));

C=eye(4);

