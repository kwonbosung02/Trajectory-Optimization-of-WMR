function f = get_fMatrix(Acond,Bcond,states,num,guess)
global params;
f = 2 * Bcond' * params.Qcond * Acond * (states-guess.state(:,num.simNum));
end