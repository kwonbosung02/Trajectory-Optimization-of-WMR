function [states_,input] = TrajectoryOptimization(horNum,states,data,guess,input)

%Non-Linear constraints 
nonlcon = @NonLinearConstraints;

global idx params;
n_hor = horNum;

u = input;
func = @(X)sum(sum((X(1:3,1:n_hor)-guess.state(1:3,1:n_hor))' * params.Qunit * (X(1:3,1:n_hor)-guess.state(1:3,1:n_hor)))) ...
        + sum(sum(X(4:5,1:n_hor)' * params.Runit * X(4:5,1:n_hor)));
func2 = @(X) sum(sum((X(1:3,1)-guess.state(1:3,1))' * params.Qunit * (X(1:3,1)-guess.state(1:3,1)))) + ...
                sum(sum((X(1:3,n_hor)-guess.state(1:3,n_hor))' * params.Qunit * (X(1:3,n_hor)-guess.state(1:3,n_hor)))) + ...
                    sum(sum(X(4:5,n_hor)' * params.Runit * X(4:5,n_hor)));
lb = [];
ub = [];
options = optimoptions('fmincon','MaxFunctionEvaluations',3500);
value  = fmincon(func,repmat( [states; u] , 1, n_hor) ,[],[],[],[],lb,ub,nonlcon,options); %fun x0 A b Aeq beq lb ub

states_ = value(1:3,:);
input = value(4:5,:);


end



