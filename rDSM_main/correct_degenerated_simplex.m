function [SimplexState,PD]=correct_degenerated_simplex(SimplexState,PD,func,limits,c)
    % This function corrects the degeneracy of the simplex
    % Replace the worst performing point by the point that maximizes
    % "volume" and keeps the same "diameter".
        
    % WANG Tianyu, 2023/06/26

    % Copyright: 2023 WANG Tianyu (email address)
    % CC-BY-SA

%% Parameters
    N = size(PD,2)-4; % Dimension
    SimplexCoordinates = PD(SimplexState(1:N+1),1:N); % Simplex coordinates

%% Print
    if c == 0.25
        fprintf('Simplex degenerated type: %s \n','Edge degenrated')
    elseif c == 0.75
        fprintf('Simplex degenerated type: %s \n','Volume degenrated')
    elseif c == 0.5
        fprintf('Simplex degenerated type: %s \n','Both edge and volume degenrated')
    end
    [simplex_volume,simplex_perimeter] = simplex_geo_quantities(PD(SimplexState(1:N+1),1:N));
    fprintf('   Simplex volume :    %e \n',simplex_volume)
    fprintf('   Simplex perimeter: %0.8f \n',simplex_perimeter)
    
%% Correct the degeneracy and evaluate the new point
% --- Compute Lagrangian partial derivatives
    Lagrangian_partial_derivatives = compute_Lagrangian_partial_derivatives(SimplexCoordinates);
% --- This is an option for choosing the initial point
    centroid_point = mean(SimplexCoordinates(1:N,1:N));%centroid
    initial_point = mean([centroid_point;SimplexCoordinates(N+1,1:N)]);  
    initial_cond = [0.1,initial_point]; % Lagrange mult = 0.1, 
    %initial_cond = [0.1,SimplexCoordinates(N+1,1:N)]; % Lagrange mult = 0.1, Original points 

    % --- Solve grad L = 0 with Newton-Raphson method
    [~,~,sol,~] = mulNewton(Lagrangian_partial_derivatives,initial_cond,1e-4);
    pd = double(sol(2:N+1,:));

% --- Evaluate the solution if out of the domain otherwise give INF cost
    if sum(pd<limits(:,1)) || sum(pd>limits(:,2)) 
            costd = Inf; 
        else
            costd = func(pd');
    end

%% Update
% --- Update PD
    Np = size(PD,1); IDd = Np+1;
    PD = [PD;pd',IDd,costd,SimplexState(N+2),c];

% --- Update simplex state
    SimplexState(N+3) = c;
    SimplexState(N+1) = IDd;

% --- Sort simplex state
    SimplexState = simplexsort(SimplexState,PD);

%% Print
    [simplex_volume,simplex_perimeter] = simplex_geo_quantities(PD(SimplexState(1:N+1),1:N));
    disp('Corrected simplex:')
    fprintf('   Simplex volume:    %e \n',simplex_volume)
    fprintf('   Simplex perimeter: %0.8f \n',simplex_perimeter)