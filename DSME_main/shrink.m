function [SimplexState,PD,c] = shrink(SimplexState,PD,func,sigm)
    % This function is the shrink step for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = size(SimplexState,2)-3; % Dimension

%% Initialization 
    % --- points
    p1 = PD(1,1:N);
    ppi = PD(SimplexState(2:(N+1)),1:N);

%% Shrink
    % --- Build shrink points
    ps = p1 + sigm*(ppi-p1);
    % --- Evaluation
    costs = func(ps);

%% Update PD
    Np = size(PD,1); IDs = Np+(1:N)'; % Shink point IDs
    PD = [PD;ps,IDs,costs,SimplexState(end-1)*ones(N,1),4*ones(N,1)];

%% Update simplex state
    c=4; % Default value
    % --- SimplexState update
    SimplexState(2:(N+1)) = IDs; % p2,...,pN+1 <- ps
    SimplexState(end-1) = SimplexState(end-1)+1; % Simplex number
    SimplexState(end) = c; % Operation
    SimplexState = simplexsort(SimplexState,PD); % Sort