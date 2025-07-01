function [simplex_volume,simplex_perimeter]=simplex_geo_quantities(SimplexCoordinates)
    % This function computes the volume and perimeter of a simplex.

%% Parameters
    N = size(SimplexCoordinates,2); % Dimension
    
%% Volume
    simplex_volume = (1/factorial(N))*abs(det([SimplexCoordinates';ones(1,N+1)]));
%% Perimeter
    SL = pdist(SimplexCoordinates); %SL: side length
    simplex_perimeter = sum(SL);
