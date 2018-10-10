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
plot(Edu.t, Edu.uk, Mar.t, Mar.uk, 'r'); grid; hold on;
plot(Edu.t, Umax*linspace(1,1,m), 'k','LineWidth', TAM);
plot(Edu.t, -Umax*linspace(1,1,m), 'k','LineWidth', TAM);
xlabel('k', 'FontSize', FTAM); ylabel('u(k)', 'FontSize', FTAM);
axis([Edu.t(1) Edu.t(end) -5.5 5.5]);

figure
%%% kappa = 1.1
TAM  = 2;
FTAM = 16;
m = max(size(Edu.t));
plot(Edu.t, Edu.uk2, Mar.t, Mar.uk2, 'r'); grid; hold on;
plot(Edu.t, Umax*linspace(1,1,m), 'k','LineWidth', TAM);
plot(Edu.t, -Umax*linspace(1,1,m), 'k','LineWidth', TAM);
xlabel('k', 'FontSize', FTAM); ylabel('u(k)', 'FontSize', FTAM);
axis([Edu.t(1) Edu.t(end) -5.5 5.5]);
legend('Método Proposto', 'CYG2011');