function SimplexState = move_point_at_the_end(SimplexState,point_to_move)
    % This function reorder the simplex by setting the point to move as the
    % last point.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    %  p1 | ... | pN+1 | Simplex numb. | Operation | C1 | ... | CN+1
    N = (numel(SimplexState)-2)/2-1; % Dimension

%% Find point in the simplex
    idx_point = find(SimplexState(1:N+1)==point_to_move);

%%  Reorder
    % --- Switch the IDs
    SimplexState([N+1,idx_point]) = SimplexState([idx_point,N+1]);
    % --- Switch the compters
    SimplexState(N+3+[N+1,idx_point]) = SimplexState(N+3+[idx_point,N+1]);
    
    