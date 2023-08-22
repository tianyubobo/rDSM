function Lag_part_derivatives = compute_Lagrangian_partial_derivatives(SimplexCoordinates)
    % This function builds the partial derivatives of the Lagrangian.
    % Input:
    % SimplexCoordinates: Coordinates of all the points of the simplex.
    % Last row are the cooridnates of the worst point.
    % Output:
    % A vector of symbolic expressions being the partial derivatives.
        
    % WANG Tianyu, 2023/06/26

    % Copyright: 2023 WANG Tianyu (wangtianyu@stu.hit.edu.cn)
    % CC-BY-SA

fprintf('Computing Lagrangian derivatives ... ')    

%% Parameters
    N = size(SimplexCoordinates,2);
    s = sym('s',[1,N]); % Symbolic variables: coordinates of the worst point

%% Compute perimeter and volume as function of s, coordinates of worst point
% --- Perimeter of the simplex
    SL = pdist(SimplexCoordinates); %SL: side length
    p_t = sum(SL);

% --- Perimeter of the simplex as a function of s
    A = SimplexCoordinates(1:N,:)-s;
    P_T = sum(sqrt(sum(A.^2,2))) + sum(pdist(SimplexCoordinates(1:N,:)));

% --- Volume
    V_T = (1/factorial(N))*abs(det([[SimplexCoordinates(1:N,:)',transpose(s)];ones(1,N+1)]));

%% Lagrangian
    % --- Lagrange multiplier
    syms L_mult
    % --- Lagrangian
    L = V_T + L_mult * (P_T - p_t);

%% Lagrangian partial derivatives
    % --- Initialization
    Lag_part_derivatives = [];
    % --- Partial derivaties in s(i) (coordinates of point to optimize)
    for j=1:N
        Lag_part_derivatives = [Lag_part_derivatives,diff(L,s(j))];
    end
    % --- Partial derivatives in L_mult (Lagrage multiplier)
    Lag_part_derivatives = [Lag_part_derivatives,diff(L, L_mult)];

fprintf('Done! \n')    
end
