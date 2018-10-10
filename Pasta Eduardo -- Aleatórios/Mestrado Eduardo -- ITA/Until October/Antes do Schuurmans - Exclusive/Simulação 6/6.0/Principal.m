close all; clear; clc;

%% 1.: Matrizes de Estados Incertas.
MatrizesDeEstados;

%% 2.: Dom�nio de Atra��o dado a Quant. de Pontos.
V = VetoresLimitesDominioAtracao(A, B, 1, 181);
V1 = V(:,1);
V2 = V(:,2);

%% 3.: Plota Dom�nio de Atra��o. 
PlotaDominioAtracao;

%% 4.: Ponto
xk0 = [1; 0];
DentroOuForaDoDominioAtracao(V, xk0);
       
    