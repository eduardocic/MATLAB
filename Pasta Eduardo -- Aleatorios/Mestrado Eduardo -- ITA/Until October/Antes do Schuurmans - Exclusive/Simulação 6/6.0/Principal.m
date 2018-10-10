close all; clear; clc;

%% 1.: Matrizes de Estados Incertas.
MatrizesDeEstados;

%% 2.: Domínio de Atração dado a Quant. de Pontos.
V = VetoresLimitesDominioAtracao(A, B, 1, 181);
V1 = V(:,1);
V2 = V(:,2);

%% 3.: Plota Domínio de Atração. 
PlotaDominioAtracao;

%% 4.: Ponto
xk0 = [1; 0];
DentroOuForaDoDominioAtracao(V, xk0);
       
    