function out = Main()
close all
clear all
clc

global idx params;
%index and parameters
[idx, params] = get_params();

data = get_Data();

%initial state
states = params.startState;
 
%iteration number
iterNum = params.iterNum;

%plot the data
plot(data.x,data.y,'LineWidth',2);
hold on
plot(data.startx,data.starty,'LineWidth',2);
hold on
plot(data.endx,data.endy,'LineWidth',2);
grid on
xlim([-3 13])
ylim([-2 2])


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

%initial control input
input = params.InitialInput;

horNum = iterNum;

[states,input] = TrajectoryOptimization(horNum,states,data,guess,input);

plot(states(idx.x,:),states(idx.y,:),'LineWidth',3);
disp(states)
disp(input)
end 


