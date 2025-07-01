function plot_rDSM_simplices(SimplexHistory,PointsDatabase)
    % This function chooses the right function to plot the simplices
    % history following the dimension N of the problem.

%% Parameters
N = size(PointsDatabase,2)-4;

%% Switch
switch N % Dimension
    case 2
        plot_2D_rDSM_simplices(SimplexHistory,PointsDatabase);
    case 3
        plot_3D_rDSM_simplices(SimplexHistory,PointsDatabase);
end
