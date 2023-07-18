function [ax,ay,U_0,X,Y,Z,z] = WG_Parameter(cln,xmin,xmax,ymin,ymax,NumMea,NumActua,b)
% cln: number of centroids
% NumMea:measurements points
U_0=10;% Objective velocity
%% Measurement
Region=[xmin,xmax;ymin,ymax];
m1=linspace(Region(1,1),Region(1,2),NumMea);
m2=linspace(Region(2,1),Region(2,2),NumMea);
[X,Y]=meshgrid(m1,m2);
Z =  -   exp(-2*(X-1).^2   -2*(Y-1).^2)...
    -1/2*exp(-2*(X+1).^2-2*(Y-1).^2)...
    -1/3*exp(-2*(X-1).^2-2*(Y+1).^2)...
    +5*exp(-2*(X+0.5).^2-2*(Y+0.5).^2);

%% Control law
a1=linspace(Region(1,1),Region(1,2),NumActua);
a2=linspace(Region(2,1),Region(2,2),NumActua);
[ax,ay]=meshgrid(a1,a2);
c1=linspace(Region(1,1),Region(1,2),sqrt(cln));
c2=linspace(Region(2,1),Region(2,2),sqrt(cln));
[cx,cy]=meshgrid(c1,c2);

b=reshape(b,[sqrt(cln),sqrt(cln)]);
z=griddata(cx,cy,b,ax,ay,'linear');

end