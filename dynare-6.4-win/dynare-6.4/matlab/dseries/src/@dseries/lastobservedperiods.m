function [b, D] = lastobservedperiods(o)

% Return, for each variable, the last period without missing observations (last period without NaN).
%
% INPUTS
% - o   [dseries]    with N variables and T periods.
%
% OUTPUTS
% - b   [struct]     with N fields, each name field is a variable name and its content a date object.
% - D   [dates]      N elements.

% Copyright © 2023 Dynare Team
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

d = cumprod(~isnan(o));
b = struct();

for i=1:o.vobs
    b.(o.name{i}) = o.dates(find(d(:,i), 1, 'last'));
end

if nargout>1
    D = dates(o.dates.freq);
    for i=1:o.vobs
        D.append_(b.(o.name{i}));
    end
end

return % --*-- Unit tests --*--

%@test:1
try
    a = randn(10, 3);
    a(end,1) = NaN;
    a(end,2) = NaN;
    a(end-1,2) = NaN;
    A = dseries(a, '2000Q1', {'A1', 'A2', 'A3'});
    b = A.lastobservedperiods();
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = isequal(b.A1, dates('2002Q1'));
    t(3) = isequal(b.A2, dates('2001Q4'));
    t(4) = isequal(b.A3, dates('2002Q2'));
end

T = all(t);
%@eof:1

%@test:2
try
    a = randn(10, 3);
    a(end,1) = NaN;
    a(end,2) = NaN;
    a(end-1,2) = NaN;
    A = dseries([a, a], '2000Q1', {'A1', 'A2', 'A3', 'B1', 'B2', 'B3'});
    [b, D] = lastobservedperiods(A);
    d = unique(D);
    tmp = {};
    for i=1:length(d)
        tmp{i} = A(D==d(i));
    end
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    for i=1:length(d)
        t(i+1) = isequal(tmp{i}.name,{sprintf('A%u', i); sprintf('B%u', i)});
    end
end

T = all(t);
%@eof:2
