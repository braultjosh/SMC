function Y = rcumprod(X)

% Returns the cumulated product of X from bottom to top (reversed order
% compared to cumprod, emulate the `reverse` option).
%
% INPUTS
% - X      [double]      T×N array
%
% OUTPUTS
% - Y      [double]      T×N array

if isoctave
    Y = flipud(cumprod(flipud(X)));
else
    Y = cumprod(X, 'reverse');
end
