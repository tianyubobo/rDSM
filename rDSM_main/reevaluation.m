function [SimplexState,PD] = reevaluation(SimplexState,PD,func)
    % This function reevaluates points in the simplex that stayed too long.
    % This step avoid keeping false good points.
        
    % WANG Tianyu, 2023/06/26

    % Copyright: 2023 WANG Tianyu (email address)
    % CC-BY-SA

%% Parameters
    N = size(PD,2)-4; % Dimension

%% Initialization
counters = SimplexState(N+4:end);
too_long_in_simplex = (counters >= 1.5*N);

%% Loop over the simplex points
for k=1:N+1
    if too_long_in_simplex(k)
        % --- Reevaluation
        pk = PD(SimplexState(k),1:N); % Select pk to reevaluate
        costk = func(pk); % Reevaluate
        % --- Update PD
        Np = size(PD,1); IDk = Np+1;
        PD = [PD;pk,IDk,costk,SimplexState(N+2),-1]; % -1 for reevaluation
        % --- Update simplex state
        SimplexState(k) = IDk;
        SimplexState(N+3+k) = 1;% Reinitilize counter
    end
end
% --- Sort simplex state
    SimplexState = simplexsort(SimplexState,PD);