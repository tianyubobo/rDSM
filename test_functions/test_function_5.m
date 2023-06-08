function val = test_function_5(x,y,z)
    % This function is a test case for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Test
if nargin == 1
    if size(x,2) == 3
        z = x(:,3);
        y = x(:,2);
        x = x(:,1);
    else
        error(['Input format is wrong. Columns should indicate different dimensions\n' ...
            'and lines differents points'])
    end
end

%% Evaluation
val = x.^2 + y.^2 + z.^2;