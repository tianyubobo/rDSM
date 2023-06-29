function [SimplexState,PD]=correct_degenerated_simplex(SimplexState,PD,func,c,limits)
    % This function plots the simplices.
    % This is used to visualize the optimization process of DSME.
        
    % WANG Tianyu, 2023/06/26

    % Copyright: 2023 WANG Tianyu (email address)
    % CC-BY-SA

%% Parameters
    N = size(PD,2)-4; % Dimension

%% 
TP = PD(SimplexState(1:N+1),1:N);%TP: triangel points
syms s
%f = fun(s,TP,N);
[~,~,sol,~] = mulNewton(fun(s,TP,N),[TP(N+1,1:N),0.1],1e-4);
%[News2, News3, ~] = solve(equ,[s2,s3,lamda]);
%r1 = eval(News2);
%r2 = eval(News3);
%r1(r1==0)=[]; r2(r2==0)=[];
%r = [r1,r2];
%syms x
%f = fun(x,PD,SimplexState,r);
%[~,~,sol,~] = mulNewton(f,TP(N+1,1:N),1e-5);
pd = double(sol(2:N+1,:));
%costd = func(pd');
%Make the point inside the domain
if sum(pd<limits(:,1)) || sum(pd>limits(:,2)) 
        costd = Inf;
    else
        costd = func(pd');
end
%update PD and SimplexState if degeneracy 
% --- Update PD
Np = size(PD,1); IDd = Np+1;
PD = [PD;pd',IDd,costd,SimplexState(N+2),c];
% --- Update simplex state
SimplexState(N+3) = c;
SimplexState(N+1) = IDd;
% --- Sort simplex state
    SimplexState = simplexsort(SimplexState,PD);

