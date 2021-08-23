function states_ = TrajectoryOptimization(simNum,idx,params,states,data,guess)

%Non-Linear constraints 

%Cost function
func = @(X)(X(1:3,:)-Xt(1:3,:))' * params.Qunit * (X(1:3,:)-Xt(1:3,:)) + (X(1:3,:)-Xt(1:3,:))' * params.Qunit * (X(1:3,:)-Xt(1:3,:)) + X(4:5,:)' * params.Runit * X(4:5,:);

num.simNum = simNum;
for horNum = 1 : idx.n_hor
    disp(simNum + horNum - 1);
end


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
states_ = 0;

end



