function [A, B] = get_DynamicMatrix(num,guess)
global idx params;
simNum = num.simNum;
horNum = num.horNum;

A = eye(idx.n_states);
k_ = simNum + horNum - 1;

%Value A
A(idx.x, idx.theta) = -guess.data(idx.v,k_) * sin(guess.data(idx.theta,k_)) * params.dt;
A(idx.y, idx.theta) = guess.data(idx.v,k_) * cos(guess.data(idx.theta,k_)) * params.dt;

%Value B
B = zeros(idx.n_states,idx.n_inputs);
B(idx.x, 1) = cos(guess.data(idx.theta,k_)) * params.dt;
B(idx.y, 1) = sin(guess.data(idx.theta,k_)) * params.dt;
B(idx.theta, 2) = params.dt ; 

end