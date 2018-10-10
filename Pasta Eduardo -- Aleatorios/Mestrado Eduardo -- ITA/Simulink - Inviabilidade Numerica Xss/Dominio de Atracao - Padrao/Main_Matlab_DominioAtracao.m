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


%% 3) Determinação dos Vetores Limite ao Domínio de Atração.
%
% - Utilize 180 para passo de 1º;
% - Utilize 1800 para passo de 0.1º; e
% - Utilize 18000 para passo de 0.01º.
DominioKothare = DirecaoDominioAtracaoKothare(A, B, Umax, 180);

% 4.: Plota a Região do Domínio de Atração.
PlotaDominioAtracaoKothare(DominioKothare);        % Visualiza o Domínio de Atração.

% 5.: Salva os valores dos vetores do Domínio de Atração.
save('DomainKothare.mat','DominioKothare');
