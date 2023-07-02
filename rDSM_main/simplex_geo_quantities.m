function [simplex_volume,simplex_perimeter]=simplex_geo_quantities(SimplexCoordinates)
    % This function computes the volume and perimeter of a simplex.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    N = size(SimplexCoordinates,2); % Dimension
    
%% Volume
    simplex_volume = (1/factorial(N))*abs(det([SimplexCoordinates';ones(1,N+1)]));

%% Perimeter
    SL = pdist(SimplexCoordinates); %SL: side length
    simplex_perimeter = sum(SL);
