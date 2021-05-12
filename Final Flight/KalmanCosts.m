%% Define costs for Kalman Filter

Qt = [0,0;0,0.0111];
Rt = 11;%.22

Q = eye(4)*.001;
R = eye(4)*.001;

R(1,1) = .01;%phi
R(2,2) = .01;%theta
R(3,3) = 1;%u
R(4,4) = 1;%v

Q(1,1) = 1;%p
Q(2,2) = 1;%q
Q(3,3) = .01;%ax
Q(4,4) = .01;%ay
