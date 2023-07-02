function [SimplexState,PD] = restart_simplex(SimplexState,PD,func)
    % This function is restarts the simplex when it is degenerated.
    % It is a step for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = size(SimplexState,2)-3; % Dimension

% *** Select furthest point from the best one and displace it such as:
% ***   (i)  The circumference is the same
% ***   (ii) The volume is maximized

