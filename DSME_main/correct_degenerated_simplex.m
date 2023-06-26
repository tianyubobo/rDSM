function [SimplexState,PD]=correct_degenerated_simplex(SimplexState,PD,func,c)
    % This function plots the simplices.
    % This is used to visualize the optimization process of DSME.
        
    % WANG Tianyu, 2023/06/26

    % Copyright: 2023 WANG Tianyu (email address)
    % CC-BY-SA

%% Parameters
    N = size(PD,2)-4; % Dimension

%% 
TP = PD(SimplexState(1:N+1),1:N);%TP: triangel points
SL = pdist(TP); %SL: side length
%Calculate the perimeter(circumference) and volume(surface) of the triangle
p_t = sum(SL); %p_t: perimeter of the triangle, number
%SL(1)does not change, find a new point pN+1
%Lagrangian multuplier for 2D
%Build function P_T, V_T
syms s2 s3 lamda%s2,s3 is the side length of each side.
P_T = SL(1) + s2 + s3 - p_t;
%s2 = p_t - SL(1) - s3;
V_T = sqrt(0.5*p_t * (0.5*p_t-SL(1)) * (0.5*p_t-(p_t - SL(1) - s3)) * (0.5*p_t-s3));
L = V_T + lamda * P_T;
equ = [diff(L,s2)==0, diff(L,s3)==0, diff(L, lamda)==0];
[News2, News3, ~] = solve(equ,[s2,s3,lamda]);
r1 = eval(News2);
r2 = eval(News3);
r1(r1==0)=[]; r2(r2==0)=[];
r = [r1,r2];
syms x
f = fun(x,PD,SimplexState,r);
[~,~,sol,~] = mulNewton(f,TP(N+1,1:N),1e-5);
pd = double(sol);
costd = func(pd');

%update PD and SimplexState if degeneracy 
% --- Update PD
Np = size(PD,1); IDd = Np+1;
PD = [PD;pd',IDd,costd,SimplexState(N+2),c];
% --- Update simplex state
%SimplexState(end) = SimplexState(end)+c;
%WTY: Why operation equals to SimplexState(end)+c? Why not directly operation=c?
SimplexState(N+3) = c;
SimplexState(N+1) = IDd;
% --- Sort simplex state
    SimplexState = simplexsort(SimplexState,PD);

% ### Guy to Tianyu: I removed the update of the simplex history.
% ### It does not make sense to add it here but I added the sorting of the
% ### simplex state.