% medium-scale DSGE model with production networks and deterministic trend neutral productivity and investment-specific technology shock


%----------------------------------------------------------------
% 0. Housekeeping
%----------------------------------------------------------------

close all;

%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------

var x_t gamma_t k_t L_t dL_t mc_t R_t rk_t w_t w_star_t f1_t f2_t vw_t eta_t y_t pi_t pi_star_t target_t x1_t x2_t s_t lambda_r_t c_t b_t bstar_t u_t mu_t v_t i_t kbar_t gdp_t g_t a_t g_gdp_t g_c_t g_i_t g_w_t g_gdp_obs g_c_obs g_i_obs g_w_obs L_obs pi_obs R_obs wBN
lambda_f_t c_f_t rk_f_t u_f_t mu_f_t i_f_t R_f_t w_f_t f1_f_t f2_f_t L_f_t k_f_t x_f_t gamma_f_t y_f_t kbar_f_t gdp_f_t m_t;

varexo eps_r_t eps_b_t eps_v_t eps_g_t eps_a_t eps_target_t eps_eta_t eps_s;

parameters phi alpha g_omega_ss100 pss100 Lss beta g_I sigma theta ksi_p h sigma_z delta kappa ksi_w chi rhoR rhoR2 alpha_pi alpha_y alpha_gy g_y rhob rhov rhog rhoa rhoeta rho_target rhom alphaBN;

%fixed parameters
beta       = 0.994;         % discount factor
delta      = 0.025;         % depreciation rate
g_y        = 0.22;          % gov spending to GDP ratio
rho_target = 0.995;         % AR(1) coefficient of inflation target shock
sigma      = 6;             % elasticity of substitution between labor
theta      = 6;             % elasticity of substitution between goods
g_I        = 1.0037;        % trend growth rate of IST



%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model(linear);
#g = (1/(1-g_y));
#g_omega = 1+(g_omega_ss100/100); 
#pibar = 1+pss100/100;
#Rbar = (pibar*g_omega)/beta;
#Rss100 = 100*(Rbar-1);
#phibar = (phi^(-phi))*((1-phi)^(phi-1))*(((alpha^(-alpha))*((1-alpha)^(alpha-1)))^(1-phi));
#rk = ((g_omega*g_I)/beta)-1+delta;
#I_K = 1 - ((1-delta)/(g_omega*g_I));
#wstar_w_bar = ((1 - ksi_w*(g_omega^(sigma-1))*(pibar^(sigma-1)))/(1-ksi_w))^(1/(1-sigma));
#w_wstar_bar = 1/wstar_w_bar;
#pistar_bar = ((1-ksi_p*(pibar^(theta-1)))/(1-ksi_p))^(1/(1-theta));
#s_bar = ((1-ksi_p)*(pistar_bar^(-theta)))/(1-ksi_p*(pibar^theta));
#mc_bar = ((theta-1)/theta)*((1-ksi_p*beta*(pibar^theta))/(1-ksi_p*beta*(pibar^(theta-1))))*((1-ksi_p*(pibar^(theta-1)))/(1-ksi_p))^(1/(1-theta));
#w_bar = ((mc_bar*(rk^(alpha*(phi-1))))/phibar)^(1/((1-alpha)*(1-phi)));
#K_L = (alpha/(1-alpha))*g_omega*g_I*(w_bar/rk);
#GAM_L = (phi/((1-phi)*(1-alpha)))*w_bar;
#GAM_K = (phi/(1-phi))*(1/alpha)*rk*(1/g_omega)*(1/g_I);
#X_L = mc_bar*(GAM_K^phi)*(K_L^(phi*(1-alpha)+alpha))*(g_omega^(alpha*(phi-1)))*(g_I^(alpha*(phi-1)));
#Y_L = X_L - GAM_L;
#K_Y = K_L*(1/Y_L);
#C_L = (1/g)*Y_L - (1-(1-delta)*(1/g_omega)*(1/g_I))*K_L;
#C_Y = C_L*(1/Y_L);
#I_Y = I_K*K_Y;
#X_GAM = X_L*(1/GAM_L);
#GAM_X = 1/X_GAM;

%steady state under flexible price-wage
#If_Kf = I_K;
#mc_bar_f = ((theta-1)/theta);
#w_bar_f = ((mc_bar_f*(rk^(alpha*(phi-1))))/phibar)^(1/((1-alpha)*(1-phi)));
#Kf_Lf = (alpha/(1-alpha))*g_omega*g_I*(w_bar_f/rk);
#GAMf_Lf = (phi/((1-phi)*(1-alpha)))*w_bar_f;
#GAMf_Kf = (phi/(1-phi))*(1/alpha)*rk*(1/g_omega)*(1/g_I);
#Xf_Lf = mc_bar_f*(GAMf_Kf^phi)*(Kf_Lf^(phi*(1-alpha)+alpha))*(g_omega^(alpha*(phi-1)))*(g_I^(alpha*(phi-1)));
#Yf_Lf = Xf_Lf - GAMf_Lf;
#Kf_Yf = Kf_Lf*(1/Yf_Lf);
#Cf_Lf = (1/g)*Yf_Lf - (1-(1-delta)*(1/g_omega)*(1/g_I))*Kf_Lf;
#Cf_Yf = Cf_Lf*(1/Yf_Lf);
#If_Yf = If_Kf*Kf_Yf;
#Xf_GAMf = Xf_Lf*(1/GAMf_Lf);
#GAMf_Xf = 1/Xf_GAMf;



% sticky price-wage equilibrium
lambda_r_t = ((h*beta*g_omega)/((g_omega-h*beta)*(g_omega-h)))*c_t(+1) - (((g_omega^2)+(h^2)*beta)/((g_omega-h*beta)*(g_omega-h)))*c_t + ((h*g_omega)/((g_omega-h*beta)*(g_omega-h)))*c_t(-1) + ((g_omega-h*beta*rhob)/(g_omega-h*beta))*b_t;
b_t = ((g_omega*h+(g_omega^2)+beta*(h^2))/((1-rhob)*(g_omega-h*beta*rhob)*(g_omega-h)))*bstar_t;
rk_t = sigma_z*u_t;
lambda_r_t = mu_t + v_t - kappa*((g_omega)^2)*(i_t - i_t(-1)) + kappa*beta*((g_omega)^2)*(i_t(+1) - i_t);
mu_t = (1-beta*(1-delta)*(1/g_omega)*(1/g_I))*(lambda_r_t(+1) + rk_t(+1)) + beta*(1/g_omega)*(1/g_I)*(1-delta)*mu_t(+1);
lambda_r_t = R_t - pi_t(+1) + lambda_r_t(+1);
w_star_t = f1_t - f2_t;
f1_t = (1 - beta*ksi_w*(pibar^(sigma*(1+chi)))*(g_omega^(sigma*(1+chi))))*(sigma*(1+chi)*w_t - sigma*(1+chi)*w_star_t + (1+chi)*L_t + eta_t) + beta*ksi_w*(pibar^(sigma*(1+chi)))*(g_omega^(sigma*(1+chi)))*(sigma*(1+chi)*pi_t(+1) + sigma*(1+chi)*w_star_t(+1) - sigma*(1+chi)*w_star_t + f1_t(+1));
f2_t = (1 - beta*ksi_w*(pibar^(sigma-1))*(g_omega^(sigma-1)))*(w_wstar_bar^(sigma-1))*(lambda_r_t + sigma*w_t - sigma*w_star_t + L_t) + beta*ksi_w*(pibar^(sigma-1))*(g_omega^(sigma-1))*((sigma-1)*pi_t(+1) + sigma*w_star_t(+1) - sigma*w_star_t + f2_t(+1));
k_t = mc_t - rk_t + s_bar*mc_bar*(s_t + x_t);
L_t = mc_t - w_t + s_bar*mc_bar*(s_t + x_t);
gamma_t = mc_t + s_bar*mc_bar*(s_t + x_t);
pi_star_t = x1_t - x2_t;
x1_t = (1 - ksi_p*beta*(pibar^theta))*(lambda_r_t + mc_t + x_t) + (ksi_p*beta*(pibar^theta))*(theta*pi_t(+1) + x1_t(+1));
x2_t = (1-ksi_p*beta*pibar^(theta-1))*(lambda_r_t + x_t) + (ksi_p*beta*(pibar^(theta-1)))*((theta-1)*pi_t(+1) + x2_t(+1));
ksi_p*(pibar^(theta-1))*(theta-1)*pi_t + (1-ksi_p)*(pistar_bar^(1-theta))*(1-theta)*pi_star_t = 0;
(1-sigma)*w_t = ksi_w*(g_omega^(sigma-1))*(pibar^(sigma-1))*((1-sigma)*w_t(-1) + (sigma-1)*pi_t) + (1-ksi_w)*(wstar_w_bar^(1-sigma))*(1-sigma)*w_star_t;
y_t = (1/(1-GAM_X))*x_t - (GAM_X/(1-GAM_X))*gamma_t;
s_t + x_t = (1/s_bar*mc_bar)*(a_t + phi*gamma_t + alpha*(1-phi)*k_t + (1-alpha)*(1-phi)*L_t);
(1/g)*y_t = (1/g)*g_t + C_Y*c_t + I_Y*i_t + rk*K_Y*(1/g_omega)*(1/g_I)*u_t;
gdp_t = y_t - rk*K_Y*(1/g_omega)*(1/g_I)*u_t;
kbar_t = (1-(1-delta)*(1/g_omega)*(1/g_I))*(v_t + i_t) + (1-delta)*(1/g_omega)*(1/g_I)*kbar_t(-1);
R_t = rhoR*R_t(-1) + rhoR2*R_t(-2) +  (1-rhoR-rhoR2)*(alpha_pi*(pi_t-target_t) + alpha_y*g_gdp_t) + m_t;
k_t = u_t + kbar_t(-1);
s_bar*s_t = -(1-ksi_p)*(pistar_bar^(-theta))*theta*pi_star_t + ksi_p*(pibar^(theta))*s_bar*(theta*pi_t + s_t(-1));
vw_t = (1 - ksi_w*((g_omega*pibar)^(sigma*(1+chi))))*(sigma*(1+chi)*w_t - sigma*(1+chi)*w_star_t) + ksi_w*((g_omega*pibar)^(sigma*(1+chi)))*(sigma*(1+chi)*w_t - sigma*(1+chi)*w_t(-1) + sigma*(1+chi)*pi_t + vw_t(-1));

% growth rates in the sticky price-wage equilibrium
g_gdp_t = gdp_t - gdp_t(-1);
g_c_t   = c_t - c_t(-1);
g_i_t   = i_t - i_t(-1);
g_w_t   = w_t - w_t(-1);
dL_t    = L_t - L_t(-1);

% flexible price-wage equilibrium
lambda_f_t = ((h*beta*g_omega)/((g_omega-h*beta)*(g_omega-h)))*c_f_t(+1) - (((g_omega^2)+(h^2)*beta)/((g_omega-h*beta)*(g_omega-h)))*c_f_t + ((h*g_omega)/((g_omega-h*beta)*(g_omega-h)))*c_f_t(-1) + ((g_omega-h*beta*rhob)/(g_omega-h*beta))*b_t;
rk_f_t = sigma_z*u_f_t;
lambda_f_t = mu_f_t + v_t - kappa*((g_omega)^2)*(i_f_t - i_f_t(-1)) + kappa*beta*((g_omega)^2)*(i_f_t(+1) - i_f_t);
mu_f_t = (1-beta*(1-delta)*(1/g_omega)*(1/g_I))*(lambda_f_t(+1) + rk_f_t(+1)) + beta*(1/g_omega)*(1/g_I)*(1-delta)*mu_f_t(+1);
lambda_f_t = R_f_t + lambda_f_t(+1);
w_f_t = f1_f_t - f2_f_t;
f1_f_t = (1+chi)*L_f_t + eta_t;
f2_f_t = lambda_f_t + L_f_t;
k_f_t = -rk_f_t + ((theta-1)/theta)*x_f_t;
L_f_t = -w_f_t + ((theta-1)/theta)*x_f_t;
gamma_f_t = ((theta-1)/theta)*x_f_t;
y_f_t = (1/(1-GAMf_Xf))*x_f_t - (GAMf_Xf/(1-GAMf_Xf))*gamma_f_t;
x_f_t = (theta/(theta-1))*(a_t + phi*gamma_f_t + alpha*(1-phi)*k_f_t + (1-alpha)*(1-phi)*L_f_t);
(1/g)*y_f_t = (1/g)*g_t + Cf_Yf*c_f_t + If_Yf*i_f_t + rk*Kf_Yf*(1/g_omega)*(1/g_I)*u_f_t;
kbar_f_t = (1-(1-delta)*(1/g_omega)*(1/g_I))*(v_t + i_f_t) + (1-delta)*(1/g_omega)*(1/g_I)*kbar_f_t(-1);
k_f_t = u_f_t + kbar_f_t(-1);
gdp_f_t = y_f_t - rk*Kf_Yf*(1/g_omega)*(1/g_I)*u_f_t;


% stochastic processes
eta_t = rhoeta*eta_t(-1) + eps_eta_t;
bstar_t = rhob*bstar_t(-1) + eps_b_t;
v_t = rhov*v_t(-1) + eps_v_t;
g_t = rhog*g_t(-1) + eps_g_t;
a_t = rhoa*a_t(-1) + eps_a_t;
target_t = rho_target*target_t(-1) + eps_target_t;
m_t = rhom*m_t(-1) + eps_r_t;

% Observation equations:
g_gdp_obs     = g_omega_ss100 + g_gdp_t;
g_c_obs       = g_omega_ss100 + g_c_t;
g_i_obs       = g_omega_ss100 + g_i_t;
g_w_obs       = g_omega_ss100 + g_w_t;
L_obs         = Lss + L_t;
pi_obs        = pss100 + pi_t;
R_obs         = Rss100 + R_t;

% Bianchi and Nicolo equation
wBN = (1/alphaBN)*wBN(-1) + eps_s - (pi_t - expectation(-1)(pi_t));
end;

estimated_params;
alpha                   , 0.30 ,0.01 , , normal_pdf, 0.30, 0.05;
g_omega_ss100           , 0.5 , 0.01, , normal_pdf, 0.5, 0.1;
h                       , 0.5 , , , beta_pdf, 0.5, 0.1;
Lss                     , 0.0 , , , normal_pdf, 0, 0.5;
pss100                  , 1.0 , , , normal_pdf, 0.75, 0.25;
chi                     ,2 , , ,gamma_pdf,2.0,0.75;
ksi_p                   , 0.5 , , , beta_pdf, 0.66, 0.05;
ksi_w                   , 0.5 , , , beta_pdf, 0.66, 0.05;
sigma_z                 ,5 , , ,gamma_pdf,5,1;
kappa                   ,4 , , ,gamma_pdf,4,1;
phi                     , 0.2 , , , beta_pdf, 0.5, 0.10;
alpha_y                 , 0.1 , 0.01, , normal_pdf, 0.13, 0.05;
alpha_gy                 , 0.1 , 0.01, , normal_pdf, 0.13, 0.05;
rhoR                    , 0.6 , , , normal_pdf, 0.8, 0.2;
rhoR2                 , -0.2 , , , normal_pdf, -0.1, 0.2;
alpha_pi                , 1.7 ,0.01 , , normal_pdf, 1.1, 0.5;

rhoa                    , 0.6 , , , beta_pdf, 0.5, 0.2;
rhog                    , 0.6 , , , beta_pdf, 0.5, 0.2;
rhoeta                  , 0.6 , , , beta_pdf, 0.5, 0.2;
rhob                    , 0.6 , , , beta_pdf, 0.5, 0.2;
rhov                    , 0.6 , , , beta_pdf, 0.5, 0.2;
rhom                    , 0.6 , , , beta_pdf, 0.5, 0.2;


stderr eps_r_t          ,0.1 , , , inv_gamma_pdf, 0.10, 1;
stderr eps_target_t     ,0.1 , , , inv_gamma_pdf, 0.10, 1;
stderr eps_a_t          ,0.5 , , , inv_gamma_pdf, 0.50, 1;
stderr eps_g_t          ,0.5 , , , inv_gamma_pdf, 0.50, 1;
stderr eps_eta_t        ,0.5 , , , inv_gamma_pdf, 0.50, 1;
stderr eps_b_t          ,0.5 , , , inv_gamma_pdf, 0.50, 1;
stderr eps_v_t          ,0.5 , , , inv_gamma_pdf, 0.50, 1;

% indeterminacy parameters
alphaBN,                        1.25,   0.5,1.5,           UNIFORM_PDF, , ,0.5, 1.5;
stderr eps_s,                   0.10,  0.001,120,        INV_GAMMA_PDF,0.1,1.0;
corr eps_r_t, eps_s,            0.00,   -1,1,             UNIFORM_PDF, , ,-1, 1;
corr eps_target_t, eps_s,       0.00, -1,1,             UNIFORM_PDF, , ,-1, 1;
corr eps_a_t, eps_s,            0.00,  -1,1,             UNIFORM_PDF, , ,-1, 1;
corr eps_g_t, eps_s,            0.00,  -1,1,             UNIFORM_PDF, , ,-1, 1;
corr eps_eta_t, eps_s,          0.00,   -1,1,             UNIFORM_PDF, , ,-1, 1;
corr eps_b_t, eps_s,            0.00, -1,1,             UNIFORM_PDF, , ,-1, 1;
corr eps_v_t, eps_s,            0.00,  -1,1,             UNIFORM_PDF, , ,-1, 1;
end;

%--------------------------------
% Run the Bayesian estimation
%--------------------------------
varobs g_gdp_obs g_c_obs g_i_obs g_w_obs L_obs pi_obs R_obs;
estimation(datafile = usdata_8407,  mh_replic=0,  nograph, nodiagnostic, mode_compute=0, presample = 4);
