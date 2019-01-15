% q_i*B_{0,3}(x) + r_i*B_{1,3}(x) + s_i*B_{2,3}(x) + t_i*B_{3,3}(x)
% compute B_{i,n}(x)
% i ---> subsets
% n ---> distinc items
% x ---> observation
% a ---> interval left end
% b ---> interval right end
% s <--- B_{i,n}(x)

function [s] = bs(i, n, x, a, b)
 s = nchoosek(n,i)*(((b - x)^(n-i)*(x-a)^i)/(b-a)^n);
end




