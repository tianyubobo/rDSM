function z=control_law(bb)
% This function gives the actuation level on each point of the grid based
% on the colocation points, i.e., the value on the centroids.
% Typically there are n^2 centroids (e.g. 16) and there are 100 control
% points.

%% Parameters
[cln,~,~,~,Reg,~,~,Act,~]=sys_paramers();

%% distant inverse evaluation
[act_x,act_y]=size(Act); 
a1=linspace(Reg(1,1),Reg(1,2),act_x);
a2=linspace(Reg(2,1),Reg(2,2),act_y);

c1=linspace(Reg(1,1),Reg(1,2),sqrt(cln));
c2=linspace(Reg(2,1),Reg(2,2),sqrt(cln));
[cx,cy]=meshgrid(c1,c2);
[ax,ay]=meshgrid(a1,a2);
b=reshape(bb,[sqrt(cln),sqrt(cln)]);
z=griddata(cx,cy,b,ax,ay,'linear');


end
