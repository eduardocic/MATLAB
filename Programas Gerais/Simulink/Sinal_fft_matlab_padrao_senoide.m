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
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);

% Sinal com ruído branco.
X = S + 2*randn(size(t));

% Plotagem do sinal.
plot(t, X);
title('Signal Corrupted with Zero-Mean Random Noise');
xlabel('t (milliseconds)');
ylabel('X(t)');

% fft do sinal já considerando o tamanho da amostra.
Y = fft(X);

% Frequência. 
F = ((0 : (1/Qtotal) : (1-1/Qtotal))*Fs).';    

% Magnitude e fase do sinal
magnitudeY = abs(Y);            
faseY      = unwrap(angle(Y)); 

% Para análise do bode.
mag_db = 20*log10(magnitudeY);

% -------------------------------------------------------------------------
% Considerando o sinal amostrado da forma:
% 
%   f(kt) = x0.d(t) + x1.d(t-T) + x2.d(t-2T) + ... + xk.d(t-kT) + ...
% 
% A transformada de Fourier é algo da forma:
% 
%   F(w) = x0 + x1.exp(-jwT) + x2.exp(-j2wT) + ... +xk.exp(-jkwT) + ...
% 
%   Perceba que o sinal em sim é uma função de 'w'. Ou seja, dado uma
% frequência de amostragem (T) e um sinal amostrado (f(kT), a gente
% consegue para cada 'dw' de frequência encontrar uma sinal. 
% 
%   Dessa forma, perceba que na "pior" situação (uma situação em que os
% exp(-jkwt), para k = 0, 1, 2, ...), a gente teria um somatório apenas
% dos parâmetros x0 + x1 + x2 + ... + xk + ...
%
%   Para a gente normalizar em relação ao sinal que está sendo apresentado,
% a gente divide pelo máximo valor possível para o sinal (que é o tamanho
% do mesmo sendo multiplicado por múltiplos 1).
% -------------------------------------------------------------------------
% 
% Normalizar.
figure;
magnitudeY_normalizada = magnitudeY/Qtotal;
plot(F, magnitudeY_normalizada); grid;
ylabel('Valor absoluto normalizado da FFT');
xlabel('Frequênci (Hz)');
xlim([0 Fs/2]);

% Apenas um teste.
figure;
magnitudeX_normalizada = abs(fft(S))/Qtotal;
% magnitudeY_normalizada = magnitudeY/Qtotal;
plot(F, magnitudeX_normalizada); grid;
ylabel('Valor absoluto normalizado da FFT');
xlabel('Frequênci (Hz)');
xlim([0 Fs/2]);


% Plot do sinal em magnitude (considerando o espectro completo).
figure;
plot(F, magnitudeY); 
xlim([0 Fs/2]);
xlabel('Frequência (Hz)');
ylabel('Magnitude (db)');

% Plot do sinal em fase (considerando o espectro completo).
figure;
plot(F, faseY);
xlim([0 Fs/2]);
xlabel('Frequência (Hz)');
ylabel('Fase (rad)');
