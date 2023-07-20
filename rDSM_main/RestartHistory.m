function [H, Restart_history] =  RestartHistory (SimplexState,PD,Restart_history,c)
% This function is used to count how many times restarted, and the restart
% points.If the restart point is restarted more than twice, stop
% the loop for optimization.

%% Parameter
N = size(PD,2)-4; % Dimension

%% Initialization
 % --- H is the counter for how many times the point is restared.
H = 0;
  if c==0.5 || c==0.25 || c ==0.75
     restart = PD(SimplexState(1,1),1:N);
            Restart_history = [Restart_history;restart];
            history_n = size(Restart_history,1);
            if history_n>1
                restart_last = Restart_history(history_n-1,1:N);
                if norm(restart-restart_last)<1.0e-6
                    H = history_n;        
                end  
            end
  end
end