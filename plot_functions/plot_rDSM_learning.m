function plot_rDSM_learning(PointsDatabase)
    % This function plots the learning process for a DSME optimization.
        
    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

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
%% Plot
scatter(1:NEval,PointsDatabase(:,N+2),MS,"yellow","filled","o","MarkerEdgeColor","black")
ylim([0,1.2*max_cost])

xlabel('# Evaluations')
ylabel('Cost')

% --- Cosmetic and shape
grid off
box on
grid on
ax=axis;
set(gca,'DataAspectRatio',[1/(ax(4)-ax(3)),1/(ax(2)-ax(1)),1])