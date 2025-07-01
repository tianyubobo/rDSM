function val = test_function(x,y)
    % This function is a test case for the rDSM algorithm.

%% Test
if nargin == 1
    if size(x,2) == 2
        y = x(:,2);
        x = x(:,1);
    else
        error(['Input format is wrong. Columns should indicate different dimensions\n' ...
            'and lines differents points'])
    end
end

%% Evaluation
val = -sqrt(2)*(x-y)/(4*sqrt(2))+0.5;
val = val + (x<0).*(y<0) * 10^3;
val = val + (y<-1) * 10^3;
val = val + (x>1) * 10^3;

