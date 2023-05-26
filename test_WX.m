    % This script launches an optimization process for the DSM/DSME
    % algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    func = @toy_function_WX;
    init_conditions = zeros(1,16);
    limits = repmat(3*[-1,1],16,1);
    Nsteps_max = 100;

%% Optimization process
    [p_sol,SimplexHistory,PointsDatabase] = DSM(init_conditions,limits,func,Nsteps_max);

%% Plot solution
    plot_DSME_learning(PointsDatabase)

%% Notes
% Improvements to be done:
% (1) Include the limits in the initialization.
