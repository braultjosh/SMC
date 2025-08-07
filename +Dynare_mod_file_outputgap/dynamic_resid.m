function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = Dynare_mod_file_outputgap.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(65, 1);
lhs = y(44);
rhs = y(96)*T(9)-y(45)*T(11)+y(8)*T(12)+y(46)*(T(1)-params(6)*params(11)*params(23))/(T(1)-params(6)*params(11));
residual(1) = lhs - rhs;
lhs = y(46);
rhs = y(47)*T(13);
residual(2) = lhs - rhs;
lhs = y(30);
rhs = params(12)*y(48);
residual(3) = lhs - rhs;
lhs = y(44);
rhs = y(49)+y(50)-(y(51)-y(11))*params(14)*T(10)+(y(98)-y(51))*params(6)*params(14)*T(10);
residual(4) = lhs - rhs;
lhs = y(49);
rhs = (y(95)+y(88))*(1-T(5)*params(6)*(1-params(13))*T(14))+y(97)*(1-params(13))*T(5)*params(6)*T(14);
residual(5) = lhs - rhs;
lhs = y(44);
rhs = y(95)+y(29)-y(92);
residual(6) = lhs - rhs;
lhs = y(32);
rhs = y(33)-y(34);
residual(7) = lhs - rhs;
lhs = y(33);
rhs = (params(8)*(1+params(16))*y(31)-y(32)*params(8)*(1+params(16))+(1+params(16))*y(26)+y(36))*(1-T(15))+(y(92)*params(8)*(1+params(16))+params(8)*(1+params(16))*y(89)-y(32)*params(8)*(1+params(16))+y(90))*T(15);
residual(8) = lhs - rhs;
lhs = y(34);
rhs = ((params(8)-1)*y(92)+params(8)*y(89)-params(8)*y(32)+y(91))*T(18)+(y(26)+y(44)+params(8)*y(31)-params(8)*y(32))*T(43);
residual(9) = lhs - rhs;
lhs = y(25);
rhs = y(28)-y(30)+T(44);
residual(10) = lhs - rhs;
lhs = y(26);
rhs = y(28)-y(31)+T(44);
residual(11) = lhs - rhs;
lhs = y(24);
rhs = y(28)+T(44);
residual(12) = lhs - rhs;
lhs = y(39);
rhs = y(41)-y(42);
residual(13) = lhs - rhs;
lhs = y(41);
rhs = (y(23)+y(44)+y(28))*(1-params(6)*params(10)*T(19))+(params(9)*y(92)+y(93))*params(6)*params(10)*T(19);
residual(14) = lhs - rhs;
lhs = y(42);
rhs = (y(44)+y(23))*(1-params(6)*params(10)*T(20))+((params(9)-1)*y(92)+y(94))*params(6)*params(10)*T(20);
residual(15) = lhs - rhs;
residual(16) = y(38)*(params(9)-1)*params(10)*T(20)+y(39)*T(45);
lhs = (1-params(8))*y(31);
rhs = ((1-params(8))*y(3)+(params(8)-1)*y(38))*T(17)*params(15)*T(16)+y(32)*T(46);
residual(17) = lhs - rhs;
lhs = y(37);
rhs = y(23)*1/(1-T(36))-y(24)*T(36)/(1-T(36));
residual(18) = lhs - rhs;
lhs = y(43)+y(23);
rhs = (y(55)+params(1)*y(24)+y(25)*(1-params(1))*params(2)+(1-params(1))*(1-params(2))*y(26))*T(47);
residual(19) = lhs - rhs;
lhs = (1-params(22))*y(37);
rhs = (1-params(22))*y(54)+y(45)*T(35)+y(51)*(1-(1-params(13))/(T(1)*params(7)))*T(30)*T(34)+y(48)*T(5)*T(14)*T(22)*T(30)*T(34);
residual(20) = lhs - rhs;
lhs = y(53);
rhs = y(37)-y(48)*T(5)*T(14)*T(22)*T(30)*T(34);
residual(21) = lhs - rhs;
lhs = y(52);
rhs = (y(50)+y(51))*(1-T(5)*(1-params(13))*T(14))+y(12)*T(5)*(1-params(13))*T(14);
residual(22) = lhs - rhs;
lhs = y(29);
rhs = y(85)+(1-params(17)-params(18))*(params(19)*(y(38)-y(40))+params(20)*y(56))+params(17)*y(2)+params(18)*y(22);
residual(23) = lhs - rhs;
lhs = y(25);
rhs = y(48)+y(12);
residual(24) = lhs - rhs;
lhs = y(43)*T(26);
rhs = y(39)*params(9)*(-(1-params(10)))*T(25)+(params(9)*y(38)+y(7))*params(10)*T(19)*T(26);
residual(25) = lhs - rhs;
lhs = y(35);
rhs = (params(8)*(1+params(16))*y(31)-y(32)*params(8)*(1+params(16)))*(1-T(21))+(params(8)*(1+params(16))*y(31)-params(8)*(1+params(16))*y(3)+params(8)*(1+params(16))*y(38)+y(4))*T(21);
residual(26) = lhs - rhs;
lhs = y(56);
rhs = y(53)-y(13);
residual(27) = lhs - rhs;
lhs = y(57);
rhs = y(45)-y(8);
residual(28) = lhs - rhs;
lhs = y(58);
rhs = y(51)-y(11);
residual(29) = lhs - rhs;
lhs = y(59);
rhs = y(31)-y(3);
residual(30) = lhs - rhs;
lhs = y(27);
rhs = y(26)-y(1);
residual(31) = lhs - rhs;
lhs = y(68);
rhs = y(46)*(T(1)-params(6)*params(11)*params(23))/(T(1)-params(6)*params(11))+y(100)*T(9)-y(69)*T(11)+y(17)*T(12);
residual(32) = lhs - rhs;
lhs = y(70);
rhs = params(12)*y(71);
residual(33) = lhs - rhs;
lhs = y(68);
rhs = y(50)+y(72)-(y(73)-y(18))*params(14)*T(10)+(y(103)-y(73))*params(6)*params(14)*T(10);
residual(34) = lhs - rhs;
lhs = y(72);
rhs = (y(99)+y(101))*(1-T(5)*params(6)*(1-params(13))*T(14))+y(102)*(1-params(13))*T(5)*params(6)*T(14);
residual(35) = lhs - rhs;
lhs = y(68);
rhs = y(99)+y(74);
residual(36) = lhs - rhs;
lhs = y(75);
rhs = y(76)-y(77);
residual(37) = lhs - rhs;
lhs = y(76);
rhs = y(36)+(1+params(16))*y(78);
residual(38) = lhs - rhs;
lhs = y(77);
rhs = y(68)+y(78);
residual(39) = lhs - rhs;
lhs = y(79);
rhs = T(4)*y(80)-y(70);
residual(40) = lhs - rhs;
lhs = y(78);
rhs = T(4)*y(80)-y(75);
residual(41) = lhs - rhs;
lhs = y(81);
rhs = T(4)*y(80);
residual(42) = lhs - rhs;
lhs = y(82);
rhs = y(80)*1/(1-T(42))-y(81)*T(42)/(1-T(42));
residual(43) = lhs - rhs;
lhs = y(80);
rhs = T(8)*(y(55)+params(1)*y(81)+(1-params(1))*params(2)*y(79)+(1-params(1))*(1-params(2))*y(78));
residual(44) = lhs - rhs;
lhs = (1-params(22))*y(82);
rhs = (1-params(22))*y(54)+y(69)*T(41)+y(73)*(1-(1-params(13))/(T(1)*params(7)))*T(38)*T(40)+y(71)*T(5)*T(14)*T(22)*T(38)*T(40);
residual(45) = lhs - rhs;
lhs = y(83);
rhs = (y(50)+y(73))*(1-T(5)*(1-params(13))*T(14))+y(19)*T(5)*(1-params(13))*T(14);
residual(46) = lhs - rhs;
lhs = y(79);
rhs = y(71)+y(19);
residual(47) = lhs - rhs;
lhs = y(84);
rhs = y(82)-y(71)*T(5)*T(14)*T(22)*T(38)*T(40);
residual(48) = lhs - rhs;
lhs = y(36);
rhs = params(27)*y(5)+x(it_, 7);
residual(49) = lhs - rhs;
lhs = y(47);
rhs = params(23)*y(9)+x(it_, 2);
residual(50) = lhs - rhs;
lhs = y(50);
rhs = params(24)*y(10)+x(it_, 3);
residual(51) = lhs - rhs;
lhs = y(54);
rhs = params(25)*y(14)+x(it_, 4);
residual(52) = lhs - rhs;
lhs = y(55);
rhs = params(26)*y(15)+x(it_, 5);
residual(53) = lhs - rhs;
lhs = y(40);
rhs = params(28)*y(6)+x(it_, 6);
residual(54) = lhs - rhs;
lhs = y(85);
rhs = params(29)*y(20)+x(it_, 1);
residual(55) = lhs - rhs;
lhs = y(60);
rhs = params(3)+y(56);
residual(56) = lhs - rhs;
lhs = y(61);
rhs = params(3)+y(57);
residual(57) = lhs - rhs;
lhs = y(62);
rhs = params(3)+y(58);
residual(58) = lhs - rhs;
lhs = y(63);
rhs = params(3)+y(59);
residual(59) = lhs - rhs;
lhs = y(64);
rhs = y(26)+params(5);
residual(60) = lhs - rhs;
lhs = y(65);
rhs = params(4)+y(38);
residual(61) = lhs - rhs;
lhs = y(66);
rhs = y(29)+100*(T(1)*T(2)/params(6)-1);
residual(62) = lhs - rhs;
lhs = y(67);
rhs = 1/params(30)*y(16)+x(it_, 8)-(y(38)-y(21));
residual(63) = lhs - rhs;
lhs = y(86);
rhs = y(92);
residual(64) = lhs - rhs;
lhs = y(87);
rhs = y(2);
residual(65) = lhs - rhs;

end
