clear all; close all; clc;

load('ComparativoContinua.mat');
t   = ans.Time;                 % Tempo (s).
ref = ans.Data(1:end,1);        % Sinal de refer�ncia.
SEM = ans.Data(1:end,2);        % Sem aproxima��o (atraso puro).
COM = ans.Data(1:end,3);        % Com aproxima��o (Pad�).

TAM = 2;
plot(t, ref, 'b-' ,'LineWidth', TAM); hold on;
plot(t, SEM, 'r-' ,'LineWidth', TAM); 
plot(t, COM, 'g-' ,'LineWidth', TAM); 
grid;
xlabel('Tempo (s)');
ylabel('pith rate - q');
legend('Refer�ncia', 'Malha com atraso -- sem aproxima��o','Malha com atraso -- com aproxima��o Pad�');

