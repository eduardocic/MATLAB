function [] = Plota_DA(V)

% (*) Plota Região do Domínio de Atração.
% ---------------------------------------


V1  = V(1:end,1);
V2  = V(1:end,2);

%% Área do Domínio de Atração
area(V1, V2, 'FaceColor', 'w');  % na cor branca.
grid;
end




