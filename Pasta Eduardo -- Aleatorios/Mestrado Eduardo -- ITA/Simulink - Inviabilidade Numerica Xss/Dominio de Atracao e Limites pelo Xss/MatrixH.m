function Saida = MatrizH (A)
    
n  = max(size(A{1}));         % Ordem da matriz.
c  = max(size(A));            % Quantas matrizes A's existem - cardinalidade. 

I     = eye(n);     % Matriz Identidade.
Pilha = 0*I;        % Vetor para concatenação - zerado.
for i=1:c
   Aa{i} = I - A{i};  
   Pilha = [Pilha; Aa{i}];
end

Pilha = Pilha(n+1:end,:);   % Retira a 1º matriz quadrada de zeros.
H = null(Pilha);

Saida = H;

end