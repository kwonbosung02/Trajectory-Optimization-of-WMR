
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
n_input = idx.n_inputs;

%initial and final state equality constraints
initial(idx.x) = x(1,1) - params.startState(idx.x);
initial(idx.y) = y(1,1) - params.startState(idx.y);
initial(idx.theta) = theta(1,1) - params.startState(idx.theta);
     
final(idx.x) = x(1,n_hor) - params.endState(idx.x);
final(idx.y) = y(1,n_hor) - params.endState(idx.y);
final(idx.theta) = theta(1,n_hor) - params.endState(idx.theta);


%finalInputs(1) = v(1,n_hor) - 0;
%finalInputs(2) = w(1,n_hor) - 0;

for i = 1 : size(x,2)
    %object inequality constraints
    outCircle(i) = -((x(1,i)- params.obs.x )^2 + ( y(1,i)- params.obs.y )^2 - (params.obs.rad)^2);
    
    %v and w inequality constraints
    v_cond(n_input * (i-1) + 1) = v(1,i) - params.v_max;
    v_cond(n_input * (i-1) + 2) = params.v_min - v(1,i);
    
    w_cond(n_input * (i-1) + 1) = w(1,i) - params.w_max;
    w_cond(n_input * (i-1) + 2) = params.w_min - w(1,i);
    
    
    if i ~= size(x,2)
        dynConst(n_states * (i-1) + 1) =  x(1,i+1) - x(1,i) - dt * v(1,i) * cos( theta(1,i) ) ;
        dynConst(n_states * (i-1) + 2) =  y(1,i+1) - y(1,i) - dt * v(1,i) * sin( theta(1,i) ) ;
        dynConst(n_states * (i-1) + 3) =  theta(1,i+1) - theta(1,i) - dt * w(1,i)  ;
    end
    
end

c = [outCircle' ; v_cond' ; w_cond'  ];

ceq = [dynConst'; initial'; final' ];
end