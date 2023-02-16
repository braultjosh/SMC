%% Figure: Waterfall plot
fig = figure(1);

subplot(2,2,1)
parai = 35; % rpi
itsel = 1:1:tune.nphi;
nsel  = length(itsel);

bins = 0:0.01:3.5;
post = zeros(nsel, length(bins));
for i = 1:nsel
    
    phisel  = itsel(i);
    para    = squeeze(parasim(phisel, :, parai));
    [id, m] = multinomial_resampling(wtsim(:, phisel)');
    para    = para(id);
    
    post(i, :) = ksdensity(para, bins);
end

colscale = (0.65:-0.05:0);
colormap(repmat(colscale', 1, 3));

phigrid = (1:1:tune.nphi)';
waterfall(bins, phigrid, post)

set(gca, 'linewidth', 1, 'fontsize', 15)
xlabel(['$r_{\pi}$'], 'fontsize', 20, 'interpreter', 'latex')
ylabel(['$N_{\phi}$'], 'fontsize', 20, 'interpreter', 'latex')

subplot(2,2,2)
parai = 45; % alphaBN
itsel = 1:1:tune.nphi;
nsel  = length(itsel);

bins = 0.5:0.01:1.5;
post = zeros(nsel, length(bins));
for i = 1:nsel
    
    phisel  = itsel(i);
    para    = squeeze(parasim(phisel, :, parai));
    [id, m] = multinomial_resampling(wtsim(:, phisel)');
    para    = para(id);
    
    post(i, :) = ksdensity(para, bins);
end

colscale = (0.65:-0.05:0);
colormap(repmat(colscale', 1, 3));

phigrid = (1:1:tune.nphi)';
waterfall(bins, phigrid, post)

set(gca, 'linewidth', 1, 'fontsize', 15)
xlabel(['$\alpha_{BN}$'], 'fontsize', 20, 'interpreter', 'latex')
ylabel(['$N_{\phi}$'], 'fontsize', 20, 'interpreter', 'latex')

subplot(2,2,3)
parai = 39; % steady state inflation
itsel = 1:1:tune.nphi;
nsel  = length(itsel);

bins = 0:0.01:1;
post = zeros(nsel, length(bins));
for i = 1:nsel
    
    phisel  = itsel(i);
    para    = squeeze(parasim(phisel, :, parai));
    [id, m] = multinomial_resampling(wtsim(:, phisel)');
    para    = para(id);
    
    post(i, :) = ksdensity(para, bins);
end

colscale = (0.65:-0.05:0);
colormap(repmat(colscale', 1, 3));

phigrid = (1:1:tune.nphi)';
waterfall(bins, phigrid, post)

set(gca, 'linewidth', 1, 'fontsize', 15)
xlabel(['$\bar{\pi}$'], 'fontsize', 20, 'interpreter', 'latex')
ylabel(['$N_{\phi}$'], 'fontsize', 20, 'interpreter', 'latex')

subplot(2,2,4)
parai = 8; % sigma_s
itsel = 1:1:tune.nphi;
nsel  = length(itsel);

bins = 0:0.01:0.5;
post = zeros(nsel, length(bins));
for i = 1:nsel
    
    phisel  = itsel(i);
    para    = squeeze(parasim(phisel, :, parai));
    [id, m] = multinomial_resampling(wtsim(:, phisel)');
    para    = para(id);
    
    post(i, :) = ksdensity(para, bins);
end

colscale = (0.65:-0.05:0);
colormap(repmat(colscale', 1, 3));

phigrid = (1:1:tune.nphi)';
waterfall(bins, phigrid, post)

set(gca, 'linewidth', 1, 'fontsize', 15)
xlabel(['$\sigma_{s}$'], 'fontsize', 20, 'interpreter', 'latex')
ylabel(['$N_{\phi}$'], 'fontsize', 20, 'interpreter', 'latex')
