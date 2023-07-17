    % This script is used to test fminsearch()

    % Wang Tianyu, 2023/07/12

    % Copyright: 2023 Wang Tianyu (wangtianyu@stu.hit.edu.cn)
    % CC-BY-SA

%% Parameters
%         func = @test_function_7;
%         init_conditions = [0.5,-0.4,0.8];
%         limits = [-1,1;-1,1;-1,1];
%     func = @test_function_3;
%     init_conditions = [-0.75,0.35];
%     limits = [-1,1;-1,1];
%     Nsteps_max = 500;
%     func = @Rosenbrock_2D_function;
%     init_conditions = [-3.5,12];
%     limits = 10*[-1,1;-1,1]+[1;5];
%     Nsteps_max = 150;

% --- 3D function
func = @test_function_5;
init_conditions = [-0.75,0.35,0.9];
limits = [-1,1;-1,1;-1,1];
Nsteps_max = 100;
        epsilon = 1.0e-6; %epsilon is the converged condition.
    
%%  fminsearch
        options = optimset('PlotFcns',@optimplotfval,'TolX',epsilon);
        %options = optimset('OutputFcn',@optimplotfval,'Display','iter');
%         figure
        [fminsearch_sol,fval,exitflag,output] = fminsearch(func,init_conditions,options);

%% Print solution
        fprintf('fminsearch solution until converging to %i : \n', epsilon)
        fprintf('   %0.3f \n',fminsearch_sol)

%% Obtain the iteration process data in the figure
%         h_line=get(gca,'Children');
%         xdata=get(h_line,'Xdata');
%         ydata=get(h_line,'Ydata');
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