function [] = PlotaDominioAtracao(V)
% Plota Região do Domínio de Atração.
V1 = V(:,1);
V2 = V(:,2);

plot(V1, V1, '*r', 'MarkerSize',5); grid;
hold on;
plot(V1, V2);

% figure
% %% Área do Domínio de Atração
% area(V1, V2, 'FaceColor', 'r'); 
% grid;
end




