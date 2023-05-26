    % This script launches an optimization process for the DSM algorithm.
    % This script is used to validate the DSM code.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    func = @test_function_1;
    init_conditions = [-0.75,0.35];
    limits = [-1,1;-1,1];
    Nsteps_max = 30;

%% Optimization process
    [p_sol,SimplexHistory,PointsDatabase] = DSM(init_conditions,limits,func,Nsteps_max);

%% Plot solution - 2D
    figure
    subplot(1,3,1)
    % --- Plot background
    plot_2D_map(limits,func);
    % --- Plot DSME learning process
    plot_2D_DSME(SimplexHistory,PointsDatabase)
    subplot(1,3,2)
    plot_DSME_learning(PointsDatabase)
    subplot(1,3,3)
    plot_2D_Simplex(SimplexHistory,PointsDatabase)
    % --- Position
    set(gcf,'Position',[20,521,1845,420])

%% Compare with fminsearch
    options = optimset('PlotFcns',@optimplotfval,'MaxIter',Nsteps_max);
    fminsearch_sol = fminsearch(func,init_conditions,options);

%% Print solution
    fprintf('DSM solution after %i iterations: \n', Nsteps_max)
    fprintf('   %0.3f \n',p_sol)
    fprintf('fminsearch solution after %i iterations: \n', Nsteps_max)
    fprintf('   %0.3f \n',fminsearch_sol)