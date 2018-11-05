clear all; close all; clc;

% Ordem do Filtro.
n  = 2;

% Frequência de corte.
Wn = 0.2;

% Obtenção dos coeficientes.
[num, den] = butter(n,Wn);

% Resposta em frequência do filtro.
freqz(num,den);

h = impz(num, den, 50);

H = fft(h);

figure;
plot(abs(H));



