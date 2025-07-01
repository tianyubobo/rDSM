function plot_3D_map(limits,func)
    % This function plots the 3D of a function.
    % This is used to visualize the optimization process of an algorithm.


%% Parameters
% Number of points in x and y directions.
    Nx = 100;
    Ny = 100;
    Nz = 100;

%% Domain limits
    % --- X-limits
X1 = limits(1,1);
X2 = limits(1,2);
    % --- Y-limits
Y1 = limits(2,1);
Y2 = limits(2,2);
    % --- Z-limits
Z1 = limits(2,1);
Z2 = limits(2,2);
    % --- Vectors
x = linspace(X1,X2,Nx);
y = linspace(Y1,Y2,Ny);
z = linspace(Z1,Z2,Nz);

%% Build the mesh
    [X,Y,Z] = meshgrid(x,y,z);

%% Evalute the function on the grid
    val = func(X,Y,Z); 
    
%% Plot
    % --- Define levels
    iso_levels = 0:0.2:1;
    s_cell = cell(numel(iso_levels),1);
    
    % --- Compute surfaces
    for k=1:numel(iso_levels)
        s_cell{k} = isosurface(X,Y,Z,val,iso_levels(k));
    end

axis([-1,1,-1,1,-1,1])
xlabel('$p_1$','Interpreter','latex')
ylabel('$p_2$','Interpreter','latex')
zlabel('$p_3$','Interpreter','latex')

cmp_CL = flip(gray(numel(iso_levels)));
hold on
for k=1:numel(iso_levels)
    QQQ(k) = patch(s_cell{end-k+1});
    set(QQQ(k),'FaceColor',cmp_CL(end-k+1,:));  
    set(QQQ(k),'EdgeColor','none');
    set(QQQ(k),'FaceAlpha',0.1);
end
hold off
% --- Colorbar
colormap(cmp_CL)
caxis([0,1])
% caxis([val_min,val_max])% By WTY
colorbar

% --- Cosmetic and shape
view(3);
axis tight
grid off
box on
set(gca,'DataAspectRatio',[1,1,1])
%set(gca,'TickDir','none')%WTY: 'none' is not available, use
%'in'|'out'|'both'instead
set(gca,'TickDir','out')
