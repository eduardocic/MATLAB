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


%% 3) Determina��o dos Vetores Limite ao Dom�nio de Atra��o.
%
% - Utilize 180 para passo de 1�;
% - Utilize 1800 para passo de 0.1�; e
% - Utilize 18000 para passo de 0.01�.
DominioKothare = DirecaoDominioAtracaoKothare(A, B, Umax, 180);

% 4.: Plota a Regi�o do Dom�nio de Atra��o.
PlotaDominioAtracaoKothare(DominioKothare);        % Visualiza o Dom�nio de Atra��o.

% 5.: Salva os valores dos vetores do Dom�nio de Atra��o.
save('DomainKothare.mat','DominioKothare');
