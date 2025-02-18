    % This script launches an optimization process for the DSM algorithm.
    % This script is used to validate the DSM code.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    func = @test_function;
    init_conditions = [-0.75,0.35];
    limits = [-1,1;-1,1];
    Nsteps_max = 90;
    N = 2;

%% Optimization process
    [p_sol,SimplexHistory,PointsDatabase] = rDSM(init_conditions,limits,func,Nsteps_max,N);

%% Plot solution
    figure
    subplot(1,2,1)
    % --- Plot background and simplices history
        plot_func_map(limits,func);
        plot_rDSM_simplices(SimplexHistory,PointsDatabase)
    subplot(1,2,2)
    % --- Plot learning curve
        plot_rDSM_learning(PointsDatabase)
    % --- Position
    set(gcf,'Position',[20,521,1245,420])
    set(gcf,'color','white');
