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

%     n = size(A,2);  % Dimensão Matrizes "A's"
%     m = size(A,1);  % Quantidade de Matrizes.
%     q = m/n;
%     
%     I = eye(n);     % Matriz Identidade.
%     
%     Delta = 0*I;
%     for i = 1:q
%         Aint = A((i-1)*n+1:(i*n),:);
%         Beta(1:n, 1:n) = (I-Aint);
%         Delta = [Delta; Beta];
%     end
%     Delta = Delta(n+1:end,:);
%     
%     H = null(Delta);
%     
%     Saida = H;
end