function plot_2D_rDSM_simplices(SimplexHistory,PointsDatabase)
    % This function plots the simplices.
    % This is used to visualize the optimization process of DSME.
        
    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Plot parameters
    MS = 35; % Marker size

%% Parameters
    N = size(PointsDatabase,2)-4; % Dimension
    Nsteps = size(SimplexHistory,1);

%% Plot the steps
hold on
    for p=1:Nsteps
        SimplexPointIndices = SimplexHistory(p,1:N+1);
        SimplexCoord = PointsDatabase(SimplexPointIndices,1:N);
        % --- Simplex type
        SimplexType = SimplexHistory(p,N+3);
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
    end
hold off
