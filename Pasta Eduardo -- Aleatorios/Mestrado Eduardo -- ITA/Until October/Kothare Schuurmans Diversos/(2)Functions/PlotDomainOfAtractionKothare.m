function [] = PlotaDominioAtracao(V)
% Plota Regi�o do Dom�nio de Atra��o.
V1 = V(:,1);
V2 = V(:,2);

%% �rea do Dom�nio de Atra��o
area(V1, V2, 'FaceColor', 'r'); 
grid;
% axis([-600 600 -40 40]);
title('Dom�nio de Atra��o.');
% xlabel('\theta');
% ylabel('\theta}');
end




