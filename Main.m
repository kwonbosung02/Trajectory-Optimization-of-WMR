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

%main
for simNum  = 1 : iterNum
    
     states = TrajectoryOptimization(simNum,idx,params,states,data);
     plot(states(idx.x),states(idx.y),'-o');
     drawnow;
     
end

end 