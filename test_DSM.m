    % This script launches an optimization process for the DSM algorithm.
    % This script is used to validate the DSM code.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    func = @test_function_3;
    init_conditions = [-0.75,0.35];
    limits = [-1,1;-1,1];
    Nsteps_max = 30;

%     func = @Rosenbrock_2D_function;
%     init_conditions = [-3.5,12];
%     limits = 10*[-1,1;-1,1]+[1;5];
%     Nsteps_max = 150;
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

%% Compare with fminsearch
%       options = optimset('PlotFcns',@optimplotfval,'TolX',1.0e-6);
%       %options = optimset('OutputFcn',@optimplotfval,'Display','iter');
%       %figure
%       [fminsearch_sol,fval,exitflag,output] = fminsearch(func,init_conditions,options);

%% Print solution
fprintf('DSM solution after %i iterations: \n', Nsteps_max)
fprintf('   %0.3f \n',p_sol)
%fprintf('fminsearch solution after %i iterations: \n', Nsteps_max)
%fprintf('   %0.3f \n',fminsearch_sol)

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
    % --- 3D
%     func = @test_function_5;
%     init_conditions = [-0.75,0.35,0.35];
%     limits = [-1,1;-1,1;-1,1];
%     Nsteps_max = 30;