% *************************************************************************
% - A ideia base desse arquivo é fazer como que encontremos o domínio de
% atração do sistema no espaço 2D;
% - Para tal, o que faremos aqui é correr um vetor da forma:
%   
%    xk0 = [cos(theta);
%           sin(theta)];
%
% - Determinaremos, assim, a região do domínio de atraçao.
%
% *************************************************************************
close all; clear; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MainPath = 'C:\Users\Eduardo\Documents\MATLAB\Mestrado\Simulações\Kothare Schuurmans Diversos';
Modulos = {'(1)Inicialization';'(2)Functions';'(3)LMI'};

Tamanho = max(size(Modulos));

for i=1:Tamanho
    rmpath([MainPath '\' Modulos{i,:}]);
    addpath([MainPath '\' Modulos{i,:}]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1) Matrizes de Estado
SteadyStateMatrix;

%% 2) Carrega Variveis Diversas e xk0
Constraints;

% 3.: Determinação dos Vetores Limite ao Domínio de Atração.
%
% - Utilize 180 para passo de 1º;
% - Utilize 1800 para passo de 0.1º; e
% - Utilize 18000 para passo de 0.01º.
DomainSchuurmans = DirectionDomainOfAtractionSchuurmans(A, B, K, Umax, 1800);

% 4.: Plota a Região do Domínio de Atração.
PlotDomainOfAtractionSchuurmans(DomainSchuurmans);        % Visualiza o Domínio de Atração.

% 5.: Salva os valores dos vetores do Domínio de Atração.
save('DomainSchuurmans.mat','DomainSchuurmans');