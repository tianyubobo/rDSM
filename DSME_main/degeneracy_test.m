function [c,edge_ratio,volume_ratio] = degeneracy_test(SimplexState,PD,eps_edge,eps_vol)
    % This function tests if the simplex is denerated or not.
    % This function is called in plot_2D_Simplex, DSM and DSME.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = size(SimplexState,2)-6; % Dimension

%% Degeneracy test
    % *** The degeneracy of the simplex is characerized.

    % --- Original test by Bernd and Guy
    % *** Compare the min and the max distance of one point to the centroid
    % *** of all points -> Not sufficient.
%     % --- Compute centroid of all the simplex points, called center.
%     SimplexCoord = PD(SimplexState(1:N+1),1:N);
%     center = mean(SimplexCoord,1);
%     % --- Compute closest and furthest points from the center
%     distances2center = sqrt(sum((SimplexCoord-center).^2,2));
%     dmin = min(distances2center);
%     dmax = min(distances2center);
%     if dmin>=0.1*dmax, return,end

    % --- Luersen & Le Riche, C&S, 2004
    % *** Build edge matrix
        edge_matrix = PD(SimplexState(2:N+1),1:N)-PD(SimplexState(1),1:N);
        norm_list = nan(N,1);
        for k=1:N, norm_list(k) = norm(edge_matrix(k,:)); end
    % *** Test 1: edge ratio
        edge_ratio = min(norm_list)/max(norm_list);
    % *** Test 2: Volume ratio
        volume_ratio = abs(det(edge_matrix))/prod(norm_list);
    % *** Tests
    c = 0;
    if (edge_ratio < eps_edge) 
        c = 0.25;
        if (volume_ratio < eps_vol)
            c = 0.75;
        end
    else
        if (volume_ratio < eps_vol)
            c = 0.5;
        end
    end
    

