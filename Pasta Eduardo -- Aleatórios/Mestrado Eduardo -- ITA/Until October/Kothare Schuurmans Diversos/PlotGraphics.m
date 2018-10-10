clear; close all; clc;

load('Situacao5Simulada.mat');
load('DomainKothareSituacao3.mat');

% Deslocamento dos estados.
x1 = X(1,1:1000);
x2 = X(2,1:1000);
u  = U(1:1000);

% Domínio de Atração.
V1 = DomainKothare(1:end,1);
V2 = DomainKothare(1:end,2);


% s(1) = subplot(1,2,1); hold on;
% s(2) = subplot(1,2,2); 
% 
% 
% stairs(s(1), x1, 'LineWidth', 1.5);
% stairs(s(1), x2, 'r', 'LineWidth', 1.5);
% % legend(s(1), 'x1', 'x2');
% title(s(1),'Estados.');
% 
% stairs(s(2), u, 'LineWidth', 1.5);
% title(s(2),'Entrada de Controle.');
% line([0 max(size(u))],[-2 -2],'Color','r',...
%                               'LineWidth',1);
% line([0 max(size(u))],[2 2],'Color','r',...
%                               'LineWidth',1);
%                           
% axis([0 1000 -2.5 2.5]);


plot(V1, V2, 'r', 'LineWidth',2);
hold on; 
plot(x1, x2);
plot(x1(1), x2(1), 'og', 'MarkerSize', 6, ...
                       'MarkerFaceColor','g');
title('Deslocamento do Estado para a origem.');
grid;
                   



