% *************************************************************************
% - A ideia base desse arquivo � fazer como que encontremos o dom�nio de
% atra��o do sistema no espa�o 2D;
% - Para tal, o que faremos aqui � correr um vetor da forma:
%   
%    xk0 = [cos(theta);
%           sin(theta)];
%
% - Determinaremos, assim, a regi�o do dom�nio de atra�ao.
% *************************************************************************
close all; clear; clc;

% 1.: Carrega Matrizes no Estado de Espa�os.
MatrizesEspacoEstados;

% 2.: Carrega Variveis Diversars e xk0
VariaveisDiversas_Restricoes;
% xk_0;

% 3.: Determina��o dos Vetores Limite ao Dom�nio de Atra��o.
V = VetoresLimitesDominioAtracao(A, B, Umax, 181);

% 4.: Plota a Regi�o do Dom�nio de Atra��o.
% PlotaDominioAtracao(V);        % Visualiza o Dom�nio de Atra��o.