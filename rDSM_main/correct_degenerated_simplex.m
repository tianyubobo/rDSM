function [SimplexState,PD]=correct_degenerated_simplex(SimplexState,PD,func,c,limits)
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
    [simplex_volume,simplex_perimeter] = simplex_geo_quantities(PD(SimplexState(1:N+1),1:N));
    fprintf('   Simplex volume:    %0.2f \n',simplex_volume)
    fprintf('   Simplex perimeter: %0.2f \n',simplex_perimeter)

%% Correct the degeneracy and evaluate the new point
% --- Compute Lagrangian partial derivatives
    Lagrangian_partial_derivatives = compute_Lagrangian_partial_derivatives(SimplexCoordinates);
    initial_cond = [SimplexCoordinates(N+1,1:N),0.1]; % Original points, Lagrange mult = 0.1
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
    fprintf('   Simplex volume:    %0.2f \n',simplex_volume)
    fprintf('   Simplex perimeter: %0.2f \n',simplex_perimeter)
















%% Old version with comments
% TP = PD(SimplexState(1:N+1),1:N);%TP: triangel points
% syms s
% %f = fun(s,TP,N);
% [~,~,sol,~] = mulNewton(fun(s,TP,N),[TP(N+1,1:N),0.1],1e-4);
% %[News2, News3, ~] = solve(equ,[s2,s3,lamda]);
% %r1 = eval(News2);
% %r2 = eval(News3);
% %r1(r1==0)=[]; r2(r2==0)=[];
% %r = [r1,r2];
% %syms x
% %f = fun(x,PD,SimplexState,r);
% %[~,~,sol,~] = mulNewton(f,TP(N+1,1:N),1e-5);
% pd = double(sol(2:N+1,:));
% %costd = func(pd');
% %Make the point inside the domain
% if sum(pd<limits(:,1)) || sum(pd>limits(:,2)) 
%         costd = Inf;
%     else
%         costd = func(pd');
% end
% %update PD and SimplexState if degeneracy 
% % --- Update PD
% Np = size(PD,1); IDd = Np+1;
% PD = [PD;pd',IDd,costd,SimplexState(N+2),c];
% % --- Update simplex state
% SimplexState(N+3) = c;
% SimplexState(N+1) = IDd;
% % --- Sort simplex state
%     SimplexState = simplexsort(SimplexState,PD);

