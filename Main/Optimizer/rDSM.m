function [PSOL,SH,PD] = rDSM(init_conditions,limits,func,Nsteps_max,N)
    % This function is the main one for the rDSM algorithm
    % Note that when a point goes outside the domain, no evaluation is
    % performed and an infinite cost is automatically associated to this
    % point.
 

%% rDSM parameters
    [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = DSM_parameters_N(N);

%% Initialization
    % Reshape input
    init_conditions = reshape(init_conditions,1,[]);
    % Creates the simplex history (SH) and points database (PD)
    [SH,PD,N] = DSM_initialization(init_conditions,init_coeff,limits,func);
    fprintf('Simplex is initialized.\n')
%% Clean for the log files    
    fclose('all');
    delete('Output\PointsDatabase.txt')
    delete('Output\SimplexHistory.txt')
    delete('Output\ReevaluationHistory.txt')
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
            [SimplexState,PD] = reevaluation(SimplexState,PD,func);
        
        % --- Degeneracy test
            c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol);
            SimplexState(N+3) = SimplexState(N+3)+c;

        % --- Update simplex history  
            SH = [SH;SimplexState]; 
            
        % --- Save log files
        write_output_files(SH,PD) 
        
        % --- Maximum tolerance
        if negligeable_improvement(PD,SimplexState,limits,1.0e-12) 
            break
        end     
            
        % --- Iterative correction of the simplex if degenerated
        if c
            [SimplexState,PD]=iterative_simplex_correction(SimplexState,PD,func,limits,c);
            % --- Update simplex history
            SH = [SH;SimplexState];
            % --- Save log files
            write_output_files(SH,PD)  
        end
    end
    
%% Solution
    PSOL = PD(SH(end,1),1:end-4);

%% Print solution
    fprintf('rDSM solution after %i iterations: \n', p)
    fprintf('   %0.3f \n',PSOL)

end
