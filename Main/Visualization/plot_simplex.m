function plot_simplex(SimplexHistory,PointsDatabase)
    % This function chooses the right function to plot the simplices
    % history following the dimension N of the problem.
        
    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
N = size(PointsDatabase,2)-4;

%% Switch
switch N % Dimension
    case 2
        plot_2D_simplex(SimplexHistory,PointsDatabase);
    case 3
        plot_3D_simplex(SimplexHistory,PointsDatabase);
end
