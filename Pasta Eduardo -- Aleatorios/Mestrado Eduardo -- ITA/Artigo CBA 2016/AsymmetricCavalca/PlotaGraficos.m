clear; close all; clc;

%%% Carrega o arquivo principal Main.
Main;

%%% Carrega o arquivo.
load('CavalcaSimulation.mat');

%%% Separa os valores do vetor dado.
T      = Cavalca(1,1:end);
u      = Cavalca(2,1:end);
x1k    = Cavalca(3,1:end);
x2k    = Cavalca(4,1:end);
yk     = Cavalca(5,1:end);
yss    = Cavalca(6,1:end);

LinhaUmax = linspace(1,1,max(size(T)))*Umax;
LinhaUmin = -linspace(1,1,max(size(T)))*Umax;
LinhaYmax = linspace(1,1,max(size(T)))*Y(2);
LinhaYmin = linspace(1,1,max(size(T)))*Y(1);


%%% Determina posicionamento dos vetores no plot.
s(1) = subplot(2,2,1); hold; grid; axis([0 max(T) -(1.05*Umax) (1.05*Umax)]);% u(k) 
s(2) = subplot(2,2,2); hold; grid; axis([0 max(T) (1.05*Ymin) 5]);% y(k)
s(3) = subplot(2,2,3); hold; grid; axis([0 max(T) (1.05*Ymin) (2*Ymax)]);% u(k)
s(4) = subplot(2,2,4); hold; grid; axis([0 max(T) -6 (2*Ymax)]);% y(k)

%%% Plot do resultado.  
% Subgráfico 1.
stairs(s(1), T, u, 'LineWidth',1);                % plota u(k)
stairs(s(1), T, LinhaUmax,'r--','LineWidth',1);
stairs(s(1), T, LinhaUmin,'r--','LineWidth',1);
title(s(1), 'Entrada de Controle u(k)');
legend(s(1), 'u(k)',  'u_{max} e u_{min}');
xlabel(s(1), 'T (s)');



% Subgráfico 2.
stairs(s(2), T, x1k, 'LineWidth',1);               % plota x1(k)
stairs(s(2), T, x2k, 'r', 'LineWidth',1);               % plota x1(k)
title(s(2), 'Estados x_{1}(k) e x_{2}(k)');
legend(s(2), 'x_{1}(k)', 'x_{2}(k)');
xlabel(s(2), 'T (s)');



%%% Plot do resultado.  
% Subgráfico 1.
plot(s(3), T, yk, 'LineWidth',1);                % plota u(k)
stairs(s(3), T, LinhaYmax,'r--','LineWidth',1);
stairs(s(3), T, LinhaYmin,'r--','LineWidth',1);
title(s(3), 'Saída y(k)');
xlabel(s(3), 'T (s)');
legend(s(3), 'y(k)', 'y_{max} e y_{min}');

% Subgráfico 2.
stairs(s(4), T, yss, 'LineWidth',1);               % plota x1(k)
title(s(4), 'Referência y_{ss}(k)');
legend(s(4), 'y_{ss}(k)');
xlabel(s(4), 'T (s)');


% Macetes para colocar o pdf em 'landscape'.
% h = gcf;    % Get handle to Current Figure
% set(h,'PaperOrientation','landscape');
% set(h,'PaperUnits','normalized');
% set(h,'PaperPosition', [0 0 1 1]);
% print(gcf, '-dpdf', 'test4.pdf');