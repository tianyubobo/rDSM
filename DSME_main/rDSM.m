function [PSOL,SH,PD] = rDSM(init_conditions,limits,func,Nsteps_max)
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
    [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = rDSM_parameters;

%% Initialization
    % Creates the simplex history (SH) and points database (PD)
    [SH,PD] = rDSM_initialization(init_conditions,init_coeff,limits,func);
    
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
        
        % --- Update simplex history % ### Added by Guy.
            SH = [SH;SimplexState]; % ### Added by Guy.

        % --- Degeneracy test
        c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol);
        if c % ### Guy to Tianyu: it's enough, no need "== 0.25 || c ==0.75 || c == 0.5"
            % --- Correction of the degenerated simplex
            [SimplexState,PD]=correct_degenerated_simplex(SimplexState,PD,func,c);
%             % --- Restart simplex (literature solution) We need to compare the two solutions.
%             [SimplexState,PD] = restart_simplex(SimplexState,PD,func);
            % --- Update simplex history
            SH = [SH;SimplexState]; % ### Added by Guy.
        end
     end
    
%% Solution
    PSOL = PD(SH(end,1),1:end-4);
end
