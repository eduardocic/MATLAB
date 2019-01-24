function [n, p, qA, qB, N] = ProcessamentoMatrizesEstado(A, B)
%% --------------------------------
% Dados para dimensões da matrizes.
% ---------------------------------
n = size(A,2);      % Ordem das matrizes "A's" (n x n). 
p = size(B,2);      % Parâmetro de entradas de "B's" (n x p).

alfa = size(A,1);
beta = size(B,1);
qA = alfa/n;                 % # da matrizes 'A' (A1 e A2);
qB = beta/n;                 % # da matrizes 'B' (B);
N  = qA*qB;                  % # Vértices Politopo ('2' de A e '1' de B);

end