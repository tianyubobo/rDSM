function val = test_function_4(x,y)
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
sigm = 0.35;

val = -sqrt(2)*(x-y)/(4*sqrt(2))+0.5+ ...
      0.75*exp(-((x-1).^2+(y-0).^2)/(2*sigm.^2))+ ...    % (1,0)
      0.25*exp(-((x-0).^2+(y-1).^2)/(2*sigm.^2))+ ...    % (0,1)
      0.25*exp(-((x+1).^2+(y-0).^2)/(2*sigm.^2))+ ...    % (-1,0)
      0.75*exp(-((x-0).^2+(y+1).^2)/(2*sigm.^2));        % (0,-1)


