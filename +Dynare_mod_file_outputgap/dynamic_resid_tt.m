function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 47);

T(1) = 1+params(3)/100;
T(2) = 1+params(4)/100;
T(3) = params(1)^(-params(1))*(1-params(1))^(params(1)-1)*(params(2)^(-params(2))*(1-params(2))^(params(2)-1))^(1-params(1));
T(4) = (params(9)-1)/params(9);
T(5) = 1/params(7);
T(6) = params(7)^((params(1)-1)*params(2));
T(7) = params(6)*params(11)^2;
T(8) = params(9)/(params(9)-1);
T(9) = T(1)*params(6)*params(11)/((T(1)-params(6)*params(11))*(T(1)-params(11)));
T(10) = T(1)^2;
T(11) = (T(7)+T(10))/((T(1)-params(6)*params(11))*(T(1)-params(11)));
T(12) = T(1)*params(11)/((T(1)-params(6)*params(11))*(T(1)-params(11)));
T(13) = (T(7)+T(10)+T(1)*params(11))/((T(1)-params(11))*(1-params(23))*(T(1)-params(6)*params(11)*params(23)));
T(14) = 1/T(1);
T(15) = params(6)*params(15)*T(2)^(params(8)*(1+params(16)))*T(1)^(params(8)*(1+params(16)));
T(16) = T(1)^(params(8)-1);
T(17) = T(2)^(params(8)-1);
T(18) = T(16)*params(6)*params(15)*T(17);
T(19) = T(2)^params(9);
T(20) = T(2)^(params(9)-1);
T(21) = params(15)*(T(1)*T(2))^(params(8)*(1+params(16)));
T(22) = params(13)+T(1)*params(7)/params(6)-1;
T(23) = ((1-T(17)*params(15)*T(16))/(1-params(15)))^(1/(1-params(8)));
T(24) = ((1-params(10)*T(20))/(1-params(10)))^(1/(1-params(9)));
T(25) = (T(24))^(-params(9));
T(26) = (1-params(10))*T(25)/(1-params(10)*T(19));
T(27) = T(24)*T(4)*(1-params(6)*params(10)*T(19))/(1-params(6)*params(10)*T(20));
T(28) = T(22)^((params(1)-1)*params(2));
T(29) = (T(27)*T(28)/T(3))^(1/((1-params(1))*(1-params(2))));
T(30) = params(7)*T(1)*params(2)/(1-params(2))*T(29)/T(22);
T(31) = (T(5)*T(14)*params(1)/(1-params(1))*1/params(2)*T(22))^params(1);
T(32) = T(1)^((params(1)-1)*params(2));
T(33) = T(6)*T(27)*T(31)*T(30)^(params(2)+params(1)*(1-params(2)))*T(32);
T(34) = 1/(T(33)-params(1)/((1-params(1))*(1-params(2)))*T(29));
T(35) = T(34)*((1-params(22))*(T(33)-params(1)/((1-params(1))*(1-params(2)))*T(29))-(1-T(5)*(1-params(13))*T(14))*T(30));
T(36) = 1/(T(33)*1/(params(1)/((1-params(1))*(1-params(2)))*T(29)));
T(37) = (T(4)*T(28)/T(3))^(1/((1-params(1))*(1-params(2))));
T(38) = params(7)*T(1)*params(2)/(1-params(2))*T(37)/T(22);
T(39) = T(6)*T(32)*T(4)*T(31)*T(38)^(params(2)+params(1)*(1-params(2)));
T(40) = 1/(T(39)-params(1)/((1-params(1))*(1-params(2)))*T(37));
T(41) = T(40)*((1-params(22))*(T(39)-params(1)/((1-params(1))*(1-params(2)))*T(37))-(1-T(5)*(1-params(13))*T(14))*T(38));
T(42) = 1/(T(39)*1/(params(1)/((1-params(1))*(1-params(2)))*T(37)));
T(43) = (1-T(18))*(1/T(23))^(params(8)-1);
T(44) = (y(43)+y(23))*T(26)*T(27);
T(45) = (1-params(9))*(1-params(10))*(T(24))^(1-params(9));
T(46) = (1-params(8))*(1-params(15))*(T(23))^(1-params(8));
T(47) = T(27)*1/T(26);

end
