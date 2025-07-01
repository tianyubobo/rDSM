function [allx,ally,r,iter]=mulNewton(F,X0,eps)
  % This function uses Newton–Raphson method to solve the equtions
  % Solve F = fun(x) = 0
  % Input: 
  % F: The equation function to be solved 
  % x0: The initial point,(lamda, s1,s2,...,sN)
  % eps: Precision, default,1.0e-4
  % Output:
  % allx: matrix, history solution of the unknown variable
  % ally: matrix, history solution of F
  % r: vector, the final solution of the unknown variable
  % iter: integer, the number of iterations
   
fprintf('Solving the problem with Newton-Raphson s method ... ')

%% Input
    if nargin==2
      eps=1.0e-4;
    end

%% Parameters
    var = transpose(symvar(F)); % Symbolic variables
    Nunknowns = length(X0); % Number of unknowns
    % --- Initialization
        iter_max = 200;
        restart_new_init_condition = 0;
    % --- Allocation
        ally = zeros(Nunknowns,iter_max); % History solution of the unknown variable
        allx = zeros(Nunknowns,iter_max); % History solution of F
    

%% Newton–Raphson method
    % --- Initial condition
        x0 = reshape(X0,[],1); 
    % --- Compute Jacobian
        dF = jacobian(F,var);
    % --- Evaluate function and Jacobian at initial point
        Fx = subs(F,var,x0);
        dFx = subs(dF,var,x0);
        r=double(x0-dFx\transpose(Fx));
    % --- Loop
        iter = 1;
        err = 1;
        while err>eps
          x0=r;
          Fx = subs(F,var,x0);
          dFx = subs(dF,var,x0);
          r = double(x0-dFx\transpose(Fx));
          err = norm(r-x0);
          if (iter > iter_max)
              disp('Too many iterations! Restarting with different inital conditions');
              restart_new_init_condition=1;
              break;
          end
          allx(:,iter) = x0;
          ally(:,iter) = Fx;
          iter = iter+1; 
        end
        allx(:,all(allx==0,1)) = [];
        ally(:,all(ally==0,1)) = [];

%% Restart with different initial conditions
if restart_new_init_condition
    % --- New initial condition
        x0 = reshape(X0,[],1);
        x0(1) = -x0(1);
    % --- Evaluate function and Jacobian at initial point
        Fx = subs(F,var,x0);
        dFx = subs(dF,var,x0);
        r = double(x0-dFx\transpose(Fx));
    % --- Loop  
    iter = 1;
    err = 1;
    while err>eps
      x0=r;
      Fx = subs(F,var,x0);
      dFx = subs(dF,var,x0);
      r = double(x0-dFx\transpose(Fx));
      err = norm(r-x0);
      if (iter > iter_max)
          disp('Too many iterations!');
          break;
      end
      allx(:,iter) = x0;
      ally(:,iter) = Fx;
      iter = iter+1;     
    end
end
allx(:,all(allx==0,1)) = [];
ally(:,all(ally==0,1)) = [];

fprintf('Done! \n')