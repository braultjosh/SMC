function o = weeksince(y, w, z)

% Returns the number of ISO weeks since base year z.
%
% INPUTS
% - y   [integer] scalar or vector, the year.
% - w   [integer] scalar or vector, the week.
% - z   [integer] scalar, base year.
%
% OUTPUTS
% - o   [integer] scalar or vector, number of weeks.

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

if nargin<3
    z = 0; % Default value for base year.
end

n = zeros(length(y), 1);

id = y-1>=z;

if ~isempty(id)
    n(id) = longyearsince(y(id)-1, z);
end

o = 52*(y-z)+n+w;

return % --*-- Unit tests --*--

%@test:1
try
    w = weeksince(2001, 1, 2000);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = w==53;
end

T = all(t);
%@eof:1

%@test:2
try
    w = weeksince(2002, 1, 2000);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = w==105;
end

T = all(t);
%@eof:2

%@test:3
try
    w = weeksince(2003, 1, 2000);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = w==157;
end

T = all(t);
%@eof:3

%@test:4
try
    w = weeksince(2004, 1, 2000);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = w==209;
end

T = all(t);
%@eof:4

%@test:5
try
    w = weeksince(2005, 1, 2000); % 2004 is a long year (53 weeks).
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = w==262;
end

T = all(t);
%@eof:5
