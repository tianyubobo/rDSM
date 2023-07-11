function val = test_function_7(x,y,z)
    % This function is a test case for the rDSM algorithm.

    % WANG Tianyu, 2023/06/26

    % Copyright: 2023 WANG Tianyu (email address)
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

% --- init_conditions = [0.5,-0.4,0.8];
val = val + (x > -0.5) .* (x < -0.4) * 10^3;%By WTY
val = val + (y >  0.0) .* (y <  0.5) * 10^3;
val = val + (z > -0.5) .* (z <  0.5) * 10^3;
