function [J]=toy_function_WX(b)

% x,y region
xmin=-3;
xmax=3;
ymin=-3;
ymax=3;
Reg=[xmin,xmax;ymin,ymax];
% control actuators
act_x=10; % x direction actuators
act_y=10; % y direction actuators
Act=zeros(act_x,act_y);
% reference velocity
U_0=0;

%% original measurements
[X,Y,In]=Ref();

z=control_law(b);
[act_x,act_y]=size(Act); 
a1=linspace(Reg(1,1),Reg(1,2),act_x);
a2=linspace(Reg(2,1),Reg(2,2),act_y);
[ax,ay]=meshgrid(a1,a2);
Mea_act=griddata(ax,ay,z,X,Y,'cubic');

New_z=In+Mea_act;

J=sum(sum((New_z-U_0).^2));
end

function z=control_law(bb)

cln=16; % number of centroids
con=1; % number of independent actuators
% x,y region
xmin=-3;
xmax=3;
ymin=-3;
ymax=3;
Reg=[xmin,xmax;ymin,ymax];
% control actuators
act_x=10; % x direction actuators
act_y=10; % y direction actuators
Act=zeros(act_x,act_y);
% centroids define
c1=linspace(xmin,xmax,sqrt(cln));
c2=linspace(ymin,ymax,sqrt(cln));
[cx,cy]=meshgrid(c1,c2);
cx=reshape(cx,[cln,1]);
cy=reshape(cy,[cln,1]);
C=[cx,cy];

%% distant inverse evaluation
[act_x,act_y]=size(Act); 
a1=linspace(Reg(1,1),Reg(1,2),act_x);
a2=linspace(Reg(2,1),Reg(2,2),act_y);
[ax,ay]=meshgrid(a1,a2);
z=[];
for i=1:act_x
    for j=1:act_y
        p=[ax(i,j) ay(i,j)];
        b=reshape(bb,[cln,con]);
        k=sqrt(sum((p-C).^2,2)+0.00001);
        w=1./k;
        Sw=sum(w);
        z(i,j)=b'*(w./Sw);
    end
end
end

function [X,Y,In]=Ref()
% x,y region
xmin=-3;
xmax=3;
ymin=-3;
ymax=3;
Reg=[xmin,xmax;ymin,ymax];
% measurements points
m=8; % x direction measurements
n=8; % y direction measurements
Mea=zeros(m,n);

[mea_x,mea_y]=size(Mea); 
m1=linspace(Reg(1,1),Reg(1,2),mea_x);
m2=linspace(Reg(2,1),Reg(2,2),mea_y);
[X,Y]=meshgrid(m1,m2);
Z=[];
[n,m]=size(X);
for i=1:n
    for j=1:m
        Z(i,j)=-exp(-2*(X(i,j)-1)^2-2*(Y(i,j)-1)^2)-1/2*exp(-2*(X(i,j)+1)^2-2*(Y(i,j)-1)^2)-1/3*exp(-2*(X(i,j)-1)^2-2*(Y(i,j)+1)^2)-1/4*exp(-2*(X(i,j)+1)^2-2*(Y(i,j)+1)^2);
    end
end
In=Z;
end

