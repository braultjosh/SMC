function [d, m, y] = firstweekofyear(y)

% Returns the month and day the first week of the year.
%
% INPUTS
% - y   [integer] the year.
%
% OUTPUS
% - y   [integer] the year of the first iso-8601 week of year y (may be equal to y-1)
% - m   [integer] the month number (1 or 12)
% - d   [integer] the day of the month.

% Copyright © 2021-2023 Dynare Team
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

d = firstdayofyear(y);

m = ones(length(d), 1);

id = d==2 | d==3 | d==4;
if any(id)
    % Tuesday, Wednesday, or Thursday
    m(id) = 12;
    y(id) = y(id)-1;
    d(id) = 33-d(id);
end

id = d==5 | d==6 | d==7;
if any(id)
    % Friday, Saturday, or Sunday
    d(id) = 9-d(id);
end

return % --*-- Unit tests --*--

%@test:1
t = false(2,1);

try
    [d, m, y] = firstweekofyear(1971);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = d==4;
end

T = all(t);
%@eof:1


%@test:2
t = false(10,1);

try
    [d, m, y] = firstweekofyear([1972;1973;1974]);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = d(1)==3;
    t(3) = d(2)==1;
    t(4) = d(3)==31;
    t(5) = m(1)==1;
    t(6) = m(2)==1;
    t(7) = m(3)==12;
    t(8) = y(1)==1972;
    t(9) = y(2)==1973;
    t(10) = y(3)==1973;
end

T = all(t);
%@eof:2
