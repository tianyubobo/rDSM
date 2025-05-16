function val = test_function_easom(x,y)
    % This function is a test case using the easom function
    %This test results depend on the inital point.
    %init_conditions = [-4,4],[4,-4],failed;[-4,-4]success.
    % Wang Tianyu, 2023/07/11

    % Copyright: 2023 Wang Tianyu (wangtianyu@stu.hit.edu.cn)
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
val = -cos(x).*cos(y).*exp(-((x-pi).^2 + (y-pi).^2));
% --- renormalization (between 0 and 1)
val = val-(-3.0308e-05)/(3.0308e-05);
end
%% For testing
% func = @test_function_easom;
% init_conditions = [-1,-1];
% limits = [-5,5;-5,5];
% Nsteps_max = 200;