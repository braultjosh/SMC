function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = Dynare_mod_file_outputgap.static_resid_tt(T, y, x, params);
end
residual = zeros(65, 1);
lhs = y(22);
rhs = y(23)*T(33)-y(23)*T(36)+y(23)*T(37)+y(24)*(T(1)-params(6)*params(11)*params(23))/(T(1)-params(6)*params(11));
residual(1) = lhs - rhs;
lhs = y(24);
rhs = y(25)*T(38);
residual(2) = lhs - rhs;
lhs = y(8);
rhs = params(12)*y(26);
residual(3) = lhs - rhs;
lhs = y(22);
rhs = y(27)+y(28);
residual(4) = lhs - rhs;
lhs = y(27);
rhs = (y(22)+y(8))*(1-T(18)*T(19)*params(6)*(1-params(13)))+y(27)*(1-params(13))*T(18)*params(6)*T(19);
residual(5) = lhs - rhs;
lhs = y(22);
rhs = y(22)+y(7)-y(16);
residual(6) = lhs - rhs;
lhs = y(10);
rhs = y(11)-y(12);
residual(7) = lhs - rhs;
lhs = y(11);
rhs = (params(8)*(1+params(16))*y(9)-y(10)*params(8)*(1+params(16))+(1+params(16))*y(4)+y(14))*(1-T(39))+T(39)*(y(11)+y(16)*params(8)*(1+params(16)));
residual(8) = lhs - rhs;
lhs = y(12);
rhs = (y(12)+(params(8)-1)*y(16))*T(40)+(y(4)+y(22)+params(8)*y(9)-params(8)*y(10))*T(41);
residual(9) = lhs - rhs;
lhs = y(3);
rhs = y(6)-y(8)+T(42);
residual(10) = lhs - rhs;
lhs = y(4);
rhs = T(42)+y(6)-y(9);
residual(11) = lhs - rhs;
lhs = y(2);
rhs = y(6)+T(42);
residual(12) = lhs - rhs;
lhs = y(17);
rhs = y(19)-y(20);
residual(13) = lhs - rhs;
lhs = y(19);
rhs = (1-T(11)*params(6)*params(10))*(y(1)+y(22)+y(6))+T(11)*params(6)*params(10)*(y(19)+params(9)*y(16));
residual(14) = lhs - rhs;
lhs = y(20);
rhs = (1-T(8)*params(6)*params(10))*(y(22)+y(1))+T(8)*params(6)*params(10)*(y(20)+(params(9)-1)*y(16));
residual(15) = lhs - rhs;
residual(16) = y(16)*(params(9)-1)*params(10)*T(8)+y(17)*T(43);
lhs = (1-params(8))*y(9);
rhs = T(5)*params(15)*T(6)*((params(8)-1)*y(16)+(1-params(8))*y(9))+y(10)*T(44);
residual(17) = lhs - rhs;
lhs = y(15);
rhs = y(1)*1/(1-T(26))-y(2)*T(26)/(1-T(26));
residual(18) = lhs - rhs;
lhs = y(21)+y(1);
rhs = (y(33)+params(1)*y(2)+y(3)*(1-params(1))*params(2)+(1-params(1))*(1-params(2))*y(4))*T(45);
residual(19) = lhs - rhs;
lhs = (1-params(22))*y(15);
rhs = (1-params(22))*y(32)+T(25)*y(23)+(1-(1-params(13))/(T(1)*params(7)))*T(17)*T(24)*y(29)+y(26)*T(18)*T(19)*T(4)*T(17)*T(24);
residual(20) = lhs - rhs;
lhs = y(31);
rhs = y(15)-y(26)*T(18)*T(19)*T(4)*T(17)*T(24);
residual(21) = lhs - rhs;
lhs = y(30);
rhs = (1-T(18)*(1-params(13))*T(19))*(y(28)+y(29))+T(18)*(1-params(13))*T(19)*y(30);
residual(22) = lhs - rhs;
lhs = y(7);
rhs = y(63)+(1-params(17)-params(18))*(params(19)*(y(16)-y(18))+params(20)*y(34))+y(7)*params(17)+y(7)*params(18);
residual(23) = lhs - rhs;
lhs = y(3);
rhs = y(26)+y(30);
residual(24) = lhs - rhs;
lhs = T(12)*y(21);
rhs = y(17)*params(9)*T(10)*(-(1-params(10)))+(y(21)+params(9)*y(16))*params(10)*T(11)*T(12);
residual(25) = lhs - rhs;
lhs = y(13);
rhs = (params(8)*(1+params(16))*y(9)-y(10)*params(8)*(1+params(16)))*(1-T(46))+T(46)*(y(16)*params(8)*(1+params(16))+y(13));
residual(26) = lhs - rhs;
residual(27) = y(34);
residual(28) = y(35);
residual(29) = y(36);
residual(30) = y(37);
residual(31) = y(5);
lhs = y(46);
rhs = y(24)*(T(1)-params(6)*params(11)*params(23))/(T(1)-params(6)*params(11))+T(33)*y(47)-T(36)*y(47)+T(37)*y(47);
residual(32) = lhs - rhs;
lhs = y(48);
rhs = params(12)*y(49);
residual(33) = lhs - rhs;
lhs = y(46);
rhs = y(28)+y(50);
residual(34) = lhs - rhs;
lhs = y(50);
rhs = (1-T(18)*T(19)*params(6)*(1-params(13)))*(y(46)+y(48))+(1-params(13))*T(18)*params(6)*T(19)*y(50);
residual(35) = lhs - rhs;
lhs = y(46);
rhs = y(46)+y(52);
residual(36) = lhs - rhs;
lhs = y(53);
rhs = y(54)-y(55);
residual(37) = lhs - rhs;
lhs = y(54);
rhs = y(14)+(1+params(16))*y(56);
residual(38) = lhs - rhs;
lhs = y(55);
rhs = y(46)+y(56);
residual(39) = lhs - rhs;
lhs = y(57);
rhs = T(13)*y(58)-y(48);
residual(40) = lhs - rhs;
lhs = y(56);
rhs = T(13)*y(58)-y(53);
residual(41) = lhs - rhs;
lhs = y(59);
rhs = T(13)*y(58);
residual(42) = lhs - rhs;
lhs = y(60);
rhs = y(58)*1/(1-T(32))-y(59)*T(32)/(1-T(32));
residual(43) = lhs - rhs;
lhs = y(58);
rhs = T(47)*(y(33)+params(1)*y(59)+(1-params(1))*params(2)*y(57)+(1-params(1))*(1-params(2))*y(56));
residual(44) = lhs - rhs;
lhs = (1-params(22))*y(60);
rhs = (1-params(22))*y(32)+T(31)*y(47)+(1-(1-params(13))/(T(1)*params(7)))*T(28)*T(30)*y(51)+y(49)*T(18)*T(19)*T(4)*T(28)*T(30);
residual(45) = lhs - rhs;
lhs = y(61);
rhs = (1-T(18)*(1-params(13))*T(19))*(y(28)+y(51))+T(18)*(1-params(13))*T(19)*y(61);
residual(46) = lhs - rhs;
lhs = y(57);
rhs = y(49)+y(61);
residual(47) = lhs - rhs;
lhs = y(62);
rhs = y(60)-y(49)*T(18)*T(19)*T(4)*T(28)*T(30);
residual(48) = lhs - rhs;
lhs = y(14);
rhs = y(14)*params(27)+x(7);
residual(49) = lhs - rhs;
lhs = y(25);
rhs = params(23)*y(25)+x(2);
residual(50) = lhs - rhs;
lhs = y(28);
rhs = y(28)*params(24)+x(3);
residual(51) = lhs - rhs;
lhs = y(32);
rhs = y(32)*params(25)+x(4);
residual(52) = lhs - rhs;
lhs = y(33);
rhs = y(33)*params(26)+x(5);
residual(53) = lhs - rhs;
lhs = y(18);
rhs = y(18)*params(28)+x(6);
residual(54) = lhs - rhs;
lhs = y(63);
rhs = y(63)*params(29)+x(1);
residual(55) = lhs - rhs;
lhs = y(38);
rhs = params(3)+y(34);
residual(56) = lhs - rhs;
lhs = y(39);
rhs = params(3)+y(35);
residual(57) = lhs - rhs;
lhs = y(40);
rhs = params(3)+y(36);
residual(58) = lhs - rhs;
lhs = y(41);
rhs = params(3)+y(37);
residual(59) = lhs - rhs;
lhs = y(42);
rhs = y(4)+params(5);
residual(60) = lhs - rhs;
lhs = y(43);
rhs = params(4)+y(16);
residual(61) = lhs - rhs;
lhs = y(44);
rhs = 100*(T(1)*T(2)/params(6)-1)+y(7);
residual(62) = lhs - rhs;
lhs = y(45);
rhs = y(45)*1/params(30)+x(8);
residual(63) = lhs - rhs;
lhs = y(64);
rhs = y(16);
residual(64) = lhs - rhs;
lhs = y(65);
rhs = y(7);
residual(65) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
