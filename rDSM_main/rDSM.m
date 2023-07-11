function [PSOL,SH,PD] = rDSM(init_conditions,limits,func,Nsteps_max)
    % This function is the main one for the rDSM algorithm
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
    [SH,PD,N] = rDSM_initialization(init_conditions,init_coeff,limits,func);
    fprintf('Simplex is initialized.\n')
    
%% rDSM optimization
    % --- Initialization of the simplex state
    SimplexState = SH;

    % --- Loop
    for p=1:Nsteps_max
        fprintf('Simplex iteration %i\\%i.\n',p,Nsteps_max)
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
        % --- Reevaluation by WTY
            %[SimplexState,PD] = reevaluation(SimplexState,PD,func);
        
        % --- Degeneracy test
            c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol);
            SimplexState(N+3) = SimplexState(N+3)+c;

        % --- Update simplex history % 
            SH = [SH;SimplexState]; % 

        % --- Iterative correction of the simplex if degenerated
            if c
                [SimplexState,PD]=iterative_simplex_correction(SimplexState,PD,func,limits,c);
                % --- Update simplex history
                SH = [SH;SimplexState];
            end

        % --- Maximum tolerance
        % *** If the best point and its closest neighbor are too close
        % *** (d/D<1e-6, D diameter domain), break the for loop.
%             if negligeable_improvement(PD,tol) 
%                 break
%             end
    end
    
%% Solution
    PSOL = PD(SH(end,1),1:end-4);
end
