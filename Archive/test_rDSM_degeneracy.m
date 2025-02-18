    % This script launches an optimization process for the rDSM algorithm.
    % This script tests if the degeneracy is well coded and addressed.
    % A well chosen test function should be used.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    func = @test_function_2; 
    init_conditions = [-0.75,-0.65];
    limits = [-1,1;-1,1];
    Nsteps_max = 30;

%% Optimization process
[p_sol,SimplexHistory,PointsDatabase] = rDSM(init_conditions,limits,func,Nsteps_max);

%% Plot solution
    figure
    subplot(1,3,1)
    % --- Plot background and simplices history
        plot_func_map(limits,func);
        plot_rDSM_simplices(SimplexHistory,PointsDatabase)
    subplot(1,3,2)
    % --- Plot learning curve
        plot_rDSM_learning(PointsDatabase)
    subplot(1,3,3)
        plot_simplex(SimplexHistory,PointsDatabase)
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
% (3) func = @test_function_3; % Does not work
%     init_conditions = [-0.75,0.35];
%     limits = [-1,1;-1,1];
%     Nsteps_max = 20;
% func = @test_function_easom;
% init_conditions = [-1,-1];
% limits = [-5,5;-5,5];
% Nsteps_max = 200;
% --- 3D Test
% func = @test_function_5;
% init_conditions = [-0.75,0.35,0.9];
% limits = [-1,1;-1,1;-1,1];
% Nsteps_max = 100;