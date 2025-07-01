function plot_func_map(limits,func)
    % This function chooses the right function to plot the map following
    % the dimension N of the problem.


%% Parameters
N = size(limits,1);

%% Switch
switch N % Dimension
    case 2
        plot_2D_map(limits,func);
    case 3
        plot_3D_map(limits,func);
end
