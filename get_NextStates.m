function xN = get_NextStates(states, u)
global idx params;
xN = [0; 0; 0];
%x
xN(idx.x) = states(idx.x) + params.dt * u(1) * cos(states(idx.theta));
%y
xN(idx.y) = states(idx.y) + params.dt * u(1) * sin(states(idx.theta));
%theta
xN(idx.theta) = states(idx.theta) + params.dt * u(2);

end