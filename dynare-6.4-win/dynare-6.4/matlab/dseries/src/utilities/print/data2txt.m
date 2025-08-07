function str= data2txt(y)

% Prints a one dimensional array.

% Copyright © 2017-2022 Dynare Team
%
% This code is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare dseries submodule is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <https://www.gnu.org/licenses/>.

str = mat2str(y);
str = strrep(str, 'NaN', '-99999');
str = strrep(str, '[', '(\n');
str = strrep(str, ';', '\n');
str = strrep(str, ']', '\n)');

return % --*-- Unit tests --*--

%@test:1
try
    data_mat=[NaN
        1
        3
        3
        4
        1
        2
        3
        4
        1.5
        2.3
        3.1
        NaN
        1.2
        NaN
        3
        5];


    ts = dseries(data_mat,'1999Q1');
    o = x13(ts);
    o.transform('function','log');
    o.automdl('savelog','amd');
    o.x11('save','(d11)');
    o.run();
    deseasonalized_data = o.results.d11;
    if deseasonalized_data.nobs~=16 || deseasonalized_data.init~=dates('1999Q2')
        t(1) = false;
    else
        t(1) = true;
    end
catch
    t(1) = false;
end
T = all(t);

%@eof:1