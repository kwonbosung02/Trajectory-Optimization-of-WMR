global idx

function [c,ceq] = get_NonLinearConstraints(X)

c = -((X(idx.x,1)- 5)^2 + (X(idx.y,1)-0)^2 - 2^2);
ceq = [];
end