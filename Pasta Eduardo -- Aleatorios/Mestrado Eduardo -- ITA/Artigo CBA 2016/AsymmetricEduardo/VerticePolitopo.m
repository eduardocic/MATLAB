function [Aj, Bj] = VerticePolitopo(A, B, m)

n = max(size(A));     % Incertezas 'A'
p = max(size(B));     % Incertezas 'B'
L = n*p;              % Cardinalidade de politopos total.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   E c�digo a seguir pega a parte inteira mais pr�xima do maior inteiro, 
%   dominado, logicamente, pela quantidade de incertezas da matriz de
%   controle 'B'. Nesse caso, vou dividindo a quantidade de v�rtices,
%   ordenado pela vari�vel 'm' e assim os divido pela vari�vel 'p', a qual 
%   me d� a ordena��o de qual par (Aj,Bj) est� sendo chamado por vez.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = ceil(m/p);        
l = rem(m,p);
if (l == 0)
    l = p;
end

Aj = A{k};
Bj = B{l};

end