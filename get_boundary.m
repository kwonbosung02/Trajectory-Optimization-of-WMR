function [lb, ub] = get_boundary(n_hor)
global params

lb = [-inf; -inf; -inf; params.v_min; params.w_min];
ub = [ inf;  inf;  inf; params.v_max; params.w_max];

lb = repmat(lb,1,n_hor)
ub = repmat(ub,1,n_hor)
end