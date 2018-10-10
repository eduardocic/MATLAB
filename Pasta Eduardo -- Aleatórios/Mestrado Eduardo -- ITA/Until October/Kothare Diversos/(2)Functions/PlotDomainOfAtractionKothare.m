function [] = PlotaDominioAtracao(V)
% Plota Região do Domínio de Atração.
V1 = V(:,1);
V2 = V(:,2);

%% Área do Domínio de Atração
area(V1, V2, 'FaceColor', 'r'); 
grid;
end




