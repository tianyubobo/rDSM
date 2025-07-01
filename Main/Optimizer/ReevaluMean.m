function [PD, SimplexState] = ReevaluMean(PD,SimplexState,N,k)
%Take the mean value of the reevaluated points.

%% Select the points and calculate the mean value    
    % --- The reevaluation point
    %[Point Coordinate value, Cost,ID];
    ReevaluatedPoint = [PD(end,1:N),PD(end,N+2),size(PD,1)];
    % --- The point before reevaluated
    Points = PD(1:end-1,1:N); 
    Dist = pdist([PD(end,1:N);Points]);
    IDree = find(Dist(1:size(Points,1))==0);
    %[Point Coordinate value, Cost,ID];
    PreReevaluatedPoint =[PD(IDree,1:N),PD(IDree,N+2),PD(IDree,N+1)];
    
    % --- Take the mean value of costs
    %[Point Coordinate value, Cost,ID];
    NewPoint = [PD(end,1:N),mean([PD(end,N+2),PD(IDree,N+2)']),size(PD,1)+1];
%% Output file
    fRH = fopen('Output\\ReevaluationHistory.txt','a+');
    fprintf(fRH, '%s','Reevaluation points: p_1 | ... | p_N | cost| ID ');
    fprintf(fRH,'\r\n');
    lines = size(PreReevaluatedPoint,1);
    fprintf(fRH, '%s',' Pre-reevaluation points ');
    fprintf(fRH,'\r\n');
    for i  = 1:lines
        fprintf(fRH,'%.4f\t',PreReevaluatedPoint(i,:));
        fprintf(fRH,'\r\n'); 
    end
    fprintf(fRH, '%s',' Reevaluated points ');
    fprintf(fRH,'\r\n');
    fprintf(fRH,'%.4f\t',ReevaluatedPoint);
    fprintf(fRH,'\r\n');
    fprintf(fRH, '%s',' New points ');
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
 