function states_ = TrajectoryOptimization(simNum,states,data,guess)

%Non-Linear constraints 
nonlcon = @NonLinearConstraints;
global idx params;


%
num.simNum = simNum;
for horNum = 1 : idx.n_hor
    num.horNum = horNum;
    [Adyn,Bdyn] = get_DynamicMatrix(num,guess);
    A{horNum} = Adyn;
    B{horNum} = Bdyn;
end
[Acond, Bcond] = get_CondensedMatrix(A,B);
H = get_HessianMatrix(Bcond,num);
f = get_fMatrix(Acond,Bcond,states, num, guess);
H = (H + H') / 2 ;
u = quadprog(H, f, params.quadProgA,params.quadProgb);

states_ = get_NextStates(states, u);


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



