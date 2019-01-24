function [Aj, Bj] = VerticePolitopo(A, B, m)

n = max(size(A));     % Incertezas 'A'
p = max(size(B));     % Incertezas 'B'
L = n*p;              % Cardinalidade de politopos total.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   E código a seguir pega a parte inteira mais próxima do maior inteiro, 
%   dominado, logicamente, pela quantidade de incertezas da matriz de
%   controle 'B'. Nesse caso, vou dividindo a quantidade de vértices,
%   ordenado pela variável 'm' e assim os divido pela variável 'p', a qual 
%   me dá a ordenação de qual par (Aj,Bj) está sendo chamado por vez.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = ceil(m/p);        
l = rem(m,p);
if (l == 0)
    l = p;
end

Aj = A{k};
Bj = B{l};

end