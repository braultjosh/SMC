function daycode = firstdayofyear(y)

% Returns the first day of year y.
%
% INPUTS
% - y           [integer]     scalar or vector, year(s).
%
% OUTPUTS
% - daycode     [integer]     scalar or vector.
%
% REMARKS
% Days are encoded as follows:
%
%   1 -> Monday
%   2 -> Tuesday
%   3 -> Wednesday
%   4 -> Thursday
%   5 -> Friday
%   6 -> Saturday
%   7 -> Sunday

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

daycode = mod(1+5*mod(y-1,4)+4*mod(y-1,100)+6*mod(y-1,400), 7);

% Monday is the first day of the week acoording to ISO-8607
id = (daycode==0);
daycode(id) = 7;

return % --*-- Unit tests --*--

%@test:1
try
    dc = firstdayofyear(2000);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = dc==6;
end

T = all(t);
%@eof:1

%@test:2
try
    dc = firstdayofyear([2001;2002]);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = isequal(dc, [1;2]);
end

T = all(t);
%@eof:2
