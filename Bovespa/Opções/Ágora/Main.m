clear all; close all; clc

% -------------------------------------------------------------------------
%                            OP��ES DE COMPRA
%                           ------------------  
%
%  * Limitei m�ximo de 8 op��es por vez
% -------------------------------------------------------------------------
Exercicio       = [13.5, 14, 14.5, 15, 15.5  16];
Premio          = [1.87, 1.39,  0.98,  0.63,  0.38, 0.21];

% -------------------------------------------------------------------------
save('PrecosOpcoes.mat', 'Exercicio', 'Premio');
Interface();


