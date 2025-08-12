% close all
% clear
% clc
% delete *.asv
% path('Mfiles',path);
% path('Optimization Routines',path);
% path('LRE',path);
% path('toolbox_ss',path);
% warning('off','all');
% path('Results',path);

% Load results
%load('results_tvt_19601979.mat')
% load('results_tvt_19601979.mat');

% Check to see if positive definitiveness of the VarCov matrix matters here

% Compute variance decomposition over parameter draws
store_decomp = [];
p = 1;
while p <=10000  
    draw = randi([1 10000],1,24);
    for k = 1:24
        modelpara(p) = parapost(draw(k),k);
    end
    modelpara = parapost(p,:);
    [T1, ~ , T0, ~, GEV] = model_solution(modelpara);
    [A,B,H,R,Se,Phi, PD] = sysmat(T1,T0,modelpara);
    m=min(size(B));
    n=length(Se);
    decomp=zeros(m,n);
    v=zeros(m,n);
    
    for i=1:n
           v(:,i)=diag(B*(dlyap(T1,T0(:,i)*Se(i,i)*T0(:,i)'))*B');
    end
    for j=1:m
        for k=1:n
            decomp(j,k)=v(j,k)./sum(v(j,:));
        end
    end
    store_decomp(p,:) = decomp(:)'; % goes down columns then across rows where row is variable
    p = p+1;
end

sorted = sort(store_decomp);

table_values = [mean(sorted); sorted(1000,:); sorted(9000,:)];
