clear all; close all; clc;

PreLoad;
load('EduardoSIM.mat');
Edu = SIM;
clear SIM;

load('MarianaSIM.mat');
Mar = SIM;
clear SIM;


%%% kappa = 0.9
TAM  = 2;
FTAM = 16;
m = max(size(Edu.t));
plot(Edu.t, Edu.y, Mar.t, Mar.y, 'r');grid; hold on
plot(Edu.t, Ymax*linspace(1,1,m),'k','LineWidth', TAM);

xlabel('k', 'FontSize', FTAM); ylabel('y(k)', 'FontSize', FTAM);
axis([Edu.t(1) Edu.t(end) -10.5 0.8]);

% Quadrado seleção
Ini = 7;
Fim = 20;
xx = [ Edu.t(Ini), Edu.t(Fim), Edu.t(Fim), ...
       Edu.t(Ini), Edu.t(Ini)];                     % Coordenadas x do quadrado.
yy = [ Edu.y(Ini), Edu.y(Ini), (Edu.y(Fim)+0.5), ...
      (Edu.y(Fim)+0.5), Edu.y(Ini)];               % Coordenadas x do quadrado.
hold on;
plot(xx, yy, 'k--', 'LineWidth', TAM);                  % Plota Quadrado.

% Inset
axes('Position',[.39 0.18 .5 .47]);
box on
plot(Edu.t(Ini:Fim), Edu.y(Ini:Fim), 'LineWidth', TAM); hold on;
plot(Mar.t(Ini:Fim), Mar.y(Ini:Fim), 'r','LineWidth', TAM);
plot(Edu.t(Ini:Fim), Ymax*linspace(1,1,Fim-Ini+1),'k', 'LineWidth', TAM);grid; 
axis([Edu.t(Ini) Edu.t(Fim) Edu.y(Ini) (Edu.y(Fim)+0.5)]);
set(gca,'fontsize',13);


figure;
%%% kappa = 1.1
m = max(size(Edu.t));
plot(Edu.t, Edu.y2, Mar.t, Mar.y2, 'r');grid; hold on
plot(Edu.t, Ymax*linspace(1,1,m),'k','LineWidth', TAM);
legend('Método Proposto', 'CYG2011');
xlabel('k', 'FontSize', FTAM); ylabel('y(k)', 'FontSize', FTAM);
axis([Edu.t(1) Edu.t(end) -10.5 0.8]);

% Quadrado seleção
Ini = 7;
Fim = 20;
xx = [ Edu.t(Ini), Edu.t(Fim), Edu.t(Fim), ...
       Edu.t(Ini), Edu.t(Ini)];                     % Coordenadas x do quadrado.
yy = [ Edu.y2(Ini), Edu.y2(Ini), (Edu.y2(Fim)+0.5), ...
      (Edu.y2(Fim)+0.5), Edu.y2(Ini)];               % Coordenadas x do quadrado.
hold on;
plot(xx, yy, 'k--', 'LineWidth', TAM);                  % Plota Quadrado.

% Inset
axes('Position',[.39 0.18 .5 .47]);
box on
plot(Edu.t(Ini:Fim), Edu.y2(Ini:Fim), 'LineWidth', TAM); hold on;
plot(Mar.t(Ini:Fim), Mar.y2(Ini:Fim), 'r','LineWidth', TAM);
plot(Edu.t(Ini:Fim), Ymax*linspace(1,1,Fim-Ini+1),'k', 'LineWidth', TAM);grid; 
axis([Edu.t(Ini) Edu.t(Fim) Edu.y2(Ini) (Edu.y2(Fim)+0.5)]);
set(gca,'fontsize',13);

