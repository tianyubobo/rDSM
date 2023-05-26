function [SH,PD] = DSME_initialization(init_conditions,init_coeff,limits,func)
    % This function initialize the simplex history (SH) and points database
    % (PD) for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = numel(init_conditions); % Dimension
    dX = init_coeff*(limits(:,2)-limits(:,1)); % Shifts

%% Initialization   
    % --- Build intial points and evaluation
    p1_N_plus_one = repmat(init_conditions,N+1,1); % Starting coordinates
    cost1_N_plus_one = [func(init_conditions);NaN(N,1)]; % Values
    for p=1:N
        p1_N_plus_one(p+1,p) = p1_N_plus_one(p+1,p) + dX(p); % Shift
        cost1_N_plus_one(p+1) = func(p1_N_plus_one(p+1,:)); % Evaluation
    end 
    % --- Sort
    [~,SimplexPointIndicesSorted] = sort(cost1_N_plus_one);
    
    % --- Initialize PD = PointsDatabase
    %  p_1 | ... | p_N | ID | Cost | in Simplex numb. | Operation
    PD(1:(N+1),:) = [p1_N_plus_one,(1:(N+1))',cost1_N_plus_one,zeros(N+1,2)];
    
    % --- Initialize SH = SimplexHistory
    % p1 | ... | pN+1 | Simplex numb. | Operation
    SH = [SimplexPointIndicesSorted',0,0];