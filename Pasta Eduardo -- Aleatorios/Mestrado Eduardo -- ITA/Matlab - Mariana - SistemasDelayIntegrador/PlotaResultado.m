clear; close all; clc;

%%% Carrega Constantes.
F1_MatrizesDeEstado;                % Carrega as Matrizes A, B e C.
F2_Constantes;                      % Matrizes 'R' e 'S' + 'tao' + 'T'. 
F3_RestricoesECondicoesIniciais;    % Umax e zk0.


%%% Carrega Arquivo de Simula��o.
load('Resultado.mat');

T   = Yoko.t;
uk  = Yoko.U;
hk  = Yoko.Z;

%__________________________________________________________________________
% 1. Gr�fico - RESULTADO PURO (vindo da simula��o direto).
%__________________________________________________________________________
stairs(T, uk, 'LineWidth', 1.5); hold;
stairs(T, hk, 'r', 'LineWidth', 1.5); grid; 
legend('u(k)', 'h(k)');
title('Sem Compensa��o para a Origem.');
xlabel('Tempo(s)');

figure;
%__________________________________________________________________________
% 2. Gr�fico - RESULTADO COMPENSADO (ajuste para a realidade).
%__________________________________________________________________________
N   = max(size(T));         % Tamanho do vetor.
REF = linspace(1,1,N);

%%% Compensa��o de valores por refer�ncia.
hp_ref = 30*REF;        % 30%
up_ref = 65*REF;        % 65%


%%% Respostas finais -- EM PORCENTAGEM.
% hp = 30 + hk;
% up = 65 + uk;
hp = 12.5 + hk;
up = 60 + uk;


%%% Plota Resultado Compensado.
stairs(T, up, 'LineWidth',1.5); hold on;           % plota up(k).
stairs(T, hp, 'r', 'LineWidth',1.5);               % plota hp(k).
stairs(T, up_ref + Umax,'-.k');  % Limite Superior up(k).
stairs(T, up_ref - Umax,'-.k');  % Limite Inferior up(k).
stairs(T, hp_ref, '-.k');
axis([0 max(T) 0 100]);
legend('u(k)', 'h(k)');
title('Resultado Final');
xlabel('Tempo(s)');