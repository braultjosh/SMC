function b = islongyear(y)

% Returns true iff y is a year with 53 weeks.
%
% INPUTS
% - y     [integer]     scalar or vector, year(s).
%
% OUTPUTS
% - b     [logical]     scalar or vector, equal to true iff y is a leap year.


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

b = mod(y+fix(y/4)-fix(y/100)+fix(y/400),7)==4 | mod(y-1+fix((y-1)/4)-fix((y-1)/100)+fix((y-1)/400),7)==3;

return % --*-- Unit tests --*--

%@test:1
Years = [4; 9 ; 15 ; 20 ; 26 ; 32 ; 37 ; 43 ; 48 ; 54 ; 60 ; 65 ; 71 ; 76 ; 82 ; 88 ; 93 ; 99 ;
         105 ; 111 ; 116 ; 122 ; 128 ; 133 ; 139 ; 144 ; 150 ; 156 ; 161 ; 167 ; 172 ; 178 ; 184 ; 189 ; 195 ;
         201 ; 207 ; 212 ; 218 ; 224 ; 229 ; 235 ; 240 ; 246 ; 252 ; 257 ; 263 ; 268 ; 274 ; 280 ; 285 ; 291 ; 296 ;
         303 ; 308 ; 314 ; 320 ; 325 ; 331 ; 336 ; 342 ; 348 ; 353 ; 359 ; 364 ; 370 ; 376 ; 381 ; 387 ; 392 ; 398];
try
    ly = islongyear(Years);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(ly);
end

T = all(t);
%@eof:1

%@test:2
LongYears = [4; 9 ; 15 ; 20 ; 26 ; 32 ; 37 ; 43 ; 48 ; 54 ; 60 ; 65 ; 71 ; 76 ; 82 ; 88 ; 93 ; 99 ;
             105 ; 111 ; 116 ; 122 ; 128 ; 133 ; 139 ; 144 ; 150 ; 156 ; 161 ; 167 ; 172 ; 178 ; 184 ; 189 ; 195 ;
             201 ; 207 ; 212 ; 218 ; 224 ; 229 ; 235 ; 240 ; 246 ; 252 ; 257 ; 263 ; 268 ; 274 ; 280 ; 285 ; 291 ; 296 ;
             303 ; 308 ; 314 ; 320 ; 325 ; 331 ; 336 ; 342 ; 348 ; 353 ; 359 ; 364 ; 370 ; 376 ; 381 ; 387 ; 392 ; 398];

Years = setdiff(1:400, LongYears);

try
    ly = islongyear(Years);
    t(1) = true;
catch
    t(1) = false;
end

if t(1)
    t(2) = all(~ly);
end

T = all(t);
%@eof:2
