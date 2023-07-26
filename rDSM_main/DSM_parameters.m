function [alph,gamm,phi,sigm,init_coeff,eps_edge,eps_vol] = DSM_parameters(N)
    % This function initialize the parameters for the rDSM algorithm.

    % Guy Y. Cornejo Maceda, 2023/05/10

    % Copyright: 2023 Guy Y. Cornejo Maceda (gy.cornejo.maceda@gmail.com)
    % CC-BY-SA

%% Parameters
    % --- Initialization parameter
    %init_coeff = 0.05;  % Percentage of domain range for initial shift
    init_coeff = 0.1; %Larger
    % --- Downhill simplex method parameters
%     alph = 1;           % Reflexion parameter
%     gamm = 2;           % Expansion parameter
%     phi = 0.5;          % Contraction parameter
%     sigm = 0.5;         % Shrink parameter
    
    % --- Nelder-Mead method parameters from 
    %Gao, F., Han, L., 2012. Comput Optim Appl 51, 259¨C277. 
    %https://doi.org/10.1007/s10589-010-9329-3
    %N = 36; % dimension
    alph = 1;           % Reflexion parameter
    gamm = 1 + 2/N;           % Expansion parameter
    phi = 0.75 - 1 /(2*N);          % Contraction parameter
    sigm = 1 - 1/N;         % Shrink parameter
    % --- Degeneracy parameters
    eps_edge = 1.0*10^(-(sqrt(N)+3));%-inf;    % Lower limit for edge ratio for degeneracy
    eps_vol = 1.0*10^(-(sqrt(N)+3));%-inf;     % Lower limit for volume ratio for degeneracy