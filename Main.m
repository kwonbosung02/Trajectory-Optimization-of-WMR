function out = Main()
close all
clear all
clc
global idx params;
%index and parameters
[idx, params] = get_params();

data = get_Data();

%initial state
states = params.startState; %[0 0 0]
 
%iteration number
iterNum = params.iterNum;

%plot the data
plot(data.x,data.y,'LineWidth',2);
hold on
plot(data.startx,data.starty,'LineWidth',2);
hold on
plot(data.endx,data.endy,'LineWidth',2);
grid on

%guess trajectory
% x y theta v w 
guess.x = linspace(params.startState(idx.x), params.endState(idx.x),iterNum);
guess.y = linspace(params.startState(idx.y), params.endState(idx.y),iterNum);
guess.theta = linspace(params.startState(idx.theta), params.endState(idx.theta),iterNum);
guess.v = linspace(0,0,iterNum);
guess.w = linspace(0,0,iterNum);

%state and control force
guess.data = vertcat(guess.x,guess.y,guess.theta,guess.v,guess.w);
guess.state = vertcat(guess.x,guess.y,guess.theta);

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

for simNum  = 1 : iterNum - idx.n_hor + 1
    
     states = TrajectoryOptimization(simNum,states,data,guess);
     disp(states);
     plot(states(idx.x),states(idx.y),'-o');
     drawnow;
     
end

end 