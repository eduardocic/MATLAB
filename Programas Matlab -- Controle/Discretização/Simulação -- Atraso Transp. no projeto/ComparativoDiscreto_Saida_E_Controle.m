clear all; close all; clc;

load('dt025_DesignModern.mat');
t1  = ans.Time;
ref = ans.Data(1:end,1);
y1  = ans.Data(1:end,2);
u1  = ans.Data(1:end,3);

load('dt025_LQR.mat');
t2 = ans.Time;
y2 = ans.Data(1:end,2);
u2 = ans.Data(1:end,3);

% Resposta da saída.
% ------------------
TAM = 2;
plot(t1, ref, 'LineWidth', TAM); hold on;
plot(t1, y1, 'r-', 'LineWidth', TAM);
plot(t2, y2, 'g-', 'LineWidth', TAM);
grid;
xlabel('Tempo (s)');
ylabel('pitch rate - q');
legend('Referência', 'Com atraso ZOH no projeto', 'Sem atraso ZOH no projeto');


% Resposta do controle.
% ---------------------
figure;
stairs(t1, u1, 'b-', 'LineWidth', TAM); hold on;
stairs(t2, u2, 'r-', 'LineWidth', TAM);
grid;
xlabel('Tempo (s)');
ylabel('Controle u(k)');
legend('Com atraso ZOH no projeto', 'Sem atraso ZOH no projeto');