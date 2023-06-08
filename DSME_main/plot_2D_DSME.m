function plot_2D_Simplex(SimplexHistory,PointsDatabase,Step)
    % This function plots the last simplex
    % This is used to visualize the optimization process of DSME.
        
    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% DSME parameters
    [~,~,~,~,~,eps_edge,eps_vol] = DSME_parameters;

%% Test
    if nargin<3
        Step = size(SimplexHistory,1);
    end
    if Step>size(SimplexHistory,1)
        error('Step is too large')
    end
    
    % --- Simplex degenerated?
    [c,edge_ratio,volume_ratio] = degeneracy_test(SimplexHistory(Step,:),PointsDatabase,eps_edge,eps_vol);
    c = 4*c; % 1: edge ratio, 2: volume ratio, 3: both

%% Plot parameters
    MS = 60; % Marker size

%% Parameters
    N = size(SimplexHistory,2)-6; % Dimension

%% Plot the simplex
hold on
    SimplexPointIndices = SimplexHistory(Step,1:N+1);
    SimplexCoord = PointsDatabase(SimplexPointIndices,1:N);
    % --- Plot the edges
    for q=1:(N+1)
        for r=(q+1):(N+1)
            plot(SimplexCoord([q,r],1),SimplexCoord([q,r],2),'Color','y')
        end
    end
    % --- Plot points
    scatter(SimplexCoord(:,1),SimplexCoord(:,2),MS,"yellow","filled","o","MarkerEdgeColor","black")
    % --- Plot best point
    scatter(SimplexCoord(1,1),SimplexCoord(1,2),MS,"red","filled","o","MarkerEdgeColor","black")
    % --- Plot centroid
    centroid = mean(SimplexCoord(1:N,:),1);
    scatter(centroid(:,1),centroid(:,2),MS,"green","filled","^","MarkerEdgeColor","black")
hold off

    % Window
    center = mean(SimplexCoord(1:N+1,:),1);
    dX = max(max(abs(SimplexCoord-center)));
    xlim(center(1)+1.35*dX.*[-1,1])
    ylim(center(2)+1.35*dX.*[-1,1])

    xticks();
    yticks();
    xticklabels('')
    yticklabels('')
    set(gca,'DataAspectRatio',[1,1,1])
    set(gca,'TickDir','in')
    %set(gca,'TickDir','none')
%     set(gca,'color','none')
    axis off

%% Text
    switch c
        case 1
        text(center(1),center(2)+dX,{sprintf('Simplex after %i iterations',Step);...
                                     sprintf('Degenerated: edge ratio = %0.1f',edge_ratio)},...
            "HorizontalAlignment","center")
        case 2
        text(center(1),center(2)+dX,{sprintf('Simplex after %i iterations',Step);...
                                     sprintf('Degenerated: volume ratio = %0.1f',volume_ratio)},...
            "HorizontalAlignment","center")
        case 3
        text(center(1),center(2)+dX,{sprintf('Simplex after %i iterations',Step);...
                                     sprintf('Degenerated: edge ratio = %0.1f',edge_ratio);...
                                     sprintf('Degenerated: volume ratio = %0.1f',volume_ratio)},...
            "HorizontalAlignment","center")
        otherwise
%         text(center(1)+dX,center(2)+dX,sprintf('Simplex after %i iterations',Step),...
%             "HorizontalAlignment","center")
    end
