function [X,Y,In]=Ref()

[~,~,~,~,Reg,~,Mea,~,~]=sys_paramers();
[mea_x,mea_y]=size(Mea); 
m1=linspace(Reg(1,1),Reg(1,2),mea_x);
m2=linspace(Reg(2,1),Reg(2,2),mea_y);
[X,Y]=meshgrid(m1,m2);

% ---
Z =  -   exp(-2*(X-1).^2   -2*(Y-1).^2)...
    -1/2*exp(-2*(X+1).^2-2*(Y-1).^2)...
    -1/3*exp(-2*(X-1).^2-2*(Y+1).^2)...
    +5*exp(-2*(X+0.5).^2-2*(Y+0.5).^2);

In=Z;
end
