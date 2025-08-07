function trend = lineartrend(o)

% Returns a trend centered on zero.
%
% INPUTS
% - o       [dseries]   time series with T observations.
%
% OUTPUTS
% - trend   [double]    T*1 vector, linear trend with mean zero.
%
% REMARKS
% the generic element of the returned argument is trend(i) = i - (n+1)/2.

% Copyright © 2017-2023 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <https://www.gnu.org/licenses/>.

trend = transpose(1:o.nobs)-.5*(o.nobs+1);

return % --*-- Unit tests --*--

%@test:1
a = dseries(randn(100,3));
try
    trend = a.lineartrend;
    t(1) = 1;
catch
    t(1) = 0;
end

if t(1)
    t(2) = abs(mean(trend))<1e-12;
end
T = all(t);
%@eof:1
