
function [c,ceq] = NonLinearConstraints(X) %x y theta v w

global idx params;

x = X(idx.x,1);
y = X(idx.y,1);
theta = X(idx.theta,1);
v = X(idx.v,1);
w = X(idx.w,1);
dt = params.dt;


%circle 
c(1) = -((x- 5)^2 + (y-0)^2 - 2^2);

%control constraints
c(2) = v - params.v_max;  % v <= v_max
c(3) = -v + params.v_min; % v >= v_min
c(4) = w - params.w_max;  % w <= w_max
c(5) = -w + params.w_min; % w >= w_min

ceq = [];

end