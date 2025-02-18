function plot_W_control(PointData)
    % This function plots the actuation for the control of fan array wind
    % generator
    % It takes as input one row of PointsDatabase.
        
    % Guy Y. Cornejo Maceda, 2023/08/22

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA


%% Parameters
    N = size(PointData,2)-4; % Dimension
    Nn = sqrt(N);

%% Process data
    cost = PointData(:,N+2);
    actuation_levels = reshape(PointData(1:N),Nn,Nn);
    ID = PointData(N+1);

%% Plot
    imagesc([1,Nn],[1,Nn],actuation_levels)
    % --- values
    hold on
    for p=1:5
        for q=1:5
            al = actuation_levels(p*5-5+q);
            textcol = [1,1,1];
            if al<640
                textcol = [0,0,0];
            end
            text(p,q,sprintf("%0.2f",al),"HorizontalAlignment","center","VerticalAlignment","middle",...
                "Interpreter","latex","Color",textcol)
        end
    end
    hold off
    xticks(0.5:1:(Nn+0.5))
    yticks(0.5:1:(Nn+0.5))
    xticklabels('')
    yticklabels('')
    axis([0.5,(Nn+0.5),0.5,(Nn+0.5)])
    grid off
    colorbar
    colormap(flip(gray(64)))
    caxis([610,650])

% --- Cosmetic and shape
    grid off
    box on
    grid on
    set(gca,'DataAspectRatio',[1,1,1])
    set(gca,'TickDir','none')
    set(gcf,'Position',[1244, 315, 520, 441])
    title(sprintf('ID: %i, cost = %0.2f',ID,cost),"Interpreter","latex")
