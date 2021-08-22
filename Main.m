function out = Main()
close all
clear all
clc
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


%main



for simNum  = 1 : iterNum
    
     states = TrajectoryOptimization(simNum,idx,params,states,data,guess);
     plot(states(idx.x),states(idx.y),'-o');
     drawnow;
     
end

end 