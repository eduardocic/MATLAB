clear all; close all; clc;

load('ComparativoContinua.mat');
t   = ans.Time;                 % Tempo (s).
ref = ans.Data(1:end,1);        % Sinal de referência.
SEM = ans.Data(1:end,2);        % Sem aproximação (atraso puro).
COM = ans.Data(1:end,3);        % Com aproximação (Padé).

TAM = 2;
plot(t, ref, 'b-' ,'LineWidth', TAM); hold on;
plot(t, SEM, 'r-' ,'LineWidth', TAM); 
plot(t, COM, 'g-' ,'LineWidth', TAM); 
grid;
xlabel('Tempo (s)');
ylabel('pith rate - q');
legend('Referência', 'Malha com atraso -- sem aproximação','Malha com atraso -- com aproximação Padé');

