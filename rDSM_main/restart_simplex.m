function [SimplexState,PD] = restart_simplex(SimplexState,PD,func,limits,init_coeff)
    % This function is restarts the simplex when it is degenerated.
    % It is a step for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = size(PD,2)-4; % Dimension
    dX = init_coeff*(limits(:,2)-limits(:,1)); % Shifts

    disp('Simplex is degenerated! Soft restart')

%% Restart the simplex from the best point
    % --- Best point
    best_point = PD(SimplexState(1),1:N);
    % --- Build intial points and evaluation
    p1_N_plus_one = repmat(best_point,N+1,1); % Starting coordinates
    cost1_N_plus_one = [func(best_point);NaN(N,1)]; % Values
    for p=1:N
        p1_N_plus_one(p+1,p) = p1_N_plus_one(p+1,p) + dX(p); % Shift
        cost1_N_plus_one(p+1) = func(p1_N_plus_one(p+1,:)); % Evaluation
    end 

%% Update
% --- Update PD
    Np = size(PD,1); IDs = Np+(1:N)';
    PD = [PD;p1_N_plus_one(2:(N+1),:),IDs,cost1_N_plus_one(2:(N+1),:),zeros(N,2)];

% --- Update simplex state
    SimplexState(2:N+1) = IDs;
    SimplexState(N+2) = SimplexState(N+2)+1; % Simplex number
    SimplexState(N+3) = 0; % Restart
    SimplexState(N+5:end) = ones(1,N); % Counter of points 2 to N+1 reinitialize to 1

% --- Sort simplex state
    SimplexState = simplexsort(SimplexState,PD);
end