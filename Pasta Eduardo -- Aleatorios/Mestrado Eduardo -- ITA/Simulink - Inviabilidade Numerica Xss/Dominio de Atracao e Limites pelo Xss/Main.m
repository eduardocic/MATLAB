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

clear; close all; clc;

MatrizesDeEstado;
Restricoes;

% -------------------------------------------------------------------------
% - Utilize 180 para passo de 1�;
% - Utilize 1800 para passo de 0.1�; e
% - Utilize 18000 para passo de 0.01�.
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
PlotaDominioAtracaoKothare(DominioKothare); % Visualiza o Dom�nio de Atra��o.
grid;


% save('DomainKothare.mat','DominioKothare');
