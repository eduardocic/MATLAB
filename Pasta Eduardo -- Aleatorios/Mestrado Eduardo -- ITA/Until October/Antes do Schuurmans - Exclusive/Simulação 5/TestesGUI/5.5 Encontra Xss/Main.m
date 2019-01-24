%%erl - A ideia base desse arquivo é fazer como que encontremos o domínio de
% atração do sistema no espaço 2D;

% - Para tal, o que faremos aqui é correr um vetor da forma:
%   
%    xk0 = [cos(theta);
%           sin(theta)];

% - Determinaremos, assim, a região do domínio de atraçao.

close all; clear; clc;

%% 1.: Matrizes de Estados Incertas.
MatrizesDeEstados;
H    = MatrizH(A);
Umax = 5;
T    = 1;


xk0 = [3; 5];
% u  = LMI(A, B, 1, 1);








