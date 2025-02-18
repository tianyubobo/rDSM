function plot_WG(p_sol)
    % Function to plot the result of a the WG problem optimization.

%% Run the "experiment"
% --- Best solution
    [Controlled_Z,ax,ay,az,X,Y,Z,U_0,cx,cy] = WG_experiment(p_sol);

%% Plot control map
    % --- Plot control map
    axx(1) = subplot(2,3,1);
    hold on
    contourf(ax,ay,az)
    QQ = scatter(cx(:), cy(:),'ro','MarkerFaceColor','auto');
    hold off
    set(gcf,'unit','centimeters','position',[1 1 15 12])
    xlabel('x','Interpreter','latex');
    ylabel('y','Interpreter','latex');
    colorbar
    colormap(axx(1),hot)
    box on
    grid off
    caxis([min(p_sol),max(p_sol)])
    title('Control map','Interpreter','latex')

    legend(QQ,{'Centroids'},'Position',[0.13,0.52,0.06,0.02])
    
    % --- Plot actuation level
    subplot(2,3,4)
    hold on
    plot(p_sol,'ro','MarkerFaceColor','auto')
    box on
    grid on
    ylabel('Action');
    xlabel('Centroids')
    title('Actuation level','Interpreter','latex')

%% Plot unforced case
    % --- Plot unforced map
    axx(2) = subplot(2,3,2);
    hold on
    contourf(X,Y,Z)
    plot(X, Y,'b^','MarkerFaceColor','auto')
    plot(ax, ay,'rs','MarkerFaceColor','auto')
    hold off
    set(gcf,'unit','centimeters','position',[1 1 15 12])
    xlabel('x','Interpreter','latex');
    ylabel('y','Interpreter','latex');
    colorbar
    colormap(axx(2),parula)
    caxis([min([Z(:);Controlled_Z(:)]),max([Z(:);Controlled_Z(:)])])
    title('Unforced map','Interpreter','latex')

    % --- Plot unforced map 3D
    axx(4) = subplot(2,3,5);
    hold on
    surf(X,Y,Z,'FaceAlpha',0.5)
    surf(X,Y,Controlled_Z,'FaceAlpha',0.5)
    hold off
    set(gcf,'unit','centimeters','position',[1 1 15 12])
    xlabel('x','Interpreter','latex');
    ylabel('y','Interpreter','latex');
    zlabel('$U$','Interpreter','latex');
    colormap(axx(4),"parula")
    caxis([min([Z(:);Controlled_Z(:)]),max([Z(:);Controlled_Z(:)])])
    box on
    grid off
    view(3)

%%  Plot best solution
    % --- Plot controlled map
    axx(3) = subplot(2,3,3);
    hold on
    contourf(X,Y,Controlled_Z)
    PP(1) = scatter(X(:), Y(:),'b^','MarkerFaceColor','auto');
    PP(2) = scatter(ax(:), ay(:),'rs','MarkerFaceColor','auto');
    hold off
    set(gcf,'unit','centimeters','position',[1 1 15 12])
    xlabel('x','Interpreter','latex');
    ylabel('y','Interpreter','latex');
    colorbar
    colormap(axx(3),parula)
    caxis([min([Z(:);Controlled_Z(:)]),max([Z(:);Controlled_Z(:)])])
    title('Controlled map','Interpreter','latex')

    legend(PP,{'Measurement points','Actuation points'},'Position',[0.80,0.50,0.09,0.04])
    
%% comparison and analysis
    subplot(2,3,6)
    plot(Z(:),'bo-')
    hold on
    plot(Controlled_Z(:),'r+--')
    plot([0,numel(Z)],U_0*[1,1],'k-')
    xlabel('Measurement points')
    ylabel('$U$','Interpreter','latex')
    xlim([0,numel(Z)])
    ylim( [ min([0,min([Z(:);Controlled_Z(:)])])-1, ...
            1+max([U_0,max([Z(:);Controlled_Z(:)])]) ])

    legend('Unforced','Controlled','Objectif')


set(gcf,'Position',[1.3758    1.6669   45.0321   24.2094])