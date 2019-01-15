function [ newx ] = errman(x,y)

% check for input error and eventually return modified input
% or visualize a specific error message
% x ---> x_i vector
% y ---> y_i vector
% newx <--- modified x_i vector

% errors management
% make sure x and y are not empty
if(isempty(x) || isempty(y))
    error('NATCSI:XorYempty', 'Error: one or both vectors are empty' )
end

% make sure x is real
if ~all(isreal(x))
   x = real(x);
   warning('NATCSI:Xnotreal', 'Warning: data points imaginary part will be ignored')
end

% check for Nans and Inf's among the sites:
nanx = find(~isfinite(x), 1);
if ~isempty(nanx)
    error('NATCSI:NaNs', 'Error: there are infinite or NaN values among the sites')
end

% make sure x and y have the same number of elements
if(length(x) ~= length(y))
    error('NATCSI:XYnotsamenum', 'Error: x and y have a different number of elements')
elseif(length(x) == 1)
    error('NATCSI:toofewpoints', 'Error: you need more than one point to interpolate')
end

newx = x;

end