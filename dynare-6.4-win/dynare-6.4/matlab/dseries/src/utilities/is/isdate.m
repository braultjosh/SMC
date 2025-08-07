function b = isdate(str)

% Tests if the input string can be interpreted as a date.
%
% INPUTS
% - str     [char]      1×m array, date (potentially)
%
% OUTPUTS
% - b       [logical]   scalar equal to true iff str can be interpreted as a date.

% Copyright © 2013-2023 Dynare Team
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

if isnumeric(str) && isscalar(str)
    b = true;
    return
end

b = isstringdate(str);

return % --*-- Unit tests --*--

%@test:1
date_1 = 1950;
date_2 = '1950m2';
date_3 = '-1950m2';
date_4 = '1950m52';
date_5 = ' 1950';
date_6 = '1950Y';
date_7 = '-1950a';
date_8 = '1950m ';
date_9 = '1950w50';
date_10 = '2000-01-01';
date_11 = '2000-02-30';

t(1) = isdate(date_1);
t(2) = isdate(date_2);
t(3) = isdate(date_3);
t(4) = ~isdate(date_4);
t(5) = ~isdate(date_5);
t(6) = isdate(date_6);
t(7) = isdate(date_7);
t(8) = ~isdate(date_8);
t(9) = isdate(date_9);
t(10) = isdate(date_10);
t(11) = ~isdate(date_11);
T = all(t);
%@eof:1
