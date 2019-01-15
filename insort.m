function [newx, newy] = insort(x, y)

% sort the input to ensure nondecreasing site sequence
% x ---> x_i vector
% y ---> y_i vector
% newx <--- increasing sorted x vector
% newy <--- y vector sorted accordingly to keep (x_i,y_i) correspondence

m = length(x);

oldx = x;
newx = sort(x);

for i = 1:m
    for j = 1:m
        if(newx(i) == oldx(j))
            newy(i) = y(j);
        end
    end
end

end


