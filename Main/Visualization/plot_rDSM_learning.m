function plot_rDSM_learning(PointsDatabase)
    % This function plots the learning process for a DSME optimization.

%% Parameters
    % --- Plot parameters
    MS = 35; % Marker size
    % --- Data parameters
    N = size(PointsDatabase,2)-4; % Dimension
    NEval = size(PointsDatabase,1);

%% Process data
    cost_list = PointsDatabase(:,N+2);
    normal_costs = cost_list;
    normal_costs(normal_costs>900)=[];
    max_cost = max(normal_costs);
    min_cost = min(normal_costs);%By WTY
    % --- Cost > 10^3
    idx = 1:numel(cost_list);
    idx_bad = idx(cost_list>900);

%% Plot
PP(1) = scatter(1:NEval,PointsDatabase(:,N+2),MS,"yellow","filled","o","MarkerEdgeColor","black");
hold off
ylim([min([0,min_cost]),1.2*max_cost]) 
xlabel('Evaluation','Interpreter','latex')
ylabel('$J$','Interpreter','latex')
xlim([0,200])
% --- Cosmetic and shape
grid off
box on
grid on
ax=axis;
set(gca,'DataAspectRatio',[1/(ax(4)-ax(3)),1/(ax(2)-ax(1)),1])