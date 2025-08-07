function o = fill_(o, name, value)

% Fills a dseries object.
%
% INPUTS
% - o        [dseries]
% - name     [char, cell]    row char arry or cell of row char arrays.
% - value    [double]        scalar, vector or matrix.

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

if ischar(name)
    name = {name};
end

if iscell(name) & (rows(name)==1 || columns(name)==1)
    for  i=1:length(name)
        id = find(strcmp(name{i}, o.name));
        if isempty(id)
            error('dseries::fill: Variable %s is unknown.', name{i})
        else
            if isscalar(value)
                o.data(:,id) = value;
            elseif isvector(value) && length(value)==length(name)
                o.data(:,id) = value(i);
            elseif ismatrix(value) && columns(value)==length(name) && rows(value)==nobs(o)
                o.data(:,id) = value(:,i);
            else
                error('dseries::fill: dimension of the last argument is not correct.')
            end
        end
    end
else
    error('dseries::fill: Argument must be a row char array or a cell array of row char arrays')
end

return % --*-- Unit tests --*--

%@test:1
% Define a dates object
o = dseries(randn(10,5));

% Call the tested routine.
try
    o.fill_('Variable_1', NaN);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(isnan(o.data(:,1)));
end

T = all(t);
%@eof:1

%@test:2
% Define a dates object
o = dseries(randn(10,5));

% Call the tested routine.
try
    o.fill_({'Variable_1' 'Variable_3'}, NaN);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(isnan(o.data(:,1)));
    t(3) = all(isnan(o.data(:,3)));
end

T = all(t);
%@eof:2

%@test:3
% Define a dates object
o = dseries(randn(10,5));

% Call the tested routine.
try
    o.fill_({'Variable_1' 'Variable_3'}, [1 2]);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(o.data(:,1)==1);
    t(3) = all(o.data(:,3)==2);
end

T = all(t);
%@eof:3

%@test:4
% Define a dates object
o = dseries(randn(10,5));

% Call the tested routine.
try
    o.fill_({'Variable_1' 'Variable_3'}, [ones(10,1) zeros(10,1)]);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(o.data(:,1)==1);
    t(3) = all(o.data(:,3)==0);
end

T = all(t);
%@eof:4
