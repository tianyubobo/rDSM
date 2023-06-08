function [SH,PD] = DSME(init_conditions,limits,func,Nsteps_max)
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
    N = size(SimplexState,2)-6; % Dimension
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
        %Reevaluate from WTY
        count = SimplexState(N+4:end);
        k = find(count >= 1.5*N);
        if k
            for i = 1:size(k,1) 

                p_r = PD(count(i),1:N);
                cost_r = func(p_r);%Reevaluate
                %update PD
                Np = size(PD,1); ID_r = Np+1;
                PD = [PD;p_r,ID_r,cost_r,SimplexState(N+2),1];
                SimplexState(N+3+k) = 1;%Counter
                
            end
        end
        %End reevaluate from WTY
%         % --- Degeneracy test
%         c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol);
%         SimplexState(end) = SimplexState(end)+c;
         % --- Update simplex history
         SH = [SH;SimplexState];
         % --- Restart simplex
         if c
             [SimplexState,PD] = restart_simplex(SimplexState,PD,func);
             % --- Update simplex history
             SH = [SH;SimplexState];
         end
     end
    

end
