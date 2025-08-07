function q = intersect(o, p)

% Overloads intersect function for dates objects.
%
% INPUTS
% - o [dates]
% - p [dates]
%
% OUTPUTS
% - q [dates] All the common elements in o and p.

% Copyright © 2013-2022 Dynare Team
%
% This code is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare dates submodule is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <https://www.gnu.org/licenses/>.

if ~isa(o, 'dates') || ~isa(p, 'dates')
    error('dates:intersect:ArgCheck','All input arguments must be dates objects!')
end

if o.length()==p.length() && isequal(o, p)
    q = copy(o);
    return
end

if ~isequal(o.freq, p.freq)
    q = dates();
    return
end

time = intersect(o.time, p.time, 'legacy');

q = dates();
if isempty(time)
    return
end

q.freq = o.freq;
q.time = time;

return % --*-- Unit tests --*--

%@test:1
% Define some dates objects
d1 = dates('1950Q1'):dates('1969Q4') ;
d2 = dates('1960Q1'):dates('1969Q4') ;
d3 = dates('1970Q1'):dates('1979Q4') ;

% Call the tested routine.
c1 = intersect(d1,d2);
c2 = intersect(d1,d3);

% Check the results.
t(1) = isequal(c1,d2);
t(2) = isequal(isempty(c2),true);
T = all(t);
%@eof:1

%@test:2
% Define some dates objects
d1 = dates('1950Q1'):dates('1969Q4') ;
d2 = dates('1950Q1'):dates('1969Q4') ;

% Call the tested routine.
c1 = intersect(d1,d2);

% Check the results.
t(1) = isequal(c1,d1);
T = all(t);
%@eof:2

%@test:3
% Define some dates objects
d1 = dates('2000-01-01'):dates('2000-01-10');
d2 = dates('2000-01-05'):dates('2000-01-10');

% Call the tested routine.
c1 = intersect(d1,d2);

% Check the results.
t(1) = isequal(c1,d2);
T = all(t);
%@eof:3
