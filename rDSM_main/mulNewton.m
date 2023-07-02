function [allx,ally,r,n]=mulNewton(F,X0,eps)
  %This function uses Newton–Raphson method to solve the equtions
  %Solve F = fun(x) = 0
  %WTY: This is found online and slightly modified 
  %https://zhuanlan.zhihu.com/p/63103354
  %Input: 
  %F: The equation function to be solved 
  %x0: The initial point,(lamda, s1,s2,...,sN)
  %eps: Precision, default,1.0e-4
  %Return:
  %allx: matrix, history solution of the unknown variable
  %ally: matrix, history solution of F
  %r: vector, the final solution of the unknown variable
  %n:integer, the number of iterations
  
%% Input
    if nargin==2
      eps=1.0e-4;
    end

%% Parameters
    var = transpose(symvar(F)); % Symbolic variables
    n = 1;
    tol=1;
    N=200;
    symx=length(X0);
    ally=zeros(symx,N);
    allx=zeros(symx,N);
    restart_new_init_condition = 0;

%% Newton–Raphson method
% --- Initial condition
    x0 = transpose(X0); x0 = x0([end,1:end-1]) ;
        % L_mult -> x0(1)
        % s1     -> x0(2)
        % s2     -> x0(3)
        % ...
% --- Compute Jacobian
    dF = jacobian(F,var);
% --- Evaluate function and Jacobian at initial point
    Fx = subs(F,var,x0);
    dFx = subs(dF,var,x0);
    r=x0-double(dFx)\transpose(Fx);
% --- Loop  
    while tol>eps
      x0=r;
      Fx = subs(F,var,x0);
      dFx = subs(dF,var,x0);
      
      r=vpa(x0-double(dFx)\transpose(Fx));
      tol=norm(r-x0);
      if(n>N)
          disp('Too many iterations！Restarting with different inital conditions');
          restart_new_init_condition=1;
          break;
      end
      allx(:,n)=x0;
      ally(:,n)=Fx;
      n=n+1;
      allx(:,all(allx==0,1))=[];
      ally(:,all(ally==0,1))=[];
      
    end

%% Restart with different initial conditions
if restart_new_init_condition
    % --- New initial condition
     x0 = transpose(X0); x0 = x0([end,1:end-1]) ;
     x0(1) = -x0(1);
    % --- Evaluate function and Jacobian at initial point
    Fx = subs(F,var,x0);
    dFx = subs(dF,var,x0);
    r=x0-double(dFx)\transpose(Fx);
    % --- Loop  
    n=1;
    while tol>eps
      x0=r;
      Fx = subs(F,var,x0);
      dFx = subs(dF,var,x0);
      
      r=vpa(x0-double(dFx)\transpose(Fx));
      tol=norm(r-x0);
      if(n>N)
          disp('Too many iterations！');
          break;
      end
      allx(:,n)=x0;
      ally(:,n)=Fx;
      n=n+1;
      allx(:,all(allx==0,1))=[];
      ally(:,all(ally==0,1))=[];
      
    end
end
