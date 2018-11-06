% =========================================================================
%
% Descrição:
% ----------
%   
%    Obtenção dos pontos de pico de um sinal. 
%
% 
% Feito por:
% ----------
% 
%   Eduardo H. Santos
%   06/11/2018
% =========================================================================


clear all; close all; clc;

% Tempo final de simulação e quantidade de amostras.
Tfinal  = 10;
Amostra = 10001; 

% Tempo e sinal, seguido de um plot.
t = linspace(0, Tfinal, Amostra);
for i = 1:max(size(t))
    s(i) = exp(-t(i))*sin(2*pi*t(i));
end
plot(t,s); grid;

% Ordena as amostras em valores em ordem decrescentes. Os seus índices
% também estão separados.
[valores, indices] = sort(s, 'descend');

% Busca por janela temporal.
janela = 10;
% Definicao do passo
passo  = floor(Amostra/janela);

for i = 1:janela
    
   % Dividir a janela temporal para análise pontual.
   tIntermed = t((passo*(i-1) + 1):passo*(i));
   vIntermed = s((passo*(i-1) + 1):passo*(i));
   
   [val, index] = sort(vIntermed, 'descend');
   
   MAX_p(i)     = val(1);
   MAX_index(i) = (passo*(i-1)) + index(1);
   MIN_p(i)     = val(end);
   MIN_index(i) = (passo*(i-1)) + index(end);
end

dt = t(end)-t(end-1);
for i = 1:max(size(MAX_index))
    t_max(i) = dt*(MAX_index(i)-1);
    t_min(i) = dt*(MIN_index(i)-1);
end

hold on;
plot(t_max, MAX_p, '*r');
plot(t_min, MIN_p, 'og');


% =========================================================================
% Utilização dos valores mínimos do sistema por meio da função 'findpeaks'.
% 
% =========================================================================

% Encontra os valores máximos.
% ----------------------------
[v_max, index_max] = findpeaks(s);

% Encontra os valores mínimos.
% ----------------------------
[v_min, index_min] = findpeaks(-s);
v_min = -v_min;

% Plota o resultado.
figure;
plot(t, s); hold on;
plot((index_max-1)*dt, v_max, 'r*');
plot((index_min-1)*dt, v_min, 'k*');



% Mudança de frequência do sistema.
freq   = linspace(1,10,10);

