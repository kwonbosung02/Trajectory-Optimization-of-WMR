function states_ = TrajectoryOptimization(simNum,idx,params,states,data)
%     
%     num.simNum = simNum; %k
%     
%     for hornum = 1 : idx.n_hor
%         
%     num.horNum = hornum;    
%     [Adyn,Bdyn] = get_DynamicMatrix(num,idx,params,data,states);
%     A{hornum} = Adyn; %(k|k) (k+1|k) ... (k + horizon -1 | k)
%     B{hornum} = Bdyn; %(k|k) (k+1|k) ... (k + horizon -1 | k)
%     
%     end
%     
%     [Acond, Bcond] = get_CondensedMatrix(A,B,idx,params);
%     
%     H = get_HessianMatrix(Bcond,idx,params,num);
%     H = (H + H') / 2 ;
%     f = get_fMatrix(Acond,Bcond,states,idx,params, num, data);
%     %d = get_dMatrix(states, Acond,idx, params, num, data)
%     %quadProgb = get_quadProgb(states, idx, params, num, data);
%     
%     u = quadprog(H, f, params.quadProgA,params.quadProgb);
%     
%     
%     states_ = get_NextStates(states,idx, params, u);
%     

%inequality constraints
%A = params.A;
%b = params.b;
%equality constraints
%Aeq = [];
%Beq = [];d

%non-linear constraints
function [c,ceq] = NonLinearConstraints(X)

c = -((X(1)- 5)^2 + (X(2)-0)^2 - 2^2);
ceq = [];

end
nonlcon = @NonLinearConstraints;
%function 
func = @(X)(X-params.startState)' *(X-params.startState) + (X-params.endState)' * (X-params.endState)

%fix this with U
states_ = fmincon(func,states,[],[],[],[],[],[],nonlcon);


end