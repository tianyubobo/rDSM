function c = negligeable_improvement(PD,SimplexState,limits,abs_error)
% *** If the best point and its closest neighbor are too close
% *** (d/D<1e-6, D diameter domain), break the for loop.

%% Parameter 
    c = 0;
    % ---- Dimension
    N = size(PD,2)-4;

%% Give c=60, if collapses
    PointsList = PD(1:end,1:N);
    D = norm(max(limits(:,2))-min(limits(:,1)));
    
    % --- The closest neighbor of the best point 
    Distance2BestPoint = sum((PointsList-PointsList(SimplexState(1),:)).^2,2);
    % --- Remove the same points (from reevaluations and the one in the simplex)
    Distance2BestPoint(Distance2BestPoint==0)=[];
    % --- Minimum
    min_distance = min(Distance2BestPoint);

    if min_distance/D < abs_error
        c = 60;
        % --- Print
        disp('Simplex achieves negligeable improvement.')
        fprintf('   Ratio between the distance between the two best points \n')
        fprintf('   and the diameter of the domain is less than %s \n',num2str(abs_error))
        disp('Optimization is stopped.')
    end
end