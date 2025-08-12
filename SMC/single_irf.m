close all
clear
clc
delete *.asv
path('Mfiles',path);
path('Optimization Routines',path);
path('LRE',path);
path('toolbox_ss',path);
warning('off','all');
path('Results',path);

modelpara(1) = 0.5;
modelpara(2) = 0.6;
modelpara(3) = 2.25;
modelpara(4) = 0;
modelpara(5) = 0.25;
modelpara(6) = 0.7;
modelpara(7) = 0;
modelpara(8) = 0.4;
modelpara(9) = 0.75;
modelpara(10) = 1.4;
modelpara(11) = 0.9;
modelpara(12) = 0.25;
modelpara(13) = 0.2;
modelpara(14) = 2;
modelpara(15) = 1.4;
modelpara(16) = 0.2;
modelpara(17) = 0.5;
modelpara(18) = 1.5;
modelpara(19) = 0.5;
modelpara(20) = 0.5;
modelpara(21) = 0.5;
modelpara(22) = 0.99;
modelpara(23) = 0.10;
%modelpara(23) = 0;
modelpara(24) = 0;




[T1, ~ , T0, ~, GEV] = model_solution(modelpara);
[A,B,H,R,Se,Phi, PD] = sysmat(T1,T0,modelpara);

nsim = 15;
e_b = 1;
e_z = 2;
e_i = 3;
e_s = 4;
e_p = 5;
QQ = zeros(5, 5);
QQ(e_b,e_b) = (modelpara(14))^2;
QQ(e_z,e_z) = (modelpara(15))^2;
QQ(e_i,e_i) = (modelpara(16))^2;
QQ(e_s,e_s) = (modelpara(17))^2;
QQ(e_p,e_p) = (modelpara(23))^2;

QQ(e_s,e_b) = modelpara(19)*modelpara(17)*modelpara(14);
QQ(e_s,e_z) = modelpara(20)*modelpara(17)*modelpara(15);
QQ(e_s,e_i) = modelpara(21)*modelpara(17)*modelpara(16);
QQ(e_s,e_p) = modelpara(24)*modelpara(17)*modelpara(23);


% QQ(e_s,e_b) = modelpara(19)*modelpara(17)*modelpara(14);
% QQ(e_b,e_s) = QQ(e_s,e_b);
% QQ(e_s,e_z) = modelpara(20)*modelpara(17)*modelpara(15);
% QQ(e_z,e_s) = QQ(e_s,e_z);
% QQ(e_s,e_i) = modelpara(21)*modelpara(17)*modelpara(16);
% QQ(e_i,e_s) = QQ(e_s,e_i);
% QQ(e_s,e_p) = modelpara(24)*modelpara(17)*modelpara(23);
% QQ(e_p,e_s) = QQ(e_s,e_p);
%QQ = (QQ+QQ')/2;
QQchol = chol(QQ);

x = zeros(17,nsim+1);
%shockvec = normrnd(0,1,[5,nsim]);
shockvec = zeros(5,nsim);
shockvec(4,2) = 1;

for t = 2:nsim
   x(:,t) = T1*x(:,t-1) + T0*QQchol*shockvec(:,t); 
   y(:,t) = A + B*x(:,t);
end
%y = y(:,101:end)';
y = y(:,2:end);
plot(y(1,:)); hold on;
plot(y(2,:)); hold on;
plot(y(3,:)); hold on;

std(y(:,1))
std(y(:,2))
std(y(:,3))