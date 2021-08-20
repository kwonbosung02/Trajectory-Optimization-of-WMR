
function [c,ceq] = NonLinearConstraints(X)

c = -((X(1)- 5)^2 + (X(2)-0)^2 - 2^2);
ceq = [];

end