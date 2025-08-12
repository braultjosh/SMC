close all
clear ;clc
delete *.asv
path('Mfiles',path); path('Optimization Routines',path);
path('LRE',path); path('toolbox_ss',path);
warning('off','all');

%load('./Results/results_6019_tvt.mat')
load('results.mat')

data = load('usdat_60Q119Q4.txt');

%paraint(1,22) = 0.98;
%paraint(2,22) = 0.999;


k = 1;
while k<=1000

draw = randi([1 20000]); 
modelpara = parapost(draw,:);
%draw = randi([1 20000],1,24);
%for p = 1:24
%    modelpara(p) = parapost(draw(p),p);
%end

% 90% interval for OLS
% p = 1;
% while p<=24
%     draw = randi([1 10000], 1, 1);
%     lb = ge(parapost(draw,p),paraint(1,p));
%     ub = le(parapost(draw,p),paraint(2,p));
%     tot = ub + lb;
%     if tot ==2
%     modelpara(p) = parapost(draw,p);
%     p = p+1;
%     end
%     tot = 0;
% end

%modelpara = parapost(k,:);
% check in bounds
%lb = ge(modelpara,paraint(1,:));
%ub = le(modelpara,paraint(2,:));
%bound = sum(lb) + sum(ub);
%if bound==48

    [T1, ~, T0, ~, GEV] = model_solution(modelpara);
    [A,B,H,R,Se,Phi, PD] = sysmat(T1,T0,modelpara);

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

     smoothedobs(:,:,k) = (A+B*sbigtvec(:,:))';
     smoothedtar(:,k) = A(2) + sbigtvec(17,:)';
     k = k+1;
%end
end

% 
% 
% % % Figures for full sample
sorted_target = sort(smoothedtar', 'descend');
for i = 1:length(data)
meantarget(i,1) = mean(sorted_target(:,i))*4;
end
ub = sorted_target(round(0.05*k),:)*4;
lb = sorted_target(round(0.95*k),:)*4;
% 
% 
dates = 1960:0.25:2019.75;
colorBNDS1=[0.7 0.7 0.7];
figure(1);
plot(dates',meantarget, 'LineWidth', 2, 'Color', 'k'); hold on; grid on;
fill([dates fliplr(dates)]' ,[ub'; flipud(lb')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.3); hold on;
xlim([1959 2020.75]); xticks([1960 1970 1980 1990 2000 2010 2020]);
%xticks([1 41 81 121 161 201 241]); xticklabels({'1960', '1970', '1980', '1990', '2000', '2010', '2020'});
ylabel('$$\hat{\pi}_t^{\star}$$', 'Interpreter', 'Latex','fontsize',14);

% 
% %Import other targets
% targets = xlsread('InflationTargets.xlsx', 'Sheet1', 'A6:Q189');
% CG = xlsread('InflationTargets.xlsx', 'CG');
% 
% colorBNDS1=[0.7 0.7 0.7];
% % Estimated target figure
% figure(1);
% subplot(2,1,1)
% plot(dates',meantarget, 'LineWidth', 2, 'Color', 'k'); hold on; grid on;
% fill([dates fliplr(dates)]' ,[ub'; flipud(lb')],...
% colorBNDS1,'EdgeColor','None', 'facealpha', 0.3); hold on;
% xlim([1959 2008.75]); xticks([1960 1970 1980 1990 2000])
% %xticks([1 41 81 121 161 201]); xticklabels({'1960', '1970', '1980', '1990', '2000', '2010'});
% ylabel('$$\hat{\pi}_t^{\star}$$', 'Interpreter', 'Latex','fontsize',14);
% subplot(2,1,2)
% plot(targets(:,1),targets(:,5), 'LineWidth', 2,   'Color',  [0.9290 0.6940 0.1250]); hold on;
% plot(targets(:,1),targets(:,4), 'LineWidth', 2,  'Color', [0 0.4470 0.7410]); hold on;
% plot(CG(:,11),CG(:,10), 'LineWidth', 2,  'Color', [0.6350 0.0780 0.1840]); hold on; grid on;
% ylabel('$$\hat{\pi}_t^{\star}$$', 'Interpreter', 'Latex','fontsize',14);
% ylim([0 10]);
% xlim([1959 2008.75]); xticks([1960 1970 1980 1990 2000])
% legend('Ireland (2007)', 'Aruoba-Schorfheide (2011)', 'Coibion-Gorodnichenko (2011)');
% 
% 
% 
% 
% % % % Export 10,000 estimates of the target to excel
% % % Check how the targets look
% % figure(1);
% % for i = 1:10000
% %     plot(smoothedtar(:,i)*4); hold on;
% % end
% 
% % dates = 1960:0.25:2007.75;
% % smoothedtar_wdates = [dates', data(:,2), smoothedtar];
% % filename= 'estimated_targets.xlsx';
% % xlswrite(filename,smoothedtar_wdates);
% % After go and manually add headers to the excel document
% 
