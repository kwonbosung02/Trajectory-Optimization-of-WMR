function H = get_HessianMatrix(Bcond,num)
global params;
H = 2 * (Bcond' * params.Qcond * Bcond + params.Rcond);


end