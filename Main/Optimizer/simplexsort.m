function SimplexState = simplexsort(SimplexState,PD)
    % This function sorts the indices of the simplex points based on their
    % cost.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = size(PD,2)-4; % Dimension
    
%%  Sort
    % --- Simplex costs
    SimplexCosts = PD(SimplexState(1:N+1),N+2);
    % --- Sort
    [~,SimplexPointIndicesSorted] = sort(SimplexCosts);
    % --- Update indices
    SimplexIndices = SimplexState(1:N+1);
    SimplexState(1:N+1) = SimplexIndices(SimplexPointIndicesSorted);
    % --- Update counters
    SimplexCounters = SimplexState(end-N:end);
    SimplexState(end-N:end) = SimplexCounters(SimplexPointIndicesSorted);
    