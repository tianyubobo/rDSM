function [PD, SimplexState] = ReevaluMean(PD,SimplexState,N,k)
% It's better to run these lines of codes before run the test file, so that, we close and
% clean the old useless files.
%fclose('all');
%delete('D:\DSME\ReevaluationHistory.txt')
%% Creat a file named ReevaluationHistory.txt
fRH = fopen('D:\DSME\ReevaluationHistory.txt','a+');
%% Select the points and calculate the mean value    
% --- The reevaluation point
%[Point Coordinate value, Cost,ID];
ReevaluatedPoint = [PD(end,1:N),PD(end,N+2),size(PD,1)];
% --- The point before reevaluated
Points = PD(1:end-1,1:N); 
IDree = find(pdist([PD(end,1:N);Points])==0);
%[Point Coordinate value, Cost,ID];
PreReevaluatedPoint =[PD(IDree(1),1:N),PD(IDree(1),N+2),PD(IDree(1),N+1)];
% --- Take the mean value of costs
%[Point Coordinate value, Cost,ID];
NewPoint = [PD(end,1:N),mean([PD(end,N+2),PD(IDree(1),N+2)]),size(PD,1)+1];
%% Output file
fprintf(fRH,'%.4f\t',PreReevaluatedPoint);
fprintf(fRH,'\r\n'); 
fprintf(fRH,'%.4f\t',ReevaluatedPoint);
fprintf(fRH,'\r\n'); 
fprintf(fRH,'%.4f\t',NewPoint);
fprintf(fRH,'\r\n'); 
fclose(fRH);
%% Update
% --- Update PD
PD = [PD;PD(end,1:N),size(PD,1)+1,mean([PD(end,N+2),PD(IDree(1),N+2)]),SimplexState(N+2),-2];% -2 for taking the mean value before and after reevaluation
% --- Update SimplexState
SimplexState(k) = size(PD,1);

end
 