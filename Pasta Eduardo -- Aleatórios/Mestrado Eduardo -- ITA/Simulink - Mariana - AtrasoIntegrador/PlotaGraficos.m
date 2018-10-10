clear; close all; clc;

%%% Carrega o arquivo principal Main.
Main;

%%% Carrega o arquivo.
load('Yokogawa.mat');

%%% Separa os valores do vetor dado.
T   = Yokogawa(1,1:end);
uk  = Yokogawa(2,1:end);
hk  = Yokogawa(3,1:end);

N   = max(size(T));         % Tamanho do vetor.
REF = linspace(1,1,N);

%%% Compensação de valores por referência.
hp_ref = 0.3*70*REF;        % 30% de 70cm.
up_ref = 0.65*3450*REF;     % 65% de 3450rpm.

%%% Respostas finais -- SEM PORCENTAGEM.
hp = hp_ref - hk;
up = up_ref - uk;

%%% Respostas finais -- COM PORCENTAGEM.
for i=1:N
   hp_til(i) = hp(i)*(100/70);
   up_til(i) = up(i)*(100/3450);     
end



stairs(T, up_til, 'LineWidth',1); hold on;       % plota up(k).
stairs(T, up_ref*(100/3450) + Umax*(100/3450),'-.k');  % Limite Superior up(k).
stairs(T, up_ref*(100/3450) - Umax*(100/3450),'-.k');  % Limite Inferior up(k).

stairs(T, hp_til, 'LineWidth',1);                % plota hp(k).
stairs(T, hp_ref*(100/70), '-.k');
axis([0 max(T) 0 100]);




%%% Determina posicionamento dos vetores no plot.
% s(1) = subplot(2,1,1); hold; grid; 
% s(2) = subplot(2,1,2); hold; grid; 
% 
% %%% Plot do resultado.  
% % Subgráfico 1.
% stairs(s(1), T, up_til, 'LineWidth',1);                % plota u(k)
% xlabel(s(1),'T(s)');
% ylabel(s(1),'up(k)');
% 
% stairs(s(2), T, hp_til, 'LineWidth',1);                % plota u(k)
% xlabel(s(2),'T(s)');
% ylabel(s(2),'hp(k)');



% Macetes para colocar o pdf em 'landscape'.
% h = gcf;    % Get handle to Current Figure
% set(h,'PaperOrientation','landscape');
% set(h,'PaperUnits','normalized');
% set(h,'PaperPosition', [0 0 1 1]);
% print(gcf, '-dpdf', 'test4.pdf');