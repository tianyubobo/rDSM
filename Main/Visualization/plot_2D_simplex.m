function plot_2D_simplex(SimplexHistory,PointsDatabase,Step)
    % This function plots the last simplex
    % This is used to visualize the optimization process of rDSM.

%% Parameters
% --- Dimension
    N = size(PointsDatabase,2)-4; 
    % --- rDSM parameters
    [~,~,~,~,~,eps_edge,eps_vol] = DSM_parameters;
% --- Plot parameters
    MS = 60; % Marker size

%% Test
    if nargin<3
        Step = size(SimplexHistory,1);
    end
    if Step>size(SimplexHistory,1)
        error('Step is too large')
    end
    
    % --- Simplex degenerated?
    [~,edge_ratio,volume_ratio] = degeneracy_test(SimplexHistory(Step,:),PointsDatabase,eps_edge,eps_vol);
    SimplexType = SimplexHistory(Step,N+3);
    c = 4*rem(SimplexType,1);
    if logical(c)
        if SimplexType<1
            simplex_line_type = 'b--';
        else
            simplex_line_type = 'r-';
        end
    else
        simplex_line_type = 'y-';
    end

%% Plot the simplex
hold on
    SimplexPointIndices = SimplexHistory(Step,1:N+1);
    SimplexCoord = PointsDatabase(SimplexPointIndices,1:N);
    % --- Plot the edges
    for q=1:(N+1)
        for r=(q+1):(N+1)
            plot(SimplexCoord([q,r],1),SimplexCoord([q,r],2),simplex_line_type)
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
        text(center(1),center(2)+dX,sprintf('Simplex after %i iterations',Step),...
            "HorizontalAlignment","center")
    end

%% Legend
hold on
PP(1)=plot(nan,nan,'y-');
PP(2)=plot(nan,nan,'r-');
PP(3)=plot(nan,nan,'b--');
hold off

legend(PP,{'Simplex','Degenerated simplex','Corrected simplex'}, ...
            'Position',[0.85,0.04,0.13,0.20])