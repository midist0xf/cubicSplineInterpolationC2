function  [ pp, f ]  = ncs( x, y)

% NCSI Cubic spline interpolation with natural end conditions
%   It is the piecewise polynomial (pp) form of a cubic spline. 
%   pp are in Bernstein's basis:
%      p_i(x)=q_iB_{0,3}(x)+r_iB_{1,3}(x)+s_iB_{2,3}(x)+t_i)B_{3,3}(x)
%
% PRECONDITION: ensure nondecreasing site sequence
% x ---> x_i vector
% y ---> y_i vector 
% pp <--- p_i(x) values vector

% x observations number
m = length(x);

% define the increment h_i = x_x+1 - x_i
h = zeros(1, m);
for i = 1:m-1
    h(i) = x(i+1)-x(i);
end

% linear system to solve Ax = b
% A end conditions
A = zeros(m);
A(1, 1:2) = [2*h(1) h(1)];
A(m, m-1:m) = [h(m-1) 2*h(m-1)];

% populate remaining A elements
c = 1;
for r = 2:m-1
    A(r,c) = h(r);
    A(r,c+1) = 2*(h(r)+h(r-1));
    A(r,c+2) = h(r-1);
    c = c+1;    
end

% b column vector
% b end conditions
b = zeros(m,1);
b(1,1) = y(2)-y(1);
b(m,1) = y(m)-y(m-1);

% populate remaining b elements
for i = 2:m-1
    b(i,1) = (h(i)/h(i-1))*(y(i)-y(i-1))+((h(i-1)/h(i))*(y(i+1)-y(i)));
end

% D_i column vector
d = A\b;

% q_i r_i s_i t_i Bernstein polynomial's coefficients vectors
qc = zeros(1, m-1);
tc = zeros(1, m-1);
for i = 1:m-1
    % conditions imposed to make the spline interpolates data
    qc(i) = y(i);
    tc(i) = y(i+1);
end

rc = zeros(1,m-1);
sc = zeros(1,m-1);
for i = 1:m-1
    rc(i) = y(i)+h(i)*d(i);
    sc(i) = y(i+1)-h(i)*d(i+1);
end
    
% evaluation
f = linspace(min(x),max(x), 100);

pp = double.empty;
for i = 1:m-1
    for j = 1:length(f) 
         % find which intervals f(j) belongs to and use proper coefficients
         % to evaluate Bernstein polynomials
         if(f(j)>=x(i)) && (f(j)<=x(i+1))
             pp(j) = qc(i)*bs(0,3,f(j),x(i),x(i+1)) + rc(i)*bs(1,3,f(j),x(i),x(i+1)) ... 
             + sc(i)*bs(2,3,f(j),x(i),x(i+1)) + tc(i)*bs(3,3,f(j),x(i),x(i+1));
         end
    end
end

end
