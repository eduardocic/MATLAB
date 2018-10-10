% *************************************************************************
% - A ideia base desse arquivo � fazer como que encontremos o dom�nio de
% atra��o do sistema no espa�o 2D;
% - Para tal, o que faremos aqui � correr um vetor da forma:
%   
%    xk0 = [cos(theta);
%           sin(theta)];
%
% - Determinaremos, assim, a regi�o do dom�nio de atra�ao.
%
% *************************************************************************
close all; clear; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MainPath = 'C:\Users\Eduardo\Documents\MATLAB\Mestrado\Simula��es\Kothare Schuurmans Diversos';
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

% 3.: Determina��o dos Vetores Limite ao Dom�nio de Atra��o.
%
% - Utilize 180 para passo de 1�;
% - Utilize 1800 para passo de 0.1�; e
% - Utilize 18000 para passo de 0.01�.
DomainSchuurmans = DirectionDomainOfAtractionSchuurmans(A, B, K, Umax, 1800);

% 4.: Plota a Regi�o do Dom�nio de Atra��o.
PlotDomainOfAtractionSchuurmans(DomainSchuurmans);        % Visualiza o Dom�nio de Atra��o.

% 5.: Salva os valores dos vetores do Dom�nio de Atra��o.
save('DomainSchuurmans.mat','DomainSchuurmans');