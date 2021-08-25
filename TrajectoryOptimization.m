function [states_,input] = TrajectoryOptimization(horNum,states,data,guess,input)

%Non-Linear constraints 
nonlcon = @NonLinearConstraints;
global idx params;
n_hor = horNum;

% %%%%%%%%%%%%%%%%%%%%%%
% num.simNum = simNum;
% for horNum = 1 : idx.n_hor
%     num.horNum = horNum;
%     [Adyn,Bdyn] = get_DynamicMatrix(num,guess);
%     xA{horNum} = Adyn;
%     B{horNum} = Bdyn;
% end
% 
% [Acond, Bcond] = get_CondensedMatrix(A,B);
% H = get_HessianMatrix(Bcond,num);
% f = get_fMatrix(Acond,Bcond,states, num, guess);
% H = (H + H') / 2 ;
% u = quadprog(H, f, params.quadProgA,params.quadProgb);
% 
% states_ = get_NextStates(states, u);
% %%%%%%%%%%%%%%%%%%%%%%

u = input;
func = @(X) ( sum( sum(  (X(1:3,1:n_hor)-guess.state(1:3,1:n_hor))' * params.Qunit * (X(1:3,1:n_hor)-guess.state(1:3,1:n_hor))) ...
        + sum ( sum( X(4:5,1:n_hor)' * params.Runit * X(4:5,1:n_hor) ) ))) ;
    
lb = [-Inf; -Inf; -Inf; params.v_min; params.w_min];
ub = [Inf; Inf; Inf; params.v_max; params.v_max];
    
value  = fmincon(func,repmat( [states; u] , 1, n_hor) ,[],[],[],[],lb,ub,nonlcon); %fun x0 A b Aeq beq lb ub

states_ = value(1:3,:);
input = value(4:5,:);

%

%main
%should put dynamic model
%    
%     Xt = guess.data(:,simNum + horNum);
%     
%     func = @(X)(X(1:3,:)-Xt(1:3,:))' * params.Qunit * (X(1:3,:)-Xt(1:3,:)) + (X(1:3,:)-Xt(1:3,:))' * params.Qunit * (X(1:3,:)-Xt(1:3,:)) + X(4:5,:)' * params.Runit * X(4:5,:);
%     value  = fmincon(func,states,[],[],[],[],[],[],nonlcon);
%     disp(value);
%     states_ = get_NextStates(states,value);
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
  
%non-linear constraints



% num.simNum = simNum; %k
% nonlcon = @get_NonLinearConstraints;
% 
% for horNum = 1 : idx.n_hor
%     num.horNum = horNum; 
%     
%     Xt = guess.data(:,simNum +horNum);
%     
%     value  = fmincon(func,states,[],[],[],[],[],[],nonlcon);
%     disp(value);
%     states_ = get_NextStates(states,value);
% 
% end

end



