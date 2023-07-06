function [PSOL,SH,PD] = restartDSM(init_conditions,limits,func,Nsteps_max)
% This function is a variant of DSM where the simplex is "restarted" when
% degenerated.

%% DSM parameters
    [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = rDSM_parameters;

%% Initialization
    % Creates the simplex history (SH) and points database (PD)
    [SH,PD,N] = rDSM_initialization(init_conditions,init_coeff,limits,func);
    
%% DSM optimization
    % --- Initialization of the simplex state
    SimplexState = SH;
    
    % --- Restart point history
    Restart_history = [];
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
        % --- Degeneracy test
        c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol);
        SimplexState(N+3) = SimplexState(N+3)+c;

        % --- Update simplex history 
            SH = [SH;SimplexState]; 
            
        % --- Simplex restart if degenerated, by WTY
        if c
            disp('Simplex is degenerated! Soft restart')
             % --- Restart simplex (literature solution) We need to compare the two solutions.
             [SimplexState,PD] = restart_simplex(SimplexState,PD,func,limits,init_coeff);
            % --- Update simplex history
            SH = [SH;SimplexState]; % ### Added by Guy.
        end       
    end
    
%% Solution
    PSOL = PD(SH(end,1),1:end-4);
end