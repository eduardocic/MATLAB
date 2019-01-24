clear all; close all; clc;

PreLoad;
load('EduardoSIM.mat');
Edu = SIM;
clear SIM;

load('MarianaSIM.mat');
Mar = SIM;
clear SIM;


%%% kappa = 0.9
TAM  = 2;
FTAM = 16;
m = max(size(Edu.t));
stairs(Edu.t, Edu.yss, 'LineWidth', TAM); grid; hold on
stairs(Mar.t, Mar.yss, 'r', 'LineWidth', TAM);
xlabel('k', 'FontSize', FTAM); ylabel('y_{ss}', 'FontSize', FTAM);
axis([Edu.t(1) Edu.t(end) -10.5 0.8]);


figure;
% figure;TAM  = 2;
FTAM = 16;
m = max(size(Edu.t));
stairs(Edu.t, Edu.yss2, 'LineWidth', TAM); grid; hold on
stairs(Mar.t, Mar.yss, 'r', 'LineWidth', TAM);
xlabel('k', 'FontSize', FTAM); ylabel('y_{ss}', 'FontSize', FTAM);
axis([Edu.t(1) Edu.t(end) -10.5 0.8]);
legend('Método Proposto', 'CYG2011');