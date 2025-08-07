function b = isweekly(str)

% Tests if the input can be interpreted as a monthly date.
%
% INPUTS
%  o str     string.
%
% OUTPUTS
%  o b       logical scalar, equal to true if str can be interpreted as a weekly date or false otherwise.

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

if ischar(str)
    if isempty(regexp(str,'^-?[0-9]+[Ww]([1-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-3])$','once'))
        b = false;
        return
    else
        b = true;
    end
else
    b = false;
    return
end

% TODO Also test w.r.t. the number of weeks in a year.
if b
    period = cellfun(@str2double, strsplit(str, {'W','w'}));
    if isequal(period(2), 0) || period(2)>(52+islongyear(period(1)))
        b = false;
    end
end


return % --*-- Unit tests --*--

%@test:1
date_1 = '1950M2';
date_2 = '1950W2';
date_3 = '-1950w2';
date_4 = '1950W52';
date_5 = '1950 azd ';
date_6 = '1950Y';
date_7 = '1950Q3';
date_8 = '1950m24';
date_9 = '2003W53';
date_10 = '2004W53';

t(1) = ~isweekly(date_1);
t(2) = isweekly(date_2);
t(3) = isweekly(date_3);
t(4) = isweekly(date_4);
t(5) = ~isweekly(date_5);
t(6) = ~isweekly(date_6);
t(7) = ~isweekly(date_7);
t(8) = ~isweekly(date_8);
t(9) = ~isweekly(date_9);
t(10) = isweekly(date_10);
T = all(t);
%@eof:1
