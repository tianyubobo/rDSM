    % This script launches an optimization process for the DSM/DSME
    % algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    func = @test_function_WG;
    Nparam = 49; % /!\ Choose a square number
    init_conditions = 10*ones(Nparam,1); % Initial PWM
    limits = repmat([0,20],Nparam,1);
    Nsteps_max = 500;

%% Optimization process
    [p_sol,SimplexHistory,PointsDatabase] = DSM(init_conditions,limits,func,Nsteps_max);

%% Plot solution
    figure
    plot_rDSM_learning(PointsDatabase)
    figure
    plot_WG(p_sol)


