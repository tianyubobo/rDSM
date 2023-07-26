    % This script launches an optimization process for the DSM/DSME algorithm.
    % This script tests n-dimensional problem

    % Wang Tianyu, 2023/07/26

    % Copyright: 2023 Wang Tianyu (wangtianyu@stu.hit.edu.cn)
    % CC-BY-SA

%% Parameters

    func = @Rosenbrock_ND_function;
    Nparam =16;
    init_conditions = 10*ones(1,Nparam); 
    limits = repmat([0,20],Nparam,1);   
    Nsteps_max = 500;
%% Optimization process
[p_sol,SimplexHistory,PointsDatabase] = rDSM(init_conditions,limits,func,Nsteps_max,Nparam);

%% Plot solution
    figure
    plot_rDSM_learning(PointsDatabase)


