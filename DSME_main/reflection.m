function [SimplexState,PD,c,IDr] = reflection(SimplexState,PD,func,alph,limits)
    % This function is the reflection step for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = size(SimplexState,2)-3; % Dimension

%% Initialization 
    % --- Centroid
    centroid = mean(PD(SimplexState(1:N),1:N),1);
    % --- Points
    pN_plus_one = PD(SimplexState(N+1),1:N);
    % --- Costs
    cost1 = PD(SimplexState(1),N+2);
    costN = PD(SimplexState(N),N+2);

%% Reflection
    % --- Build reflection point
    pr = centroid + alph*(centroid-pN_plus_one);
    % --- Evaluation
    if sum(pr'<limits(:,1)) || sum(pr'>limits(:,2)) 
        costr = Inf;
    else
        costr = func(pr);
    end
    

%% Update PD
    Np = size(PD,1); IDr = Np+1; % Reflection point ID
    PD = [PD;pr,IDr,costr,SimplexState(end-1),1];

%% Stopping criterion
    c=0; % Default value
    % --- Criterion
    if (cost1 <= costr) && (costr < costN)
        % --- Operation
        c=1;
        % --- SimplexState update
        SimplexState(N+1) = IDr; % pN+1 <- pr
        SimplexState(end-1) = SimplexState(end-1)+1; % Simplex number
        SimplexState(end) = c; % Operation
        SimplexState = simplexsort(SimplexState,PD);
    end