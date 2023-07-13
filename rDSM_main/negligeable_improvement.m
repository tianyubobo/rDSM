function c = negligeable_improvement(PD,SimplexState,abs_error)
% *** If the best point and its closest neighbor are too close
% *** (d/D<1e-6, D diameter domain), break the for loop.

%% Parameter 
    c = 0;
    % ---- Dimension
    N = size(PD,2)-4;

%% Give c=60, if collapses
    PointsList = PD(1:end,1:N);
    D = max(pdist(PointsList));
    % WTY: I define the diameter as the max distance between two points
    % in the point database so far. 
    % An option definition is using the limits, then the parameter limits 
    % should be an input parameter in this function, or just let diameter 
    % be an input parameter.
    % D = norm(limits(:,2)-limits(:,1))
    
    % --- The closest neighbor of the best point 
    PointsListOrdered = PointsList;
    PointsListOrdered([1,SimplexState(1)],:)=PointsListOrdered([SimplexState(1),1],:);
    Dis = pdist(PointsListOrdered);
    d = Dis(find(Dis(1:size(PD,1)-1) == min(Dis(1:size(PD,1)-1))));
    if d/D < abs_error
        c = 60;
    end
end