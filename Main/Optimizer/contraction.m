function [SimplexState,PD,c,IDr] = contraction(SimplexState,PD,func,phi,IDr)
    % This function is the contraction step for the rDSM algorithm.
    % Inside and outside contraction are considered.


%% Parameters
    N = size(PD,2)-4; % Dimension

%% Initialization 
    % --- Centroid
    centroid = mean(PD(SimplexState(1:N),1:N),1);
    % --- Points
    pN_plus_one = PD(SimplexState(N+1),1:N);
    pr = PD(IDr,1:N);
    % --- Costs
    costN_plus_one = PD(SimplexState(N+1),N+2);
    costr = PD(IDr,N+2);

%% Contraction
    % --- Build contraction points
    pc1 = centroid + phi*(pr-centroid); % Outside contraction
    pc2 = centroid + phi*(pN_plus_one-centroid); % Inside contraction

%% Stopping criterion - Evaluation and update
    c=0; % Default value
    % --- Criterion
    if (costr < costN_plus_one) % ---- Outside contraction
        % --- Evaluation
        costc1 = func(pc1);
        % --- Update PD
        Np = size(PD,1); IDc1 = Np+1; % Contraction point ID
        PD = [PD;pc1,IDc1,costc1,SimplexState(end-1),31];
        if (costc1 < costr)
        % --- Operation
        c=31;
        % --- SimplexState update
        SimplexState(N+1) = IDc1; % pN+1 <- pc1
        SimplexState(N+2) = SimplexState(N+2)+1; % Simplex number
        SimplexState(N+3) = c; % Operation
        % --- Sort counters - WTY: All SimplexState is updated
        SimplexState(N+4:end-1) = SimplexState(N+4:end-1)+1; % Counters from p1 to pN
        SimplexState(end) = 1; % Counter of pN+1
        % --- Update simplex state
        SimplexState = simplexsort(SimplexState,PD); % Sort
        end
    else % ---- Inside contraction
        % --- Evaluation
        costc2 = func(pc2);
        % --- Update PD
        Np = size(PD,1); IDc2 = Np+1; % Contraction point ID
        PD = [PD;pc2,IDc2,costc2,SimplexState(end-1),32];
        if (costc2 < costN_plus_one)
        % --- Operation
        c=32;
        % --- SimplexState update
        SimplexState(N+1) = IDc2; % pN+1 <- pc2
        SimplexState(N+2) = SimplexState(N+2)+1; % Simplex number
        SimplexState(N+3) = c; % Operation
        % --- Update counters - WTY: All SimplexState is updated
        SimplexState(N+4:end-1) = SimplexState(N+4:end-1)+1; % Counters from p1 to pN
        SimplexState(end) = 1; % Counter of pN+1
        % --- Sort simplex state
        SimplexState = simplexsort(SimplexState,PD); % Sort
        end
    end