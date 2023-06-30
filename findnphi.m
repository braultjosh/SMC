function [fphi_dist] = findnphi(phi_hat, phi_n1, wtsim, loglh, ESS)
        incwt_hat           = exp((phi_hat-phi_n1)*loglh);
        unwtsim_hat         = wtsim.*incwt_hat; % numerator of normalization
        zhat_hat            = sum(unwtsim_hat); % denominator of normalization
        wtsim_hat           = unwtsim_hat/zhat_hat; 
        ESS_hat             = 1/sum(wtsim_hat.^2); % Effective sample size, (5.16)
        fphi_dist           = ESS_hat-0.95*ESS;
    end