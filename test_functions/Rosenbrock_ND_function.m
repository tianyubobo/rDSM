function val = Rosenbrock_ND_function(x)
    % This function is a test case for the DSME algorithm.

    % Wang Tianyu, 2023/07/26

    % Copyright: 2023 Wang Tianyu (wangtianyu@stu.hit.edu.cn)
    % CC-BY-SA
%% Input and output
% --- Input: x, M*N matrix
% --- Output: val, the value of n-dimensional Rosenbrock funcion

%% Evaluation
[M,N] = size(x);
val = zeros(M,1);

for i=1:M
    for j=1:N-1
        xij = x(i,j);
        xijj = x(i,j+1);
        if xij>0 && xij<20   
            if xij>0 && xijj<20
            val(i,1) = val(i,1)+100*(xijj-xij.^2).^2 + (1-xij).^2 ;
            end
        else
        val(i,1) = 10^10 ;
        break;
        end
    end
end
val = val/10000;

