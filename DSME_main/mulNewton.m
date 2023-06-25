function [allx,ally,r,n]=mulNewton(F,x0,eps)
%This function uses Newton¨CRaphson method to solve the equtions
%Solve F = fun(x) = 0
%WTY: This is found online and slightly modified 
%https://zhuanlan.zhihu.com/p/63103354
%Input: 
%F: The equation function to be solved 
%x0: The initial point
%eps: Precision, default,1.0e-4
%Return:
%allx: matrix, history solution of the unknown variable
%ally: matrix, history solution of F
%r: vector, the final solution of the unknown variable
%n:integer, the number of iterations
%%
  if nargin==2
    eps=1.0e-4;
  end
  x0 = transpose(x0);
  Fx = subs(F,transpose(symvar(F)),x0);
  var = transpose(symvar(F));
  dF = jacobian(F,var);
  dFx = subs(dF,transpose(symvar(F)),x0);
  n=dFx;
  r=x0-inv(dFx)*Fx';
  n=1;
  tol=1;
  N=100;
  symx=length(x0);
  ally=zeros(symx,N);
  allx=zeros(symx,N);

  while tol>eps
    x0=r;
    Fx = subs(F,transpose(symvar(F)),x0);
    dFx = subs(dF,transpose(symvar(F)),x0);
    r=vpa(x0-inv(dFx)*Fx');
    tol=norm(r-x0);
    if(n>N)
        disp('Too many iterations£¡');
        break;
    end
    allx(:,n)=x0;
    ally(:,n)=Fx;
    n=n+1;
    allx(:,all(allx==0,1))=[];
    ally(:,all(ally==0,1))=[];
    
end