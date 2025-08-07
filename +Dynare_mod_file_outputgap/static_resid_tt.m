function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 47);

T(1) = 1+params(3)/100;
T(2) = 1+params(4)/100;
T(3) = params(1)^(-params(1))*(1-params(1))^(params(1)-1)*(params(2)^(-params(2))*(1-params(2))^(params(2)-1))^(1-params(1));
T(4) = params(13)+T(1)*params(7)/params(6)-1;
T(5) = T(2)^(params(8)-1);
T(6) = T(1)^(params(8)-1);
T(7) = ((1-T(5)*params(15)*T(6))/(1-params(15)))^(1/(1-params(8)));
T(8) = T(2)^(params(9)-1);
T(9) = ((1-params(10)*T(8))/(1-params(10)))^(1/(1-params(9)));
T(10) = (T(9))^(-params(9));
T(11) = T(2)^params(9);
T(12) = (1-params(10))*T(10)/(1-params(10)*T(11));
T(13) = (params(9)-1)/params(9);
T(14) = T(9)*T(13)*(1-T(11)*params(6)*params(10))/(1-T(8)*params(6)*params(10));
T(15) = T(4)^((params(1)-1)*params(2));
T(16) = (T(14)*T(15)/T(3))^(1/((1-params(1))*(1-params(2))));
T(17) = params(7)*T(1)*params(2)/(1-params(2))*T(16)/T(4);
T(18) = 1/params(7);
T(19) = 1/T(1);
T(20) = params(7)^((params(1)-1)*params(2));
T(21) = (T(18)*T(19)*T(4)*params(1)/(1-params(1))*1/params(2))^params(1);
T(22) = T(1)^((params(1)-1)*params(2));
T(23) = T(20)*T(14)*T(21)*T(17)^(params(2)+params(1)*(1-params(2)))*T(22);
T(24) = 1/(T(23)-T(16)*params(1)/((1-params(1))*(1-params(2))));
T(25) = T(24)*((1-params(22))*(T(23)-T(16)*params(1)/((1-params(1))*(1-params(2))))-T(17)*(1-T(18)*(1-params(13))*T(19)));
T(26) = 1/(T(23)*1/(T(16)*params(1)/((1-params(1))*(1-params(2)))));
T(27) = (T(13)*T(15)/T(3))^(1/((1-params(1))*(1-params(2))));
T(28) = params(7)*T(1)*params(2)/(1-params(2))*T(27)/T(4);
T(29) = T(20)*T(22)*T(13)*T(21)*T(28)^(params(2)+params(1)*(1-params(2)));
T(30) = 1/(T(29)-params(1)/((1-params(1))*(1-params(2)))*T(27));
T(31) = T(30)*((1-params(22))*(T(29)-params(1)/((1-params(1))*(1-params(2)))*T(27))-(1-T(18)*(1-params(13))*T(19))*T(28));
T(32) = 1/(T(29)*1/(params(1)/((1-params(1))*(1-params(2)))*T(27)));
T(33) = T(1)*params(6)*params(11)/((T(1)-params(6)*params(11))*(T(1)-params(11)));
T(34) = params(6)*params(11)^2;
T(35) = T(1)^2;
T(36) = (T(34)+T(35))/((T(1)-params(6)*params(11))*(T(1)-params(11)));
T(37) = T(1)*params(11)/((T(1)-params(6)*params(11))*(T(1)-params(11)));
T(38) = (T(34)+T(35)+T(1)*params(11))/((T(1)-params(11))*(T(1)-params(6)*params(11)*params(23))*(1-params(23)));
T(39) = params(6)*params(15)*T(2)^(params(8)*(1+params(16)))*T(1)^(params(8)*(1+params(16)));
T(40) = T(6)*T(5)*params(6)*params(15);
T(41) = (1-T(40))*(1/T(7))^(params(8)-1);
T(42) = (y(21)+y(1))*T(12)*T(14);
T(43) = (1-params(9))*(1-params(10))*(T(9))^(1-params(9));
T(44) = (1-params(8))*(1-params(15))*(T(7))^(1-params(8));
T(45) = T(14)*1/T(12);
T(46) = params(15)*(T(1)*T(2))^(params(8)*(1+params(16)));
T(47) = params(9)/(params(9)-1);

end
