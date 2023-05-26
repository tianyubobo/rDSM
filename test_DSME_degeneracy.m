    % This script launches an optimization process for the DSM algorithm.
    % This script tests if the degeneracy is well coded and addressed.
    % A well chosen test function should be used.

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

%% Interesting cases:
% (1) func = @test_function_2;
%     init_conditions = [-0.75,-0.65];
%     limits = [-1,1;-1,1];
%     Nsteps_max = 30;
% (2) func = @Rosenbrock_2D_function;
%     init_conditions = [-3.5,12];
%     limits = 10*[-1,1;-1,1]+[1;5];
%     Nsteps_max = 150;
% (3) func = @test_function_3;
%     init_conditions = [-0.75,0.35];
%     limits = [-1,1;-1,1];
%     Nsteps_max = 30;