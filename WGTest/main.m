
%% Optimization
n = 25; % number of parameters to be optimized, corresponding to the number of centroids.
% X0 is the initial control parameter in the list tabel.
X0=10*ones(n,1); %initial PWM
eps=5; %standard length of DSM; the interval between new parameter sampling ;
%
alpha = 1.0; %coeficient of reflection 
beta = 0.5; %coeficient of contration and shrink
gamma = 2; %coeficient of expansion
m=500; %iterations
% --- Degeneracy parameters --- by Guy (20230528)
eps_edge = 0.1;    % Lower limit for edge ratio for degeneracy
eps_vol = 0.01;     % Lower limit for volume ratio for degeneracy
[fmin, xmin] = DSM('cost', X0, n, alpha, beta, gamma, m, eps,eps_edge,eps_vol);% optimization results; fmin:the best J; xmin:the best control parameters

%% Postprocess data
[cln,con,dim,datapath,Reg,C,Mea,Act,U_0]=sys_paramers();
[X,Y,In]=Ref();% unforced mode
% --- Centroid coordinates
x_centroids = C(:,1);
y_centroids = C(:,2);
% --- Actuators coordinates
[act_x,act_y]=size(Act); 
a1=linspace(Reg(1,1),Reg(1,2),act_x);
a2=linspace(Reg(2,1),Reg(2,2),act_y);
[x_actuators,y_actuators]=meshgrid(a1,a2);

% --- Best solution
z=control_law(xmin);
Mea_act=griddata(x_actuators,y_actuators,z,X,Y,'cubic');
New_z=In+Mea_act; % Unforced + control

%% Plot control map
figure
hold on
contourf(x_actuators,y_actuators,z)
plot(x_centroids, y_centroids,'ko')
plot(x_actuators, y_actuators,'r+')
hold off
set(gcf,'unit','centimeters','position',[1 1 15 12])
xlabel('x');
ylabel('y');
colorbar
zlabel('z');
box on
grid off
caxis([0,15])
title('Control map')

% --- Plot actuation level
figure()
hold on
plot(xmin)
ylabel('Action');
xlabel('Centroids')

%% Plot unforced case
figure
hold on
contourf(X,Y,In)
plot(x_centroids, y_centroids,'ko')
plot(x_actuators, y_actuators,'r+')
hold off
set(gcf,'unit','centimeters','position',[1 1 15 12])
xlabel('x');
ylabel('y');
colorbar
caxis([0,15])
title('Unforced map')

figure
surf(X,Y,In)
set(gcf,'unit','centimeters','position',[1 1 15 12])
xlabel('x');
ylabel('y');
zlabel('z');
box on
grid off

%%  Plot best solution
figure
hold on
contourf(X,Y,New_z)
plot(x_centroids, y_centroids,'ko')
plot(x_actuators, y_actuators,'r+')
hold off
set(gcf,'unit','centimeters','position',[1 1 15 12])
xlabel('x');
ylabel('y');
colorbar
caxis([0,15])
title('Controlled map')

%% comparision and analysis
figure()
plot(reshape(In,[64,1]))
hold on
plot(reshape(New_z,[64,1]))

figure()
bar([reshape(In,[64,1]),reshape(New_z,[64,1])])
set(gcf,'unit','centimeters','position',[1 1 15 12])

%% Data load
dms=load('result/dms.txt');

figure()
hold on
plot(dms(:,n+1))
xlabel('Iterations');
ylabel('J')
set(gcf,'unit','centimeters','position',[1 1 15 12])
box on

