clear all; close all; clc;

% Carrega tempo dt = 0,25.
load('dt025.mat');
t1 = ans.Time(1:end);
y1 = ans.Data(1:end,2);

% Carrega tempo dt = 0,25.
load('dt01.mat');
t2 = ans.Time(1:end);
y2 = ans.Data(1:end,2);

% Carrega tempo dt = 0,25.
load('dt0025.mat');
t3 = ans.Time(1:end);
y3 = ans.Data(1:end,2);

% Plota sa�da.
Tam = 2;
plot(t1, y1, 'b-', 'LineWidth', Tam); hold on;
plot(t2, y2, 'r-', 'LineWidth', Tam); 
plot(t3, y3, 'g-', 'LineWidth', Tam);
legend('\delta T = 0,25s', '\delta T = 0,1s', '\delta T = 0,025s');
grid;
xlabel('Tempo (s)');
ylabel('q - pitch rate');
