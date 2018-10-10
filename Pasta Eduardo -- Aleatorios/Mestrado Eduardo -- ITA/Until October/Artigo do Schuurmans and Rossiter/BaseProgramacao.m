% Este pequeno código permite visualizar que se pode criar de maneira
% recursiva variáveis que podem ser utilizadas na solução do problema de
% LMIs no qual se coloca um horizonte de controle finito de dimensão 'nc'.

clear, clc, close all;
Matrizes;
setlmis([]);

for i=1:3
    [X(i)] = lmivar(2,[2 1]);
end

% ----------------------------------------------
% Tentativa de criar uma variável tridimensional
for i=1:3
    for  j = 1:3
        [Y(i,j)] = lmivar(2,[2 1]);
    end
end
% ----------------------------------------------

lmis = getlmis();

for i=1:3
    x(1:n,i) = decinfo(lmis, X(i));
end

% ----------------------------------------------
% Tentativa de criar uma variável tridimensional
for i=1:3
    for  j = 1:3
        decinfo(lmis, Y(i,j));
    end
end
% ----------------------------------------------

teste = funcaoteste(x(1:n,1), A1, B1)