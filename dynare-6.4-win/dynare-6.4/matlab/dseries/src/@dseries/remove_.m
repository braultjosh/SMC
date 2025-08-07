function o = remove_(o, a)

% Removes a variable from a dseries object (alias for the pop_ method) or a list of variables.

% Copyright © 2017-2023 Dynare Team
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

if ischar(a)
    o = pop_(o, a);
elseif iscellofchar(a)
    [isino, io] = ismember(a, o.name);
    io = io(isino);
    o.data(:,io) = [];
    o.name(io) = [];
    o.tex(io) = [];
    o.ops(io) = [];
    otagnames = fieldnames(o.tags);
    for i=1:length(otagnames)
        o.tags.(otagnames{i})(io) = [];
    end
    if any(~isino)
        w = warning('off', 'backtrace');
        for i=1:length(a)
            if ~isino(i)
                warning('Variable %s is not a member of the dseries object.', a{i})
            end
        end
        warning(w.state, 'backtrace')
    end
else
    error('Unexpected type.')
end

return  % --*-- Unit tests --*--

%@test:1
% Define a datasets.
A = rand(10,6);

% Define names
A_name = {'A1';'A2';'A3';'A4';'A5';'A6'};

% Instantiate a time series object.
try
    ts1 = dseries(A,[],A_name,[]);
    ts1.tag('type');
    ts1.tag('type', 'A1', 1);
    ts1.tag('type', 'A2', 2);
    ts1.tag('type', 'A3', 3);
    ts1.remove_({'A1','A3','A5'});
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = dassert(ts1.vobs,3);
    t(3) = dassert(ts1.nobs,10);
    t(4) = dassert(ts1.data,[A(:,2), A(:,4), A(:,6)],1e-15);
    t(5) = isequal(ts1.name,{'A2';'A4';'A6'});
end
T = all(t);
%@eof:1


%@test:2
% Define a datasets.
A = rand(10,6);

% Define names
A_name = {'A1';'A2';'A3';'A4';'A5';'A6'};

% Instantiate a time series object.
try
    ts1 = dseries(A,[],A_name,[]);
    ts1.tag('type');
    ts1.tag('type', 'A1', 1);
    ts1.tag('type', 'A2', 2);
    ts1.tag('type', 'A3', 3);
    ts1.remove_({'A1','A3','A5','A7','A9'});
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = dassert(ts1.vobs,3);
    t(3) = dassert(ts1.nobs,10);
    t(4) = dassert(ts1.data,[A(:,2), A(:,4), A(:,6)],1e-15);
    t(5) = isequal(ts1.name,{'A2';'A4';'A6'});
end
T = all(t);
%@eof:1
