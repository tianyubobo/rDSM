function [SimplexState,PD]=iterative_simplex_correction(SimplexState,PD,func,limits,c)
    % This function corrects the degeneracy of the simplex iteratively.
    % Replace the worst performing point by the point that maximizes
    % "volume" and keeps the same "diameter".
    % If after moving the worst point, the simplex is still degenerated or
    % the new point is outside the domain then, the second worst point is
    % moved. And so on.
    % In the case where the new point is outside the domain, this new point
    % is ignored and the original point is kept.
        
    % WANG Tianyu, 2023/06/26

    % Copyright: 2023 WANG Tianyu (email address)
    % CC-BY-SA

%% Parameters
    N = size(PD,2)-4; % Dimension
    [~,~,~,~,~,eps_edge,eps_vol] = DSM_parameters;

%% Print
    disp('Simplex is degenerated! Correction...')

%% Initialization
    mu = 1;% The mu-th worst point need to be moved
    list_of_points = SimplexState(1:N+1);

%% Iterative correction
    while c && (mu < N+1) % While is degenerated and the point to move is not the best one
        % --- Save simplex state
            OldSimplexState = SimplexState;
        % --- Simplex correction
            fprintf('   - Moving %i-th worst point. (dim=%i) \n',mu,N)% WTY:I think it is moving the mu-th worst point.
            [SimplexState,PD] = correct_degenerated_simplex(SimplexState,PD,func,limits,c);
        % --- Test point outside domain
            worst_cost = PD(SimplexState(N+1),N+2);
            if isinf(worst_cost)
                c=inf;
                SimplexState = OldSimplexState;
            end
        % --- Degeneracy test if inside
            if not(isinf(c))
                c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol);% check again if degenerateda
            end
         % --- Select next worst point
            mu = mu + 1;
            point_to_move = list_of_points(end-mu+1);
            SimplexState = move_point_at_the_end(SimplexState,point_to_move);
    end
               
%% Print
    disp('Simplex corrected!')