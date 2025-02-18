function J = test_function_WG(b)
% This function simulates an WG experiment and computes the cost function.

%% "Experiment"
% --- Actuation levels (z)
    [Controlled_Z,~,~,~,~,~,~,U_0] = WG_experiment(b);

% --- Cost funtion
    %J=mean((New_z-U_0).^2,"all");% This can be used for 2018b and newer version
    J = mean(mean((Controlled_Z-U_0).^2));

