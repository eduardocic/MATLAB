function [] = PlotaDominioAtracao(V)
% Plota Regi�o do Dom�nio de Atra��o.
V1 = V(:,1);
V2 = V(:,2);

plot(V1, V1, '*r', 'MarkerSize',5); grid;
hold on;
plot(V1, V2);

% figure
% %% �rea do Dom�nio de Atra��o
% area(V1, V2, 'FaceColor', 'r'); 
% grid;
end




