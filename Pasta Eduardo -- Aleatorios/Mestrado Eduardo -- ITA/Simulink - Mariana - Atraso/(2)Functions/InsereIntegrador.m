function [AwI, BwI] = InsereIntegrador(A, B, C)

% Legenda.
% AwI   -- Matriz A com Integrador.
% BwI   -- Matriz B com Integrador.
% CwI   -- Matriz C com Integrador.

%%% Matrizes Aumentadas com Integradores.
RowLine = zeros(size(A,1),1);      % Coluna só de zeros.
AwI = [ A    RowLine;
        -C       1   ];
BwI = [B; 0];

end