function o = dummy(iperiod, len, subperiod, name)

% Returns a dummy in a dseries object.
%
% INPUTS
% - iperiod     [dates]     scalar, initial period.
% - len         [integer]   scalar, number of periods.
% - superiod    [integer]   scalar or vector, subperiod(s) index where the dummy is nonzero.
% - name        [char]      row char array, name of the dummy variable.
%
% OUTPUTS
% - o           [dseries]

% Copyright © 2022-2023 Dynare Team
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

if ~(isdate(iperiod) || isdates(iperiod))
    error('First input argument must be a string date or dates object.')
end

if ~(isscalar(len) && isint(len))
    error('Second input argument must be a scalar integer.')
end

if ~((isscalar(subperiod) || isvector(subperiod)) && all(isint(subperiod)))
    error('Second input argument must be a scalar integer.')
else
    if ~issubperiod(subperiod, dates(iperiod).freq)
        error('Third input argument is not a subperiod.')
    end
end

p = dates(iperiod)+(0:len-1);
d = zeros(len, 1);

for i=1:length(subperiod)
    d(p.subperiod()==subperiod(i)) = 1;
end

o = dseries(d, iperiod, name);

return % --*-- Unit tests --*--

%@test:1
try
    ts = dummy(dates('1950Q1'), 15, 2, 'toto');
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(ts(ts.dates.subperiod()==2).data);
end

T = all(t);
%@eof:1

%@test:2
try
    ts = dummy('1950Q1', 15, 2, 'toto');
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(ts(ts.dates.subperiod()==2).data);
end

T = all(t);
%@eof:2

%@test:3
try
    ts = dummy('1950Q1', 15, [1,2,3,4], 'toto');
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(ts.data);
end

T = all(t);
%@eof:3
