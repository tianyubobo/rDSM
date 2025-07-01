function [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = DSM_parameters_N(N)
    % This function initialize the parameters for the rDSM algorithm.
    
%% Parameters
    % --- Initialization parameter
    init_coeff = 0.05;  % Percentage of domain range for initial shift
    % --- Downhill simplex method parameters
    alph = 1;           % Reflexion parameter
    gamm = 2;           % Expansion parameter
    phi = 0.5;          % Contraction parameter
    sigm = 0.5;         % Shrink parameter
    
    % --- Degeneracy parameters
    eps_edge = 0.1;    % Lower limit for edge ratio for degeneracy
    eps_vol = 0.1;     % Lower limit for volume ratio for degeneracy

   