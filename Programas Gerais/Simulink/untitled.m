clear all; close all; clc;

% -------------------------------------------------------------------------
% Link do site para análise e estudo.
% 
% https://www.mathworks.com/help/signal/examples/practical-introduction-to-frequency-domain-analysis.html
% -------------------------------------------------------------------------

% Frequência de amostragem, em Hz.
Fs = 44100;

% -------------------------------------------------------------------------
% Carrega um arquivo de áudio.
% 
% Esse arquivo tem um tamanho definido. Qual é o tamanho do arquivo/?
y  = audioread('guitartune.wav');

% Se a gente sabe a frequência entre as amostras e a gente sabe também
% quanto dado a gente tem, a gente consegue determinar o tempo total da
% gravação.
t_total_grav = max(size(y))*1/Fs;
t = linspace(0, t_total_grav, max(size(y)));
% no caso, dá 15 segundos.
% -------------------------------------------------------------------------
plot(t, y); grid;
title('Sinal "guitartune.wav"');
xlabel('tempo (s)');
ylabel('Sinal amostrado');


% Quantidade de pontos total da amostra.
Qtotal = max(size(y));

% fft do sinal já considerando o tamanho da amostra.
Y = fft(y);
% Y      = fft(y, Qtotal);

% Ele secciona o sinal entre 0Hz e 44100Hz em espaços tais que dizem
% respeito à quantidade de pontos da amostra. Esse é o 'delta w'.
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





% Plot do sinal em magnitude (considerando o espectro completo).
figure;
plot(F, mag_db); 
xlim([0 Fs/2]);
xlabel('Frequência (Hz)');
ylabel('Magnitude (db)');

% Plot do sinal em fase (considerando o espectro completo).
figure;
plot(F, faseY);
xlim([0 Fs/2]);
xlabel('Frequência (Hz)');
ylabel('Fase (rad)');







