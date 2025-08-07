function n = longyearsince(y, z)

% Returns the number of long years since base year z.
%
% INPUTS 
% - y   [integer] scalar or vector, the year.
% - z   [integer] scalar, base year (default is 0).
%
% OUTPUTS 
% - n   [integer] scalar or vector, number of long years.

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

if nargin<2
    z = 0; % Default value for base year.
end

n = zeros(length(y), 1);

for i=1:length(y)
    if y(i)>=z
        n(i) = sum(islongyear(z:y));
    end
end