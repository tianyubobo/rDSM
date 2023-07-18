function [cln,con,dim,datapath,Reg,C,Mea,Act,U_0]=sys_paramers()
%cln=25; % number of centroids
cln = 9;
con=1; % number of independent actuators
dim=2; % dimensions of feature space
% x,y region
xmin=-1.625;
xmax=1.625;
ymin=-1.625;
ymax=1.625;
Reg=[xmin,xmax;ymin,ymax];
% measurements points
m=8; % x direction measurements
n=8; % y direction measurements
Mea=zeros(m,n);
% control actuators
act_x=10; % x direction actuators
act_y=10; % y direction actuators
Act=zeros(act_x,act_y);% define dimentions of control parameters 
% centroids define
c1=linspace(xmin,xmax,sqrt(cln));
c2=linspace(ymin,ymax,sqrt(cln));
[cx,cy]=meshgrid(c1,c2);
cx=reshape(cx,[cln,1]);
cy=reshape(cy,[cln,1]);
C=[cx,cy];
% Objective velocity
U_0=10;
% path
folderpath ='';
datapath=[folderpath,''];


end
