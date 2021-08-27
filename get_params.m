function [idx,params] = get_params()

idx.x = 1;
idx.y = 2;
idx.theta = 3;
idx.v = 4;
idx.w = 5;

idx.n_states = 3;
idx.n_inputs = 2;
idx.n_hor = 3;
idx.n_dim = 3;


%Weight matrix
%params.Qunit = [1,1,0.33];
%params.Runit = [1e-1,1e-1];
params.Qunit = diag([10,10,8]);
params.Runit = 1e-8 * eye(1);
params.Qfinal = 100;

%Algoritmhs
params.maxFuncIteration= 200000;

%sampling period dt
params.T = 10;
params.dt = 0.1;


%iteration number
params.iterNum = params.T / params.dt ;

%start and end State
params.startState = [0; 0; 0];
params.endState = [8; 0; 0];

%Initial Control Input
params.InitialInput = [0; 0];
%constraint
params.v_min = -30;
params.v_max = 30;
params.w_min = -30;
params.w_max = 30;

% Obstacle
params.obs.x = 4;
params.obs.y = 0;
params.obs.rad = 1;

