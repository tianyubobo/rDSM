function [Controlled_Z,ax,ay,az,X,Y,Z,U_0,cx,cy] = WG_experiment(b)
% This function simulation the WG experiment.
% Input: actuation level at different control points.
% Output:
%   z: actuation level for each actuator

%% Parameters
    U_0=10;               % Objecive velocity
    cln = numel(b);       % Number of clusters
    NumMea=8;             % Number of measurement points (in one direction, total = ^2)
    NumActua=10;          % Number of actuators (in one direction, total = ^2)
    % --- Domain
        xmin=-1.625;      % Left boundary
        xmax=1.625;       % Right boundary
        ymin=-1.625;      % Bottom boundary
        ymax=1.625;       % Top boundary

%% Unforced measurement
    % --- Measurement grid
        m1=linspace(xmin,xmax,NumMea);
        m2=linspace(ymin,ymax,NumMea);
        [X,Y]=meshgrid(m1,m2);
    % --- Initial condition
    Z = - 1.0 * exp(-2*(X-1.0).^2 - 2*(Y-1.0).^2)...
        - 1/2 * exp(-2*(X+1.0).^2 - 2*(Y-1.0).^2)...
        - 1/3 * exp(-2*(X-1.0).^2 - 2*(Y+1.0).^2)...
        + 5.0 * exp(-2*(X+0.5).^2 - 2*(Y+0.5).^2);

%% Actuation levels
    % --- Actuation grid
        a1=linspace(xmin,xmax,NumActua);
        a2=linspace(ymin,ymax,NumActua);
        [ax,ay]=meshgrid(a1,a2);
    % --- Centroid grid (Control grid)
        c1=linspace(xmin,xmax,sqrt(cln));
        c2=linspace(ymin,ymax,sqrt(cln));
        [cx,cy]=meshgrid(c1,c2);
    % --- Interpolation actuation based on the centroid values
        b=reshape(b,sqrt(cln),sqrt(cln));
        az=griddata(cx,cy,b,ax,ay,'linear');

%% "Experiment"
    % --- Interpolation control on measurement points
    Mea_act=griddata(ax,ay,az,X,Y,'linear');
    % --- Sum unforced + control
    Controlled_Z = Z+Mea_act;

end