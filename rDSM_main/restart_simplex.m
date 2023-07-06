function [SimplexState,PD] = restart_simplex(init_conditions,init_coeff,limits,func,Nsteps_max,SH,PD)
    % This function is restarts the simplex when it is degenerated.
    % It is a step for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA
%% DSM parameters
    [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = rDSM_parameters;   
%% Restart    
    [~,~,N] = rDSM_initialization(init_conditions,init_coeff,limits,func);
    
% *** Select furthest point from the best one and displace it such as:
% ***   (i)  The circumference is the same
% ***   (ii) The volume is maximized

%% restartDSM optimization
    % --- Initialization of the simplex state
    SimplexState = SH;

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
    end
    disp('Simplex is degenerated!')
end