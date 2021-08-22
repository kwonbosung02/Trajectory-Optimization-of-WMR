function xN = get_NextStates(states, value)

xN = [0; 0; 0; 0; 0];
%x
xN(1) = value(1) + 0.025 * value(4) * cos(value(3));
%y
xN(2) = value(2) + 0.025 * value(4) * sin(value(3));
%theta
xN(3) = value(3) + 0.025 * value(5);

end