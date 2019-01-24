clear all; close all; clc;

load('ClosedLoop_Simulink_Longitudinal.mat');

t       = ans(1,:);
Vt      = ans(2,:);
alpha   = ans(3,:);
beta    = ans(4,:);
phi     = ans(5,:);
theta   = ans(6,:);
psi     = ans(7,:);
P       = ans(8,:);
Q       = ans(9,:);
R       = ans(10,:);
Pn      = ans(11,:);
Pe      = ans(12,:);
Pd      = ans(13,:);

subplot(5,2,1);
plot(t, Vt); grid;
xlabel('Tempo (s)');
ylabel('V_t (ft/s)');

subplot(5,2,2);
plot(t, alpha); grid;
xlabel('Tempo (s)');
ylabel('\alpha');

subplot(5,2,3);
plot(t, beta); grid;
xlabel('Tempo (s)');
ylabel('\beta');

subplot(5,2,4);
plot(t, phi); grid;
xlabel('Tempo (s)');
ylabel('\phi');

subplot(5,2,5);
plot(t, theta); grid;
xlabel('Tempo (s)');
ylabel('\theta');

subplot(5,2,6);
plot(t, psi); grid;
xlabel('Tempo (s)');
ylabel('\psi');


subplot(5,2,7);
plot(t, P); grid;
xlabel('Tempo (s)');
ylabel('P');

subplot(5,2,8);
plot(t, Q); grid;
xlabel('Tempo (s)');
ylabel('Q');

subplot(5,2,9);
plot(t, R); grid;
xlabel('Tempo (s)');
ylabel('R');

