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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MainPath = 'C:\Users\Eduardo\Documents\MATLAB\Mestrado\Simulações\Kothare Diversos';
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

%% 3) Determinação dos Vetores Limite ao Domínio de Atração.
V = DirectionDomainOfAtractionKothare(A, B, Umax, 181);

% 4.: Plota a Região do Domínio de Atração.
PlotDomainOfAtractionKothare(V);        % Visualiza o Domínio de Atração.