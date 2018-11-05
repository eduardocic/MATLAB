close all; clear all; clc;

% Frequência de amostragem.
Fs = 1000;
% Tempo de amostragem.
T  = 1/Fs;            
% Quantidade de amostras
Qtotal  = 1500;             
% Tempo total do sinal.
t  = (0:Qtotal-1)*T;

% Sinal original.
% ----------------
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
% FFT do sinal.
S_fft = abs(fft(S, Qtotal));
w     = linspace(0, pi/T, Qtotal);
plot(w, S_fft);
xlim([0 pi/T]);


% Implementação de um filtro passa baixas para filtragem do sinal de
% frequência de 120 Hz.
% ----------------------------------------------------------------------
H = fir1(50, 0.2, 'low');
% FFT do sinal.
H_fft = abs(fft(H, Qtotal));

% plot(S_fft); hold on;
plot(H_fft);

Filtrado = filter(H, 1, S);

figure;
% plot(Filtrado); hold on;
% plot(S_fft)
Filtrado_fft  = abs(fft(Filtrado, Qtotal))
plot(Filtrado_fft);

figure;
plot(Filtrado);
