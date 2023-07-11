function [SimplexState,PD,c,IDr] = expansion(SimplexState,PD,func,gamm,IDr,limits)
    % This function is the expansion step for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = size(PD,2)-4; % Dimension

%% Initialization 
    % --- Centroid
    centroid = mean(PD(SimplexState(1:N),1:N),1);
    % --- Points
    pr = PD(IDr,1:N);
    % --- Costs
    cost1 = PD(SimplexState(1),N+2);
    costr = PD(IDr,N+2);

%% Expansion
    % --- Build expansion point
    pe = centroid + gamm*(pr-centroid);
    
%% Stopping criterion
    c=0; % Default value
    % --- Criterion
    if (costr < cost1) % --- Compute expansion
        % --- Evaluation
        if sum(pe'<limits(:,1)) || sum(pe'>limits(:,2)) 
            coste = Inf;
        else
            coste = func(pe);
        end
        % --- Update PD
        Np = size(PD,1); IDe = Np+1; % Expansion point ID
        PD = [PD;pe,IDe,coste,SimplexState(end-1),2];

        if coste < costr % --- Expansion
        % --- Operation
        c=2;
        % --- SimplexState update
        SimplexState(N+1) = IDe; % pN+1 <- pr
        SimplexState(N+2) = SimplexState(N+2)+1; % Simplex number
        SimplexState(N+3) = c; % Operation
        % --- Update counters - WTY: All SimplexState is updated
        SimplexState(N+4:end-1) = SimplexState(N+4:end-1)+1; % Counters from p1 to pN
        SimplexState(end) = 1; % Counter of pN+1
        % --- Sort simplex state
        SimplexState = simplexsort(SimplexState,PD); % Sort
        else % --- Only reflection
        % --- Operation
        c=1;
        % --- SimplexState update
        %WTY: All SimplexState is updated
        SimplexState(N+1) = IDr; % pN+1 <- pe
        SimplexState(N+2) = SimplexState(N+2)+1; % Simplex number
        SimplexState(N+3) = c; % Operation
        % --- Update counters - WTY: All SimplexState is updated
        SimplexState(N+4:end-1) = SimplexState(N+4:end-1)+1; % Counters from p1 to pN
        SimplexState(end) = 1; % Counter of pN+1
        % --- Sort simplex state
        SimplexState = simplexsort(SimplexState,PD); % Sort
        end
    end