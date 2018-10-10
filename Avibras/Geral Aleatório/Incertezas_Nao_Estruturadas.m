close all; clear all; clc;

% Modelo de incertezas  NÃO-ESTRUTURADAS - SISO.
% ----------------------------------------------
% 
% a) Incertezas Aditivas.
%   ----------------------
% omega = logspace(-1,3,100);
% 
% K0   = 1.0; 
% T0   = 1/15;
% Gnom = tf([K0],[T0 1]);
% 
% % Plota a incerteza aditiva de forma a encontrar um maximizante para o erro
% % do sistema.
% Gnom_frd = frd(Gnom,omega);
% figure(1)
% hold off
% for K = (0.8*K0) : (0.08*K0) : (1.2*K0)
%     
%     for T = (0.7*T0) : (0.06*T0) : (1.3*T0)
%         G = tf([K],[T 1]);
%         G_frd = frd(G,omega);
%         diff  = G_frd - Gnom_frd;
%         bodemag(diff, 'c--', omega);
%         hold on
%     end
% end
% grid
% temp1 = 'Approximation of uncertain transfer function';
% temp2 = ' by additive uncertainty'; title([temp1 temp2]);
% legend('|Wa(j\omega)|','|G(j\omega)-G_{nom}(j\omega)|',3);
% 
% % Encontrando uma função que majora todo o erro mapeado.
% ord = 2;        % Queremos um sistema de segunda ordem que aproxime o 
%                 % sistema como um todo.
% [freq, resp_db] = ginput(20);           % Pego 20 pontos do mapeio.
% for i = 1:20                            % Converto para logaritmo.
%     resp(i) = 10^(resp_db(i)/20);       % Resposta em magnitude.
% end 
% sys = frd(resp,freq);                   % Crio um objeto com os valores selecionados.
% W = fitmagfrd(sys,ord);                 % Encontro um sistema alternativo que fita bem os
%                                         % dados de segunda ordem.
% Wtf = tf(W);                            % Converto em função de transferência.
% % Plota o majorante.
% hold on;
% bodemag(Wtf, 'r');
% 
% % Reproduz o bloco de incerteza aditiva.
% Delta_a = ultidyn('Delta_a',[1 1]);
% G = Gnom + Wtf*Delta_a;
% =========================================================================

% 
% b) Incertezas Multiplicativas.
%   -----------------------------
omega = logspace(-1,3,100);

K0 = 1.0; 
T0 = 1/15;
Gnom = tf([K0],[T0 1]);
Gnom_frd = frd(Gnom,omega);
figure(1)
hold off
for K = (0.8*K0) : (0.08*K0) : (1.2*K0)
    for T = (0.7*T0) : (0.06*T0) : (1.3*T0)
        G = tf([K],[T 1]);
        G_frd   = frd(G,omega);
        reldiff = (G_frd - Gnom_frd)/Gnom_frd;       % Diferença relativa.
        bodemag(reldiff, 'c--' ,omega)
        hold on
    end
end
grid
temp1 = 'Approximation of uncertain transfer function';
temp2 = ' by multiplicative uncertainty';
title([temp1 temp2]);
legend('|Wm(j\omega)|', '|(G(j\omega)-G_{nom}(j\omega))/G_{nom}(j\omega)|',3)

ord = 1;
[freq, resp_db] = ginput(20);           % Pego 20 pontos do mapeio.
for i = 1:20                            % Converto para logaritmo.
    resp(i) = 10^(resp_db(i)/20);       % Resposta em magnitude.
end 
sys = frd(resp,freq);                   % Crio um objeto com os valores selecionados.
W = fitmagfrd(sys,ord);                 % Encontro um sistema alternativo que fita bem os
                                        % dados de segunda ordem.
Wtf = tf(W);                            % Converto em função de transferência.
% Plota o majorante.
hold on;
bodemag(Wtf, 'r');

% Reproduz o bloco de incerteza aditiva.
Delta_a = ultidyn('Delta_a',[1 1]);
G = Gnom*(1 + Wtf*Delta_a);

% plota o sistema incerto e o nominal.
bode(G,'b-',Gnom,'r--',omega); grid;
% =========================================================================

