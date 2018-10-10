function Saida = MatrizH (A)
    
    n = size(A,2);  % Dimensão Matrizes "A's"
    m = size(A,1);  % Quantidade de Matrizes.
    q = m/n;
    
    I = eye(n);     % Matriz Identidade.
    
    Delta = 0*I;
    for i = 1:q
        Aint = A((i-1)*n+1:(i*n),:);
        Beta(1:n, 1:n) = (I-Aint);
        Delta = [Delta; Beta];
    end
    Delta = Delta(n+1:end,:);
    
    H = null(Delta);
    
    Saida = H;
end