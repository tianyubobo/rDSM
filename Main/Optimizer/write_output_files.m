function write_output_files(SH,PD)
    % Export output files.

%% Open output files
    % --- Point database
        fPD = fopen('Output\PointsDatabase.txt','w+');
        fprintf(fPD,'%s','p_1 | ... | p_N | ID | Cost | in Simplex numb. | Operation');
        fprintf(fPD,'\r\n'); 
    % --- Simplex history
        fSH = fopen('Output\SimplexHistory.txt','w+');
        fprintf(fSH,'%s','p1 | ... | pN+1 | Simplex numb. | Operation | C1 | ... | CN+1');
        fprintf(fSH,'\r\n'); 

%% Output point database and simplex history
    % --- Point database
        for p = 1:size(PD,1)    
            fprintf(fPD,'%.4f\t',PD(p,:));
            fprintf(fPD,'\r\n');
        end
    % --- Simplex history
        for p = 1:size(SH,1)    
            fprintf(fSH,'%.4f\t',SH(p,:));
            fprintf(fSH,'\r\n');
        end

%% Close the output files 
        fclose(fPD);
        fclose(fSH);

%% Save ASCII format
    save('Output\PointsDatabase.dat','PD','-ascii')
    save('Output\SimplexHistory.dat','SH','-ascii')