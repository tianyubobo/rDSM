function [PSOL,SH,PD] = DSME(init_conditions,limits,func,Nsteps_max)
    % This function is the main one for the DSME algorithm
    % Note that when a point goes outside the domain, no evaluation is
    % performed and an infinite cost is automatically associated to this
    % point.
    % This version:
    % - deals with the case when the algorithm goes beyond the limits. It
    % gives a cost of INF. See REFLECTION, and EXPANSION.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% DSME parameters
    [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = DSME_parameters;

%% Initialization
    % Creates the simplex history (SH) and points database (PD)
    [SH,PD] = DSME_initialization(init_conditions,init_coeff,limits,func);
    
%% DSME optimization
    % --- Initialization of the simplex state
    SimplexState = SH;
    N = size(PD,2)-4; % Dimension
    % --- Loop
    for p=1:Nsteps_max
        % --- 1-Reflexion
        [SimplexState,PD,c,IDr] = reflection(SimplexState,PD,func,alph,limits);
        
        if c ~= 1
        % --- 2-Expansion
        [SimplexState,PD,c] = expansion(SimplexState,PD,func,gamm,IDr,limits);
        % --- 3-Contraction
            if c~=2 && c~=1
        [SimplexState,PD,c] = contraction(SimplexState,PD,func,phi,IDr);
        % --- 4-shrink
                if c~=31 && c~=32
        [SimplexState,PD] = shrink(SimplexState,PD,func,sigm);
                end
            end
        end
        % --- Reevaluation from WTY
            counters = SimplexState(N+4:end);
            too_long_in_simplex = (counters >= 1.5*N);
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

        % --- Degeneracy test
        c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol)
        if c == 0.25 || c ==0.75 || c == 0.5
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
            r1(find(r1==0))=[]; r2(find(r2==0))=[];
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
            % --- Update simplex history
            SH = [SH;SimplexState];
        end
      SimplexState = simplexsort(SimplexState,PD);

        % --- Update simplex history
            SH = [SH;SimplexState];

        % --- Restart simplex
%          if c
%              [SimplexState,PD] = restart_simplex(SimplexState,PD,func);
%              % --- Update simplex history
%              SH = [SH;SimplexState];
%          end
     end
    
%% Solution
    PSOL = PD(SH(end,1),1:end-4);
end
