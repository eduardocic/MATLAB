%%erl - A ideia base desse arquivo � fazer como que encontremos o dom�nio de
% atra��o do sistema no espa�o 2D;

% - Para tal, o que faremos aqui � correr um vetor da forma:
%   
%    xk0 = [cos(theta);
%           sin(theta)];

% - Determinaremos, assim, a regi�o do dom�nio de atra�ao.

close all; clear; clc;

%% 1.: Matrizes de Estados Incertas.
MatrizesDeEstados;
H    = MatrizH(A);
Umax = 5;
T    = 1;


xk0 = [3; 5];
% u  = LMI(A, B, 1, 1);








