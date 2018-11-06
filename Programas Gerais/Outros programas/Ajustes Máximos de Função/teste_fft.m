clear all; close all; clc;

% Carregando os dados
load('dados.mat');

% Período de amostragem e frequência do sistema.
T    = 0.001;
freq = 1/T;

% Cortando o intervalo de saída do sinal de entrada e saída.
alpha = 50;
[t_cortado, signal_out_cortado] = corte(signal_out, t, t_int(alpha), t_int(alpha+1));
[    ~    , signal_in_cortado ] = corte(signal_in,  t, t_int(alpha), t_int(alpha+1));

% Qual será o 'dw' utilizado para o cálculo da Fast Fourier Transform?
n      = max(size(signal_in_cortado));
qtotal = n*100;

% fft do sinal já considerando o tamanho da amostra.
in  = fft(signal_in_cortado, qtotal);
out = fft(signal_out_cortado, qtotal);
magnitude_in  = abs(in);
magnitude_out = abs(out);

% Dividirei o meu intervalo entre amostras em 100. O resultado está em 
% rad/s.
omega = linspace(0, freq, qtotal);

figure;
magnitude_in_normalizada  = magnitude_in/soma(magnitude_in);
magnitude_out_normalizada = magnitude_out/soma(magnitude_out);
plot(omega, magnitude_in_normalizada); 
hold on;
plot(omega, magnitude_out_normalizada, 'r'); 
grid;

ylabel('Valor absoluto normalizado da FFT');
xlabel('Frequência (rad/s)');
xlim([0 max(omega)]);


