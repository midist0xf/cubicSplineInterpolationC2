function [pp] = natcsi (x,y)

% Compute cubic spline interpolation with natural end conditions
% x ---> x_i vector
% y ---> y_i vector 
% pp <--- p_i(x) values vector

% input error management
x = errman(x,y);

% ensure nondecreasing site sequence
if any(diff(x)<0) 
    [x,y] = insort(x,y);
end

% get the cubic spline
[pp, f] = ncs(x,y);

% plot
plot(f,pp,'k',x,y,'ro')
title('Natural Cubic Spline Interpolation')
xlabel('Observations')
ylabel('Spline values')
legend('spline','points','Location','southeast')

end