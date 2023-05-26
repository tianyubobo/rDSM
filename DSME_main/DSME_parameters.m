function [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = DSME_parameters
    % This function initialize the parameters for the DSME algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    % --- Initialization parameter
    init_coeff = 0.05;  % Percentage of domain range for initial shift

    % --- Downhill simplex method parameters
    alph = 1;           % Reflexion parameter
    gamm = 2;           % Expansion parameter
    phi = 0.5;          % Contraction parameter
    sigm = 0.5;         % Shrink parameter
    
    % --- Degeneracy parameters
    eps_edge = -inf;    % Lower limit for edge ratio for degeneracy
    eps_vol = -inf;     % Lower limit for volume ratio for degeneracy