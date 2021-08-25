
function [c,ceq] = NonLinearConstraints(X) %x y theta v w

global idx params;

n_hor = params.iterNum;

%state
x = X(idx.x,1:n_hor);
y = X(idx.y,1:n_hor);
theta = X(idx.theta,1:n_hor);

%control input
v = X(idx.v,1:n_hor);
w = X(idx.w,1:n_hor);

dt = params.dt;

n_states = idx.n_states;
n_inputs = idx.n_inputs;


initial(idx.x) = x(1,1) - params.startState(idx.x);
initial(idx.y) = y(1,1) - params.startState(idx.y);
initial(idx.theta) = theta(1,1) - params.startState(idx.theta);

final(idx.x) = x(1,n_hor) - params.endState(idx.x);
final(idx.y) = y(1,n_hor) - params.endState(idx.y);
final(idx.theta) = theta(1,n_hor) - params.endState(idx.theta);

    
    % final(n_states*(0)+1) = x(1,end) - guess.x(1,end);
    % final(n_states*(0)+2) = y(1,end) - guess.y(1,end);
    % final(n_states*(0)+3) = theta(1,end) - guess.theta(1,end);


for i=1:size(x,2)
    
    outCircle(i) = -((x(1,i)- 5)^2 + (y(1,i)-0)^2 - 2^2);
  
    if i ~= size(x,2)
        dynConst(n_states * (i-1) + 1) =  x(1,i+1) - x(1,i) - dt * v(1,i) * cos( theta(1,i) ) ;
        dynConst(n_states * (i-1) + 2) =  y(1,i+1) - y(1,i) - dt * v(1,i) * sin( theta(1,i) ) ;
        dynConst(n_states * (i-1) + 3) =  theta(1,i+1) - theta(1,i) - dt * w(1,i)  ;
    
        
    end
end

c = [outCircle'];

ceq = [dynConst' ; initial' ; final'];

end