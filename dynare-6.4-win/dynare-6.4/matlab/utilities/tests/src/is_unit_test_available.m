function info = is_unit_test_available(mfile)

% Decides if unitary tests defined in a matlab routine (file) have to be run
% by checking the content of the first line.
%
% INPUTS
%  - mfile  [string]    name of the routine (with full relative path)
%
% OUTPUTS
%  - info   [logical]   scalar, equal to true if unit tests must be run, false otherwise.

% Copyright © 2013-2023 Dynare Team
%
% This file is part of Dynare (m-unit-tests module).
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare's m-unit-tests module is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
% or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
% more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <https://www.gnu.org/licenses/>.

info = false;

filecontent = fileread(mfile);

if ~isempty(regexp(filecontent, 'return(\s*)\%(\s*)--\*--(\s*)Unit tests(\s*)--\*--','match'))
    info = true;
    return
end

if ~isempty(regexp(filecontent, 'end(\s*)\%(\s*)classdef(\s*)--\*--(\s*)Unit tests(\s*)--\*--','match'))
    info = true;
    return
end
