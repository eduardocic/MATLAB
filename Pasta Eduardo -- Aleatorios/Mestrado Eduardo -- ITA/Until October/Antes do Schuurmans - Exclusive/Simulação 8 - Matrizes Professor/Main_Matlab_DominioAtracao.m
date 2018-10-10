% *************************************************************************
% - A ideia base desse arquivo é fazer como que encontremos o domínio de
% atração do sistema no espaço 2D;
% - Para tal, o que faremos aqui é correr um vetor da forma:
%   
%    xk0 = [cos(theta);
%           sin(theta)];
%
% - Determinaremos, assim, a região do domínio de atraçao.
% *************************************************************************
close all; clear; clc;

% 1.: Carrega Matrizes no Estado de Espaços.
MatrizesEspacoEstados;

% 2.: Carrega Variveis Diversars e xk0
VariaveisDiversas_Restricoes;
% xk_0;

% 3.: Determinação dos Vetores Limite ao Domínio de Atração.
V = VetoresLimitesDominioAtracao(A, B, Umax, 181);

% 4.: Plota a Região do Domínio de Atração.
% PlotaDominioAtracao(V);        % Visualiza o Domínio de Atração.