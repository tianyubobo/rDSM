function plot_2D_map(limits,func)
    % This function plots the 2D of a function.
    % This is used to visualize the optimization process of an algorithm.
        
    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
% Number of points in x and y directions.
    Nx = 100;
    Ny = 100;

%% Domain limits
    % --- X-limits
X1 = limits(1,1);
X2 = limits(1,2);
    % --- Y-limits
Y1 = limits(2,1);
Y2 = limits(2,2);
    % --- Vectors
x = linspace(X1,X2,Nx);
y = linspace(Y1,Y2,Ny);

%% Build the mesh
    [X,Y] = meshgrid(x,y);

%% Evalute the function on the grid
    val = func(X,Y);
    val_min= min(min(val));% By WTY
    val_max = max(max(val));% By WTY
    % WTY: Using this for Matlab R2018b and newer version is better, but I am
    % using R2018a...
    % val_min = min(val,[],'all');
    % val_max = max(val,[],'all');
%% Plot
imagesc(limits(1,:),limits(2,:),val);
set(gca,'YDir','normal')

% --- Tick and labels
xlabel('$p_1$','Interpreter','latex')
ylabel('$p_2$','Interpreter','latex')
xticks();
yticks();
xticklabels('')
yticklabels('')

% --- colorbar
colormap(flip(gray(64)))
caxis([0,1])
% caxis([1.2*val_min,1.2*val_max])% By WTY
colorbar

% --- Cosmetic and shape
axis tight
grid off
box on
ax = axis;
set(gca,'DataAspectRatio',[1/(ax(4)-ax(3)),1/(ax(2)-ax(1)),1])
%set(gca,'TickDir','none')%WTY: none is not available, use
%'in'|'out'|'both'instead
set(gca,'TickDir','out')
