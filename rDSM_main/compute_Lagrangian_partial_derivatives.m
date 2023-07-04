function Lag_part_derivatives = compute_Lagrangian_partial_derivatives(SimplexCoordinates)
    % This function builds the partial derivatives of the Lagrangian.
    % Input:
    % SimplexCoordinates: Coordinates of all the points of the simplex.
    % Last row are the cooridnates of the worst point.
    % Output:
    % A vector of symbolic expressions being the partial derivatives.
        
    % WANG Tianyu, 2023/06/26

    % Copyright: 2023 WANG Tianyu (email address)
    % CC-BY-SA

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

end

%% Old version
    %The new pN+1 is an intersection of two circles. The first
    %circle: r = News2, center point is p1,PD(SimplexState(1)), the
    %second circle: r = News3, center point is p2, PD(SimplexState(2))
    %f(1) = (x(1)-PD(SimplexState(1),1)).^2+(x(2)- PD(SimplexState(1),2)).^2 - r(1).^2;
    %f(2) = (x(1)-PD(SimplexState(2),1)).^2+(x(2)- PD(SimplexState(2),2)).^2 - r(2).^2;

%           SL = pdist(TP); %SL: side length
%       % --- Calculate the perimeter(circumference) and volume(surface) of
%       % the triangle (simplex)
%       p_t = sum(SL); % p_t: perimeter of the triangle (simplex) , number
% 
%       syms L_mult % Lagrange multiplier
%       for i=1:N % N is the dimension 
%             s(i)=sym (['s',num2str(i)]);
%       end
%       A = TP(1:N,:)-s;
%       P_T = sum(sqrt(sum(A.^2,2))) + sum(SL(:,(N-1)))- p_t;
%       %s2 = p_t - sum(SL(:,(N-1))) - s3;
%       V_T = (1/factorial(N))*(det([[TP(1:N,:)',transpose(s)];ones(1,N+1)]));
%       %V_T = sqrt(0.5*p_t * (0.5*p_t-sum(SL(:,(N-1)))) * (0.5*p_t-(p_t - sum(SL(:,(N-1))) - s3)) * (0.5*p_t-s3));
%       L = V_T + L_mult * P_T;
%       f = [];
%       for j=1:N
%             f = [f,diff(L,s(j))];
%       end
%       f = [f,diff(L, L_mult)];
% end