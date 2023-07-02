    % This script launches an optimization process for the DSME algorithm.
    % This script tests if the reevaluation is well coded.
    % A stochastic test function can be used to mimic the experimental
    % conditions.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    func = @test_function_5;
    init_conditions = [-0.75,0.35,0.9];
    limits = [-1,1;-1,1;-1,1];
    Nsteps_max = 30;

%% Optimization process
[p_sol,SimplexHistory,PointsDatabase] = DSM(init_conditions,limits,func,Nsteps_max);

%% Plot solution - 2D
figure
subplot(1,3,1)
% --- Plot background
 plot_3D_map(limits,func);
% --- Plot DSME learning process
plot_2D_rDSM(SimplexHistory,PointsDatabase)
subplot(1,3,2)
plot_rDSM_learning(PointsDatabase)
subplot(1,3,3)
% plot_2D_Simplex(SimplexHistory,PointsDatabase)
% --- Position
set(gcf,'Position',[20,521,1845,420])

%% Verify if the reevaluation is done.
%     N = numel(init_conditions);
% % --- Find the reevaluations
% PD_indices = PointsDatabase(:,end)<0;
% Reevaluation_indices = PointsDatabase(PD_indices,N+1);
% % --- Find first iteration
% first_iter = 0*Reevaluation_indices;
% for k=1:numel(Reevaluation_indices)
%     [~,fi] = min(sum(abs(PointsDatabase(1:Reevaluation_indices(k)-1,1:N)-PointsDatabase(Reevaluation_indices(k),1:N)),2));
%     first_iter(k)=fi;
% end

%% Interesting cases
% --- 2D
%     func = @test_function_1;
%     init_conditions = [-0.75,0.35];
%     limits = [-1,1;-1,1];
%     Nsteps_max = 30;
