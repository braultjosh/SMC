function o = ordinalinisoyear(y, m, d)

% Returns the ordinal date (day number in current year).
%
% INPUTS 
% - y   [integer] scalar or vector, the year.
% - m   [integer] scalar or vector, the month.
% - d   [integer] scalar or vector, the day in a month.
%
% OUTPUTS 
% - o   [integer] scalar or vector, day number in year y.
%
% REMARKS 
% odinalinyear(2000,1,1) returns 1.

% Copyright © 2021 Dynare Team
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

D = [31; 28; 31; 30; 31; 30; 31; 31; 30; 31; 30; 31]; % Number of days in January, February, ..., December (for a non leap year)

if ~(isvector(y) && isvector(m) && isvector(d)) || ~(isint(y) && isint(m) && isint(d))
    error('Arguments must be vectors of integers.')
end

if ~(length(y)==length(m) && length(y)==length(d))
    error('Arguments must have same lengths.')
end

if any(m>12) || any(m<1)
    error('Second argument must be an integer between 1 and 12 (month).')
end

if any(d<1)
    error('Third argument must be a positive integer (day).')
end

id = m==2; % February requires a special treatment.

if any(d(~id)>D(m(~id))) || any(d(id)>28+isleapyear(y(id)))
    error('Dates are wrong (third argument cannot be greater than 28, 29, 30 or 31 depending on the value of the second argument).')
end

o = zeros(length(y), 1);

for i=1:length(o)
    o(i) = d(i) + days(y(i), m(i));
end

function n = days(y, m)
    if m>1
        n = sum(D(1:m-1));
    else
        n = 0;
    end
    if m>2
        n = n + isleapyear(y);
    end
end

end