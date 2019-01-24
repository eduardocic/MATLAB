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

clear; close all; clc;

MatrizesDeEstado;
Restricoes;

% -------------------------------------------------------------------------
% - Utilize 180 para passo de 1º;
% - Utilize 1800 para passo de 0.1º; e
% - Utilize 18000 para passo de 0.01º.
DominioKothare = DirecaoDominioAtracaoKothare(A, B, Umax, 180);
% -------------------------------------------------------------------------

% Eixos do sistema.
xmin = min(DominioKothare(1:end,1));
xmax = max(DominioKothare(1:end,1));
ymin = min(DominioKothare(1:end,2));
ymax = max(DominioKothare(1:end,2));
squad = [xmin xmax ymin ymax];

RegiaoEntreRetas(A, B, Umax, squad);
hold on;
PlotaDominioAtracaoKothare(DominioKothare); % Visualiza o Domínio de Atração.
grid;


% save('DomainKothare.mat','DominioKothare');
