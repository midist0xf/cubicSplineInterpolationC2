
function  [dd] = natcsi2d( x, y )

% Computes a cubic curve using cubic spline interpolation
% with natural end conditions
% x ---> x_i vector
% y ---> y_i vector 
% dd <--- scalar functions vector

% input error management
x = errman(x,y);

% observations  number
m = length(x);

% chord parameterization method
t = zeros(1, m);

tau = zeros(1, m);
tau(1,1) = 0;

for i = 2:m
    tau(1, i) = tau(1, i-1) + sqrt((x(i)-(x(i-1)))^2 + (y(i)-y(i-1))^2);
end

for i = 1:m
    t(1,i) = tau(i)/tau(m);
end

% c_1(t) interpolates (t_i, x_i)
% c_2(t) interpolates (t_i, y_i)
c1 = ncs(t, x);
c2 = ncs(t, y);

dd = zeros(2, length(c1));
dd(1,:) = c1;
dd(2,:) = c2;

plot(c1,c2,'k',x,y,'or')
title('Cubic curve')
xlabel('C1(t)')
ylabel('C2(t)')
legend('spline','points','Location','southeast')

end
    