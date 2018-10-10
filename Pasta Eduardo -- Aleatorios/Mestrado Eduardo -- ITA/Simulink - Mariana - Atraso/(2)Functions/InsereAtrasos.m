function [Adelay, Bdelay, Cdelay] = InsereAtrasos(A, B, C, tao)


%%% Valores para constru��o das matrizes
n   = size(A, 1);          % Pega a ordem da matiz           

%%% Forma��o do bloco da matriz 'Aaug'
bloco1A = 0*linspace(1,1,n+tao);
bloco2A = zeros(tao-1,n);
bloco3A = eye(tao-1);
bloco4A = zeros(tao-1,1);

%%% Forma��o do bloco da matriz Baug
bloco1B    = zeros(n,1);
bloco2B    = linspace(0,0,tao)';
bloco2B(1) = 1;


%%% Forma��o dos v�rtices do politopo
% 1� Parte - Incerteza apenas em B.
Adelay{1} = [   A             zeros(n,tao);
                       bloco1A            ;
             bloco2A   bloco3A   bloco4A  ];
Bdelay{1} = [B; bloco2B];

% 2� Parte - Incertezas apenas em A.
for i=2:(tao+1)
    Vaux = zeros(n,tao);
    Vaux(1:end,i-1) = B;
    Adelay{i} = [   A         Vaux        ;
                          bloco1A         ;
                 bloco2A bloco3A bloco4A ];
    Bdelay{i} = [zeros(n,1); bloco2B];
end

Cdelay = [C zeros(1,tao)];


end