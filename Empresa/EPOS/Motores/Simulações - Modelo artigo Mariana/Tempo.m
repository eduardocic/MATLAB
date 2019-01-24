clear all; close all; clc;

load('EduardoSIM.mat');
Edu = SIM;
clear SIM;

load('MarianaSIM.mat');
Mar = SIM;
clear SIM;

% Plot dos tempos
plot(Edu.t, Edu.Tempo1, Mar.t, Mar.Tempo1); grid;
xlabel('k','FontSize', 16);
ylabel('Tempo de otimiza��o (s)', 'FontSize', 16);
legend('M�todo Proposto', 'CGY2011');


figure;
plot(Edu.t, Edu.Tempo2, Mar.t, Mar.Tempo2); grid;
xlabel('k', 'FontSize', 16);
ylabel('Tempo de otimiza��o (s)','FontSize', 16);
legend('M�todo Proposto', 'CGY2011');