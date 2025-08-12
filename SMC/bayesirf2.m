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

% Load results
load('results_tvt_19601979.mat')
%load('results_fix_19601979.mat')

irf_mat = [];
nirf = 16;
shockvec = zeros(5,nirf,5);
shockvec(1,2,1) = 1;
shockvec(2,2,2) = 1;
shockvec(3,2,3) = 1;
shockvec(4,2,4) = 1;
shockvec(5,2,5) = 1;


k=1;
while k <=10000
    x = zeros(17,nirf,5);
    draw = randi([1 10000],1,24);
    for p = 1:24
        modelpara(p) = parapost(draw(p),p);
    end
    modelpara = parapost(k,:);
    [T1, ~ , T0, ~, GEV] = model_solution(modelpara);
    [A,B,H,R,Se,Phi, PD] = sysmat(T1,T0,modelpara);

    e_b = 1;
    e_z = 2;
    e_i = 3;
    e_s = 4;
    e_p = 5;
    % Varcov
    QQ = zeros(5, 5);
    QQ(e_b,e_b) = (modelpara(14))^2;
    QQ(e_z,e_z) = (modelpara(15))^2;
    QQ(e_i,e_i) = (modelpara(16))^2;
    QQ(e_s,e_s) = (modelpara(17))^2;
    QQ(e_p,e_p) = (modelpara(23))^2;
    %if modelpara(18)<=1
    QQ(e_s,e_b) = modelpara(19)*modelpara(17)*modelpara(14);
    QQ(e_b,e_s) = QQ(e_s,e_b);
    QQ(e_s,e_z) = modelpara(20)*modelpara(17)*modelpara(15);
    QQ(e_z,e_s) = QQ(e_s,e_z);
    QQ(e_s,e_i) = modelpara(21)*modelpara(17)*modelpara(16);
    QQ(e_i,e_s) = QQ(e_s,e_i);
    QQ(e_s,e_p) = modelpara(24)*modelpara(17)*modelpara(23);
    QQ(e_p,e_s) = QQ(e_s,e_p);
    %end
    QQchol = chol(QQ);
    for j = 1:5
        for t = 2:nirf
                x(:,t,j) = T1*x(:,t-1,j) + T0*QQchol*shockvec(:,t,j);
        end
        x = x(:,2:end,:);
        y_irf(k,:,j) = x(1,:,j)+x(9,:,j);
        pi_irf(k,:,j) = x(2,:,j);
        r_irf(k,:,j) = x(5,:,j);
    end
    k = k+1;
end

% Store mean, 90 and 10% responses
for j = 1:5
y_hold = sort(y_irf(:,:,j), 'descend');
pi_hold = sort(pi_irf(:,:,j), 'descend');
r_hold = sort(r_irf(:,:,j), 'descend');
final_irf(:,:,j) = [mean(y_hold); mean(pi_hold); mean(r_hold); y_hold(1000,:); pi_hold(1000,:); r_hold(1000,:); y_hold(9000,:); pi_hold(9000,:); r_hold(9000,:)];
end




%colorBNDS1=[0.8500 0.3250 0.0980]; % orange = fixed 
colorBNDS1=[0 0.4470 0.7410]; % blue  = tvt
hor = 15;
figure(1);
subplot(5,3,1)
plot(final_irf(1,:,1), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(4,:,1)'; flipud(final_irf(7,:,1)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
ylabel('Preference', 'FontWeight','bold'); title('Output')
subplot(5,3,2)
plot(final_irf(2,:,1), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(5,:,1)'; flipud(final_irf(8,:,1)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
title('Inflation')
subplot(5,3,3)
plot(final_irf(3,:,1), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(6,:,1)'; flipud(final_irf(9,:,1)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
 title('Nominal rate')

subplot(5,3,4)
plot(final_irf(1,:,2), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(4,:,2)'; flipud(final_irf(7,:,2)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
ylabel('Technology', 'FontWeight','bold'); 
subplot(5,3,5)
plot(final_irf(2,:,2), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(5,:,2)'; flipud(final_irf(8,:,2)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
subplot(5,3,6)
plot(final_irf(3,:,2), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(6,:,2)'; flipud(final_irf(9,:,2)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
    

subplot(5,3,7)
plot(final_irf(1,:,3), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(4,:,3)'; flipud(final_irf(7,:,3)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
ylabel('Monetary policy', 'FontWeight','bold');
subplot(5,3,8)
plot(final_irf(2,:,3), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(5,:,3)'; flipud(final_irf(8,:,3)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
subplot(5,3,9)
plot(final_irf(3,:,3), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(6,:,3)'; flipud(final_irf(9,:,3)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
    
subplot(5,3,10)
plot(final_irf(1,:,4), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(4,:,4)'; flipud(final_irf(7,:,4)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
ylabel('Sunspot', 'FontWeight','bold');
subplot(5,3,11)
plot(final_irf(2,:,4), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(5,:,4)'; flipud(final_irf(8,:,4)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
subplot(5,3,12)
plot(final_irf(3,:,4), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(6,:,4)'; flipud(final_irf(9,:,4)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;

subplot(5,3,13)
plot(final_irf(1,:,5), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(4,:,5)'; flipud(final_irf(7,:,5)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
ylabel('Inflation target', 'FontWeight','bold');
subplot(5,3,14)
plot(final_irf(2,:,5), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(5,:,5)'; flipud(final_irf(8,:,5)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;
subplot(5,3,15)
plot(final_irf(3,:,5), 'LineWidth', 2, 'Color', 'k'); hold on;
fill([1:hor fliplr(1:hor)]' ,[final_irf(6,:,5)'; flipud(final_irf(9,:,5)')],...
colorBNDS1,'EdgeColor','None', 'facealpha', 0.35); hold on;