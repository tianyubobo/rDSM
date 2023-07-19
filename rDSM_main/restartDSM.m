function [PSOL,SH,PD] = restartDSM(init_conditions,limits,func,Nsteps_max)
% This function is a variant of DSM where the simplex is "restarted" when
% degenerated.

%% DSM parameters
    [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = DSM_parameters;

%% Initialization
    % Reshape input
    init_conditions = reshape(init_conditions,1,[]);
    % Creates the simplex history (SH) and points database (PD)
    [SH,PD,N] = DSM_initialization(init_conditions,init_coeff,limits,func);
    
    delete('D:\DSME\PointsDatabase.txt')
    fPD = fopen('D:\DSME\PointsDatabase.txt','a+');
    fprintf(fPD,'%s','p_1 | ... | p_N | ID | Cost | in Simplex numb. | Operation');
    fprintf(fPD,'\r\n'); 
    for i = 1:size(PD,1)     
            fprintf(fPD,'%.4f\t',PD(i,:));
            fprintf(fPD,'\r\n');
    end
    lines = size(PD,1);
    delete('D:\DSME\SimplexHistory.txt')
    fSH = fopen('D:\DSME\SimplexHistory.txt','a+');
    fprintf(fSH,'%s','p1 | ... | pN+1 | Simplex numb. | Operation | C1 | ... | CN+1');
    fprintf(fSH,'\r\n'); 

%% DSM optimization
    % --- Initialization of the simplex state
    SimplexState = SH;
    Restart_history = [];
    fprintf(fSH,'%.4f\t',SimplexState);
    fprintf(fSH,'\r\n'); 
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
        % --- Degeneracy test
        c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol);
        SimplexState(N+3) = SimplexState(N+3)+c;

        % --- Update simplex history 
            SH = [SH;SimplexState]; 
        % --- Output point database and simplex history
        for i = lines+1:size(PD,1)    
            fprintf(fPD,'%.4f\t',PD(i,:));
            fprintf(fPD,'\r\n');
        end
        lines = size(PD,1);
        fprintf(fSH,'%.4f\t',SimplexState);
        fprintf(fSH,'\r\n'); 
        % --- Maximum tolerance
        if negligeable_improvement(PD,SimplexState,limits,1.0e-12) 
            break
        end 
        [H, Restart_history] =  RestartHistory (SimplexState,PD,Restart_history,c);
        if H
           break
        end
        % --- Simplex restart if degenerated, by WTY
        if c
        % --- Restart simplex
        [SimplexState,PD] = restart_simplex(SimplexState,PD,func,limits,init_coeff);
        % --- Update simplex history
        SH = [SH;SimplexState]; % ### Added by Guy.
        fprintf(fSH,'%.4f\t',SimplexState);
        fprintf(fSH,'\r\n'); 
        % --- Degeneracy test again, if the new simplex is degenerated or
        % not.
        c = degeneracy_test(SimplexState,PD,eps_edge,eps_vol);
        SimplexState(N+3) = SimplexState(N+3)+c;
        % --- Update simplex history 
            SH = [SH;SimplexState];   
            fprintf(fSH,'%.4f\t',SimplexState);
            fprintf(fSH,'\r\n'); 
        end      
 
    end
    
%% Solution
    PSOL = PD(SH(end,1),1:end-4);

%% Print solution
     fprintf('restartDSM solution after %i iterations: \n', p)
     fprintf('   %0.3f \n',PSOL)
     fprintf('Restart times: % i \n',size(Restart_history,1))
     % --- Close the output files 
    fclose(fPD);
    fclose(fSH);
end