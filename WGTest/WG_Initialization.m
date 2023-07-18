function [cln,Region,C,Measure,Act,U_0] = WG_Parameter(cln,xmin,xmax,ymin,ymax,NumMea,NumActua,b)
% cln: number of centroids
% NumMea:measurements points
%% 

con=1; % number of independent actuators
dim=2; % dimensions of feature space
Region=[xmin,xmax;ymin,ymax];
Measure=zeros(NumMea,NumMea);
Act=zeros(NumActua,NumActua);% define dimentions of control parameters 
% centroids define
c1=linspace(xmin,xmax,sqrt(cln));
c2=linspace(ymin,ymax,sqrt(cln));
[cx,cy]=meshgrid(c1,c2);
cx=reshape(cx,[cln,1]);
cy=reshape(cy,[cln,1]);
C=[cx,cy];
% Objective velocity
U_0=10;

[mea_x,mea_y]=size(Measure); 
m1=linspace(Region(1,1),Region(1,2),mea_x);
m2=linspace(Region(2,1),Region(2,2),mea_y);
[X,Y]=meshgrid(m1,m2);

Z =  -   exp(-2*(X-1).^2   -2*(Y-1).^2)...
    -1/2*exp(-2*(X+1).^2-2*(Y-1).^2)...
    -1/3*exp(-2*(X-1).^2-2*(Y+1).^2)...
    +5*exp(-2*(X+0.5).^2-2*(Y+0.5).^2);

%% Control law
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