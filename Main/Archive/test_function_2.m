function val = test_function_2(x,y)
    % This function is a test case for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

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