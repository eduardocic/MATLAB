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