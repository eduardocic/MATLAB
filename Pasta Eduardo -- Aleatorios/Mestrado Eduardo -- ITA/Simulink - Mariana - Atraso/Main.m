close all; clear; clc;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MainPath = 'C:\Users\Eduardo\Documents\MATLAB\Mestrado\Artigo\SistemaApenasAtraso';
Modulos = {'(1)Inicialization';'(2)Functions';'(3)LMI'};

Tamanho = max(size(Modulos));

for i=1:Tamanho
    rmpath([MainPath '\' Modulos{i,:}]);
    addpath([MainPath '\' Modulos{i,:}]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Carrega as matrizes sem Integradores.
MatrizesDeEstado;       % Carrega as Matrizes de Estado.
Constraints;            % Carrega as Constraints.


%%% Construção do Politopo
[Adelay, Bdelay, Cdelay] = InsereAtrasos(A, B, C, tao);  % Insere Atraso.
