clear; close all; clc;

%% ------------------------------------------------------------------------
%               (1) Defini��o das matrizes incertas.
% -------------------------------------------------------------------------

A1 = [   0   1;
      -1.5 2.5];
  
A2 = [   0   1;
      -0.8 1.8];  

B = [0;
     1];
  
%% ------------------------------------------------------------------------
%                   (2) Determina��o do politopo G.
% -------------------------------------------------------------------------

% Concatena as matrizes de incertezas A e B.
A = [A1;
     A2];
B = [B];

C = [1 0; 0 1];
D = zeros(size(C,1), size(B,2));
 
S  = [1 0; 0 1];  % Ssqrt = sqrt(S);    % S^(-1/2)
R  = [1];  % Rsqrt = sqrt(R);    % R^(-1/2)

xk0 = [300;40];     % Deu n�o fact�vel para xk = [5; 1];

Umax = 1;     % Limite para a entrada.

T = 1;        % Passo de Simula��o.

% -------------------------------------------------------------------------
rho     = 1;        % Peso dado a vari�vel 'gamma'.
epsilon = 0.00005;  % Vem l� da LMI oriunda da igualdade do sistema (arquivo 'Main').



 