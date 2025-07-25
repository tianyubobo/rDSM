function plot_2D_map(limits,func)
    % This function plots the 2D of a function.
    % This is used to visualize the optimization process of an algorithm.

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
%% Plot
imagesc(limits(1,:),limits(2,:),val);
set(gca,'YDir','normal')

% --- Tick and labels
xlabel('$x_1$','Interpreter','latex')
ylabel('$x_2$','Interpreter','latex')
xticks();
yticks();
xticklabels('')
yticklabels('')

% --- colorbar
colormap(flip(gray(64)))
caxis([0,1])
colorbar

ylabel(colorbar,'$J$','Interpreter','latex')

% --- Cosmetic and shape
axis tight
grid off
box on
ax = axis;
set(gca,'DataAspectRatio',[1/(ax(4)-ax(3)),1/(ax(2)-ax(1)),1])
set(gca,'TickDir','out')
