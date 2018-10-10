function [D] = pick(L, k)
% O que esta função faz é pegar itens dois a dois, segundo o teste de Jury
% para criação de matrizes 2x2. Em cima de tais matrizes que serão
% determinados os determinantes dois a dois para a construção da função que
% mostra os parâmetros da função de transferência.
n = max(size(L));

% Itens um a um da matriz 2x2.
D(1,1) = L(1,1);
D(2,1) = L(2,1);
D(1,2) = L(1,(n+1)-k);
D(2,2) = L(2,(n+1)-k);

end