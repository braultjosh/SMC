clear; clc;
%load('results_tvt_19602007.mat');
load('./Empirical_Results/results_tvt_19602007.mat');

modelpara = mean(parapost);
[T1, ~, T0, ~, GEV] = model_solution(modelpara);
[A,B,H,R,Se,Phi, PD] = sysmat(T1,T0,modelpara);
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
QQchol = chol(QQ);

capt = length(data); ss = length(T1);
% Demean observation data
for p = 1:capt
    dthat(p,:) = data(p,:)-A';
end

sttvec = zeros(ss,capt); stlvec = zeros(ss,capt);
sigttvec = zeros(ss*ss,capt); sigtlvec = zeros(ss*ss,capt);
st = zeros(ss,1);
bigbvbx = R*eye(5)*R';
bigsigt = inv(eye(ss*ss)-kron(Phi,Phi))*bigbvbx(:);
bigsigt = reshape(bigsigt,ss,ss);

% st = Phi s_{t-1} + R e(t)
% yt = A + B s_{t}
bigcx = B;
bigax = Phi;

for t = 1:capt 
    stlvec(:,t) = st;
    sigtlvec(:,t) = bigsigt(:);
    omegt = bigcx*bigsigt*bigcx';
    omeginvt = inv(omegt);

    ut = dthat(t,:)' - bigcx*st;
    stt = st + bigsigt*bigcx'*omeginvt*ut;
    bigsigtt = bigsigt - bigsigt*bigcx'*omeginvt*bigcx*bigsigt;
    sttvec(:,t) = stt;
    sigttvec(:,t) = bigsigtt(:);
    st = bigax*stt;   
    bigsigt = bigbvbx + bigax*bigsigtt*bigax';
  end  

% run through Kalman smoother
sbigtvec = zeros(ss,capt);
sbigtvec(:,capt) = sttvec(:,capt);

 for j = 1:capt-1
    bigsigtt = sigttvec(:,capt-j);
    bigsigtt = reshape(bigsigtt,ss,ss);
    bigsigtp = sigtlvec(:,capt-j+1);
    bigsigtp = reshape(bigsigtp,ss,ss);
    bigjt = bigsigtt*bigax'*pinv(bigsigtp);
    stt = sttvec(:,capt-j);
    stpbigt = sbigtvec(:,capt-j+1);
    stpt = stlvec(:,capt-j+1);
    sbigtvec(:,capt-j)= stt + bigjt*(stpbigt-stpt);
 end
 
smoothedobs = (B*sbigtvec(:,:))'
 
% Back out smoothed shocks
smoothed_shock = zeros(192,5);
 for i = 2:length(data)
     smoothed_shock(i,1) = sbigtvec(8,i)-modelpara(11)*sbigtvec(8,i-1); % pref
     smoothed_shock(i,2) = sbigtvec(9,i)-modelpara(12)*sbigtvec(9,i-1); % tech
     smoothed_shock(i,3) = sbigtvec(10,i)-modelpara(13)*sbigtvec(10,i-1); % mp
     %smoothed_shock(i,5) = sbigtvec(17,i)-modelpara(22)*sbigtvec(17,i-1); % pi  
 end

x = zeros(17,192);
shockvec = smoothed_shock';
x(:,1) = sbigtvec(:,1);

for t = 2:192
   x(:,t) = T1*x(:,t-1) + T0*shockvec(:,t); 
end
smoothed_2 = (B*x(:,:))'; % no mean

plot(smoothedobs(:,2)+A(2)); hold on;
plot(smoothed_2(:,2))

target_at_mean = sbigtvec(17,:)'+A(2);

plot(target_at_mean)
