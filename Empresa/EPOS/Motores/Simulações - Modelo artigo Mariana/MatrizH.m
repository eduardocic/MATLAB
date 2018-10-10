function Saida = MatrizH (A)
    
    n = size(A{1},1);  % Dimensão Matrizes "A's"
    L = size(A,2);     % Quantas matrizes A existe.
    I = eye(n);        % Matriz Identidade.
    
    Concatena = [];
    for i = 1:L
        Delta{i} = (I - A{i});
        Concatena = [Concatena; Delta{i}];
    end
    
    Concatena;
    H = null(Concatena, 'r');
    Saida = H;
end