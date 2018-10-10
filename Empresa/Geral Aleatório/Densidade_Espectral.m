clear all; close all; clc;

% % Estilo do livro.
% L   = 3.49;
% tau = 10; 
% gamma = tau*sqrt(6/L);
% 
% Al = [    0     1;
%        -1/L^2  -2/L];
% Bl = [0; 1];
% Cl = gamma*[1/(L*sqrt(3)) 1];
% Dl = [0];
% Gl = minreal(tf(ss(Al, Bl, Cl, Dl)));
% 
% % Desenvolvido por mim.
% K  = tau*sqrt(6/L);
% Ae = [-2/L   1;
%       -1/L^2  0]; 
% Be = [K; K/(L*sqrt(3))];
% Ce = [1 0];
% De = 0;
% Ge = minreal(tf(ss(Ae, Be, Ce, De)));

M = [2 2; -1 -1];
I = eye(2);
syms d11 d12 d21 d22;
Delta = [d11 d12; d21 d22];

solve(det(I-M*Delta) == 0)
