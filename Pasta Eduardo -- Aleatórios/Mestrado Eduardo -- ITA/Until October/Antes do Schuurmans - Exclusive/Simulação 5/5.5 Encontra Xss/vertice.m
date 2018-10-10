function [Aj, Bj] = vertice(A, B, nA, qB, j)
% Dado uma concatenação das matrizes A e B, conseguiremos determinar todos
% os vértices do politopo, fazendo uma combinação entre as incertezas de Aj
% e Bj, separando o vetor.

t = mod((j-1),qB);           % Resto da divisão.
u = floor((j-1)/qB);         % Divisor;   

Aj = A((u*nA+1):((u+1)*nA),:);
Bj = B((t*nA+1):((t+1)*nA),:);
end