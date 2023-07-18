    % This script launches an optimization process for the DSM algorithm.
    % This script is used to validate the DSM code.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
%     func = @test_function_7;
%     init_conditions = [0.5,-0.4,0.8];
%     limits = [-1,1;-1,1;-1,1];
%     Nsteps_max = 100;
%     func = @Rosenbrock_2D_function;
%       init_conditions = [-3.5,12];
%       limits = 10*[-1,1;-1,1]+[1;5];
%       Nsteps_max = 500; % 500

%     func = @test_function_3;
%     init_conditions = [-0.75,0.35];
%     limits = [-1,1;-1,1];
%     Nsteps_max = 150;
    func = @Rosenbrock_2D_function;
    init_conditions = [-3.5,12];
    limits = 10*[-1,1;-1,1]+[1;5];
    Nsteps_max = 140;
% func = @test_function_easom;
% init_conditions = [-1,-1];
% limits = [-5,5;-5,5];
% Nsteps_max = 200;

% func = @test_function_5;
% init_conditions = [-0.75,0.35,0.9];
% limits = [-1,1;-1,1;-1,1];
% Nsteps_max = 100;
%% Optimization process
    [p_sol,SimplexHistory,PointsDatabase] = DSM(init_conditions,limits,func,Nsteps_max);

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

%% Interesting cases
    % --- 2D
%     func = @test_function_1;
%     init_conditions = [-0.75,0.35];
%     limits = [-1,1;-1,1];
%     Nsteps_max = 30;
% 
%     func = @test_function_3;
%     init_conditions = [-0.75,0.35];
%     limits = [-1,1;-1,1];
%     Nsteps_max = 30;
% 
%     func = @Rosenbrock_2D_function;
%     init_conditions = [-3.5,12];
%     limits = 10*[-1,1;-1,1]+[1;5];
%     Nsteps_max = 150;

    % --- 3D
%     func = @test_function_5;
%     init_conditions = [-0.75,0.35,0.35];
%     limits = [-1,1;-1,1;-1,1];
%     Nsteps_max = 30;
% 
%     func = @test_function_6;
%     init_conditions = [-0.75,0.35,0.35];
%     limits = [-1,1;-1,1;-1,1];
%     Nsteps_max = 100;
% 
%     func = @test_function_7;
%     init_conditions = [0.5,-0.4,0.8];
%     limits = [-1,1;-1,1;-1,1];
%     Nsteps_max = 100;