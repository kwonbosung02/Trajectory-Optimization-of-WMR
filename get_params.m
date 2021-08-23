function [idx,params] = get_params()

idx.x = 1;
idx.y = 2;
idx.theta = 3;
idx.v = 4;
idx.w = 5;

idx.n_states = 3;
idx.n_inputs = 2;
idx.n_hor = 5;
idx.n_dim = 3;

%iteration number
params.iterNum = 1000;

%Weight matrix
%params.Qunit = [1,1,0.33];
%params.Runit = [1e-1,1e-1];
params.Qunit = diag([1,1,0.5]);
params.Runit = 0.1 * eye(2);

%Condensed Weight matrix
params.Qcond = diag(repmat(params.Qunit,1,idx.n_hor));
params.Rcond = diag(repmat(params.Runit,1,idx.n_hor));


%sampling period dt
params.dt = 0.025;

%start and end State
params.startState = [0; 0; 0; 0; 0];
params.endState = [10; 0; 0; 0; 0];

%constraint
params.v_min = -4;
params.v_max = 4;
params.w_min = -4;
params.w_max = 4;

%constraint Matrix
%A 
params.quadProgA = cell(idx.n_hor);
Acont = vertcat(eye(2),-eye(2));

for i = 1 : idx.n_hor
    for j = 1 : idx.n_hor
        if(i == j)
        params.quadProgA{i,j} = Acont;
        end
        
        if(i ~= j)
        params.quadProgA{i,j} = [0 0; 0 0; 0 0; 0 0];
        end
    end
end
params.Aeq = cell2mat(params.quadProgA);

%b
params.Beq = cell(idx.n_hor,1);
for i = 1 : idx.n_hor

    params.quadProgb{i,1} = [params.v_max; params.w_max; -params.v_min; -params.w_min];
end
params.quadProgb = cell2mat(params.quadProgb);

end
